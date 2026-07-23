#!/bin/bash
STATE_FILE="/tmp/quickshell-dnd-state"

if [ -f "$STATE_FILE" ] && [ "$(cat $STATE_FILE)" = "on" ]; then
    qs ipc call notifications dnd_toggle
    echo "off" > "$STATE_FILE"
    notify-send -t 2000 "󰂜 DnD" "Deaktiviert"
else
    notify-send -t 2000 "󰂛 DnD" "Aktiviert"
    qs ipc call notifications dnd_toggle
    echo "on" > "$STATE_FILE"
fi
