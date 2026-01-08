#!/usr/bin/env bash
set -e

PLUGIN_NAME="ai-suggest"
REPO_URL="https://github.com/csaroff/ai-suggest"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✗]${NC} $1"; exit 1; }

# Check prerequisites
command -v git >/dev/null 2>&1 || error "git is required but not installed"
command -v zsh >/dev/null 2>&1 || error "zsh is required but not installed"
command -v claude >/dev/null 2>&1 || warn "claude CLI not found - install from https://docs.anthropic.com/en/docs/claude-code"

# Determine plugin directory
if [[ -n "$ZSH_CUSTOM" ]]; then
  PLUGIN_DIR="$ZSH_CUSTOM/plugins/$PLUGIN_NAME"
elif [[ -d "$HOME/.oh-my-zsh" ]]; then
  PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins/$PLUGIN_NAME"
else
  error "Oh-My-Zsh not found. Install from https://ohmyz.sh or set ZSH_CUSTOM"
fi

# Clone or update plugin
if [[ -d "$PLUGIN_DIR" ]]; then
  info "Plugin directory exists, updating..."
  git -C "$PLUGIN_DIR" pull --quiet
else
  info "Cloning $PLUGIN_NAME..."
  git clone --quiet "$REPO_URL" "$PLUGIN_DIR"
fi

# Add to plugins in .zshrc
ZSHRC="$HOME/.zshrc"
if [[ ! -f "$ZSHRC" ]]; then
  error ".zshrc not found at $ZSHRC"
fi

if grep -q "plugins=.*$PLUGIN_NAME" "$ZSHRC"; then
  info "Plugin already in .zshrc plugins list"
else
  info "Adding $PLUGIN_NAME to plugins..."
  # Match plugins=(...) and add our plugin
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/^plugins=(\(.*\))/plugins=(\1 $PLUGIN_NAME)/" "$ZSHRC"
  else
    sed -i "s/^plugins=(\(.*\))/plugins=(\1 $PLUGIN_NAME)/" "$ZSHRC"
  fi
fi

echo ""
info "Installation complete!"
echo ""
echo "  Restart your shell or run: source ~/.zshrc"
echo ""
echo "  Usage:"
echo "    1. Press Ctrl+X Ctrl+A to enter AI mode"
echo "    2. Type what you want to do"
echo "    3. Press Enter"
echo ""
