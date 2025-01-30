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


## Packages:-
- For Power Profile (For KDE Plasma Desktop Environment)
```
sudo pacman -S power-profiles-daemon
```
```
sudo systemctl enable power-profiles-daemon.service
```
```
sudo reboot
```
- For Bluetooth
```
yay -S bluez bluez-utils
```
```
sudo systemctl enable bluetooth
```
```
sudo systemctl start bluetooth
```
- Fastfetch
```
yay -S fastfetch
```
- Neofetch
```
yay -S neofetch
```

## Configurations:-
=> visual-studio-code-bin: 
> Run below command
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
- Fixing sound issue (In Acer Predator Helios Neo 16 PHN16-71):
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
- Kitty Configuration: 
> Run below commands
```
cd /home/veronica/.config/kitty/
```
> Then you will see three files `kitty.conf`, `kitty.conf.bak` and `theme.conf`
> For `kitty.conf` paste this in place of text inside
```
# font_family      CaskaydiaCove Nerd Font Mono
# bold_font        auto
# italic_font      auto
# bold_italic_font auto
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


# BEGIN_KITTY_FONTS
font_family      family="Maple Mono"
bold_font        auto
italic_font      true
bold_italic_font auto
# END_KITTY_FONTS
```
> For `kitty.conf.bak`, do same as above
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
> For `theme.conf`, do same as above
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
> It's done...
