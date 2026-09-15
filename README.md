# Ombiance

A bar-widget plugin for the [Omarchy](https://omarchy.org/) shell that plays
looping ambient background soundscapes — waves, a coffee shop, a restaurant,
a rainy Tokyo night street, a fireplace, highway traffic, a nighttime
forest, rain, a thunderstorm, a quiet library, a train journey, and morning
birdsong — for work, play, or sleep.

## Dependencies

- `mpv` — does the actual audio playback
- `socat` — talks to mpv's JSON IPC socket
- `python3` — parses the JSON IPC replies

All three ship on a stock Omarchy install.

## Install

```bash
ln -s /home/f4nt0m/Work/omarchy-ombiance ~/.config/omarchy/plugins/io.github.phillipelwood1.ombiance
omarchy-shell shell rescanPlugins
omarchy plugin enable io.github.phillipelwood1.ombiance
```

The plugin lands in the right section of the bar. Moving it is the usual
`omarchy bar move io.github.phillipelwood1.ombiance --section <left|center|right>`.

Because it's a symlink back into this dev checkout, editing the QML here and
saving hot-reloads it in the running shell (`~/.config/omarchy/plugins/`
watches for changes) — no reinstall step needed.

## Using it

- **Left-click** the bar icon to open the soundscape picker.
- Click a **soundscape tile** to start it (switches instantly if something
  is already playing — no restart, no volume glitch).
- The **Work / Play / Sleep / All** row filters which tiles are shown.
- The transport row **pauses/resumes** and **stops** playback; the slider
  sets volume live.
- **Right-click** the bar icon to toggle pause, **middle-click** to stop,
  without opening the panel.

Volume and your last mood filter are remembered in `shell.json` across
restarts.

## How it works

`scripts/ombiance-ctl` is a small bash wrapper around a single long-lived
`mpv --idle=yes --loop-file=inf --input-ipc-server=...` process. The QML
panel shells out to it (`play <category> <file> [volume]`, `stop`,
`toggle-pause`, `volume <0-100>`, `status`) instead of embedding playback
logic directly, matching how Omarchy's own first-party bar widgets (network,
power, audio) delegate to small scripts and just render the result.

## Adding more soundscapes

1. Drop a looping `.ogg` file into `sounds/` — name it `<id>.ogg`.
2. Add `{ id: "<id>", label: "...", icon: "...", moods: [...] }` to the
   `soundscapes` array in `Model.js`. `moods` is any of `work`, `play`,
   `sleep`.

See `sounds/SOURCES.md` for the license/attribution of the bundled audio.
