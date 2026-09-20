import { useEffect, useRef } from "react";
import { buildSprite, Palette, SPRITE_H, SPRITE_W } from "../game/sprites";

type Props = { palette: Palette; scale?: number; className?: string };

export default function PixelChar({ palette, scale = 5, className }: Props) {
  const ref = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    const c = ref.current;
    if (!c) return;
    const g = c.getContext("2d");
    if (!g) return;
    const sprite = buildSprite(palette);
    let frame = 0;
    const id = window.setInterval(() => {
      frame = 1 - frame;
      g.imageSmoothingEnabled = false;
      g.clearRect(0, 0, c.width, c.height);
      g.drawImage(sprite.down[frame], 0, 0, SPRITE_W, SPRITE_H, 0, 0, c.width, c.height);
    }, 320);
    g.imageSmoothingEnabled = false;
    g.drawImage(sprite.down[0], 0, 0, SPRITE_W, SPRITE_H, 0, 0, c.width, c.height);
    return () => window.clearInterval(id);
  }, [palette]);

  return (
    <canvas
      ref={ref}
      width={SPRITE_W * scale}
      height={SPRITE_H * scale}
      className={`pixelated ${className ?? ""}`}
    />
  );
}
