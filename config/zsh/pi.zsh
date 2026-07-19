# Non-interactive Zsh helpers loaded by Pi before each `!` command.
# Keep this free of prompt, completion, and terminal UI setup.

git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return

  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify "$ref"; then
      echo "${ref:t}"
      return 0
    fi
  done

  for remote in origin upstream; do
    ref=$(command git rev-parse --abbrev-ref "$remote/HEAD" 2>/dev/null)
    if [[ $ref == "$remote"/* ]]; then
      echo "${ref#"$remote/"}"
      return 0
    fi
  done

  echo master
  return 1
}

gcb() { git checkout -b "$@"; }
gl() { git pull "$@"; }
gcm() { git checkout "$(git_main_branch)" "$@"; }
