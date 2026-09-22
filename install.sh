#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
target="$config_home/niri"
stamp="$(date +%Y%m%d-%H%M%S)"

mkdir -p "$target"
if [[ -f "$target/config.kdl" ]]; then
    cp -a "$target/config.kdl" "$target/config.kdl.backup-$stamp"
fi

install -Dm644 "$repo_dir/config.kdl" "$target/config.kdl"
install -Dm644 "$repo_dir/outputs.kdl" "$target/outputs.kdl"
install -Dm755 "$repo_dir/scripts/toggle-left-fullscreen.py" "$target/scripts/toggle-left-fullscreen.py"
install -Dm755 "$repo_dir/scripts/launch-resolve.sh" "$target/scripts/launch-resolve.sh"

niri validate -c "$target/config.kdl"
printf 'Niri configuration installed in %s\n' "$target"
