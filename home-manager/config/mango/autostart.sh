#!/usr/bin/env bash

set +e

# Portal
xdg-desktop-portal-wlr >/dev/null 2>&1 &

# Input Method
fcitx5 --replace -d >/dev/null 2>&1 &

# Clipboard
wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &
wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# Tray Applets
blueman-applet >/dev/null 2>&1 &
nm-applet >/dev/null 2>&1 &

# Polkit
xfce-polkit >/dev/null 2>&1 &

# KDE Connect
kdeconnectd >/dev/null 2>&1 &

# Walker Backend
systemctl --user is-active --quiet elephant.service || \
systemctl --user start elephant.service
