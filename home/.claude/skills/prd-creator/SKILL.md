---
name: prd-creator
description: Create a human-readable PRD.md and seed prd.json tasks from a project idea. Optimized for technical founders. Uses exa MCP for research. Outputs (1) docs/specs/PRD_<topic>_<timestamp>.md and (2) prd.json entries per prd-manager schema.
---

# PRD Creator Skill

Create structured product requirements from a project idea. Produces both human-readable documentation and machine-consumable task breakdowns.

## Outputs

1. **PRD.md** → `docs/specs/PRD_<topic-slug>_<YYYYMMDD_HHMM>.md`
2. **prd.json entries** → Appended to repository root `prd.json` (per prd-manager schema)

## Audience

Technical founder who codes. Assumptions:

- Knows how to build software
- Has opinions on tech stack
- Wants concise, direct communication
- Values testable acceptance criteria over vague requirements

Skip basics. Challenge assumptions. Be direct.

## Workflow

### Phase 1: Project Classification

Ask upfront:

> **Is this a greenfield project (new from scratch) or brownfield (adding to existing codebase)?**

| Type | Approach |
|------|----------|
| **Greenfield** | Full discovery: research market, propose complete feature set, define architecture |
| **Brownfield** | Codebase-aware: analyze existing patterns/stack, propose features that fit, respect conventions |

For **brownfield**, before brainstorming:
- Read existing `package.json`, config files, folder structure
- Identify current stack, patterns, conventions
- Note existing features to avoid duplication
- Understand architectural constraints

### Phase 2: Research & Discovery

Use exa MCP tools to gather context:

```
skill_mcp(mcp_name="exa", tool_name="web_search_exa", arguments='{"query": "<query>", "num_results": 5}')
```

**Available exa tools:**
- `web_search_exa` - Market research, competitors, best practices
- `get_code_context_exa` - Implementation patterns, code examples
- `crawling_exa` - Deep-dive specific docs/articles
- `company_research_exa` - Competitor analysis, integration partners
- `deep_researcher_start` / `deep_researcher_check` - Complex multi-step research

**Research goals:**
- Similar products/competitors (what works, what's missing)
- Common feature patterns for this type of product
- User expectations and pain points
- Technical considerations and gotchas

Cite sources: `[Title](URL)`

### Phase 3: Feature Brainstorm (Agent-Led)

**Agent proposes a comprehensive feature set** based on research. Don't ask the user to list features—propose them.

Present features grouped by category:

```markdown
Based on my research, here's a proposed feature set for "<Project>":

## Core Features (V1 Must-Haves)
1. **User Authentication** - Email/password + OAuth (Google)
   - Why: Table stakes for any user-facing app
2. **[Feature B]** - Description
   - Why: [Rationale from research]
3. ...

## Enhanced Features (V1 Nice-to-Haves)
4. **[Feature D]** - Description
   - Why: Competitors X and Y have this
5. ...

## Future Features (Post-V1)
6. **[Feature F]** - Description
   - Why: Advanced use case, defer to reduce scope

---

**Questions for you:**
- Add anything missing?
- Remove anything that's out of scope?
- Move features between tiers?
- Any hard constraints I should know about?
```

**Key principles:**
- **Be opinionated**: Propose what YOU think is right, not vague options
- **Show reasoning**: "Competitors X and Y both have this" or "Common pattern for this domain"
- **Group by priority**: Must-have vs nice-to-have vs future
- **Challenge scope creep**: If user adds too much, push back on V1 feasibility

### Phase 4: Feature Refinement (User-Led)

Iterate until feature set is locked:

1. User adds/removes/re-prioritizes features
2. Agent incorporates changes, may push back on scope
3. Repeat until user confirms: **"Feature set looks good, proceed"**

**Scope guardrails:**
- V1 should have 5-10 features max (push back if more)
- Each feature should be deliverable in 1-3 days
- If feature is too big, break it down or defer parts

Only proceed to technical details AFTER feature set is confirmed.

### Phase 5: Technical Questions

Now ask targeted technical questions. One at a time. Skip if preset answers.

**For greenfield:**
1. **Stack confirmation**: "I'm assuming web (React + TanStack). Correct, or different preference?"
2. **Data model**: "Main entities I see: User, [X], [Y]. Any others? PII concerns?"
3. **Auth**: "Email/password + Google OAuth? Need SSO or MFA?"
4. **Integrations**: "Will you need payments (Stripe?), email (Resend?), analytics?"
5. **Hosting**: "Preference? (Vercel/Netlify/self-hosted)"
6. **Constraints**: "Budget ceiling? Timeline? Compliance requirements?"

**For brownfield:**
1. **Confirm understanding**: "I see you're using [stack]. New features should follow these patterns, correct?"
2. **Integration points**: "Where does this feature connect to existing code?"
3. **Scope boundaries**: "Any areas of the codebase I should NOT touch?"

### Phase 6: Generate PRD.md

Human-readable document. See template below.

Include:
- Agreed feature set with acceptance criteria
- Technical decisions and rationale
- Data model
- Risks and mitigations

### Phase 7: Generate prd.json Entries

Break down each feature into implementable tasks:

- One task per feature (or sub-feature if complex)
- Concrete, testable acceptance steps
- Proper categorization and priority

### Phase 8: Confirm & Write

Show:
- PRD.md path + summary
- prd.json entries to add (full list)
- Any duplicates that will be skipped

**Write only after user confirms.** Never auto-commit.

## Stack Presets

### Mobile (React Native / Expo)

```yaml
Build: Expo SDK + EAS Build, TypeScript strict
Navigation: React Navigation (native stack)
Data: TanStack Query + REST or GraphQL
State: Jotai (atomic)
Auth: OAuth via Auth0/Clerk/Supabase + expo-secure-store
Storage: AsyncStorage (non-sensitive), SecureStore (tokens)
Testing:
  - Unit: Jest + React Native Testing Library
  - E2E: Detox or Maestro
Lint: ESLint (RN config), Prettier
Typecheck: tsc --noEmit
CI: EAS Build + GitHub Actions
```

### Web App (React + TypeScript + TanStack)

```yaml
Build: Vite (SPA) or Tanstack Start (SSR/SSG) - confirm need
Framework: React 19+, TypeScript strict
Router: TanStack Router (type-safe)
Data: TanStack Query (server state)
State: Zustand (client state)
Forms: Tanstack Form + Zod
Tables: TanStack Table (if needed)
UI: Tailwind CSS (default) in version 4
Testing:
  - Unit: Vitest + Testing Library
  - E2E: Playwright
Lint: Biome
Typecheck: tsc --noEmit or tsgo
CI: Netlify or Docker + cloud
```

### Content Site (Astro + Tailwind)

```yaml
Build: Astro 4+, TypeScript
Content: Markdown/MDX with content collections
Styling: Tailwind CSS
Images: Astro assets (optimized, responsive)
Search: Pagefind (static) - confirm
CMS: None (git-based) or Headless (Sanity) - confirm
Islands: React/Preact/Solid for interactive bits
Testing:
  - E2E: Playwright (critical paths)
  - Links: broken-link-checker
  - A11y: axe-core
Lint: ESLint (astro plugin), Prettier
Typecheck: astro check + tsc
CI: Netlify/Cloudflare Pages
```

## PRD.md Template

```markdown
# PRD: <Topic>

| Field | Value |
|-------|-------|
| Owner | <name/role> |
| Date | <YYYY-MM-DD> |
| Stack | <preset> + <deviations> |
| Status | Draft |

## Goals

What success looks like. Measurable outcomes.

## Non-Goals

Explicitly out of scope for V1.

## Target Users

Who uses this? Primary persona. Use cases.

## Core Features (V1)

### Feature 1: <Name>
- **Category**: functional/ui/api/infra
- **Priority**: high/medium/low
- **Description**: What it does
- **Acceptance Criteria**:
  1. Step 1
  2. Step 2
  3. Step 3
- **Technical Notes**: Implementation hints, constraints

### Feature 2: <Name>
...

## Data Model

### Entity: <Name>
| Field | Type | Constraints | Notes |
|-------|------|-------------|-------|
| id | uuid | PK | |
| ... | | | |

### Relationships
- User has many Posts
- ...

## Auth & Security

- **Providers**: <list>
- **Session**: JWT / cookie / etc.
- **PII Handling**: <approach>
- **Compliance**: <requirements>

## Integrations

| Service | Purpose | Notes |
|---------|---------|-------|
| Stripe | Payments | ... |
| ... | | |

## Non-Functional Requirements

| Aspect | Target |
|--------|--------|
| Response time | < 200ms p95 |
| Availability | 99.9% |
| Budget | $X/month |
| Hosting | <preference> |

## Milestones

### Phase 1: MVP (Week 1-2)
- Feature A
- Feature B

### Phase 2: Polish (Week 3-4)
- Feature C
- ...

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| ... | High/Med/Low | ... |

## References

- [Title](URL) - brief note
- ...
```

## prd.json Schema (from prd-manager)

```json
{
  "category": "functional|ui|api|infra|docs|test",
  "description": "Unique feature description (acts as key)",
  "steps": ["Testable step 1", "Testable step 2"],
  "passes": false,
  "priority": "high|medium|low"
}
```

**Rules:**

- `passes` always `false` on creation
- `description` must be unique (case-insensitive)
- `steps` must be concrete and verifiable
- Never delete existing entries

**Category mapping:**

- Auth, payments, navigation, CRUD, business logic → `functional`
- Styling, layout, animations, responsive → `ui`
- REST/GraphQL endpoints, webhooks → `api`
- CI/CD, hosting, config, env setup → `infra`
- README, guides, comments → `docs`
- Test coverage, test utilities → `test`

**Priority mapping:**

- V1 must-haves → `high`
- Nice-to-haves for V1 → `medium`
- Post-V1 / future → `low`

## Example Output

### PRD.md (abbreviated)

```markdown
# PRD: AI Meal Planner

| Field | Value |
|-------|-------|
| Owner | @founder |
| Date | 2026-01-08 |
| Stack | Web App (React + TanStack) |

## Goals
- Users generate personalized weekly meal plans in < 30s
- 80% of generated plans require no modifications

## Core Features (V1)

### Feature 1: User Authentication
- **Category**: functional
- **Priority**: high
- **Acceptance Criteria**:
  1. User signs up with email/password
  2. User logs in; session persists across refresh
  3. User logs out; session cleared
...
```

### prd.json entries

```json
[
  {
    "category": "functional",
    "description": "User authentication with email/password",
    "steps": [
      "User signs up with email and password",
      "Validation errors shown for invalid input",
      "User logs in successfully",
      "Session persists across page refresh",
      "User logs out; session cleared"
    ],
    "passes": false,
    "priority": "high"
  },
  {
    "category": "functional",
    "description": "Generate personalized meal plan",
    "steps": [
      "User enters dietary preferences",
      "User clicks generate",
      "AI generates 7-day meal plan in < 30s",
      "Plan displays with breakfast/lunch/dinner per day",
      "User can regenerate individual meals"
    ],
    "passes": false,
    "priority": "high"
  }
]
```

## Error Handling

- **Duplicate description**: Skip with warning, don't fail entire operation
- **Invalid prd.json**: Report parse error, do not write
- **Missing docs/specs/**: Offer to create directory
- **Research fails**: Continue without research, note limitation

## Integration with Ralph Wiggum

After `/prd create`:

1. `prd.json` has prioritized, testable tasks
2. Run `ralph-single` to implement first high-priority failing feature
3. Agent writes tests, passes gates, marks complete
4. Repeat with `ralph-sprint` for batch execution

## Constraints

- Never auto-commit (user must review)
- Never delete prd.json entries
- JSON-only edits; 2-space indent; preserve ordering
- PRD.md is reference only; prd.json is source of truth for execution
