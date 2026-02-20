#!/bin/bash
MESSAGE="Task completed"
TITLE="Claude Code"

if [[ -d "/Applications/Ghostty.app" ]] && command -v terminal-notifier &>/dev/null; then
    terminal-notifier -title "$TITLE" -message "$MESSAGE" -sound Bottle -activate com.mitchellh.ghostty
    printf '\a' > /dev/tty 2>/dev/null
elif [[ "$(uname)" == "Darwin" ]]; then
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"Bottle\""
fi
