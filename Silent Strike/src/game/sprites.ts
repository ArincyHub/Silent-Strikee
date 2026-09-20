// Pixel characters are drawn from small text maps.
// If you drop your own art in  public/sprites/player.png  and
// public/sprites/enemy1.png ... enemy4.png  the game uses those instead.

export type Palette = {
  outline: string;
  hair: string;
  skin: string;
  eyes: string;
  body: string; // shirt / suit
  shirt: string; // collar
  accent: string; // tie
  pants: string;
};

// player look = brown hair, black suit, red tie
export const PLAYER_PAL: Palette = {
  outline: "#0c0c12",
  hair: "#7a4a28",
  skin: "#eab991",
  eyes: "#0c0c12",
  body: "#242430",
  shirt: "#f0f0f0",
  accent: "#d0342c",
  pants: "#353542",
};

// enemies = black hair, blue shirt guys (small colour changes each one)
export const ENEMY_PALS: Palette[] = [
  {
    outline: "#0c0c12",
    hair: "#15151c",
    skin: "#eab991",
    eyes: "#0c0c12",
    body: "#5d7694",
    shirt: "#93a9c2",
    accent: "#3f6fd8",
    pants: "#3f6fd8",
  },
  {
    outline: "#0c0c12",
    hair: "#2b1d12",
    skin: "#d4a074",
    eyes: "#0c0c12",
    body: "#7a5f8f",
    shirt: "#b39ac4",
    accent: "#4a3c78",
    pants: "#4a3c78",
  },
  {
    outline: "#0c0c12",
    hair: "#15151c",
    skin: "#b98055",
    eyes: "#0c0c12",
    body: "#8f5b4a",
    shirt: "#c99280",
    accent: "#5a3a2e",
    pants: "#5a3a2e",
  },
  {
    outline: "#0c0c12",
    hair: "#5c5c66",
    skin: "#eab991",
    eyes: "#0c0c12",
    body: "#4d7a5a",
    shirt: "#8fc49c",
    accent: "#2f4a38",
    pants: "#2f4a38",
  },
];

// . = empty  K = outline  H = hair  S = skin  E = eye
// B = body   W = collar   R = tie   P = pants
const HEAD_BODY = [
  "....KKKKKKKK....",
  "....KHHHHHHK....",
  "....KHHHHHHK....",
  "....KHSSSSHK....",
  "....KHESSEHK....",
  "....KHSSSSHK....",
  "....KSSSSSSK....",
  "....KKSSSSKK....",
  "..KBBBBBBBBBBK..",
  "..KBBBWWWWBBBK..",
  "..KBBBWRRWBBBK..",
  "..KBBBBRRBBBBK..",
  "..KBBBBRRBBBBK..",
  "..KBBBBBBBBBBK..",
];

const LEGS_STAND = [
  "..KPPPPKKPPPPK..",
  "..KPPPPKKPPPPK..",
  "..KPPPPKKPPPPK..",
  "..KKKKK..KKKKK..",
];

const LEGS_WALK = [
  "..KPPPPKKPPPPK..",
  "..KPPPPKKPPPPK..",
  ".KPPPPK..KPPPPK.",
  ".KKKKKK..KKKKKK.",
];

function colorFor(ch: string, pal: Palette): string | null {
  switch (ch) {
    case "K":
      return pal.outline;
    case "H":
      return pal.hair;
    case "S":
      return pal.skin;
    case "E":
      return pal.eyes;
    case "B":
      return pal.body;
    case "W":
      return pal.shirt;
    case "R":
      return pal.accent;
    case "P":
      return pal.pants;
    default:
      return null;
  }
}

function makeCanvas(w: number, h: number) {
  const c = document.createElement("canvas");
  c.width = w;
  c.height = h;
  return c;
}

function drawRows(rows: string[], pal: Palette): HTMLCanvasElement {
  const c = makeCanvas(rows[0].length, rows.length);
  const g = c.getContext("2d")!;
  rows.forEach((row, y) => {
    for (let x = 0; x < row.length; x++) {
      const col = colorFor(row[x], pal);
      if (!col) continue;
      g.fillStyle = col;
      g.fillRect(x, y, 1, 1);
    }
  });
  return c;
}

// back view: hide the face, no tie
function backRows(rows: string[]): string[] {
  return rows.map((r) =>
    r
      .split("")
      .map((ch) => {
        if (ch === "S" || ch === "E") return "H";
        if (ch === "W" || ch === "R") return "B";
        return ch;
      })
      .join(""),
  );
}

function silhouette(src: HTMLCanvasElement, color: string): HTMLCanvasElement {
  const c = makeCanvas(src.width, src.height);
  const g = c.getContext("2d")!;
  g.drawImage(src, 0, 0);
  g.globalCompositeOperation = "source-in";
  g.fillStyle = color;
  g.fillRect(0, 0, c.width, c.height);
  return c;
}

export type CharSprite = {
  down: HTMLCanvasElement[]; // 2 frames
  up: HTMLCanvasElement[];
  flash: HTMLCanvasElement; // white hit flash
  ghost: HTMLCanvasElement; // dark silhouette (corpse)
};

export function buildSprite(pal: Palette): CharSprite {
  const down0 = drawRows([...HEAD_BODY, ...LEGS_STAND], pal);
  const down1 = drawRows([...HEAD_BODY, ...LEGS_WALK], pal);
  const backBase = backRows(HEAD_BODY);
  const up0 = drawRows([...backBase, ...LEGS_STAND], pal);
  const up1 = drawRows([...backBase, ...LEGS_WALK], pal);
  return {
    down: [down0, down1],
    up: [up0, up1],
    flash: silhouette(down0, "#ffffff"),
    ghost: silhouette(down0, "#2a2a33"),
  };
}

// optional: use real art files if the player added them
export function tryLoadOverride(url: string, onLoad: (img: HTMLImageElement) => void) {
  const img = new Image();
  img.onload = () => onLoad(img);
  img.onerror = () => {
    /* no file yet, keep the drawn pixels */
  };
  img.src = url;
}

export const SPRITE_W = 16;
export const SPRITE_H = 18;
