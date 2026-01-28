---
description: "Initialize a repository for Ralph Wiggum development loop (PRD-driven agent workflow)"
argument-hint: "[--pm npm|pnpm|yarn|bun] [--typecheck CMD] [--test CMD] [--e2e CMD] [--lint CMD]"
allowed-tools: ["Read", "Write", "Bash", "Grep"]
---

Initialize this repository for the Ralph Wiggum PRD-driven development workflow.

**Arguments:** $ARGUMENTS

## What This Does

1. Detects or uses specified package manager (npm, pnpm, yarn, bun)
2. Adds `ralph:single` and `ralph:sprint` scripts to package.json
3. Creates `prd.json` with empty array if missing
4. Creates `progress.txt` if missing
5. Prompts user to add features to the PRD

## Initialization Steps

### Step 1: Detect Environment

Check for existing configuration:
- Look for `package.json` to detect JS/TS project
- Check for `prd.json` (don't overwrite if exists)
- Detect package manager: pnpm-lock.yaml → pnpm, yarn.lock → yarn, bun.lockb → bun, else npm
- Look for existing typecheck/test scripts in package.json

### Step 2: Determine Commands

**Typecheck command** (in order of preference):
1. User-provided via `--typecheck`
2. Existing `typecheck` script in package.json → `{pm} run typecheck`
3. Existing `type-check` script → `{pm} run type-check`
4. Existing `tsc` script → `{pm} run tsc`
5. If TypeScript installed → `{pm} exec tsc --noEmit`
6. Default: `echo "No typecheck configured"`

**Unit Test command** (in order of preference):
1. User-provided via `--test`
2. Existing `test` script in package.json → `{pm} test`
3. Existing `test:unit` script → `{pm} run test:unit`
4. Default: `echo "No unit tests configured"`

**E2E Test command** (in order of preference):
1. User-provided via `--e2e`
2. Existing `test:e2e` script in package.json → `{pm} run test:e2e`
3. Existing `e2e` script → `{pm} run e2e`
4. Existing `playwright` script → `{pm} run playwright`
5. If Playwright installed → `{pm} exec playwright test`
6. Default: `echo "No E2E tests configured"`

**Lint command** (in order of preference):
1. User-provided via `--lint`
2. Existing `lint` script in package.json → `{pm} run lint`
3. Existing `lint:fix` script → `{pm} run lint:fix`
4. Existing `eslint` script → `{pm} run eslint`
5. If eslint installed → `{pm} exec eslint .`
6. Default: `echo "No lint configured"`

### Step 3: Update package.json

Add or update these scripts:
```json
{
  "scripts": {
    "ralph:single": "TYPECHECK_CMD=\"{typecheck}\" UNIT_TEST_CMD=\"{unit_test}\" E2E_TEST_CMD=\"{e2e_test}\" LINT_CMD=\"{lint}\" ralph-single",
    "ralph:sprint": "TYPECHECK_CMD=\"{typecheck}\" UNIT_TEST_CMD=\"{unit_test}\" E2E_TEST_CMD=\"{e2e_test}\" LINT_CMD=\"{lint}\" ralph-sprint"
  }
}
```

**Important:** Preserve all existing scripts. Only add/update ralph:* scripts.

### Step 4: Create PRD File

If `prd.json` doesn't exist, create it:
```json
[]
```

If it exists, leave it alone and report current status.

### Step 5: Create Progress File

If `progress.txt` doesn't exist, create it with header:
```
# Ralph Wiggum Progress Log
# Each line: TIMESTAMP | STATUS | FEATURE | SUMMARY | COMMIT
```

### Step 6: Verify Git

Check if directory is a git repository. If not, warn but don't fail.

## Output

After initialization, display:

```
Ralph Wiggum initialized!

Package manager: pnpm
Scripts added to package.json:
  ralph:single → Run one feature (human review after)
  ralph:sprint → Run N features continuously

Files:
  prd.json     → [created/exists] (X features, Y failing)
  progress.txt → [created/exists]

Commands:
  pnpm run ralph:single      Run single feature
  pnpm run ralph:sprint 10   Run 10 iterations

Next steps:
  1. Add features to your PRD: /prd add "Feature description" ...
  2. Or interactively: /prd
  3. Then run: pnpm run ralph:single
```

## Then Prompt for PRD

After showing the summary, ask:

"Would you like to add features to your PRD now? I can help you define:
- Feature descriptions
- Acceptance steps  
- Priority levels

Just describe what you want to build and I'll help structure it as PRD entries."

## Non-JS Projects

If no package.json exists:
1. Ask if user wants to create one (for script convenience)
2. Or suggest running ralph-single/ralph-sprint directly with env vars:
   ```bash
   TYPECHECK_CMD="make check" TEST_CMD="make test" ralph-single
   ```

## Example Configurations

**TypeScript + Vitest + Playwright project:**
```json
{
  "scripts": {
    "test": "vitest run",
    "test:e2e": "playwright test",
    "ralph:single": "TYPECHECK_CMD=\"pnpm run typecheck\" UNIT_TEST_CMD=\"pnpm test\" E2E_TEST_CMD=\"pnpm run test:e2e\" LINT_CMD=\"pnpm run lint\" ralph-single",
    "ralph:sprint": "TYPECHECK_CMD=\"pnpm run typecheck\" UNIT_TEST_CMD=\"pnpm test\" E2E_TEST_CMD=\"pnpm run test:e2e\" LINT_CMD=\"pnpm run lint\" ralph-sprint"
  }
}
```

**React + TanStack project (typical setup):**
```json
{
  "scripts": {
    "typecheck": "tsc --noEmit",
    "test": "vitest run",
    "test:e2e": "playwright test",
    "lint": "biome check",
    "ralph:single": "TYPECHECK_CMD=\"pnpm run typecheck\" UNIT_TEST_CMD=\"pnpm test\" E2E_TEST_CMD=\"pnpm run test:e2e\" LINT_CMD=\"pnpm run lint\" ralph-single",
    "ralph:sprint": "TYPECHECK_CMD=\"pnpm run typecheck\" UNIT_TEST_CMD=\"pnpm test\" E2E_TEST_CMD=\"pnpm run test:e2e\" LINT_CMD=\"pnpm run lint\" ralph-sprint"
  }
}
```

**Python project (no package.json):**
```bash
# Add to Makefile or shell alias
TYPECHECK_CMD="mypy ." UNIT_TEST_CMD="pytest tests/unit" E2E_TEST_CMD="pytest tests/e2e" LINT_CMD="ruff check ." ralph-single
```

**Go project:**
```bash
TYPECHECK_CMD="go build ./..." UNIT_TEST_CMD="go test ./..." E2E_TEST_CMD="go test -tags=e2e ./..." LINT_CMD="golangci-lint run" ralph-single
```
