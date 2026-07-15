# Dotfiles

Personal macOS dotfiles. Serves three purposes at once: bootstrapping a new
machine, version-controlling settings and config, and applying tweaks to a
machine that is already set up.

## Language

**Owned file**:
A config file whose source of truth is this repo. It is symlinked from `$DOTFILES`
into `$HOME`, and nothing but the repo writes it. Editing means editing the repo.
Examples: `CLAUDE.md`, `agents/*.md`, zsh config, git config.
_Avoid_: linked file, tracked file (both are ambiguous — managed files are tracked too).

**Tool-managed file**:
A config file whose source of truth is an external application that rewrites it
atomically (which destroys any symlink). The repo can only hold a *snapshot* of it,
never own it. Editing happens in the app; the repo copy is kept current by a
sync mechanism, not a symlink. Example: `~/.claude/settings.json`.
_Avoid_: managed file (too vague), synced file.

**Snapshot**:
The repo's copy of a tool-managed file — a point-in-time capture used for
version history and new-machine bootstrap, not a live link.
_Avoid_: backup, mirror.
