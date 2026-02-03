---
description: "Manage prd.json features and author PRDs (create|add|edit|pass|fail|list)"
argument-hint: "[create|add|edit|pass|fail|list] \"<topic or description>\" [--stack web|mobile|content] [--research] [--priority X] [--category X] [--steps ...]"
allowed-tools: ["Read", "Write", "Grep", "Skill"]
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

---

## Create PRD (`/prd create`)

**Invoke the `prd-creator` skill** to generate a full PRD from a project idea.

### Usage

```bash
# Greenfield (default): Full discovery, agent proposes features
/prd create "AI meal planner" --stack web
/prd create "Habit tracker app" --stack mobile
/prd create "Developer docs site" --stack content

# Brownfield: Analyze existing codebase first, propose features that fit
/prd create "Add social sharing" --brownfield
/prd create "Admin dashboard" --brownfield --no-research
```

### Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `<topic>` | required | Project idea or name |
| `--greenfield` | default | New project from scratch (full discovery) |
| `--brownfield` | - | Adding to existing codebase (respects existing patterns) |
| `--stack` | `web` | Preset: `web` (React+TanStack), `mobile` (React Native), `content` (Astro) |
| `--research` | enabled | Use exa MCP to research best practices |
| `--no-research` | - | Skip research phase |
| `--dry-run` | - | Preview output without writing files |

### Behavior

1. **Load skill**: Invoke `prd-creator` skill for workflow guidance
2. **Classify project**: Greenfield (new) or brownfield (existing codebase)
   - Brownfield: Analyze existing stack, patterns, conventions first
3. **Research** (if enabled): Use exa MCP for market/competitor/pattern research
   ```
   skill_mcp(mcp_name="exa", tool_name="web_search_exa", arguments='{"query": "...", "num_results": 5}')
   ```
4. **Agent brainstorms features**: Proposes comprehensive feature set based on research
   - Grouped by priority: must-have / nice-to-have / future
   - Shows reasoning for each feature
5. **User refines**: Add, remove, re-prioritize until feature set is locked
6. **Technical questions**: Stack, data model, auth, integrations (skip if obvious)
7. **Generate PRD.md**: Human-readable document with agreed features
8. **Generate prd.json entries**: Machine-consumable tasks
9. **Confirm**: Show preview and diff before writing
10. **Write files** (on confirmation):
    - `docs/specs/PRD_<topic-slug>_<YYYYMMDD_HHMM>.md`
    - Append to `prd.json` (no duplicates, no deletions)

### Stack Presets

**Web** (React + TypeScript + TanStack):
- Vite or Next.js, TanStack Router/Query, Zustand, Tailwind
- Testing: Vitest + Playwright

**Mobile** (React Native / Expo):
- Expo + EAS, React Navigation, TanStack Query, Zustand
- Testing: Jest + Detox/Maestro

**Content** (Astro + Tailwind):
- Astro 4+, MDX, Tailwind, Pagefind
- Testing: Playwright + a11y

### Output

**PRD.md** (human-readable):
- Goals, non-goals, target users
- Core features with acceptance criteria
- Data model, auth, integrations
- NFRs, milestones, risks

**prd.json** (machine-consumable):
- Each feature as a task with category, steps, priority
- `passes: false` by default
- Ready for `ralph-single` / `ralph-sprint`

### Example

```bash
/prd create "Recipe sharing platform" --stack web
```

Output:
```
PRD written: docs/specs/PRD_recipe-sharing-platform_20260108_2245.md
prd.json: 8 items added (0 duplicates skipped)

Features added:
  [high] functional: "User authentication with email/OAuth"
  [high] functional: "Create and publish recipes"
  [high] functional: "Search recipes by ingredients"
  [med]  ui: "Responsive recipe cards grid"
  [med]  api: "Recipe CRUD API endpoints"
  ...
```

### Notes

- **No auto-commit**: User must review and commit manually
- **Duplicates skipped**: Existing descriptions (case-insensitive) won't be overwritten
- **Creates docs/specs/**: Directory created if missing (with confirmation)
- **Skill required**: This command invokes the `prd-creator` skill

---

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
