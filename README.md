# claude-shell-translator

Natural language to shell command for your terminal. Like Warp's AI feature, but for any terminal.

```
❯ find all json files modified in the last hour
↓
find . -type f -name "*.json" -mmin -60
```

## Requirements

- [Claude CLI](https://docs.anthropic.com/en/docs/claude-code) (`claude` command)
- zsh (Oh-My-Zsh optional)

## Installation

### Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/csaroff/claude-shell-translator/main/install.sh | bash
```

### Manual

```bash
git clone https://github.com/csaroff/claude-shell-translator ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/claude-shell-translator
```

Add `claude-shell-translator` to your plugins in `~/.zshrc`:

```zsh
plugins=(... claude-shell-translator)
```

Restart your shell or run `source ~/.zshrc`.

### Without Oh-My-Zsh

Append directly to your `.zshrc` for easy editing:

```bash
curl -fsSL https://raw.githubusercontent.com/csaroff/claude-shell-translator/main/claude-shell-translator.plugin.zsh >> ~/.zshrc
```

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/csaroff/claude-shell-translator/main/uninstall.sh | bash
```

Or manually remove `claude-shell-translator` from your plugins and delete the plugin directory.

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
