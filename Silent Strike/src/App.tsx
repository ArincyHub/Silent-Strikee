import { useEffect, useState } from "react";
import GameScreen from "./components/GameScreen";
import { MainMenu, SettingsScreen, SocialsScreen } from "./components/Menu";
import { Settings } from "./game/engine";

type ScreenName = "menu" | "settings" | "socials" | "game";

const DEFAULTS: Settings = { volume: 0.7, ripples: true, difficulty: "normal" };

function loadSettings(): Settings {
  try {
    const raw = localStorage.getItem("silentstrike.settings");
    if (raw) return { ...DEFAULTS, ...JSON.parse(raw) };
  } catch {
    /* ignore */
  }
  return DEFAULTS;
}

export default function App() {
  const [screen, setScreen] = useState<ScreenName>("menu");
  const [settings, setSettings] = useState<Settings>(loadSettings);

  useEffect(() => {
    try {
      localStorage.setItem("silentstrike.settings", JSON.stringify(settings));
    } catch {
      /* ignore */
    }
  }, [settings]);

  if (screen === "game") {
    return <GameScreen settings={settings} onExit={() => setScreen("menu")} />;
  }

  if (screen === "settings") {
    return (
      <SettingsScreen settings={settings} setSettings={setSettings} onBack={() => setScreen("menu")} />
    );
  }

  if (screen === "socials") {
    return <SocialsScreen onBack={() => setScreen("menu")} />;
  }

  return (
    <MainMenu
      onPlay={() => setScreen("game")}
      onSettings={() => setScreen("settings")}
      onSocials={() => setScreen("socials")}
    />
  );
}
