# zsh-folder-bookmarks
# Bookmark folders and jump to them quickly from the command line.
# https://github.com/juanmanuelgarrido/zsh-folder-bookmarks

: "${FOLDER_BOOKMARKS_FILE:=$HOME/.folder-bookmarks}"

# bm [path]
# Bookmark the given path (defaults to current directory).
bm() {
  local target
  target="$(cd "${1:-.}" 2>/dev/null && pwd)" || { echo "Invalid path: $1"; return 1; }
  target="${target%/}"  # strip trailing slash

  if grep -qxF "$target" "$FOLDER_BOOKMARKS_FILE" 2>/dev/null; then
    echo "Already bookmarked: $target"
    return
  fi

  echo "$target" >> "$FOLDER_BOOKMARKS_FILE"
  echo "Bookmarked: $target"
}

# bml [path] [-r]
# List all bookmarks, or those under a given path.
# Without -r, only direct children of the given path are shown.
# With -r, all bookmarks anywhere under the given path are shown.
bml() {
  if [[ ! -f "$FOLDER_BOOKMARKS_FILE" ]]; then
    echo "No bookmarks yet. Use 'bm' to add one."
    return
  fi

  local recursive=0
  local raw_path=""

  for arg in "$@"; do
    if [[ "$arg" == "-r" ]]; then
      recursive=1
    else
      raw_path="$arg"
    fi
  done

  if [[ -z "$raw_path" ]]; then
    cat "$FOLDER_BOOKMARKS_FILE"
    return
  fi

  local prefix
  prefix="$(cd "$raw_path" 2>/dev/null && pwd)" || { echo "Invalid path: $raw_path"; return 1; }
  prefix="${prefix%/}"

  if (( recursive )); then
    grep "^${prefix}/" "$FOLDER_BOOKMARKS_FILE"
  else
    # Direct children only: prefix + one path segment, nothing deeper
    grep "^${prefix}/[^/]*$" "$FOLDER_BOOKMARKS_FILE"
  fi
}

# bmg
# Jump to a bookmarked folder interactively.
# Uses fzf if available, otherwise shows a numbered list.
bmg() {
  if [[ ! -f "$FOLDER_BOOKMARKS_FILE" ]] || [[ ! -s "$FOLDER_BOOKMARKS_FILE" ]]; then
    echo "No bookmarks yet. Use 'bm' to add one."
    return
  fi

  local dest
  if command -v fzf &>/dev/null; then
    dest=$(cat "$FOLDER_BOOKMARKS_FILE" | fzf --prompt="Go to: ")
  else
    cat -n "$FOLDER_BOOKMARKS_FILE"
    read "?Go to #: " num
    dest=$(sed -n "${num}p" "$FOLDER_BOOKMARKS_FILE")
  fi

  [[ -n "$dest" ]] && cd "$dest" || return 1
}

# bmr [path]
# Remove a bookmark. Defaults to current directory.
bmr() {
  local target
  target="$(cd "${1:-.}" 2>/dev/null && pwd)" || { echo "Invalid path: $1"; return 1; }
  target="${target%/}"

  if ! grep -qxF "$target" "$FOLDER_BOOKMARKS_FILE" 2>/dev/null; then
    echo "Not bookmarked: $target"
    return 1
  fi

  grep -vxF "$target" "$FOLDER_BOOKMARKS_FILE" > "${FOLDER_BOOKMARKS_FILE}.tmp" \
    && mv "${FOLDER_BOOKMARKS_FILE}.tmp" "$FOLDER_BOOKMARKS_FILE"
  echo "Removed bookmark: $target"
}
