
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


## Configurations:-
> - visual-studio-code-bin: 
 Run below command
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

```
wpctl status
```
```
sudo modprobe snd_hda_intel
```
