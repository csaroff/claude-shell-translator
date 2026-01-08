#!/usr/bin/env bash
set -e

PLUGIN_NAME="ai-suggest"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

info() { echo -e "${GREEN}[✓]${NC} $1"; }
error() { echo -e "${RED}[✗]${NC} $1"; exit 1; }

# Determine plugin directory
if [[ -n "$ZSH_CUSTOM" ]]; then
  PLUGIN_DIR="$ZSH_CUSTOM/plugins/$PLUGIN_NAME"
elif [[ -d "$HOME/.oh-my-zsh" ]]; then
  PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins/$PLUGIN_NAME"
else
  PLUGIN_DIR=""
fi

# Remove from plugins in .zshrc
ZSHRC="$HOME/.zshrc"
if [[ -f "$ZSHRC" ]]; then
  if grep -q "plugins=.*$PLUGIN_NAME" "$ZSHRC"; then
    info "Removing $PLUGIN_NAME from plugins list..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' "s/ $PLUGIN_NAME//" "$ZSHRC"
      sed -i '' "s/$PLUGIN_NAME //" "$ZSHRC"
      sed -i '' "s/$PLUGIN_NAME//" "$ZSHRC"
    else
      sed -i "s/ $PLUGIN_NAME//" "$ZSHRC"
      sed -i "s/$PLUGIN_NAME //" "$ZSHRC"
      sed -i "s/$PLUGIN_NAME//" "$ZSHRC"
    fi
  else
    info "Plugin not found in .zshrc plugins list"
  fi
fi

# Remove plugin directory
if [[ -n "$PLUGIN_DIR" && -d "$PLUGIN_DIR" ]]; then
  info "Removing plugin directory..."
  rm -rf "$PLUGIN_DIR"
else
  info "Plugin directory not found"
fi

echo ""
info "Uninstall complete!"
echo ""
echo "  Restart your shell or run: source ~/.zshrc"
echo ""
