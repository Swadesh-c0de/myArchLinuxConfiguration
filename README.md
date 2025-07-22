# my-ArchLinux-Configuration

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
> Run below commands
```bash
cd /home/veronica/.config/kitty/
```
> Then you will see four files `kitty.conf`, `kitty.conf.bak`, `theme.conf` and `hyde.conf`
>> For `hyde.conf` paste this in place of text inside
```
# This is the configuration file for kitty terminal
# For more information, see https://sw.kovidgoyal.net/kitty/conf.html
# For your custom configurations, put it in ./kitty.conf
font_family CaskaydiaCove Nerd Font Mono
bold_font auto
italic_font auto
bold_italic_font auto
enable_audio_bell no
font_size 9.0
window_padding_width 25
cursor_trail 1

# Themes can override any settings in this file
include theme.conf
#background_opacity 0.60
#hide_window_decorations yes
#confirm_os_window_close 0
```
>> For `kitty.conf` paste this in place of text inside
```
include hyde.conf
# Add your custom configurations here

# Font and Appearance
font_family Maple Mono
font_size 12.0

# Disable window borders
window_padding_width 0
borderless_window yes

# Transparency and Background
background_opacity 0.95
background #2e3440
foreground #d8dee9
selection_background #434c5e
selection_foreground #88c0d0

# Color Scheme
color0 #3b4252
color1 #a3be8c
color2 #81a1c1
color3 #ebcb8b
color4 #b48ead
color5 #8fbcbb
color6 #88c0d0
color7 #e5e9f0
color8 #4c566a
color9 #bf616a
color10 #a3be8c
color11 #ebcb8b
color12 #81a1c1
color13 #b48ead
color14 #8fbcbb
color15 #eceff4

# Cursor
cursor_shape block
cursor_color #d8dee9

#startup_image "/home/veronica/.config/fastfetch/pngs/arch.icon"
```
>> For `kitty.conf.bak`, do same as above
```
font_family      CaskaydiaCove Nerd Font Mono
bold_font        auto
italic_font      auto
bold_italic_font auto
enable_audio_bell no
font_size 12.0
window_padding_width 10
include theme.conf
cursor_trail 1
#background_opacity 0.60
#hide_window_decorations yes
#confirm_os_window_close 0

# initially empty, to be configured by user and remains static
include userprefs.conf

# Note: as userprefs.conf is included at the end, settings configured in this file will override the defaults
```
>> For `theme.conf`, do same as above
```

## name:     Catppuccin Mocha 🌿
## author:   Pocco81 (https://github.com/Pocco81)
## license:  MIT
## upstream: https://github.com/catppuccin/kitty/blob/main/mocha.conf
## blurb:    Soothing pastel theme for the high-spirited!



# The basic colors
foreground              #CDD6F4
background              #1E1E2E
selection_foreground    #1E1E2E
selection_background    #F5E0DC

# Cursor colors
cursor                  #F5E0DC
cursor_text_color       #1E1E2E

# URL underline color when hovering with mouse
url_color               #B4BEFE

# Kitty window border colors
active_border_color     #CBA6F7
inactive_border_color   #8E95B3
bell_border_color       #EBA0AC

# OS Window titlebar colors
wayland_titlebar_color system
macos_titlebar_color system

# Tab bar colors
active_tab_foreground   #11111B
active_tab_background   #CBA6F7
inactive_tab_foreground #CDD6F4
inactive_tab_background #181825
tab_bar_background      #11111B

# Colors for marks (marked text in the terminal)
mark1_foreground #1E1E2E
mark1_background #87B0F9
mark2_foreground #1E1E2E
mark2_background #CBA6F7
mark3_foreground #1E1E2E
mark3_background #74C7EC

# The 16 terminal colors

# black
color0 #43465A
color8 #43465A

# red
color1 #F38BA8
color9 #F38BA8

# green
color2  #A6E3A1
color10 #A6E3A1

# yellow
color3  #F9E2AF
color11 #F9E2AF

# blue
color4  #87B0F9
color12 #87B0F9

# magenta
color5  #F5C2E7
color13 #F5C2E7

# cyan
color6  #94E2D5
color14 #94E2D5

# white
color7  #CDD6F4
color15 #A1A8C9
```
>> It's done...
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