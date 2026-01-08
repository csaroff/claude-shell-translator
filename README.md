# claude-shell-translator

Translate natural language to shell commands. Like Warp AI, but for any terminal.

```
❯ find all json files modified in the last hour
↓
find . -type f -name "*.json" -mmin -60
```

## How it works

1. Press **Ctrl+X Ctrl+A** — enters AI prompt mode (shows `❯ `)
2. Type what you want in plain English
3. Press **Enter** — converts to a shell command
4. Press **Escape** to cancel

The command appears in your terminal ready to edit or run.

## Requirements

- **zsh** (bash not supported)
- **[Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code)** — the `claude` command

## Installation

### Easiest: Append to your `.zshrc`

Works with any zsh setup. Easy to inspect and customize:

```bash
curl -fsSL https://raw.githubusercontent.com/csaroff/claude-shell-translator/main/claude-shell-translator.plugin.zsh >> ~/.zshrc && source ~/.zshrc
```

### With Oh-My-Zsh

**Option A:** Auto-install script

```bash
curl -fsSL https://raw.githubusercontent.com/csaroff/claude-shell-translator/main/install.sh | bash
```

**Option B:** Manual

```bash
git clone https://github.com/csaroff/claude-shell-translator ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/claude-shell-translator
```

Then add to your `~/.zshrc`:

```zsh
plugins=(... claude-shell-translator)
```

Restart your shell or run `source ~/.zshrc`.

## Uninstall

**Oh-My-Zsh users:**

```bash
curl -fsSL https://raw.githubusercontent.com/csaroff/claude-shell-translator/main/uninstall.sh | bash
```

**Everyone else:** Remove the plugin code from your `~/.zshrc`.

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+X Ctrl+A` | Enter prompt mode |
| `Enter` | Submit to AI |
| `Escape` | Cancel |

### Optional: Use Ctrl+\` (like Warp)

Configure your terminal to send hex code `00` for `Ctrl+`` `:

**iTerm2:** Settings → Profiles → Keys → Key Mappings → Add → Keyboard Shortcut: `Ctrl+`` ` → Action: Send Hex Code → `00`

## Configuration

Uses Claude Haiku for speed. To change the model, edit the plugin:

```zsh
claude --model sonnet -p "..."  # slower but smarter
```

## License

MIT
