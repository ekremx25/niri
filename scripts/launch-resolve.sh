#!/usr/bin/env bash
set -euo pipefail

exec 9>"${XDG_RUNTIME_DIR:-/tmp}/resolve-launch.lock"
flock 9

window_id="$(niri msg --json windows | python3 -c '
import json, sys
for window in json.load(sys.stdin):
    if window.get("app_id") == "resolve":
        print(window["id"])
        break
')"
if [[ -n "$window_id" ]]; then
    niri msg action focus-window --id "$window_id"
    exit 0
fi

if pgrep -f '^/opt/resolve/bin/resolve( |$)' >/dev/null; then
    notify-send "DaVinci Resolve" "Resolve is already running; wait for it to finish starting."
    exit 0
fi

resolve_bin="$(command -v resolve || true)"
if [[ -z "$resolve_bin" && -x /opt/resolve/bin/resolve ]]; then
    resolve_bin=/opt/resolve/bin/resolve
fi
if [[ -z "$resolve_bin" ]]; then
    notify-send -u critical "DaVinci Resolve" "The Resolve executable could not be found."
    exit 1
fi

# Optional private Xwayland service. When absent, use the normal session.
if systemctl --user cat resolve-xwayland.service >/dev/null 2>&1; then
    systemctl --user import-environment WAYLAND_DISPLAY
    systemctl --user start resolve-xwayland.service
    export DISPLAY="${RESOLVE_DISPLAY:-:13}"
    export QT_QPA_PLATFORM=xcb
    for _ in {1..100}; do
        if xprop -root >/dev/null 2>&1; then
            flock -u 9
            exec 9>&-
            exec "$resolve_bin" "$@"
        fi
        sleep 0.1
    done
    notify-send -u critical "DaVinci Resolve" "The private Xwayland server could not be started."
    exit 1
fi

exec "$resolve_bin" "$@"
