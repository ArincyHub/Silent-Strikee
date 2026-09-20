import { Sfx, SoundKind } from "./audio";
import { drawText, textWidth } from "./font";
import {
  buildSprite,
  CharSprite,
  ENEMY_PALS,
  PLAYER_PAL,
  SPRITE_H,
  SPRITE_W,
  tryLoadOverride,
} from "./sprites";

export type Difficulty = "easy" | "normal" | "hard";
export type Settings = { volume: number; ripples: boolean; difficulty: Difficulty };
export type Result = { win: boolean; kills: number; time: number };

export const VIEW_W = 320;
export const VIEW_H = 180;

const WORLD_W = 900;
const WORLD_H = 640;
const HIDDEN_TIME = 30;
const VISIBLE_TIME = 5;
const SWING_TIME = 0.32;
const HIT_RANGE = 22;
const BODY_R = 5;

type Obstacle = { x: number; y: number; w: number; h: number; kind: "bush" | "rock" };

type Fighter = {
  id: number;
  player: boolean;
  x: number;
  y: number;
  vx: number;
  vy: number;
  dir: number;
  hp: number;
  maxHp: number;
  alive: boolean;
  speed: number;
  sneak: boolean;
  cooldown: number;
  swing: number;
  swung: boolean;
  walkT: number;
  stepT: number;
  flash: number;
  reveal: number;
  kills: number;
  sprite: CharSprite;
  art: HTMLImageElement | null;
  // ai only
  think: number;
  wander: { x: number; y: number } | null;
  known: { x: number; y: number; t: number } | null;
  hearing: number;
  sight: number;
  nerve: number;
};

type Ripple = { x: number; y: number; r: number; max: number; color: string };
type Corpse = { x: number; y: number; sprite: CharSprite };

function rnd(a: number, b: number) {
  return a + Math.random() * (b - a);
}

function clamp(v: number, a: number, b: number) {
  return v < a ? a : v > b ? b : v;
}

function mulberry32(seed: number) {
  let a = seed;
  return () => {
    a |= 0;
    a = (a + 0x6d2b79f5) | 0;
    let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

const SOUND_RANGE: Record<SoundKind, number> = {
  step: 125,
  swing: 170,
  hit: 215,
  death: 265,
  reveal: 999,
  hide: 999,
  hurt: 999,
};

const DIFF = {
  easy: { speed: 44, hearing: 95, sight: 130, aggro: 0.8 },
  normal: { speed: 52, hearing: 120, sight: 150, aggro: 1 },
  hard: { speed: 60, hearing: 150, sight: 175, aggro: 1.25 },
};

export class Game {
  private canvas: HTMLCanvasElement;
  private ctx: CanvasRenderingContext2D;
  private settings: Settings;
  private onEnd: (r: Result) => void;
  private onPause: () => void;

  private sfx = new Sfx();
  private bg: HTMLCanvasElement;
  private obstacles: Obstacle[] = [];
  private fighters: Fighter[] = [];
  private corpses: Corpse[] = [];
  private ripples: Ripple[] = [];

  private keys = new Set<string>();
  private mouse = { x: VIEW_W / 2, y: VIEW_H / 2, down: false };
  private raf = 0;
  private last = 0;
  private running = false;
  private paused = false;
  private over = false;

  private time = 0;
  private phase: "hidden" | "visible" = "visible";
  private phaseLeft = VISIBLE_TIME;
  private flashScreen = 0;
  private shake = 0;
  private camX = 0;
  private camY = 0;

  constructor(
    canvas: HTMLCanvasElement,
    opts: { settings: Settings; onEnd: (r: Result) => void; onPause: () => void },
  ) {
    this.canvas = canvas;
    this.canvas.width = VIEW_W;
    this.canvas.height = VIEW_H;
    this.ctx = canvas.getContext("2d")!;
    this.ctx.imageSmoothingEnabled = false;
    this.settings = opts.settings;
    this.onEnd = opts.onEnd;
    this.onPause = opts.onPause;
    this.sfx.setVolume(opts.settings.volume);

    this.bg = this.buildWorld();
    this.spawnFighters();
  }

  // ---------- setup ----------

  private buildWorld(): HTMLCanvasElement {
    const c = document.createElement("canvas");
    c.width = WORLD_W;
    c.height = WORLD_H;
    const g = c.getContext("2d")!;
    const rand = mulberry32(1337);

    g.fillStyle = "#4e9e3e";
    g.fillRect(0, 0, WORLD_W, WORLD_H);

    // grass checker
    for (let y = 0; y < WORLD_H; y += 16) {
      for (let x = 0; x < WORLD_W; x += 16) {
        if (((x / 16 + y / 16) | 0) % 2 === 0) {
          g.fillStyle = "#4a9739";
          g.fillRect(x, y, 16, 16);
        }
      }
    }
    // grass tufts
    for (let i = 0; i < 900; i++) {
      const x = Math.floor(rand() * WORLD_W);
      const y = Math.floor(rand() * WORLD_H);
      g.fillStyle = rand() > 0.5 ? "#3f8a32" : "#5cae48";
      g.fillRect(x, y, 2, 1);
      g.fillRect(x + 1, y - 1, 1, 1);
    }

    // stone border
    const b = 10;
    g.fillStyle = "#7b7f86";
    g.fillRect(0, 0, WORLD_W, b);
    g.fillRect(0, WORLD_H - b, WORLD_W, b);
    g.fillRect(0, 0, b, WORLD_H);
    g.fillRect(WORLD_W - b, 0, b, WORLD_H);
    g.fillStyle = "#5e626a";
    for (let x = 0; x < WORLD_W; x += 20) {
      g.fillRect(x, 0, 1, b);
      g.fillRect(x, WORLD_H - b, 1, b);
    }
    for (let y = 0; y < WORLD_H; y += 20) {
      g.fillRect(0, y, b, 1);
      g.fillRect(WORLD_W - b, y, b, 1);
    }
    g.fillStyle = "#0c0c12";
    g.fillRect(0, b, WORLD_W, 1);
    g.fillRect(0, WORLD_H - b - 1, WORLD_W, 1);
    g.fillRect(b, 0, 1, WORLD_H);
    g.fillRect(WORLD_W - b - 1, 0, 1, WORLD_H);

    // simple cover
    const spots: Obstacle[] = [
      { x: 150, y: 120, w: 34, h: 24, kind: "bush" },
      { x: 660, y: 110, w: 34, h: 24, kind: "bush" },
      { x: 420, y: 300, w: 40, h: 28, kind: "bush" },
      { x: 180, y: 460, w: 34, h: 24, kind: "bush" },
      { x: 700, y: 470, w: 34, h: 24, kind: "bush" },
      { x: 330, y: 80, w: 18, h: 14, kind: "rock" },
      { x: 560, y: 520, w: 18, h: 14, kind: "rock" },
      { x: 80, y: 300, w: 18, h: 14, kind: "rock" },
      { x: 790, y: 290, w: 18, h: 14, kind: "rock" },
      { x: 470, y: 160, w: 18, h: 14, kind: "rock" },
    ];
    this.obstacles = spots;

    for (const o of spots) {
      if (o.kind === "bush") {
        g.fillStyle = "#0c0c12";
        g.fillRect(o.x - 1, o.y - 1, o.w + 2, o.h + 2);
        g.fillStyle = "#2f6f2a";
        g.fillRect(o.x, o.y, o.w, o.h);
        g.fillStyle = "#3d8a34";
        g.fillRect(o.x + 2, o.y + 2, o.w - 4, o.h - 8);
        g.fillStyle = "#54a844";
        for (let i = 0; i < 10; i++) {
          g.fillRect(o.x + 3 + Math.floor(rand() * (o.w - 6)), o.y + 3 + Math.floor(rand() * (o.h - 8)), 2, 2);
        }
      } else {
        g.fillStyle = "#0c0c12";
        g.fillRect(o.x - 1, o.y - 1, o.w + 2, o.h + 2);
        g.fillStyle = "#8b9099";
        g.fillRect(o.x, o.y, o.w, o.h);
        g.fillStyle = "#6a6f78";
        g.fillRect(o.x, o.y + o.h - 4, o.w, 4);
        g.fillStyle = "#a8adb6";
        g.fillRect(o.x + 2, o.y + 2, 5, 3);
      }
    }
    return c;
  }

  private makeFighter(id: number, player: boolean, x: number, y: number): Fighter {
    const d = DIFF[this.settings.difficulty];
    const sprite = buildSprite(player ? PLAYER_PAL : ENEMY_PALS[(id - 1) % ENEMY_PALS.length]);
    const f: Fighter = {
      id,
      player,
      x,
      y,
      vx: 0,
      vy: 0,
      dir: Math.PI / 2,
      hp: player ? 4 : 3,
      maxHp: player ? 4 : 3,
      alive: true,
      speed: player ? 60 : d.speed + rnd(-3, 3),
      sneak: false,
      cooldown: 0,
      swing: 0,
      swung: false,
      walkT: 0,
      stepT: 0,
      flash: 0,
      reveal: 0,
      kills: 0,
      sprite,
      art: null,
      think: 0,
      wander: null,
      known: null,
      hearing: d.hearing,
      sight: d.sight,
      nerve: d.aggro,
    };
    tryLoadOverride(player ? "/sprites/player.png" : `/sprites/enemy${id}.png`, (img) => {
      f.art = img;
    });
    return f;
  }

  private spawnFighters() {
    this.fighters = [this.makeFighter(0, true, WORLD_W / 2, WORLD_H / 2)];
    const spots = [
      { x: 90, y: 90 },
      { x: WORLD_W - 90, y: 90 },
      { x: 90, y: WORLD_H - 90 },
      { x: WORLD_W - 90, y: WORLD_H - 90 },
    ];
    spots.forEach((s, i) => this.fighters.push(this.makeFighter(i + 1, false, s.x, s.y)));
  }

  // ---------- lifecycle ----------

  start() {
    if (this.running) return;
    this.running = true;
    this.last = performance.now();
    window.addEventListener("keydown", this.onKeyDown);
    window.addEventListener("keyup", this.onKeyUp);
    this.canvas.addEventListener("mousemove", this.onMouseMove);
    this.canvas.addEventListener("mousedown", this.onMouseDown);
    window.addEventListener("mouseup", this.onMouseUp);
    this.raf = requestAnimationFrame(this.loop);
  }

  stop() {
    this.running = false;
    cancelAnimationFrame(this.raf);
    window.removeEventListener("keydown", this.onKeyDown);
    window.removeEventListener("keyup", this.onKeyUp);
    this.canvas.removeEventListener("mousemove", this.onMouseMove);
    this.canvas.removeEventListener("mousedown", this.onMouseDown);
    window.removeEventListener("mouseup", this.onMouseUp);
    this.sfx.close();
  }

  setPaused(p: boolean) {
    this.paused = p;
    this.keys.clear();
    if (!p) this.last = performance.now();
  }

  setSettings(s: Settings) {
    this.settings = s;
    this.sfx.setVolume(s.volume);
  }

  wakeAudio() {
    this.sfx.ensure();
  }

  // ---------- input ----------

  private onKeyDown = (e: KeyboardEvent) => {
    this.sfx.ensure();
    if (e.key === "Escape") {
      this.onPause();
      return;
    }
    if ([" ", "ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"].includes(e.key)) e.preventDefault();
    this.keys.add(e.key.toLowerCase());
  };

  private onKeyUp = (e: KeyboardEvent) => {
    this.keys.delete(e.key.toLowerCase());
  };

  private onMouseMove = (e: MouseEvent) => {
    const r = this.canvas.getBoundingClientRect();
    this.mouse.x = ((e.clientX - r.left) / r.width) * VIEW_W;
    this.mouse.y = ((e.clientY - r.top) / r.height) * VIEW_H;
  };

  private onMouseDown = () => {
    this.sfx.ensure();
    this.mouse.down = true;
  };

  private onMouseUp = () => {
    this.mouse.down = false;
  };

  // ---------- loop ----------

  private loop = (now: number) => {
    if (!this.running) return;
    const dt = Math.min(0.05, (now - this.last) / 1000);
    this.last = now;
    if (!this.paused && !this.over) this.update(dt);
    this.render();
    this.raf = requestAnimationFrame(this.loop);
  };

  private update(dt: number) {
    this.time += dt;
    this.flashScreen = Math.max(0, this.flashScreen - dt * 4);
    this.shake = Math.max(0, this.shake - dt * 12);

    this.phaseLeft -= dt;
    if (this.phaseLeft <= 0) {
      if (this.phase === "visible") {
        this.phase = "hidden";
        this.phaseLeft = HIDDEN_TIME;
        this.sfx.play("hide", 0.9, 0);
      } else {
        this.phase = "visible";
        this.phaseLeft = VISIBLE_TIME;
        this.flashScreen = 1;
        this.sfx.play("reveal", 0.9, 0);
      }
    }

    const player = this.fighters[0];
    if (player.alive) this.controlPlayer(player, dt);

    for (const f of this.fighters) {
      if (!f.alive) continue;
      if (!f.player) this.thinkAi(f, dt);
      this.moveFighter(f, dt);
      this.updateSwing(f, dt);
      f.flash = Math.max(0, f.flash - dt);
      f.reveal = Math.max(0, f.reveal - dt);
      if (f.cooldown > 0) f.cooldown -= dt;
    }

    for (let i = this.ripples.length - 1; i >= 0; i--) {
      const r = this.ripples[i];
      r.r += dt * 90;
      if (r.r > r.max) this.ripples.splice(i, 1);
    }
  }

  private controlPlayer(p: Fighter, dt: number) {
    const k = this.keys;
    let dx = 0;
    let dy = 0;
    if (k.has("a") || k.has("arrowleft")) dx -= 1;
    if (k.has("d") || k.has("arrowright")) dx += 1;
    if (k.has("w") || k.has("arrowup")) dy -= 1;
    if (k.has("s") || k.has("arrowdown")) dy += 1;
    const len = Math.hypot(dx, dy);
    p.sneak = k.has("shift");
    const sp = p.speed * (p.sneak ? 0.5 : 1);
    if (len > 0) {
      p.vx = (dx / len) * sp;
      p.vy = (dy / len) * sp;
    } else {
      p.vx = 0;
      p.vy = 0;
    }
    // face the mouse
    const mwx = this.camX + this.mouse.x;
    const mwy = this.camY + this.mouse.y;
    p.dir = Math.atan2(mwy - p.y, mwx - p.x);

    if (this.mouse.down || k.has(" ")) this.attack(p);
    void dt;
  }

  private thinkAi(f: Fighter, dt: number) {
    f.think -= dt;

    // eyes only work while everyone is visible
    if (this.phase === "visible" && f.think <= 0) {
      f.think = 0.2;
      let best: Fighter | null = null;
      let bestD = f.sight;
      for (const o of this.fighters) {
        if (o === f || !o.alive) continue;
        const d = Math.hypot(o.x - f.x, o.y - f.y);
        if (d < bestD) {
          bestD = d;
          best = o;
        }
      }
      if (best) f.known = { x: best.x, y: best.y, t: this.time };
    }

    const memory = f.known && this.time - f.known.t < 5 ? f.known : null;
    let tx: number;
    let ty: number;
    let chasing = false;

    if (memory) {
      tx = memory.x;
      ty = memory.y;
      chasing = true;
    } else {
      if (!f.wander || Math.hypot(f.wander.x - f.x, f.wander.y - f.y) < 14) {
        f.wander = {
          x: clamp(f.x + rnd(-180, 180), 30, WORLD_W - 30),
          y: clamp(f.y + rnd(-180, 180), 30, WORLD_H - 30),
        };
      }
      tx = f.wander.x;
      ty = f.wander.y;
    }

    const dx = tx - f.x;
    const dy = ty - f.y;
    const dist = Math.hypot(dx, dy) || 1;
    f.dir = Math.atan2(dy, dx);
    f.sneak = !chasing;
    const sp = f.speed * (chasing ? 1 : 0.55);

    if (chasing && dist < HIT_RANGE - 4) {
      f.vx = 0;
      f.vy = 0;
      this.attack(f);
    } else {
      f.vx = (dx / dist) * sp;
      f.vy = (dy / dist) * sp;
      // blind swing when it thinks something is close
      if (chasing && dist < HIT_RANGE + 12 && Math.random() < 0.35 * f.nerve * dt * 10) this.attack(f);
    }
  }

  private moveFighter(f: Fighter, dt: number) {
    const moving = Math.abs(f.vx) + Math.abs(f.vy) > 1;
    if (moving) {
      f.walkT += dt * (f.sneak ? 4 : 8);
      f.stepT -= dt;
      if (f.stepT <= 0) {
        f.stepT = f.sneak ? 0.55 : 0.34;
        this.emitSound("step", f, f.sneak ? 0.45 : 1);
      }
    } else {
      f.walkT = 0;
    }

    let nx = f.x + f.vx * dt;
    let ny = f.y + f.vy * dt;
    nx = clamp(nx, 16, WORLD_W - 16);
    ny = clamp(ny, 22, WORLD_H - 14);

    for (const o of this.obstacles) {
      const cx = clamp(nx, o.x, o.x + o.w);
      const cy = clamp(ny, o.y, o.y + o.h);
      const ddx = nx - cx;
      const ddy = ny - cy;
      const d = Math.hypot(ddx, ddy);
      if (d < BODY_R) {
        if (d === 0) {
          ny = o.y - BODY_R;
        } else {
          nx = cx + (ddx / d) * BODY_R;
          ny = cy + (ddy / d) * BODY_R;
        }
      }
    }

    // keep bodies apart a bit
    for (const o of this.fighters) {
      if (o === f || !o.alive) continue;
      const ddx = nx - o.x;
      const ddy = ny - o.y;
      const d = Math.hypot(ddx, ddy);
      if (d > 0 && d < 9) {
        nx = o.x + (ddx / d) * 9;
        ny = o.y + (ddy / d) * 9;
      }
    }

    f.x = nx;
    f.y = ny;
  }

  private attack(f: Fighter) {
    if (f.cooldown > 0 || f.swing > 0) return;
    f.swing = SWING_TIME;
    f.swung = false;
    f.cooldown = 0.7;
    this.emitSound("swing", f, 1);
  }

  private updateSwing(f: Fighter, dt: number) {
    if (f.swing <= 0) return;
    f.swing -= dt;
    if (!f.swung && f.swing <= SWING_TIME * 0.5) {
      f.swung = true;
      for (const o of this.fighters) {
        if (o === f || !o.alive) continue;
        const dx = o.x - f.x;
        const dy = o.y - f.y;
        const d = Math.hypot(dx, dy);
        if (d > HIT_RANGE + BODY_R) continue;
        let diff = Math.atan2(dy, dx) - f.dir;
        while (diff > Math.PI) diff -= Math.PI * 2;
        while (diff < -Math.PI) diff += Math.PI * 2;
        if (Math.abs(diff) < 1.05) this.damage(o, f);
      }
    }
    if (f.swing < 0) f.swing = 0;
  }

  private damage(target: Fighter, from: Fighter) {
    target.hp -= 1;
    target.flash = 0.22;
    target.reveal = 0.55; // a hit body flickers into view
    const a = Math.atan2(target.y - from.y, target.x - from.x);
    target.x = clamp(target.x + Math.cos(a) * 9, 16, WORLD_W - 16);
    target.y = clamp(target.y + Math.sin(a) * 9, 22, WORLD_H - 14);
    this.emitSound("hit", target, 1);
    if (target.player) {
      this.shake = 1;
      this.sfx.play("hurt", 0.8, 0);
      // whoever cut you flickers into view for a moment
      from.reveal = Math.max(from.reveal, 0.5);
      if (this.settings.ripples) {
        this.ripples.push({ x: from.x, y: from.y, r: 3, max: 34, color: "#ff7070" });
      }
    }
    if (target.hp <= 0) this.kill(target, from);
  }

  private kill(target: Fighter, from: Fighter) {
    target.alive = false;
    from.kills += 1;
    this.corpses.push({ x: target.x, y: target.y, sprite: target.sprite });
    this.emitSound("death", target, 1);
    const alive = this.fighters.filter((f) => f.alive);
    const player = this.fighters[0];
    if (!player.alive) this.finish(false);
    else if (alive.length === 1) this.finish(true);
  }

  private finish(win: boolean) {
    if (this.over) return;
    this.over = true;
    const player = this.fighters[0];
    this.onEnd({ win, kills: player.kills, time: Math.floor(this.time) });
  }

  // ---------- sound ----------

  private emitSound(kind: SoundKind, source: Fighter, strength: number) {
    const range = SOUND_RANGE[kind] * strength;
    const player = this.fighters[0];

    // what the player hears
    if (source.player) {
      this.sfx.play(kind, 0.55 * strength, 0);
    } else {
      const d = Math.hypot(source.x - player.x, source.y - player.y);
      if (d < range) {
        const vol = Math.pow(1 - d / range, 1.5);
        const pan = clamp((source.x - player.x) / 140, -1, 1);
        this.sfx.play(kind, vol, pan);
        if (this.settings.ripples) {
          this.ripples.push({
            x: source.x,
            y: source.y,
            r: 3,
            max: 10 + 26 * vol,
            color: kind === "step" ? "#ffffff" : kind === "swing" ? "#ffe680" : "#ff7070",
          });
        }
      }
    }

    // what the bots hear
    for (const f of this.fighters) {
      if (f === source || !f.alive || f.player) continue;
      const d = Math.hypot(source.x - f.x, source.y - f.y);
      if (d < Math.min(range, f.hearing * strength)) {
        const miss = 6 + (d / 100) * 14;
        f.known = {
          x: source.x + rnd(-miss, miss),
          y: source.y + rnd(-miss, miss),
          t: this.time,
        };
      }
    }
  }

  // ---------- render ----------

  private render() {
    const ctx = this.ctx;
    const player = this.fighters[0];
    ctx.imageSmoothingEnabled = false;

    let camX = clamp(player.x - VIEW_W / 2, 0, WORLD_W - VIEW_W);
    let camY = clamp(player.y - VIEW_H / 2, 0, WORLD_H - VIEW_H);
    if (this.shake > 0) {
      camX += rnd(-2, 2) * this.shake;
      camY += rnd(-2, 2) * this.shake;
    }
    this.camX = Math.round(camX);
    this.camY = Math.round(camY);

    ctx.clearRect(0, 0, VIEW_W, VIEW_H);
    ctx.drawImage(this.bg, this.camX, this.camY, VIEW_W, VIEW_H, 0, 0, VIEW_W, VIEW_H);

    for (const c of this.corpses) {
      const cx = Math.round(c.x - this.camX);
      const cy = Math.round(c.y - this.camY);
      ctx.fillStyle = "rgba(120,20,20,0.5)";
      ctx.fillRect(cx - 7, cy - 2, 14, 4);
      ctx.globalAlpha = 0.8;
      ctx.save();
      ctx.translate(cx, cy);
      ctx.rotate(Math.PI / 2);
      ctx.drawImage(c.sprite.ghost, -SPRITE_W / 2, -SPRITE_H / 2);
      ctx.restore();
      ctx.globalAlpha = 1;
    }

    const order = this.fighters.filter((f) => f.alive).sort((a, b) => a.y - b.y);
    for (const f of order) this.drawFighter(f);

    for (const r of this.ripples) {
      const a = clamp(1 - r.r / r.max, 0, 1) * 0.55;
      ctx.strokeStyle = r.color;
      ctx.globalAlpha = a;
      ctx.beginPath();
      ctx.arc(Math.round(r.x - this.camX), Math.round(r.y - this.camY), r.r, 0, Math.PI * 2);
      ctx.stroke();
      ctx.globalAlpha = 1;
    }

    if (this.phase === "hidden") {
      ctx.fillStyle = "rgba(10,16,30,0.3)";
      ctx.fillRect(0, 0, VIEW_W, VIEW_H);
    }
    if (this.flashScreen > 0) {
      ctx.fillStyle = `rgba(255,255,255,${this.flashScreen * 0.5})`;
      ctx.fillRect(0, 0, VIEW_W, VIEW_H);
    }

    this.drawHud();
  }

  private drawFighter(f: Fighter) {
    const ctx = this.ctx;
    const visible = f.player || this.phase === "visible" || f.reveal > 0;
    if (!visible) return;

    const sx = Math.round(f.x - this.camX - SPRITE_W / 2);
    const sy = Math.round(f.y - this.camY - SPRITE_H + 4);

    // shadow
    ctx.fillStyle = "rgba(0,0,0,0.25)";
    ctx.fillRect(sx + 3, sy + SPRITE_H - 2, SPRITE_W - 6, 2);

    const ghostMode = f.player && this.phase === "hidden";
    ctx.globalAlpha = ghostMode ? 0.45 : 1;

    if (f.art) {
      const scale = Math.min(SPRITE_W / f.art.width, SPRITE_H / f.art.height);
      const w = Math.round(f.art.width * scale);
      const h = Math.round(f.art.height * scale);
      ctx.drawImage(f.art, sx + Math.round((SPRITE_W - w) / 2), sy + (SPRITE_H - h), w, h);
    } else {
      const up = Math.sin(f.dir) < -0.4;
      const frames = up ? f.sprite.up : f.sprite.down;
      const moving = Math.abs(f.vx) + Math.abs(f.vy) > 1;
      const frame = moving && Math.floor(f.walkT) % 2 === 1 ? frames[1] : frames[0];
      const flip = !up && Math.cos(f.dir) < -0.2;
      if (flip) {
        ctx.save();
        ctx.translate(sx + SPRITE_W, sy);
        ctx.scale(-1, 1);
        ctx.drawImage(frame, 0, 0);
        ctx.restore();
      } else {
        ctx.drawImage(frame, sx, sy);
      }
    }

    if (f.flash > 0) {
      ctx.globalAlpha = 0.85;
      ctx.drawImage(f.sprite.flash, sx, sy);
    }
    ctx.globalAlpha = 1;

    this.drawSword(f, ghostMode ? 0.45 : 1);

    // tiny hp pips above head
    if (!f.player && (this.phase === "visible" || f.reveal > 0)) {
      for (let i = 0; i < f.hp; i++) {
        ctx.fillStyle = "#0c0c12";
        ctx.fillRect(sx + 2 + i * 4, sy - 4, 3, 3);
        ctx.fillStyle = "#e04b4b";
        ctx.fillRect(sx + 2 + i * 4, sy - 4, 2, 2);
      }
    }
  }

  private drawSword(f: Fighter, alpha = 1) {
    const ctx = this.ctx;
    ctx.globalAlpha = alpha;
    let angle = f.dir + 0.8;
    if (f.swing > 0) {
      const p = 1 - f.swing / SWING_TIME;
      angle = f.dir - 1.15 + p * 2.3;
    }
    const hx = f.x - this.camX + Math.cos(f.dir) * 3;
    const hy = f.y - this.camY - 5 + Math.sin(f.dir) * 2;
    const len = 12;

    // handle
    ctx.fillStyle = "#6b4630";
    ctx.fillRect(Math.round(hx - 1), Math.round(hy - 1), 2, 2);

    for (let i = 2; i < len; i++) {
      const px = Math.round(hx + Math.cos(angle) * i);
      const py = Math.round(hy + Math.sin(angle) * i);
      ctx.fillStyle = "#0c0c12";
      ctx.fillRect(px, py + 1, 1, 1);
      ctx.fillStyle = i > len - 3 ? "#ffffff" : "#d4d8e2";
      ctx.fillRect(px, py, 1, 1);
    }

    if (f.swing > 0) {
      ctx.strokeStyle = "rgba(255,255,255,0.35)";
      ctx.beginPath();
      ctx.arc(hx, hy, len, angle - 0.7, angle);
      ctx.stroke();
    }
    ctx.globalAlpha = 1;
  }

  private drawHud() {
    const ctx = this.ctx;
    const player = this.fighters[0];

    // hearts
    for (let i = 0; i < player.maxHp; i++) {
      const x = 6 + i * 9;
      const y = 6;
      const on = i < player.hp;
      ctx.fillStyle = "#0c0c12";
      ctx.fillRect(x - 1, y - 1, 9, 8);
      ctx.fillStyle = on ? "#e04b4b" : "#3a3a46";
      ctx.fillRect(x, y, 7, 5);
      ctx.fillRect(x + 1, y + 5, 5, 1);
      ctx.fillRect(x + 2, y + 6, 3, 1);
      ctx.fillStyle = on ? "#ff8a8a" : "#4a4a58";
      ctx.fillRect(x + 1, y + 1, 2, 1);
    }

    // phase bar
    const total = this.phase === "hidden" ? HIDDEN_TIME : VISIBLE_TIME;
    const pct = clamp(this.phaseLeft / total, 0, 1);
    const bw = 96;
    const bx = Math.round(VIEW_W / 2 - bw / 2);
    ctx.fillStyle = "#0c0c12";
    ctx.fillRect(bx - 2, 4, bw + 4, 9);
    ctx.fillStyle = "#23262e";
    ctx.fillRect(bx, 6, bw, 5);
    ctx.fillStyle = this.phase === "hidden" ? "#5aa9ff" : "#6ddf5a";
    ctx.fillRect(bx, 6, Math.round(bw * pct), 5);

    const label = `${this.phase === "hidden" ? "HIDDEN" : "VISIBLE"} ${Math.ceil(this.phaseLeft)}`;
    drawText(ctx, label, Math.round(VIEW_W / 2 - textWidth(label) / 2), 16, "#e8f2e8", 1);

    const alive = this.fighters.filter((f) => f.alive).length;
    const at = `ALIVE ${alive}`;
    drawText(ctx, at, VIEW_W - 6 - textWidth(at), 7, "#e8f2e8", 1);

    if (player.sneak && player.alive) {
      drawText(ctx, "SNEAK", 6, VIEW_H - 11, "#a8e39a", 1);
    }
  }
}
