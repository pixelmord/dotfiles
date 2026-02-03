---
name: prd-manager
description: Manage a JSON Product Requirements Document (PRD). Create, list, add, edit, and mark features as passing only after end-to-end verification. JSON-only updates; do not delete or rewrite unrelated entries. Use when user wants to maintain prd.json for Ralph Wiggum development loops.
---

# PRD Manager Skill

Manage a JSON-based Product Requirements Document for iterative, agent-driven development workflows (Ralph Wiggum pattern).

## Source of Truth

File: `prd.json` at repository root (array of feature objects)

### Schema

```json
{
  "category": "functional",
  "description": "Unique feature description (acts as key)",
  "steps": ["Step 1", "Step 2", "..."],
  "passes": false,
  "priority": "high"
}
```

**Required fields:**
- `category` (string): functional, ui, api, infra, docs, test
- `description` (string): unique identifier for the feature
- `steps` (string[]): acceptance criteria / verification steps
- `passes` (boolean): false until fully verified

**Optional fields:**
- `priority` (string): high, medium, low (agents pick highest first)
- `id` (string): slug derived from description
- `owner` (string): who's responsible
- `tags` (string[]): for filtering

## Core Rules

1. **JSON only.** No Markdown. No schema drift.
2. **Never delete entries** or mutate unrelated features.
3. **Uniqueness by description** (case-insensitive match).
4. **passes=false by default** until end-to-end verification.
5. **passes=true only after** typecheck, tests, lint all green AND acceptance steps validated.
6. **Preserve ordering** and pretty-print with 2 spaces.
7. **Never remove steps** when marking pass; steps define acceptance.

## Operations

### Ensure File Exists
- If `prd.json` missing, create with empty array: `[]`

### Add Feature
```
/prd add "User can reset password" --category functional --steps "Click forgot password" "Enter email" "Receive reset link" --priority high
```
- Check description doesn't exist (case-insensitive)
- Push new object with `passes: false`
- Return brief confirmation

### Edit Feature
```
/prd edit "User can reset password" --steps "Updated step 1" "Updated step 2"
```
- Locate by exact description
- Update only specified fields
- Preserve unspecified fields

### Mark Passing
```
/prd pass "User can reset password"
```
- **Only after full verification:**
  - Typecheck passes
  - Tests pass
  - Lint passes
  - Acceptance steps validated
- Set `passes: true`
- Do NOT modify steps

### Mark Failing
```
/prd fail "User can reset password"
```
- Set `passes: false`
- Do NOT modify steps
- Use when regression detected

### List Features
```
/prd list
/prd list --status failing
/prd list --status passing
```
- Show failing first (these need work)
- Include: status, description, category, priority
- Show counts: X failing, Y passing, Z total

## Write/Read Protocol

1. **Read** `prd.json` to inspect current state
2. **Parse** and modify in-memory
3. **Write** entire JSON back atomically (2-space indent)
4. **Verify** by re-reading if paranoid

## Integration with Ralph Wiggum Scripts

This PRD format is designed for:
- `ralph-single`: Agent picks ONE failing feature, implements, verifies, marks passing
- `ralph-sprint`: Agent iterates through failing features until all pass or interrupted

The agent determines priority by:
1. Explicit `priority` field (high > medium > low)
2. Order in array (first failing feature if no priority)

## Example prd.json

```json
[
  {
    "category": "functional",
    "description": "New chat button creates a fresh conversation",
    "steps": [
      "Navigate to main interface",
      "Click the 'New Chat' button",
      "Verify a new conversation is created",
      "Check that chat area shows welcome state",
      "Verify conversation appears in sidebar"
    ],
    "passes": false,
    "priority": "high"
  },
  {
    "category": "ui",
    "description": "Dark mode toggle in settings",
    "steps": [
      "Open settings panel",
      "Toggle dark mode switch",
      "Verify theme changes immediately",
      "Verify preference persists on reload"
    ],
    "passes": true,
    "priority": "medium"
  }
]
```

## Error Handling

- **Duplicate description**: Reject add, suggest edit instead
- **Feature not found**: List similar descriptions, ask for clarification
- **Invalid JSON**: Report parse error, do not corrupt file
- **Missing required field**: Reject operation, list missing fields

## Repository Initialization

Use `/ralph-init` to set up a repository for the Ralph Wiggum workflow:

```
/ralph-init
```

This will:
1. Detect package manager (npm, pnpm, yarn, bun)
2. Add `ralph:single` and `ralph:sprint` scripts to package.json
3. Create empty `prd.json` if missing
4. Create `progress.txt` with header
5. Prompt to add features

**After initialization:**
```bash
# Run single feature (human reviews after)
pnpm run ralph:single

# Run continuous sprint (10 iterations)
pnpm run ralph:sprint 10
```

## Related Commands

| Command | Purpose |
|---------|---------|
| `/ralph-init` | Initialize repo for Ralph workflow |
| `/prd` | Manage PRD features (add/edit/pass/fail/list) |
| `/prd add` | Add feature interactively |
| `/prd list` | Show PRD status |

## Best Practices

1. **Keep descriptions concise but unique** - they're used as keys
2. **Steps should be testable** - vague steps lead to premature passes
3. **Use priority** - helps agents work on important features first
4. **Review passes** - agent marks complete, human should verify
5. **Track progress.txt** - companion file logs what was done each iteration
6. **Run `/ralph-init` first** - sets up scripts with correct env vars
