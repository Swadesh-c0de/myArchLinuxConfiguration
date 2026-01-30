# NVIDIA on linux-zen — nvidia-dkms + linux-zen-headers 🚀

**Summary:** You're on **linux-zen** (kernel 6.18.7-zen). Use **nvidia-dkms** and **linux-zen-headers** so the driver rebuilds with kernel updates and works smoothly with Wayland/X11.

---

## Your setup (what matters)

- **Kernel:** 6.18.7-zen
- ⇒ You **must** use **nvidia-dkms**
- ⇒ You **must** have **linux-zen-headers**

---

## 1. Install the correct packages (do this exactly) ✅

Run:

```bash
sudo pacman -S linux-zen-headers nvidia-dkms nvidia-utils nvidia-settings
```

> If pacman asks to replace something, answer **yes**.

---

## 2. Blacklist nouveau (mandatory) ⚠️

Create the blacklist file:

```bash
sudo nano /etc/modprobe.d/blacklist-nouveau.conf
```

Paste:

```text
blacklist nouveau
options nouveau modeset=0
```

Save and exit.

---

## 3. Enable NVIDIA DRM (smooth desktop, Wayland/X11) 🔧

Edit GRUB:

```bash
sudo nano /etc/default/grub
```

Find the line:

```text
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
```

Change it to:

```text
GRUB_CMDLINE_LINUX_DEFAULT="quiet nvidia-drm.modeset=1"
```

Rebuild GRUB:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

---

## 4. Rebuild initramfs (important) 🧩

```bash
sudo mkinitcpio -P
```

You **should see nvidia modules** being included in the output. If you see errors, copy them here and I’ll help troubleshoot.

---

## 5. Reboot 🔁

```bash
reboot
```

---

## 6. Verify everything is working ✅

After login, run:

```bash
nvidia-smi
```

If you see your GPU listed then the driver is loaded correctly.

Then check modules:

```bash
lsmod | grep nvidia
```

Expected lines:

```
nvidia
nvidia_modeset
nvidia_uvm
nvidia_drm
```

---

## 7. (Highly recommended) Prevent screen tearing on X11 🖥️

Create the X11 config:

```bash
sudo mkdir -p /etc/X11/xorg.conf.d
sudo nano /etc/X11/xorg.conf.d/20-nvidia.conf
```

Paste:

```text
Section "Device"
    Identifier "NVIDIA Card"
    Driver "nvidia"
    Option "NoLogo" "true"
    Option "TripleBuffer" "true"
EndSection
```

---

## 8. Zen kernel + NVIDIA tips (important) 💡

- After **every kernel update**, DKMS will attempt to rebuild automatically.
- If NVIDIA breaks after an update:

```bash
sudo dkms autoinstall
sudo mkinitcpio -P
reboot
```