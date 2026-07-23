-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/


hl.env("HYPRCURSOR_THEME", "Breeze_Light")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Toolkit
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Qt

hl.env("QT_QPA_PLATFORM", "wayland;xcb") 
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1") 
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_FONT_FAMILY", "JetBrainsMono Nerd Font")

-- Sudo Askpass
hl.env("SUDO_ASKPASS", "/home/micha/.config/quickshell/sudo-askpass.sh")
