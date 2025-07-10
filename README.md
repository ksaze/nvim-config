## Minimal Neovim Config
Build uses lazy package manager with plugins for LSP, autocomplete, formatting, fuzzy finder, and better syntax highlighting.
No external plugin is used for the file tree as I can work fine with netrw (the default), but I presume that isn't the case for the majority, so you can add some plugin--nerd tree is a popular choice, from my knowledge.

## Prerequisites

Before installation, ensure you have:
- **Neovim** (minimum version TBD)
- **Patched font** from [Nerd Fonts](https://www.nerdfonts.com/)
- **Terminal** that supports glyphs and true color

## Installation

### Unix-like Systems (Linux, macOS, BSD)
```bash
cd ~/.config/ && git clone https://github.com/ksaze/nvim-config.git nvim
```

### Windows
```powershell
git clone https://github.com/ksaze/nvim-config.git $env:LOCALAPPDATA\nvim
```
## Keybindings

**Leader key:** `<Space>`

### Autocompletion
| Key | Action |
|-----|--------|
| `<C-y>` | Accept suggestion |
| `<C-n>` | Next suggestion |
| `<C-p>` | Previous suggestion |

### Diagnostics
| Key | Action |
|-----|--------|
| `<leader>ld` | Show diagnostics for current line |
| `<leader>lq` | List all diagnostics in split view |
| `<leader>lt` | Toggle diagnostic signs |

### Fuzzy Finder
| Key | Action |
|-----|--------|
| `<leader>ff` | Search files in current directory |
| `<leader>fh` | Search files in home directory |
| `<leader>fp` | Search files in project root (git repos) |
| `<leader>fc` | Search files in `~/.config` |
| `<leader>fw` | Search files in `~/workspace` |

> **Note:** Adjust the `~/workspace` path in the configuration to match your development directory structure.


