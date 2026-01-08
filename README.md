# ai-suggest

Natural language to shell command for your terminal. Like Warp's AI feature, but for any terminal.

```
❯ find all json files modified in the last hour
↓
find . -type f -name "*.json" -mmin -60
```

## Requirements

- [Claude CLI](https://docs.anthropic.com/en/docs/claude-code) (`claude` command)
- zsh with Oh-My-Zsh (or compatible plugin manager)

## Installation

### Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/csaroff/ai-suggest/main/install.sh | bash
```

### Manual

```bash
git clone https://github.com/csaroff/ai-suggest ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ai-suggest
```

Add `ai-suggest` to your plugins in `~/.zshrc`:

```zsh
plugins=(... ai-suggest)
```

Restart your shell or run `source ~/.zshrc`.

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/csaroff/ai-suggest/main/uninstall.sh | bash
```

Or manually remove `ai-suggest` from your plugins and delete the plugin directory.

## Usage

1. Press **Ctrl+X Ctrl+A** to enter AI mode (shows `❯ ` prompt)
2. Type what you want to do in plain English
3. Press **Enter** to convert to a shell command
4. Press **Escape** to cancel

The generated command appears in your buffer ready to edit or execute.

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+X Ctrl+A` | Enter AI prompt mode |
| `Enter` | Submit query (in AI mode) |
| `Escape` | Cancel (in AI mode) |

### Optional: Ctrl+` (like Warp)

To use `Ctrl+`` ` as the trigger, configure your terminal to send `0x00` for that key combo:

**iTerm2:** Preferences → Profiles → Keys → Key Mappings → Add `Ctrl+`` ` → Send Hex Code → `00`

## Configuration

The plugin uses Claude Haiku for speed. To change the model, edit the plugin and modify:

```zsh
claude --model haiku -p "..."
```

## License

MIT
