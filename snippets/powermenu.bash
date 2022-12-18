#!/bin/bash
ret=$(printf "Power Off\nRestart\nLogout\nLock" | rofi -dmenu -i)
case "$ret" in
    "Power Off") systemctl shutdown ;;
    "Restart") systemctl reboot ;;
    "Logout") i3-msg exit ;;
    "Lock") i3lock ;;
    *) exit 1 ;;
esac


