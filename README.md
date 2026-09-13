# my-ArchLinux-Configuration

## Automated Setup 🚀

To set up everything automatically (packages, configurations, themes), simply run:

```bash
chmod +x setup.sh
./setup.sh
```

### Modular Setup Options ⚙️

You can run individual tasks using CLI flags or an interactive menu:

```bash
./setup.sh --help       # Display all options
./setup.sh --menu       # Launch interactive menu
./setup.sh --all        # Run all setup tasks (1-7, including KDE & SDDM)
./setup.sh --system     # Task 1: System update, base tools, yay, parallel
./setup.sh --packages   # Task 2: Categorized package installation
./setup.sh --services   # Task 3: System services configuration
./setup.sh --shell      # Task 4: Zsh, plugins, Kitty, Fastfetch
./setup.sh --tweaks     # Task 5: Desktop & application tweaks
./setup.sh --nvidia     # Task 6: NVIDIA & GRUB tweaks
./setup.sh --kde        # Task 7: KDE configs & SDDM theme restoration
```

You can also run any task script independently:
```bash
./scripts/01-system-update.sh
./scripts/02-packages.sh
./scripts/03-services.sh
./scripts/04-shell-terminal.sh
./scripts/05-desktop-tweaks.sh
./scripts/06-nvidia.sh
./scripts/07-kde-sddm.sh
```

### KDE & SDDM Restoration 🎨

To restore your KDE desktop settings (panels, shortcuts, theme) and the SDDM login theme, run:

```bash
chmod +x restore_kde_sddm.sh
./restore_kde_sddm.sh
```

### Backing up current settings 💾

If you make changes to your KDE settings or terminal configs and want to update the repo, run:

```bash
chmod +x sync_to_repo.sh
./sync_to_repo.sh
```

---


The tools and settings I utilized in the Arch Linux operating system for better learning and development are in this repository.

## Softwares and Tools:-
- yay
- google-chrome
- Mission Center
- Stacer
- Kitty
- Eye of Gnome ([Visit Site](https://archlinux.org/packages/extra/x86_64/eog/))
- Spectacle (for screenshot)
- Telegram
- visual-studio-code-bin
- superfile ([Visit Site](https://superfile.netlify.app/))
- LibreOffice ([Visit Site](https://wiki.archlinux.org/title/LibreOffice))
- zsh and oh_my_zsh
- Obsidian
- Calculator ([Visit Site](https://apps.kde.org/en-gb/kalk/))

### More
- Postman
- Requestly `yay -S requestly-bin`
- Warp
- Windsurf
- MongoDB Compass
- Mongosh
- Antigravity

### Setting up MongoDB Compass
```bash
yay -S mongodb-compass-bin mongodb-bin
sudo systemctl enable --now mongodb
```

## Coding modules
- jdk
```bash
sudo pacman -S jdk-openjdk
```

## Packages:-
- For Power Profile (For KDE Plasma Desktop Environment)
```bash
sudo pacman -S power-profiles-daemon
```
```bash
sudo systemctl enable power-profiles-daemon.service
```
```bash
sudo reboot
```
- For Bluetooth
```bash
yay -S bluez bluez-utils
```
```bash
sudo systemctl enable bluetooth
```
```bash
sudo systemctl start bluetooth
```
- Fastfetch
```bash
yay -S fastfetch
```
- Neofetch
```bash
yay -S neofetch
```
- For Screenshot
```bash
yay -S spectacle
```
- For System Monitoring
```bash
sudo pacman -S htop btop nvtop
```
- For live wallpaper
Downlaod plugin `Smart Video Wallpaper Reborn`

- For monochromatic icon pack
Downlaod `yetYet Another Monochrome Icon Set For KDE Plasma`
([See This](https://store.kde.org/p/2303161))

## Configurations:-

### kitty:
> To show the images on new terminal tab opening. Run the below command
```bash
nano ~/.bashrc || ~/.zshrc
```
> Then copy the following script and paste in the file
```bash
if [ -z "$STARTUP_IMAGE_DISPLAYED" ]; then
    # Get a random image from the directory
    IMAGE_PATH=$(find /home/veronica/.config/fastfetch/pngs/ -type f -iname "*.png" | shuf -n 1)

    # Set the desired height in pixels (you can experiment with this value)
    HEIGHT=300  # Adjust this value for your needs

    # Resize the image using ImageMagick (magick convert)
    RESIZED_IMAGE_PATH="/tmp/resized_image.png"
    magick "$IMAGE_PATH" -resize x$HEIGHT "$RESIZED_IMAGE_PATH"

    # Display the resized image using kitty
    kitty +kitten icat "$RESIZED_IMAGE_PATH"

    # Set the environment variable to avoid re-running
    export STARTUP_IMAGE_DISPLAYED=1
fi
```
> Requirements
```bash
imagemagick
```
> That will render the image at the path when a new kitty tab will open.

### visual-studio-code-bin: 
> Run the below command
```bash
sudo nano /home/veronica/.config/Code/User/settings.json
```
> Remove everything and then paste this
```json
{
    "workbench.colorTheme": "Catppuccin Mocha",
    "emmet.includeLanguages": {
        "javascript": "javascriptreact"
    },
    "editor.mouseWheelZoom": true,
    "code-runner.runInTerminal": true,
    "code-runner.saveFileBeforeRun": true,
    "liveServer.settings.donotShowInfoMsg": true,
    "workbench.iconTheme": "material-icon-theme",
    "javascript.updateImportsOnFileMove.enabled": "always",
    "git.openRepositoryInParentFolders": "always",
    "editor.fontFamily": "'Maple Mono', 'monospace', monospace",
    "editor.fontSize": 18,
    "editor.fontWeight": "normal",
    "editor.fontLigatures": false,
    "terminal.integrated.inheritEnv": false
}
```

### Fixing sound issue (In Acer Predator Helios Neo 16 PHN16-71):
> Run below commands
```
wpctl status
```
```
sudo modprobe snd_hda_intel
```
```
wpctl status
```

### Kitty Configuration:

The repository includes a modern, high-aesthetic Kitty terminal configuration located in `.config/kitty/`.

#### Quick Deployment
Deploy the configuration and shell setup automatically:
```bash
./setup.sh --shell
```
Or use the self-contained restore script from the backup folder:
```bash
cd kittyBacktup && ./restore.sh
```

#### Key Highlights
- **Typography & Ligatures:** Uses **JetBrains Mono Nerd Font** with programming ligatures (`disable_ligatures cursor`) and generous `115%` cell line height.
- **Dark Theme (Zero Deep Blue):** Active theme is **OLED Charcoal** (`#121214` neutral pitch dark with warm amber `#E78A4E` highlights, eliminating cold/blue undertones).
- **Theme Presets Library:** Alternative dark themes stored in `.config/kitty/themes/` (`oled-charcoal.conf`, `gruvbox-dark.conf`, `kanagawa-dragon.conf`, `rose-pine.conf`, `tokyo-night.conf`, `catppuccin-mocha.conf`, `nord.conf`). Switch anytime with `kitten themes`.
- **Fluid Cursor Animation:** Kitty particle trailing animation on cursor jumps (`cursor_trail 3`).
- **Glassmorphism & Padding:** `12px 16px` padding, borderless frameless window, and subtle background blur.
- **Powerline Tab Bar:** Slanted powerline tab bar showing tab index and active folder name.
- **Productivity Shortcuts:**
  - `Ctrl + Shift + Enter` / `Ctrl + Shift + D`: Create vertical / horizontal splits (inherits current directory)
  - `Ctrl + Shift + Z`: Toggle zoom / maximize active split
  - `Ctrl + Shift + H/J/K/L`: Navigate between splits
  - `Alt + 1..9`: Direct tab switching
  - `Ctrl + Shift + E`: Click/open URLs via kitten hints
  - `Ctrl + Shift + F10 / F11`: Dynamic background opacity adjustment

### Setting up two-finger swipe gesture in google-chrome
> Run below command
```bash
sudo pacman -Syu xdg-desktop-portal-kde  xdg-desktop-portal
```
```bash
sudo nano /usr/share/applications/google-chrome.desktop
```
> Copy replace these lines with same line in google-chrome.desktop file in order
```bash
Exec=/usr/bin/google-chrome-stable %U --enable-features=TouchpadOverscrollHistoryNavigation
```
```bash
Exec=/usr/bin/google-chrome-stable %U --enable-features=TouchpadOverscrollHistoryNavigation
```
```bash
Exec=/usr/bin/google-chrome-stable --incognito %U --enable-features=TouchpadOverscrollHistoryNavigation
```
> Then save the google-chrome.desktop file and run the below command as it is
```bash
sudo update-desktop-database /usr/share/applications/
```
> Done...

### Setting up zsh
> Run the commands
```bash
sudo pacman -S zsh
```
> Set zsh to default shell
```bash
chsh -s $(which zsh)
```
> Now installing Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
> Find the file `.zshrc` in this repo. Copy this in `Home` directory. Then run below command
```bash
source ~/.zshrc
```
> Hopefully it's done

### Setting up fastfetch to display images along with device specification
> Find the fastfetch file in this repo. Copy that fastfetch file in `.config` directory in `Home` directory.

>> After it's done run `fastfetch` in terminal to check if it's working or not.

>> Must install `imagemagick` to make it work

### Fixing up stuck on shutdown screen
> Run these commands as it is...
```bash
sudo nano /etc/modprobe.d/blacklist-nouveau.conf
```
> Write this in the conf file...
```
blacklist nouveau
```
> Save and exit
```bash
sudo mkinitcpio -P
```
> Reboot system
