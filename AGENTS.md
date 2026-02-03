# Dotfiles Project

This repository contains personal dotfiles managed with GNU Stow.

## Project Structure

The dotfiles are organized using the **GNU Stow** symlink farm manager. Each top-level directory represents a "package" that gets symlinked to `$HOME`.

### Directory Layout

```
dotfiles/
├── alacritty/      # Terminal emulator config
├── fish/           # Fish shell config
├── git/            # Git configuration
├── hyprland/       # Hyprland window manager (ML4W dotfiles)
├── kitty/          # Kitty terminal config
├── lab/            # Lab environment scripts (targets $HOME/lab)
├── lazygit/        # Lazygit TUI config
├── nvim/           # Neovim configuration
├── ssh/            # SSH config
├── starship/       # Starship prompt config
├── skhd/           # macOS hotkey daemon (Simple Hotkey Daemon)
├── tmux/           # Tmux configuration
├── tmuxinator/     # Tmux session manager
├── yabai/          # macOS window manager
├── zsh/            # Zsh shell configuration
├── stow.sh         # Script to stow all modules
└── sync-ml4w.sh    # Sync Hyprland config from upstream ML4W repo
```

## Requirements

```
git stow
```

## Installation

### Quick Install (All Modules)

```bash
git clone git@github.com:agravelot/dotfiles.git ~/dotfiles
cd ~/dotfiles
./stow.sh
```

### Install Individual Modules

```bash
stow -t ~ <module-name>
# Example: stow -t ~ nvim
```

### Adopt Existing Configs

If you have existing configs you want to adopt into the repo:

```bash
stow --adopt -v -t ~ <module-name>
```

## Available Modules

- **alacritty** - GPU-accelerated terminal emulator
- **fish** - Friendly interactive shell
- **git** - Git aliases and configuration
- **hyprland** - Hyprland window manager config (synced from ML4W)
- **kitty** - Fast, feature-rich terminal
- **lab** - Lab environment scripts (placed in ~/lab/)
- **lazygit** - Terminal UI for git
- **nvim** - Neovim configuration
- **ssh** - SSH client configuration
- **skhd** - macOS hotkey daemon
- **starship** - Cross-shell prompt
- **tmux** - Terminal multiplexer
- **tmuxinator** - Tmux session management
- **yabai** - macOS tiling window manager
- **zsh** - Zsh shell with custom configuration

## Special Scripts

### sync-ml4w.sh

Syncs the Hyprland configuration from the upstream ML4W (My Linux For Work) dotfiles repository.

**Behavior:**
1. Clones `https://github.com/mylinuxforwork/dotfiles.git` to `/tmp`
2. Removes unwanted configs (zshrc, fish, kitty, nvim)
3. Copies remaining dotfiles to `hyprland/` directory
4. **Restores `browser.sh` to preserve zen-browser preference** (instead of Firefox)

**Usage:**
```bash
./sync-ml4w.sh
```

### stow.sh

Stows all modules at once for quick setup.

**Usage:**
```bash
./stow.sh
```

## Lab Module

The **lab** module contains scripts for the `~/lab/` directory, which houses multiple git repositories for various projects outside the scope of this dotfiles project.

### to-worktree.sh

A script to convert a regular git repository folder into a git worktree setup. This is useful for managing multiple branches of the same repository in separate directories.

**Usage:**
```bash
to-worktree.sh <folder-name>
```

**What it does:**
1. Verifies the target is a regular git repository (not already a worktree)
2. Stashes any uncommitted changes in the target folder
3. Creates a bare repository in `~/.git-bare-repos/<folder-name>.git`
4. Converts the folder to a worktree linked to the bare repo
5. Restores all stashed changes
6. Preserves remote configuration

**Safety checks:**
- Exits with error if the folder is already a worktree
- Exits with error if there's no `.git` directory
- Exits with error if there's no remote `origin` configured

**Example:**
```bash
cd ~/lab
# Assuming you have a regular git clone in my-project/
to-worktree.sh my-project

# After conversion, you can add more worktrees:
git worktree add ~/lab/my-project-dev develop
git worktree add ~/lab/my-project-feature feature-branch
```

**Benefits of worktrees:**
- Work on multiple branches simultaneously without switching
- Each branch has its own directory
- Share the same git history and objects (saves disk space)
- No "detached HEAD" state confusion

## Stow Tips

- Stow creates symlinks: `~/.config/nvim` → `dotfiles/nvim/.config/nvim`
- The structure inside each module mirrors the home directory structure
- Use `--adopt` to move existing configs into the repo before symlinking
- Use `-D` to delete (unstow) a module: `stow -D -t ~ nvim`

## Important Notes

- **hyprland/.config/ml4w/settings/browser.sh** contains `zen-browser` - this is preserved during sync
- The `hyprland` module contains extensive ML4W dotfiles for Wayland/Hyprland
