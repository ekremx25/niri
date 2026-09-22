# Niri Configuration

A portable Niri configuration designed for Niri, Quickshell, and native Wayland applications on Arch Linux and CachyOS.

## Features

- Turkish keyboard layout and a Wayland-native application environment
- Keyboard and mouse focused window management
- Quickshell application drawer shortcut (`Super+A`)
- Open DaVinci Resolve or focus its existing window (`Super+D`)
- Toggle the focused window between the left half and an expanded column (`Super+M`)
- PipeWire volume controls and Niri screenshot shortcuts
- Automatic startup for Quickshell, NetworkManager Applet, and Waypaper
- Separate `outputs.kdl` for machine-specific monitor settings

## Requirements

Install the core packages:

```bash
sudo pacman -S niri pipewire wireplumber xdg-desktop-portal \
  xdg-desktop-portal-gnome xdg-desktop-portal-gtk \
  network-manager-applet kitty dolphin firefox
```

The configuration also calls `quickshell`, `waypaper`, and `hyprlock`. Remove their entries from `config.kdl` if you do not use them.

Niri screen sharing and OBS capture require `xdg-desktop-portal-gnome` and `xdg-desktop-portal-gtk`.

## Installation

```bash
git clone https://github.com/ekremx25/niri.git
cd niri
./install.sh
```

The installer creates a timestamped backup of the existing `~/.config/niri/config.kdl`, installs the configuration and helper scripts, and runs `niri validate`.

## Monitor Setup

List the connected outputs:

```bash
niri msg outputs
```

Edit the example in `~/.config/niri/outputs.kdl` with your output name, resolution, refresh rate, position, and scale. Monitor values are not hard-coded in the main configuration because they are machine-specific.

## Key Bindings

| Shortcut | Action |
| --- | --- |
| `Super+Return` | Open Kitty |
| `Super+B` | Open Firefox |
| `Super+E` | Open Dolphin |
| `Super+A` | Toggle the Quickshell application drawer |
| `Super+D` | Open or focus DaVinci Resolve |
| `Super+M` | Toggle left half / expanded column |
| `Super+F` | Toggle fullscreen |
| `Super+T` | Toggle floating mode |
| `Super+1…9` | Switch workspace |
| `Print` | Capture a selected region |

All key bindings are documented in [`config.kdl`](config.kdl).

## Customization

- Keyboard layout: `input.keyboard.xkb.layout`
- Default applications: the `binds` section
- Window behavior: `window-rule` blocks
- Colors, shadows, and gaps: the `layout` section
- Startup applications: `spawn-at-startup` entries

Personal password databases, key files, monitor identities, and backup files are excluded from the repository.

## License

[MIT](LICENSE)
