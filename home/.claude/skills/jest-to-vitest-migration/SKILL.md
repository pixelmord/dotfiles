---
name: jest-to-vitest-migration
description: Use when migrating a TypeScript or React test suite from Jest to Vitest. Covers API replacements, mocking differences (default exports, importActual), ESM spy limitations, window.location mocking, Vitest config/setup, and common failure fixes.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# Jest to Vitest Migration

Migrate a Jest-based TypeScript/React test suite to Vitest with minimal regressions. Apply systematic replacements, update configuration, and fix common mocking and ESM edge cases.

## Workflow

1. Install Vitest deps and remove Jest deps.
2. Add `vitest.config.ts` and a setup file.
3. Replace `jest.*` APIs with `vi.*` equivalents.
4. Fix async `importActual` usage and default-export mocks.
5. Address ESM spy limitations and window.location mocks.
6. Run tests and fix remaining failures using the error table.

## API Replacements

| Jest | Vitest |
|------|--------|
| `jest.mock()` | `vi.mock()` |
| `jest.fn()` | `vi.fn()` |
| `jest.spyOn()` | `vi.spyOn()` |
| `jest.mocked()` | `vi.mocked()` |
| `jest.clearAllMocks()` | `vi.clearAllMocks()` |
| `jest.resetAllMocks()` | `vi.resetAllMocks()` |

### Async `importActual` (Breaking Change)

Replace sync `jest.requireActual()` with async `vi.importActual()` and make the mock factory async:

```ts
// Jest (sync)
jest.mock('react', () => ({
  ...jest.requireActual('react'),
  useState: jest.fn(),
}));

// Vitest (async factory required)
vi.mock('react', async () => ({
  ...(await vi.importActual('react')),
  useState: vi.fn(),
}));
```

## Module Mocking Differences

### Default Export Requirement

Return an object with a `default` key for default exports:

```ts
// Vitest - correct
vi.mock('./component', () => ({
  default: () => <div>Mock</div>,
}));
```

### Named + Default Exports

```ts
vi.mock('swr', () => ({
  default: vi.fn(),
  useSWRConfig: vi.fn(),
}));
```

### Class Mocks

Mock classes with class syntax (not `vi.fn()`), or constructors will fail:

```ts
vi.mock('axios', () => ({
  AxiosHeaders: class MockAxiosHeaders {},
}));
```

## ESM Spy Limitation

Vitest runs native ESM. Spies only intercept external calls, not internal calls within the same module.

```ts
// timestamp-helper.ts
export function adjustLocale(locale: string) { /* ... */ }
export function getFormattedTime(datetime: string, format: Format, locale: string) {
  const adjustedLocale = adjustLocale(locale); // Not intercepted by spy
}
```

When a spy fails in Vitest but worked in Jest:

- Skip the test with a short explanation, or
- Extract the dependency into another module, or
- Inject the function as a dependency in the call site.

## window.location Mocking

Always define `configurable: true` so Vitest teardown can restore `window.location`.

```ts
const originalLocation = window.location;

beforeAll(() => {
  Object.defineProperty(window, 'location', {
    writable: true,
    configurable: true,
    value: new URL('http://localhost/'),
  });
});

afterAll(() => {
  Object.defineProperty(window, 'location', {
    writable: true,
    configurable: true,
    value: originalLocation,
  });
});
```

For per-test overrides, wrap in a helper and reset in `afterEach`.

## Configuration

### `vitest.config.ts`

```ts
import { resolve } from 'node:path';
import react from '@vitejs/plugin-react';
import tsconfigPaths from 'vite-tsconfig-paths';
import { defineConfig } from 'vitest/config';

export default defineConfig({
  plugins: [react(), tsconfigPaths()],
  resolve: {
    alias: {
      'intl-tel-input/build/css/intlTelInput.css': resolve(
        __dirname,
        './vitest-config/__mocks__/empty.ts'
      ),
    },
  },
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./vitest-config/setup.ts'],
    include: ['src/**/*.test.{ts,tsx}'],
    fakeTimers: {
      shouldAdvanceTime: true,
    },
    css: {
      modules: {
        classNameStrategy: 'non-scoped',
      },
    },
    coverage: {
      provider: 'v8',
      reportsDirectory: './report/coverage',
      reporter: ['text', 'lcov', 'json-summary', 'html'],
    },
  },
});
```

Key config notes:

- Set `fakeTimers.shouldAdvanceTime: true` for `@testing-library` `waitFor` with fake timers.
- Put `resolve.alias` at the root level, not under `test`.
- Use `globals: true` only if you want `describe`/`it`/`expect` without imports.

### `vitest-config/setup.ts`

```ts
import '@testing-library/jest-dom/vitest';
import { beforeAll, vi } from 'vitest';

beforeAll(() => {
  process.env.TZ = 'UTC';
});

vi.mock('react-i18next', () => ({
  useTranslation: () => ({
    t: (key: string): string => key,
    i18n: { changeLanguage: () => Promise.resolve({}) },
  }),
  Trans: ({ children }: { children: React.ReactNode }) => children,
}));
```

## Migration Checklist

- Install: `pnpm add -D vitest @vitest/coverage-v8`
- Remove: `jest`, `ts-jest`, `@types/jest`, `jest-environment-jsdom`
- Add `vitest.config.ts` and `vitest-config/setup.ts`
- Update `@testing-library/jest-dom` import to `@testing-library/jest-dom/vitest`
- Replace `jest.` with `vi.`
- Replace `jest.requireActual` with `await vi.importActual` and make mocks async
- Wrap default-export mocks in `{ default: ... }`
- Fix `window.location` mocks with `configurable: true`
- Update `package.json` scripts
- Run tests and fix remaining errors

## Common Errors and Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| `vi.mock() is not returning an object` | Missing `{ default: ... }` wrapper | Return `{ default: component }` |
| `No "X" export defined on mock` | Missing export in mock | Add export or use `vi.importActual()` |
| `Cannot delete property 'location'` | Missing `configurable: true` | Add `configurable: true` to `Object.defineProperty` |
| `X is not a constructor` | Mock function instead of class | Use `class MockX {}` |
| Timeouts with `waitFor` | Fake timers not advancing | Set `fakeTimers.shouldAdvanceTime: true` |
