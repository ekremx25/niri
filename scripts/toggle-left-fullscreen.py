#!/usr/bin/env python3
"""Cycle the focused Niri window: left half -> maximized column -> left half."""

import json
import os
import subprocess
from pathlib import Path


def niri(*args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        ["niri", "msg", *args],
        check=True,
        text=True,
        capture_output=True,
    )


windows = json.loads(niri("--json", "windows").stdout)
focused = next((window for window in windows if window.get("is_focused")), None)
if focused is None:
    raise SystemExit(0)

# Floating windows have no column to maximize.
if focused.get("is_floating"):
    niri("action", "maximize-window-to-edges")
    raise SystemExit(0)

window_id = focused["id"]
runtime_dir = Path(os.environ.get("XDG_RUNTIME_DIR", f"/run/user/{os.getuid()}"))
state_path = runtime_dir / "niri-left-fullscreen-state.json"
socket = os.environ.get("NIRI_SOCKET", "")

try:
    state = json.loads(state_path.read_text())
except (FileNotFoundError, json.JSONDecodeError):
    state = {}

same_window = state.get("socket") == socket and state.get("window_id") == window_id
stage = state.get("stage") if same_window else None

if stage == "left":
    niri("action", "maximize-column")
    next_stage = "maximized"
else:
    if stage == "maximized":
        niri("action", "maximize-column")
    niri("action", "move-column-to-first")
    niri("action", "set-column-width", "50%")
    next_stage = "left"

state_path.write_text(json.dumps({
    "socket": socket,
    "window_id": window_id,
    "stage": next_stage,
}))
