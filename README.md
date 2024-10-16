# .dotfiles
Config files for my laptop. More details see [system info](#system-info).  
Prepared to wipe my drive and remove Windows 11 and only use Arch.  

## Requirements
- **bash** (probably).
- **git**
- **NVIM v0.10.1** or above (anything above v0.5.0 should be ok), but vim is good enough, I tried to make my nvim setup as close to the vanilla vim as possible.
- **tmux 3.4** or above (probably compatible with lower versions as well).
- **alacritty Version 0.13.2** or above, but **any terminal that supports 256 colors is fine**, unless you want the color theme.
- **sway version 1.9** or above, but it is basically i3 but for wayland, apparently it does not work with NVIDIA's proprietary drivers(?). My current sway configuration also relies on **sway-lock** and **sway-idle**.
- I don't use Desktop Enviornments so I don't know how sway will work with one.
- Additionally for nvim you *might* need **python, node, and rust/rustc** mainly for LSPs and some plugins (although the visibility are generally toggled off when I use them so I might just remove them because Mr. Zozin said compiler is all you need).
- To run the current .bashrc without error, you also need **exa** (fancy ls -la) and **z** (fancy cd).

## System Info
- OS: Arch Linux x86\_64 & Windows 11 Dual Boot (but I use Linux on my laptop exclusively now)
- CPU: Intel i7-8565U (8) @ 4.6GHz
- GPU1: Intel WhiskeyLake-U GT2 (UHD Graphics 620)
- GPU2: NVIDIA GeForce MX150
- RAM: 8GB or something, I do not remember how much memory I allocated for Arch.
- Shell: bash, tried fish and zsh but the syntax from these 2 shells are too different from bash, use those.
