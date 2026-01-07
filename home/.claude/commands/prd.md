---
description: "Manage prd.json features for Ralph Wiggum development loops (add|edit|pass|fail|list)"
argument-hint: "[add|edit|pass|fail|list] [description] [--category X] [--steps ...] [--priority X] [--status X]"
allowed-tools: ["Read", "Write", "Grep"]
---

You are managing a JSON Product Requirements Document (`prd.json`) for iterative agent development.

**Command:** $ARGUMENTS

## Interactive Mode

**If no arguments provided, or just `add` without details:**
Guide the user through adding a feature by asking for each field one at a time:

1. **Description**: "What's the feature? (brief, unique title)"
2. **Category**: "What category? (functional / ui / api / infra / docs / test)"
3. **Steps**: "What are the acceptance steps? (list them one per line, empty line to finish)"
4. **Priority**: "Priority? (high / medium / low) [default: medium]"

Then confirm before adding:
```
Adding feature:
  description: "User can reset password"
  category: functional
  priority: high
  steps:
    1. Click forgot password link
    2. Enter email address
    3. Receive reset email
    4. Set new password
    
Add this feature? (yes/no)
```

## File Location
- `prd.json` at repository root
- Create `[]` if missing

## Operations

### Add Feature (with arguments)
```
/prd add "Feature description" --category functional --steps "Step A" "Step B" --priority high
```

### Add Feature (interactive)
```
/prd
/prd add
```
- Prompts for each field interactively (see Interactive Mode above)
- Verify description doesn't exist (case-insensitive)
- Create with `passes: false`
- Required: description, category, steps
- Optional: priority (default: medium)

### Edit Feature
```
/prd edit "Feature description" --steps "New step 1" "New step 2" --category ui
```
- Find by exact description
- Update only specified fields
- Preserve unspecified fields and passes state

### Mark Passing
```
/prd pass "Feature description"
```
- Set `passes: true`
- **Only use after verification** (typecheck, tests, lint green)
- Do NOT modify steps

### Mark Failing
```
/prd fail "Feature description"
```
- Set `passes: false`
- Do NOT modify steps

### List Features
```
/prd list
/prd list --status failing
/prd list --status passing
```
- Show table: status, description, category, priority
- Failing first by default
- Show counts

## Schema
```json
{
  "category": "functional|ui|api|infra|docs|test",
  "description": "Unique feature description",
  "steps": ["Acceptance step 1", "..."],
  "passes": false,
  "priority": "high|medium|low"
}
```

## Rules
1. JSON only. Pretty-print with 2 spaces.
2. Never delete entries or modify unrelated features.
3. Uniqueness by description (case-insensitive).
4. passes=false by default; true only after full verification.
5. Preserve array ordering.

## Workflow
1. Read `prd.json` (or create empty array if missing)
2. Parse and validate operation
3. Apply change to matching entry only
4. Write entire JSON back atomically
5. Output brief confirmation with diff summary

## Output Format

**On add/edit/pass/fail:**
```
Updated: "Feature description"
  category: functional
  passes: false → true
  steps: 3 items (unchanged)
```

**On list:**
```
PRD Status: 5 failing, 3 passing (8 total)

FAILING:
  [high] functional: "User can reset password"
  [med]  ui: "Dark mode toggle"
  
PASSING:
  [high] api: "Login endpoint returns JWT"
```
