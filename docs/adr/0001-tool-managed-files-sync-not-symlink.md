# Tool-managed config files are snapshotted and synced, not symlinked

## Context

The repo symlinks config from `$DOTFILES` into `$HOME` so the repo is the live
source of truth. This breaks for files that an external app rewrites atomically
(temp file + rename), because the rename replaces the symlink with a standalone
file. `~/.claude/settings.json` is rewritten by Claude Code and supacode, so it
silently diverged from the repo. `dot link` can't fix it (it skips existing
targets), and even a fresh-machine symlink survives only until the app's first
write. Symlinking this class of file is a losing battle against the tool on
every machine, not a one-off breakage.

## Decision

Split repo files into two classes (see `CONTEXT.md`): **owned files** stay
symlinked; **tool-managed files** are kept as a **snapshot** in the repo and
reconciled with the live file by a sync mechanism instead of a symlink. Sync
flows in two directions only — **capture** (live → repo, the everyday path) and
**seed** (repo → live, once at bootstrap, overwrite-if-absent). Authoring a
tool-managed file *from the repo* onto a running machine ("apply") is explicitly
a non-goal: the app would just re-clobber it. The mechanism is a general
registry (`dot sync`, in-script table + per-type clean function), seeded with
one entry (`claude-settings`), so adding Cursor/Raycast/etc. later is a data
change, not a new script.

## Consequences

- Snapshots are stored **normalized**: supacode-injected hooks stripped, and
  absolute paths contracted to `$HOME`/`$DOTFILES` placeholders (expanded again
  on seed). The drift detector compares in this normalized space, so noise and
  path differences never register as drift.
- Live and repo **will drift** between captures by design. A throttled,
  read-only zsh-startup nudge (mtime-gated, at most once per 14 days) surfaces
  drift; capture is never automatic, so no commit churn.
- Tool-managed snapshots are point-in-time, not authoritative. A setting you
  changed in the app is not "saved" until you `dot sync capture` and commit.
