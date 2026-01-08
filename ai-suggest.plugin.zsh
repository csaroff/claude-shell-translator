# ai-suggest: Natural language to shell command widget
# Press Ctrl+X Ctrl+A (or Ctrl+`) to enter prompt mode, type query, press Enter
# Press Escape to cancel

_AI_PROMPT_PREFIX="❯ "

_ai_command_suggest() {
  BUFFER="${_AI_PROMPT_PREFIX}"
  CURSOR=${#BUFFER}
}

_ai_escape() {
  if [[ "$BUFFER" == "${_AI_PROMPT_PREFIX}"* ]]; then
    BUFFER=""
    zle reset-prompt
  else
    zle .send-break
  fi
}

_ai_accept_line() {
  if [[ "$BUFFER" == "${_AI_PROMPT_PREFIX}"* ]]; then
    local DIM=$'\033[2m'
    local RESET=$'\033[0m'

    local query="${BUFFER#${_AI_PROMPT_PREFIX}}"
    if [[ -n "$query" ]]; then
      zle -I
      print -n "\r\033[K${DIM}thinking...${RESET}" >/dev/tty
      local cmd
      cmd=$(claude --model haiku -p "Convert to a shell command. Output ONLY the command itself - no explanation, no markdown, no questions, no alternatives. Just the single most likely command: $query" 2>/dev/null)
      # Remove code fence block if present (```bash\n...\n```)
      if [[ "$cmd" == \`\`\`* ]]; then
        cmd="${cmd#*$'\n'}"      # Remove first line (```bash)
        cmd="${cmd%\`\`\`*}"     # Remove trailing fence
      fi
      # Remove inline backticks
      cmd="${cmd#\`}"
      cmd="${cmd%\`}"
      # Take first line only and strip whitespace
      cmd="${cmd%%$'\n'*}"
      cmd="${cmd#"${cmd%%[![:space:]]*}"}"
      cmd="${cmd%"${cmd##*[![:space:]]}"}"
      print -n "\r\033[K" >/dev/tty
      BUFFER="$cmd"
      CURSOR=${#BUFFER}
      zle reset-prompt
    else
      BUFFER=""
      zle reset-prompt
    fi
  else
    zle .accept-line
  fi
}

zle -N _ai_command_suggest
zle -N _ai_escape
zle -N accept-line _ai_accept_line

bindkey '^@' _ai_command_suggest      # Ctrl+` (requires terminal config to send 0x00)
bindkey '^X^A' _ai_command_suggest    # Ctrl+X Ctrl+A
bindkey '\e' _ai_escape               # Escape to cancel
