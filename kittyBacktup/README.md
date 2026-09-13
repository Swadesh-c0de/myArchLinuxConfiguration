# Kitty Terminal Backup (`kittyBacktup`)

This directory contains a complete, self-contained backup of your modern Kitty terminal setup, including all configuration files, theme presets, and offline font bundles.

---

## What's Included

- `config/kitty.conf` — Full modern Kitty configuration (clean typography, ligatures, window padding, animated cursor trails, slanted powerline tabs, splits, productivity shortcuts).
- `config/theme.conf` — Active dark theme (OLED Charcoal: neutral pitch-black `#121214` with amber/gold accents, zero deep blue).
- `config/themes/` — Presets library (`oled-charcoal.conf`, `gruvbox-dark.conf`, `kanagawa-dragon.conf`, `rose-pine.conf`, `catppuccin-mocha.conf`, `tokyo-night.conf`, `nord.conf`).
- `fonts/JetBrainsMono.tar.xz` — Complete official JetBrains Mono Nerd Font bundle (offline archive, works without internet).
- `restore.sh` — Automated one-click restore script.

---

## How to Restore on a Fresh Linux Install

1. Open your terminal in this folder.
2. Run the restore script:
   ```bash
   bash restore.sh
   ```
   *(or `./restore.sh`)*
3. If Kitty isn't installed yet, install it with:
   - **Arch Linux:** `sudo pacman -S kitty`
   - **Ubuntu/Debian:** `sudo apt install kitty`
   - **Fedora:** `sudo dnf install kitty`
4. Done! Launch Kitty and everything will look identical to your current setup.
