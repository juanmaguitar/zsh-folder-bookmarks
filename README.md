# zsh-folder-bookmarks

Bookmark folders and jump to them quickly from the command line.

## Commands

| Command | Description |
|---|---|
| `bm` | Bookmark current directory |
| `bm ~/some/path` | Bookmark a specific path |
| `bml` | List all bookmarks |
| `bml ~/Projects` | List bookmarks under a path |
| `bmg` | Jump to a bookmark (interactive) |
| `bmr` | Remove bookmark for current directory |
| `bmr ~/some/path` | Remove a specific bookmark |

`bmg` uses [fzf](https://github.com/junegunn/fzf) for fuzzy selection if installed, otherwise falls back to a numbered list.

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

### Sheldon

Add to `~/.config/sheldon/plugins.toml`:

```toml
[plugins.zsh-folder-bookmarks]
github = "juanmanuelgarrido/zsh-folder-bookmarks"
```

Then run `sheldon lock`.

### Antigen

```zsh
antigen bundle juanmanuelgarrido/zsh-folder-bookmarks
```

### Zinit

```zsh
zinit light juanmanuelgarrido/zsh-folder-bookmarks
```
