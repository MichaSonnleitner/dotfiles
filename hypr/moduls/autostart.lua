-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
    hl.exec_cmd("qs")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("firefox")
    hl.exec_cmd("swaync")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("snappy-switcher --daemon")
    hl.exec_cmd("awww img /home/micha/.config/hypr/img/wallpaper.png")
    hl.exec_cmd("mount -t cifs //192.168.8.99/micha /mnt/share -o username=micha")
end)
