# Comprehensive Lint & Test Fix Strategy

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Achieve zero lint errors in the Moovie Flutter project by fixing root causes (missing package exports) and addressing cascading type errors and null safety violations.

**Architecture:** Three-phase approach targeting high-impact fixes first. Phase 1 fixes ~10 missing package exports (resolves ~200 errors), Phase 2 handles remaining cascading type errors, Phase 3 addresses null safety violations. Test issues are handled separately after lint cleanup.

**Tech Stack:** Flutter, Dart analyzer, package structure (feature modules, domain/data layers)

---

## Root Cause Analysis & Error Distribution

The 327 lint errors fall into clear categories:

### **Critical Missing Exports (top 10)**
These cause cascading failures affecting 200+ downstream errors:

1. **`package:movies/movies.dart`** — 23 direct errors + 100+ cascading
   - Root cause: `features/movies/lib/movies.dart` not exporting movies_domain and movies_data
   - Files: `features/movies/lib/movies.dart`, domain and data module exports

2. **`package:infinite_scroll_pagination/infinite_scroll_pagination.dart`** — 11 errors
   - Root cause: Incorrect import path or missing pub dependency
   - Affects: pagination in list screens across the app

3. **`package:profile/profile.dart`** — 8 errors + cascading
   - Root cause: `features/profile/lib/profile.dart` missing exports
   - Files: `features/profile/lib/profile.dart`, profile_domain, profile_data

4. **`package:get_it/get_it.dart`** — 8 errors
   - Root cause: GetIt not properly available to DI consumers
   - Affects: dependency injection across features

5. **`package:core/core.dart`** — 7 errors
   - Root cause: Shared utilities/models not properly exported
   - Files: Core package lib file and exported modules

6. **`package:user_activities/user_activities.dart`** — 3 errors
   - Root cause: Missing exports in user_activities feature module

7. **`package:public_profile_domain/` routes** — 2-3 specific file imports
   - Root cause: Specific domain files not in public API

8. **`package:movies_ui/` routing files** — 2-3 missing route exports
   - Root cause: Router or route class not exported from UI package

9. **`package:reviews/` aggregates** — Missing bloc/state exports

10. **Individual domain package chains** — Various missing dependencies

### **Error Categories**

- **Missing exports:** ~250 errors (cascading from above)
- **Undefined classes/types:** ~50 errors (cascade-resolved by Phase 1)
- **Type argument errors:** ~20 errors (cascade-resolved by Phase 1)
- **Null safety violations:** ~15-20 errors (unconditional property access)
- **Other (return type mismatches, body completion):** ~5-10 errors

---

## Three-Phase Fix Strategy

### **Phase 1: Export Layer (High-Impact)**

**Objective:** Fix the ~10 critical missing exports to resolve ~200+ cascading errors.

**Process:**
1. For each missing export error (23 from movies, 11 from pagination, 8 from profile, etc.):
   - Locate the package's main lib file (e.g., `features/movies/lib/movies.dart`)
   - Identify what needs to be exported (domain models, data sources, blocs, cubits, use cases)
   - Add `export` statements for all public APIs
   - Verify the dependency chain: if A imports from B, ensure B exports what A needs

2. Specific packages to audit:
   - `features/movies/lib/movies.dart` — must export movies_domain and movies_data
   - `features/profile/lib/profile.dart` — must export profile_domain and profile_data
   - `features/user_activities/lib/user_activities.dart`
   - `features/public_profile/lib/public_profile.dart` (if exists)
   - `features/reviews/lib/reviews.dart`
   - `packages/core/lib/core.dart` — shared exports
   - Check pagination package integration
   - Verify get_it availability in DI setup

3. Validation:
   - After each batch of exports, run `flutter analyze` and check error count reduction
   - Expected: 200+ errors resolved with Phase 1 alone

**Success Metric:** Remaining errors drop from 327 to ~80

---

### **Phase 2: Cascading Type Errors**

**Objective:** Resolve remaining ~80 errors from undefined classes and type mismatches.

**Process:**
1. Run `flutter analyze` and categorize remaining errors
2. Most will be "Undefined class" or "type argument" errors stemming from missing imports in UI/feature code
3. Fix by:
   - Ensuring the class is actually exported from its package (Phase 1 should handle this)
   - Correcting import paths where they're wrong
   - Adding missing intermediate exports in domain/data packages if needed
4. Case-by-case evaluation: if a class is genuinely missing or unused, note for Phase 3 suppression evaluation

**Success Metric:** Remaining errors drop from ~80 to ~20-30

---

### **Phase 3: Null Safety & Edge Cases**

**Objective:** Fix remaining ~20-30 errors with proper null safety and handle edge cases.

**Categories & Handling:**

1. **Unconditional property access on nullable receivers** (~15 errors)
   - Pattern: `receiver.property` where receiver can be null
   - Fix: Add null check (`receiver?.property`), null coalesce (`receiver?.property ?? defaultValue`), or assert
   - Evaluation: Fix all—this is critical for runtime safety

2. **Return type mismatches** (~3-5 errors)
   - Pattern: Function returns dynamic or missing return path
   - Fix: Add explicit return statements, ensure all code paths return correct type

3. **Type inference failures** (~1-2 errors)
   - Pattern: Generic type can't be inferred
   - Fix: Add explicit type arguments or fix the data type

4. **Edge cases & suppressions**:
   - If an error is truly a false positive (analyzer can't prove safety but code is safe), evaluate:
     - Is the code genuinely safe? (add comment explaining why)
     - Is fixing it worth the refactor? (simple null checks are worth it; deep refactors may warrant suppression)
   - Decision: suppress only after verification—default to fixing

**Success Metric:** 0 errors remaining

---

## Test Handling

**Current State:**
- `test/widget_test.dart` contains a smoke test for a counter UI that doesn't exist in the app
- Test fails because the app doesn't have a counter widget

**Strategy:**
- Keep test disabled via `.actions.yml: run_ios_tests: false` during lint fixes
- After lint is 100% clean, re-enable testing and decide separately:
  - Delete the smoke test (it's a template artifact)
  - OR replace with real integration tests for actual app screens
- This decouples test concerns from lint cleanup

---

## Iteration & Validation

**Per-Phase Validation:**
- After Phase 1: Run `flutter analyze`, expect <100 errors
- After Phase 2: Run `flutter analyze`, expect <30 errors
- After Phase 3: Run `flutter analyze`, expect 0 errors

**Final Validation:**
- Run `flutter pub get && dart run build_runner build --delete-conflicting-outputs`
- Run `flutter analyze` with no errors
- Commit with message: `fix: resolve all lint errors (327 → 0)`

---

## Scope & Constraints

- **Multiple sessions allowed:** If Phase 1 resolves 200+ errors in one session, feel free to pause and continue Phase 2-3 later
- **Restructuring allowed:** If a package needs better export organization or new intermediate export files, that's in scope
- **Suppression evaluation:** Case-by-case only—default to fixing, suppress only when verified safe and fixing is disproportionately costly
- **No major refactoring:** Focus on lint cleanup, not architectural changes unrelated to export/import issues

---

## Success Criteria

- ✓ `flutter analyze` returns 0 errors
- ✓ No suppressed violations (clean analysis output)
- ✓ All changes committed with clear messages (one per logical fix, e.g., "fix: add missing exports to movies package")
- ✓ Build completes: `flutter build ios --flavor=dev --simulator` succeeds
- ✓ Ready to re-enable `run_linter: true` and `run_ios_tests: true` in `.actions.yml` for CI/CD
