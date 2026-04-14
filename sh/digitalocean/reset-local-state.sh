#!/usr/bin/env bash
# Reset local DigitalOcean state for Spawn: removes saved token config and optionally
# clears DO-related environment variables in the *current* shell.
#
# Remove persisted credentials (subprocess is fine):
#   bash /path/to/reset-local-state.sh
#
# Also unset env vars in this shell (must source):
#   source /path/to/reset-local-state.sh

set -e

CONFIG="${HOME}/.config/spawn/digitalocean.json"
if [[ -e "$CONFIG" ]]; then
  rm -f "$CONFIG"
  echo "Removed: $CONFIG"
else
  echo "No file at $CONFIG (already clean)."
fi

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  echo "Note: Environment variables were not cleared (this ran in a subshell)."
  echo "  Paste in this shell, or open a new terminal:"
  echo '  unset DIGITALOCEAN_ACCESS_TOKEN DIGITALOCEAN_API_TOKEN DO_API_TOKEN DO_DROPLET_NAME DO_REGION DO_DROPLET_SIZE'
  echo "  Or from bash: source ${BASH_SOURCE[0]}"
else
  unset DIGITALOCEAN_ACCESS_TOKEN DIGITALOCEAN_API_TOKEN DO_API_TOKEN DO_DROPLET_NAME DO_REGION DO_DROPLET_SIZE 2>/dev/null || true
  echo "Cleared DigitalOcean-related environment variables in this shell."
fi
