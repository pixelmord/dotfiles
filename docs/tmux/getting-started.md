# Tmux Getting Started Guide

Essential tmux commands for web development workflows with multiple panes.

## Core Prefix Key

- **Prefix**: `Ctrl-a` (instead of default `Ctrl-b`)
- All commands below require pressing `Ctrl-a` first, then the key

---

## Essential Commands for Web Development

### 1. Session Management (Most Important!)

```bash
# Outside tmux
tm                    # Interactive session switcher (fzf-based)
tmux new -s myproject # Create named session
ta                    # Attach to last session
tls                   # List all sessions

# Inside tmux
Ctrl-a s              # Session switcher popup (tm script)
Ctrl-a d              # Detach from session
```

### 2. Creating Your Multi-Pane Layout

```bash
# Split panes (maintains current directory)
Ctrl-a |              # Split vertically (side-by-side)
Ctrl-a -              # Split horizontally (top-bottom)

# Example workflow for 5-pane setup:
# 1. Start: Ctrl-a | (split vertical)
# 2. Right pane: Ctrl-a - (split horizontal)
# 3. Left pane: Ctrl-a h, then Ctrl-a - (split horizontal)
# 4. Continue splitting as needed
```

### 3. Navigating Between Panes

```bash
# Vim-style navigation
Ctrl-a h              # Move to left pane
Ctrl-a j              # Move to down pane
Ctrl-a k              # Move to up pane
Ctrl-a l              # Move to right pane

# Or use mouse (enabled in config)
# Just click on the pane you want
```

### 4. Resizing Panes

```bash
# Hold Ctrl-a and press repeatedly (repeatable with -r flag)
Ctrl-a H              # Resize left (10 cells)
Ctrl-a J              # Resize down (10 cells)
Ctrl-a K              # Resize up (10 cells)
Ctrl-a L              # Resize right (10 cells)
```

### 5. Window Management

```bash
Ctrl-a c              # Create new window (keeps current directory)
Ctrl-a Ctrl-h         # Previous window
Ctrl-a Ctrl-l         # Next window
Ctrl-a 0-9            # Jump to window number
Ctrl-a ,              # Rename current window
```

### 6. Closing Panes and Sessions

```bash
# Close a pane
exit                  # Type 'exit' in the pane's shell
Ctrl-d                # Send EOF to close the shell (same as exit)
Ctrl-a x              # Kill current pane (asks for confirmation)

# Remove sessions
tm                    # Opens session picker
Ctrl-d                # While hovering over a session, delete it

# From command line
tmux kill-session -t session-name    # Kill specific session
tmux kill-session                    # Kill current session
tmux kill-server                     # Kill ALL sessions (nuclear option)
```

### 7. Useful Utilities (Custom Bindings)

```bash
Ctrl-a g              # Open lazygit popup (80% screen)
Ctrl-a y              # Open claude-dashboard popup
Ctrl-a =              # Tile all panes evenly
Ctrl-a y (lowercase)  # Synchronize all panes (type in all at once)
Ctrl-a T              # Toggle status bar on/off
```

### 8. Copy Mode (Vim-style)

```bash
Ctrl-a Escape         # Enter copy mode
# In copy mode:
v                     # Start selection
y                     # Copy selection
Ctrl-a p              # Paste
```

### 9. Config & Help

```bash
Ctrl-a r              # Reload tmux config
Ctrl-a ?              # Show all key bindings
```

---

## Recommended 5-Pane Layout for Web Dev

```
┌─────────────────┬─────────────────┐
│                 │                 │
│   Dev Server    │   AI Agent 1    │
│   (npm run dev) │   (claude-code) │
│                 │                 │
├─────────────────┼─────────────────┤
│                 │                 │
│   Commands      │   AI Agent 2    │
│   (git, etc)    │   (reviews)     │
│                 │                 │
├─────────────────┴─────────────────┤
│                                   │
│   Test Suite (npm test --watch)   │
│                                   │
└───────────────────────────────────┘
```

### How to create this layout:

```bash
# Start in a new session
tmux new -s webdev

# Create layout
Ctrl-a |              # Split vertical
Ctrl-a -              # Split right pane horizontal
Ctrl-a h              # Go to left pane
Ctrl-a -              # Split left pane horizontal
Ctrl-a j              # Go to bottom-left
Ctrl-a -              # Split bottom horizontal

# Navigate and start processes
Ctrl-a k              # Top-left: npm run dev
Ctrl-a l              # Top-right: claude-code
Ctrl-a j Ctrl-a j     # Bottom-left: your commands
Ctrl-a l              # Bottom-right: review agent
Ctrl-a j              # Bottom: npm test --watch
```

---

## Pro Tips from Your Config

1. **Mouse Support**: Enabled! You can click panes, resize by dragging borders, and scroll
2. **Auto-rename**: Windows auto-rename based on running command (via `tmux-smart-name`)
3. **Session Persistence**: Sessions survive terminal closes - just `ta` to reattach
4. **Clipboard**: `set-clipboard on` means tmux integrates with system clipboard
5. **Vi Mode**: Copy mode uses vim keybindings (you'll feel at home)

---

## Quick Start Workflow

```bash
# 1. Create project session
tmux new -s myapp

# 2. Split into your 5 panes (see layout above)

# 3. In each pane, start your process:
#    - Pane 1: npm run dev
#    - Pane 2: claude-code
#    - Pane 3: (leave for commands)
#    - Pane 4: your review agent
#    - Pane 5: npm test --watch

# 4. Detach when done
Ctrl-a d

# 5. Later, reattach
ta
# or
tm  # (interactive picker)
```

---

## Aliases Already Set Up

From your `.zsh_aliases`:
- `ta` = tmux attach
- `tls` = tmux ls
- `tat` = tmux attach -t [name]
- `tns` = tmux new-session -s [name]

---

## Key Takeaway

Your config is optimized for vim users with `Ctrl-a` prefix, vim-style navigation (`hjkl`), and powerful popups for lazygit and claude-dashboard. The `tm` script gives you a beautiful session switcher. Start with creating panes (`|` and `-`), navigating (`hjkl`), and using `tm` for session management!
