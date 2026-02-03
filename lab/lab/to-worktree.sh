#!/usr/bin/env bash
set -e

LAB_DIR="$HOME/lab"
BARE_REPO_DIR="$HOME/.git-bare-repos"

show_help() {
    cat << 'EOF'
Usage: to-worktree.sh <folder-name>

Convert a regular git repository folder in ~/lab to a worktree setup.
This preserves all current modifications and creates a bare repository
that can host multiple worktrees.

Arguments:
    folder-name    Name of the folder in ~/lab to convert

Example:
    to-worktree.sh my-project

The script will:
    1. Check if the folder exists in ~/lab
    2. Verify it's a git repository
    3. Verify it's NOT already a worktree
    4. Save any uncommitted changes (stash)
    5. Create a bare repository in ~/.git-bare-repos/
    6. Convert the folder to a worktree
    7. Restore all stashed changes

EOF
}

if [ -z "$1" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

FOLDER_NAME="$1"
TARGET_PATH="$LAB_DIR/$FOLDER_NAME"

if [ ! -d "$TARGET_PATH" ]; then
    echo "Error: Folder '$FOLDER_NAME' does not exist in $LAB_DIR"
    exit 1
fi

cd "$TARGET_PATH"

if [ ! -d ".git" ]; then
    echo "Error: '$FOLDER_NAME' is not a git repository"
    exit 1
fi

# Check if already a worktree
if git rev-parse --is-inside-work-tree &>/dev/null && [ -f ".git" ] || [ -L ".git" ]; then
    if git worktree list | grep -q "^$TARGET_PATH "; then
        echo "Error: '$FOLDER_NAME' is already a git worktree"
        echo "This folder is already managed as a worktree. No conversion needed."
        exit 1
    fi
fi

if [ -f ".git" ]; then
    echo "Error: '$FOLDER_NAME' appears to already be a worktree (has .git file instead of directory)"
    exit 1
fi

echo "Converting '$FOLDER_NAME' to worktree format..."

ORIGIN_URL=$(git remote get-url origin 2>/dev/null || echo "")
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "main")

if [ -z "$ORIGIN_URL" ]; then
    echo "Error: No remote 'origin' configured"
    exit 1
fi

echo "Remote URL: $ORIGIN_URL"
echo "Current branch: $CURRENT_BRANCH"

STASH_CREATED=false
if ! git diff --quiet HEAD 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
    echo "Stashing uncommitted changes..."
    git stash push -m "Auto-stash before worktree conversion"
    STASH_CREATED=true
fi

mkdir -p "$BARE_REPO_DIR"
BARE_REPO_PATH="$BARE_REPO_DIR/$FOLDER_NAME.git"

echo "Creating bare repository at $BARE_REPO_PATH..."

mv ".git" "$BARE_REPO_PATH"

cd "$BARE_REPO_PATH"
git config --bool core.bare true
git config --path core.worktree "$TARGET_PATH"

echo "Converting to worktree..."
cd "$TARGET_PATH"

git config --path core.gitdir "$BARE_REPO_PATH"

if ! git worktree list | grep -q "$TARGET_PATH"; then
    echo "Adding worktree entry..."
fi

echo "Configuring remote..."
git remote remove origin 2>/dev/null || true
git remote add origin "$ORIGIN_URL"

git fetch origin

if git show-ref --verify --quiet "refs/remotes/origin/$CURRENT_BRANCH"; then
    echo "Branch '$CURRENT_BRANCH' exists on remote"
else
    echo "Warning: Branch '$CURRENT_BRANCH' not found on remote"
fi

echo "Restoring git metadata..."

if [ "$STASH_CREATED" = true ]; then
    echo "Restoring stashed changes..."
    git stash pop
fi

echo ""
echo "✓ Successfully converted '$FOLDER_NAME' to worktree format"
echo ""
echo "Bare repository: $BARE_REPO_PATH"
echo "Worktree path:   $TARGET_PATH"
echo ""
echo "To add additional worktrees:"
echo "  git worktree add $LAB_DIR/$FOLDER_NAME-feature-branch feature-branch"
