# Dotfiles Project

Personal dotfiles managed with GNU Stow. Each top-level directory is a "package" symlinked to `$HOME`.

## Quick Start

```bash
git clone git@github.com:agravelot/dotfiles.git ~/dotfiles
cd ~/dotfiles
./stow.sh                    # Stow all modules
stow -t ~ <module>           # Stow single module (e.g., nvim, fish)
stow --adopt -v -t ~ <module>  # Adopt existing config into repo
stow -D -t ~ <module>        # Unstow (remove) a module
```

## Project Structure

```
dotfiles/
├── alacritty/   # Terminal emulator config
├── autostart/   # Desktop autostart entries
├── fish/        # Fish shell config
├── git/         # Git configuration
├── opencode/    # Opencode configuration
├── hyprland/    # Hyprland window manager (ML4W dotfiles)
├── kitty/       # Kitty terminal config
├── lab/         # Lab scripts (targets $HOME/lab)
├── lazygit/     # Lazygit TUI config
├── nvim/        # Neovim configuration
├── ssh/         # SSH config
├── starship/    # Starship prompt config
├── skhd/        # macOS hotkey daemon
├── tmux/        # Tmux configuration
├── tmuxinator/  # Tmux session manager
├── yabai/       # macOS window manager
├── zsh/         # Zsh shell configuration
├── stow.sh      # Stow all modules
└── sync-ml4w.sh # Sync Hyprland from ML4W upstream
```

## Code Style Guidelines

### Shell Scripts (Bash)

- Use `#!/usr/bin/env bash` shebang
- Always include `set -e` for strict error handling
- Use double quotes around variables: `"$VAR"`
- Prefer `[[ ]]` over `[ ]` for conditionals
- Use snake_case for function and variable names
- Indent with 2 or 4 spaces (be consistent within file)
- Use `cat << 'EOF'` for help text (prevents variable expansion)
- Validate inputs before processing
- Provide `-h`/`--help` flags for user-facing scripts

Example:
```bash
#!/usr/bin/env bash
set -e

my_function() {
  local var="$1"
  if [[ -z "$var" ]]; then
    echo "Error: var is required" >&2
    return 1
  fi
}
```

### Lua (Neovim Config)

- Format with StyLua: `stylua .` (config in `stylua.toml`)
- 2-space indentation, 120 column width
- Use double quotes for strings
- Trailing commas in multi-line tables
- Prefer explicit returns in plugin specs

### Fish Shell

- Use lowercase with hyphens for function names
- Quote variables: "$var"
- Use `functions -d` for descriptions

## Lint/Format Commands

```bash
# Format Lua files (requires stylua)
stylua nvim/.config/nvim/

# Lint shell scripts (requires shellcheck)
shellcheck *.sh lab/**/*.sh

# Check for syntax errors in bash scripts
bash -n script.sh
```

## Key Scripts

### sync-ml4w.sh

Syncs Hyprland config from ML4W upstream:
1. Clones `https://github.com/mylinuxforwork/dotfiles.git` to `/tmp`
2. Removes configs not wanted (zshrc, fish, kitty, nvim)
3. Copies remaining to `hyprland/`
4. Restores `browser.sh` to preserve zen-browser preference

### to-worktree.sh

Converts a git repo to worktree format:
```bash
to-worktree.sh <folder-name>   # Converts ~/lab/<folder> to worktree
```

Creates bare repo in `~/.git-bare-repos/` and preserves all stashed changes.

## Important Notes

- **hyprland/.config/ml4w/settings/browser.sh** contains `zen-browser` preference (preserved during sync)
- Stow mirrors home directory structure within each module
- Lab module targets `~/lab/` directory (external git repositories)
