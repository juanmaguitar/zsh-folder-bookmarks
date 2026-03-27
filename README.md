# zsh-folder-bookmarks

Bookmark folders and jump to them quickly from the command line.

## Commands

| Command | Description |
|---|---|
| `bm` | Bookmark current directory |
| `bm ~/some/path` | Bookmark a specific path |
| `bml` | List all bookmarks |
| `bml .` | List direct children of current directory |
| `bml ~/Projects` | List direct children of a path |
| `bml . -r` | List all bookmarks anywhere under current directory |
| `bmg` | Jump to a bookmark (interactive) |
| `bmr` | Remove bookmark for current directory |
| `bmr ~/some/path` | Remove a specific bookmark |

`bmg` uses [fzf](https://github.com/junegunn/fzf) for fuzzy selection if installed, otherwise falls back to a numbered list.

## Filtering and navigation

Filter results with `grep` and pipe into `cd` using `$()` command substitution:

```zsh
# Filter bookmarks by name
bml . | grep cohort

# cd directly into a filtered result
cd $(bml . | grep cohort)

# Works with -r for deeper searches too
cd $(bml ~/Projects -r | grep my-app)
```

## Configuration

Override the bookmarks file location by setting this before loading the plugin:

```zsh
export FOLDER_BOOKMARKS_FILE="$HOME/.config/folder-bookmarks"
```

## Installation

### Manual (no plugin manager)

1. Clone the repo:
   ```zsh
   git clone https://github.com/juanmanuelgarrido/zsh-folder-bookmarks \
     ~/.zsh/zsh-folder-bookmarks
   ```

2. Add to your `~/.zshrc`:
   ```zsh
   source ~/.zsh/zsh-folder-bookmarks/zsh-folder-bookmarks.plugin.zsh
   ```

3. Reload your shell:
   ```zsh
   source ~/.zshrc
   ```

### Oh My Zsh

1. Clone into the custom plugins folder:
   ```zsh
   git clone https://github.com/juanmanuelgarrido/zsh-folder-bookmarks \
     ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-folder-bookmarks
   ```

2. Add to your `~/.zshrc` plugins list:
   ```zsh
   plugins=(... zsh-folder-bookmarks)
   ```

3. Reload your shell:
   ```zsh
   source ~/.zshrc
   ```

