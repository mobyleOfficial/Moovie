# Comprehensive Lint & Test Fix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix all 327 lint errors in the Moovie Flutter project by addressing missing package exports, cascading type errors, and null safety violations.

**Architecture:** Three-phase execution targeting root causes first. Phase 1 adds missing exports to feature packages (movies, profile, user_activities, reviews, core, public_profile), Phase 2 handles remaining cascading type errors, Phase 3 fixes null safety violations. Each phase is independently valuable—stop at any point if the app becomes lint-clean.

**Tech Stack:** Flutter, Dart analyzer, package structure (monorepo with domain/data/presentation layers)

---

## Phase 1: Export Layer Fixes (High-Impact)

### Task 1: Fix movies package exports

**Files:**
- Modify: `features/movies/lib/movies.dart`
- Reference: `features/movies/domain/lib/domain.dart`, `features/movies/data/lib/data.dart`

- [ ] **Step 1: Check current movies.dart content**

Run: `cat features/movies/lib/movies.dart`

Expected output shows current exports (should be minimal or incomplete)

- [ ] **Step 2: Verify domain and data exports**

Run: `cat features/movies/domain/lib/domain.dart && echo "---" && cat features/movies/data/lib/data.dart`

Expected: Both files export models, repositories, etc.

- [ ] **Step 3: Update movies.dart to re-export all public APIs**

Edit `features/movies/lib/movies.dart`:

```dart
/// Movies feature module - exports all public APIs
export 'package:movies_domain/domain.dart';
export 'package:movies_data/data.dart';
```

(Verify these match what domain.dart and data.dart export)

- [ ] **Step 4: Run analyzer to check error reduction**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: Should be noticeably less than 327 (target: <300)

- [ ] **Step 5: Commit**

```bash
git add features/movies/lib/movies.dart
git commit -m "fix: ensure movies package exports all public APIs"
```

---

### Task 2: Fix profile package exports

**Files:**
- Modify: `features/profile/lib/profile.dart`
- Reference: `features/profile/domain/lib/domain.dart`, `features/profile/data/lib/data.dart`

- [ ] **Step 1: Check profile package structure**

Run: `ls -la features/profile/*/lib/*.dart | head -10`

Expected: See domain.dart and data.dart files

- [ ] **Step 2: Read current profile.dart**

Run: `cat features/profile/lib/profile.dart`

- [ ] **Step 3: Ensure profile.dart exports domain and data fully**

Edit `features/profile/lib/profile.dart`:

```dart
/// Profile feature module - exports all public APIs
export 'package:profile_domain/domain.dart';
export 'package:profile_data/data.dart';
```

- [ ] **Step 4: Run analyzer**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: Further error reduction (target: <250)

- [ ] **Step 5: Commit**

```bash
git add features/profile/lib/profile.dart
git commit -m "fix: ensure profile package exports all public APIs"
```

---

### Task 3: Fix reviews package exports

**Files:**
- Modify: `features/reviews/lib/reviews.dart`
- Reference: `features/reviews/domain/lib/domain.dart`, `features/reviews/data/lib/data.dart`

- [ ] **Step 1: Check if reviews package exists**

Run: `ls -la features/reviews/lib/reviews.dart 2>&1`

- [ ] **Step 2: Create or update reviews.dart with proper exports**

If file exists, edit it. If not, create `features/reviews/lib/reviews.dart`:

```dart
/// Reviews feature module - exports all public APIs
export 'package:reviews_domain/domain.dart';
export 'package:reviews_data/data.dart';
```

- [ ] **Step 3: Run analyzer**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: Error reduction

- [ ] **Step 4: Commit**

```bash
git add features/reviews/lib/reviews.dart
git commit -m "fix: add reviews package exports"
```

---

### Task 4: Fix user_activities package exports

**Files:**
- Modify: `features/user_activities/lib/user_activities.dart`

- [ ] **Step 1: Check package structure**

Run: `ls -la features/user_activities/lib/`

- [ ] **Step 2: Create or update user_activities.dart**

Create/edit `features/user_activities/lib/user_activities.dart`:

```dart
/// User Activities feature module - exports all public APIs
export 'package:user_activities_domain/domain.dart';
export 'package:user_activities_data/data.dart';
```

- [ ] **Step 3: Run analyzer**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: Continued error reduction (target: <200)

- [ ] **Step 4: Commit**

```bash
git add features/user_activities/lib/user_activities.dart
git commit -m "fix: add user_activities package exports"
```

---

### Task 5: Fix public_profile package exports

**Files:**
- Modify: `features/public_profile/lib/public_profile.dart`

- [ ] **Step 1: Check if public_profile exists**

Run: `ls -la features/public_profile/lib/public_profile.dart 2>&1`

- [ ] **Step 2: Create or update public_profile.dart**

Create/edit `features/public_profile/lib/public_profile.dart`:

```dart
/// Public Profile feature module - exports all public APIs
export 'package:public_profile_domain/domain.dart';
export 'package:public_profile_data/data.dart';
```

- [ ] **Step 3: Run analyzer**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: Error reduction (target: <150)

- [ ] **Step 4: Commit**

```bash
git add features/public_profile/lib/public_profile.dart
git commit -m "fix: add public_profile package exports"
```

---

### Task 6: Fix core package exports

**Files:**
- Modify: `packages/core/lib/core.dart`

- [ ] **Step 1: Read current core.dart**

Run: `cat packages/core/lib/core.dart`

- [ ] **Step 2: Check what subdirectories exist in core/lib**

Run: `ls -la packages/core/lib/src/`

Expected: Should see models, extensions, utils, etc.

- [ ] **Step 3: Create comprehensive core.dart exports**

Edit `packages/core/lib/core.dart` to export all public APIs:

```dart
/// Core package - shared utilities and models for all features
export 'package:core/src/models/models.dart';
export 'package:core/src/extensions/extensions.dart';
export 'package:core/src/utils/utils.dart';
// Add any other public API exports
```

(Adjust based on actual structure found in Step 2)

- [ ] **Step 4: Verify export files exist**

Run: `ls packages/core/lib/src/models/models.dart packages/core/lib/src/extensions/extensions.dart 2>&1`

If files don't exist, create barrel files that re-export their contents.

- [ ] **Step 5: Run analyzer**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: Significant error reduction (target: <100)

- [ ] **Step 6: Commit**

```bash
git add packages/core/lib/core.dart
git commit -m "fix: comprehensive core package exports"
```

---

### Task 7: Handle pagination dependency

**Files:**
- Check: `pubspec.yaml` (main app)
- Potential: `features/movies_ui/pubspec.yaml` or wherever pagination is used

- [ ] **Step 1: Find where infinite_scroll_pagination is imported**

Run: `grep -r "infinite_scroll_pagination" lib/ ui/ features/ 2>/dev/null | head -5`

- [ ] **Step 2: Check if it's in pubspec.yaml**

Run: `grep "infinite_scroll_pagination" pubspec.yaml`

- [ ] **Step 3: If not present, add it**

If missing, edit `pubspec.yaml` and add under dependencies:

```yaml
infinite_scroll_pagination: ^4.0.0
```

Then run: `flutter pub get`

- [ ] **Step 4: Run analyzer**

Run: `flutter analyze 2>&1 | grep "infinite_scroll_pagination" | wc -l`

Expected: Should resolve pagination import errors

- [ ] **Step 5: Commit**

```bash
git add pubspec.yaml
git commit -m "fix: add infinite_scroll_pagination dependency"
```

---

### Task 8: Verify Phase 1 completion

- [ ] **Step 1: Run full analyzer**

Run: `flutter analyze 2>&1 > /tmp/analyze.txt && wc -l /tmp/analyze.txt && grep "^  error" /tmp/analyze.txt | wc -l`

Expected: Error count should be <100 (from 327)

- [ ] **Step 2: Categorize remaining errors**

Run: `flutter analyze 2>&1 | grep "^  error" | cut -d'•' -f2 | sort | uniq -c | sort -rn | head -10`

This shows what categories of errors remain for Phase 2

- [ ] **Step 3: Document findings**

If error count is >100, review which packages still have issues and create additional tasks for those specific packages.

- [ ] **Step 4: Commit checkpoint**

```bash
git commit --allow-empty -m "checkpoint: Phase 1 export layer fixes complete"
```

---

## Phase 2: Cascading Type Errors (Medium-Impact)

### Task 9: Resolve undefined class errors from missing domain exports

**Files:**
- Various: Domain package lib files that need barrel exports

- [ ] **Step 1: Get current error snapshot**

Run: `flutter analyze 2>&1 | grep "Undefined class" | head -10`

- [ ] **Step 2: For each error, find the missing class**

Example: If error is "Undefined class 'Movie'", the Movie class should be in movies_domain

- [ ] **Step 3: Ensure domain packages export their models**

For each domain package (movies_domain, profile_domain, etc.), check `lib/models/models.dart` exists and exports all model classes:

Run: `cat features/movies/domain/lib/models/models.dart | head -20`

If it just has `library`, add all the `export` statements for actual model files.

- [ ] **Step 4: Repeat for each domain package with errors**

Check: profile_domain, reviews_domain, user_activities_domain, public_profile_domain

- [ ] **Step 5: Run analyzer**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: Error count drops to <50

- [ ] **Step 6: Commit**

```bash
git add features/*/domain/lib/models/
git commit -m "fix: add missing model exports in domain packages"
```

---

### Task 10: Fix remaining cascading imports in UI packages

**Files:**
- Check: `ui/*/pubspec.yaml` for missing dependencies

- [ ] **Step 1: Find remaining undefined class errors**

Run: `flutter analyze 2>&1 | grep "Undefined class" | wc -l`

If 0, skip this task. Otherwise, continue.

- [ ] **Step 2: For each undefined class, determine which package it comes from**

Example error: "Undefined class 'DiscoverMovies'" → search in features/movies/domain for DiscoverMoviesUsecase or similar

Run: `grep -r "class DiscoverMovies" features/`

- [ ] **Step 3: Verify that class is exported from its domain package**

Example: Is DiscoverMovies exported in features/movies/domain/lib/usecases/usecases.dart?

If not, add the export.

- [ ] **Step 4: Verify UI package depends on the feature package**

Example: does ui/movies_ui/pubspec.yaml depend on `movies: path: ../../features/movies`?

If not, add it.

- [ ] **Step 5: Run analyzer**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: <30 errors remaining

- [ ] **Step 6: Commit**

```bash
git add ui/*/pubspec.yaml features/*/domain/lib/
git commit -m "fix: resolve cascading type errors from missing imports and exports"
```

---

### Task 11: Handle specific missing files in domain layers

**Files:**
- As identified by analyzer

- [ ] **Step 1: Find file-not-found errors**

Run: `flutter analyze 2>&1 | grep "Target of URI doesn't exist" | wc -l`

If 0, skip. Otherwise continue.

- [ ] **Step 2: Sample error messages**

Run: `flutter analyze 2>&1 | grep "Target of URI doesn't exist" | head -3`

Example: "Target of URI doesn't exist: 'package:public_profile_domain/models/public_profile.dart'"

- [ ] **Step 3: For each missing file error, check if file exists**

Example: Check `features/public_profile/domain/lib/models/public_profile.dart`

Run: `ls features/public_profile/domain/lib/models/public_profile.dart`

- [ ] **Step 4: If file exists, add export to models/models.dart**

Edit `features/public_profile/domain/lib/models/models.dart`:

```dart
export 'public_profile.dart';
export 'profile_user.dart';
export 'profile_watched_movie.dart';
```

- [ ] **Step 5: If file doesn't exist, create it or remove the import**

If the class is genuinely missing, either create the file or remove references to it.

- [ ] **Step 6: Run analyzer**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: <20 errors

- [ ] **Step 7: Commit**

```bash
git add features/*/domain/lib/models/
git commit -m "fix: add missing domain model exports"
```

---

### Task 12: Verify Phase 2 completion

- [ ] **Step 1: Check error count**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: <30 errors remaining (mostly null safety and edge cases)

- [ ] **Step 2: Categorize remaining errors**

Run: `flutter analyze 2>&1 | grep "^  error" | cut -d'•' -f2 | sort | uniq -c | sort -rn`

- [ ] **Step 3: Commit checkpoint**

```bash
git commit --allow-empty -m "checkpoint: Phase 2 cascading type errors resolved"
```

---

## Phase 3: Null Safety & Edge Cases (Final Polish)

### Task 13: Fix unconditional property access on nullable receivers

**Files:**
- As identified by analyzer (typically in domain/presentation layers)

- [ ] **Step 1: Find null safety violations**

Run: `flutter analyze 2>&1 | grep "can't be unconditionally accessed because the receiver can be 'null'" | head -5`

Example: "The property 'englishName' can't be unconditionally accessed because the receiver can be 'null'"

- [ ] **Step 2: Locate each error file and line**

Run: `flutter analyze 2>&1 | grep "can't be unconditionally accessed" | head -1 | grep -oE "lib/.*dart:[0-9]+" | cut -d: -f1-2`

- [ ] **Step 3: Fix by adding null check or null coalesce operator**

Example: Change `model.englishName` to `model?.englishName` or `model?.englishName ?? ''`

For each file:
- Read the file at the indicated line
- Add null-safe operator (? or ??)
- Verify the fix is appropriate for the context

- [ ] **Step 4: Run analyzer**

Run: `flutter analyze 2>&1 | grep "can't be unconditionally accessed" | wc -l`

Expected: 0

- [ ] **Step 5: Commit**

```bash
git add features/ ui/ lib/
git commit -m "fix: add null safety checks for property access"
```

---

### Task 14: Fix return type mismatches

**Files:**
- As identified by analyzer

- [ ] **Step 1: Find return type errors**

Run: `flutter analyze 2>&1 | grep "return type" | head -5`

- [ ] **Step 2: For each error, locate the function and add missing return statement**

Example: Add explicit return statement to ensure all code paths return the correct type.

- [ ] **Step 3: Run analyzer**

Run: `flutter analyze 2>&1 | grep "return type" | wc -l`

Expected: 0

- [ ] **Step 4: Commit**

```bash
git add features/ lib/
git commit -m "fix: resolve return type mismatches"
```

---

### Task 15: Handle type inference and suppression decisions

**Files:**
- As identified by analyzer

- [ ] **Step 1: Find remaining errors**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

If 0, skip to final validation. Otherwise, continue.

- [ ] **Step 2: Evaluate each remaining error**

For each remaining error:
1. Determine if it's a real issue (code is unsafe)
2. If safe, consider suppression with comment explaining why
3. If unsafe, fix it

- [ ] **Step 3: Fix critical issues**

For null safety and type issues, add proper fixes (null checks, type casts, etc.)

- [ ] **Step 4: For safe-but-conservative analyzer warnings**

Add ignore comments only after verification:

```dart
// ignore: some_lint_error
var value = something;
```

- [ ] **Step 5: Run analyzer**

Run: `flutter analyze 2>&1 | grep "^  error" | wc -l`

Expected: 0

- [ ] **Step 6: Commit**

```bash
git add .
git commit -m "fix: resolve remaining lint errors and add suppression comments where appropriate"
```

---

## Final Validation & Test Handling

### Task 16: Complete lint cleanup and prepare for testing

**Files:**
- `.actions.yml` (enable linter and tests)
- `test/widget_test.dart` (decide what to do with it)

- [ ] **Step 1: Final analyze run**

Run: `flutter analyze`

Expected: Completely clean output with 0 errors

- [ ] **Step 2: Run build to verify no runtime issues**

Run: `flutter build ios --flavor=dev --simulator 2>&1 | tail -5`

Expected: "Built build/ios/iphonesimulator/MoovieDev.app"

- [ ] **Step 3: Re-enable linting in CI/CD**

Edit `.actions.yml`:

Change:
```yaml
run_linter: false
run_ios_tests: false
run_android_tests: false
```

To:
```yaml
run_linter: true
run_ios_tests: false
run_android_tests: false
```

(Keep tests disabled until we decide on the smoke test)

- [ ] **Step 4: Commit**

```bash
git add .actions.yml
git commit -m "ci: re-enable linting - lint errors now at 0"
```

- [ ] **Step 5: Decide on smoke test**

Review `test/widget_test.dart`. It tests a non-existent counter feature.

Options:
- Delete it: `git rm test/widget_test.dart && git commit -m "test: remove template smoke test"`
- Keep disabled: Leave as-is for later
- Replace with real tests: Write actual integration tests

For now, proceed with keeping it disabled.

- [ ] **Step 6: Final commit**

```bash
git commit --allow-empty -m "fix: resolve all 327 lint errors - analyze output now clean"
```

---

## Validation Checklist

- [ ] `flutter analyze` shows 0 errors
- [ ] `flutter build ios --flavor=dev --simulator` succeeds
- [ ] `flutter build apk --flavor=dev` succeeds  
- [ ] No suppressed violations (or only with justification comments)
- [ ] All exports properly documented in barrel files
- [ ] CI/CD linting is re-enabled and passing

---

## Notes for Implementation

**Phase Breakdown:**
- **Phase 1** (Tasks 1-8): Export layer fixes - expect to resolve ~200 errors with ~50 lines of changes
- **Phase 2** (Tasks 9-12): Type/import fixes - expect to resolve ~80 more errors with ~100-150 lines of changes
- **Phase 3** (Tasks 13-16): Null safety and final polish - expect to resolve remaining ~30-50 errors

**Stopping Points:**
- After Task 8: If errors are <100, Phase 1 was successful
- After Task 12: If errors are <30, Phase 2 was successful
- After Task 16: If `flutter analyze` is clean, project is ready for re-enabled linting in CI/CD

**Common Issues:**
- Import path mismatches (e.g., importing from wrong package alias)
- Missing barrel files (models.dart, repositories.dart, etc.)
- Incomplete exports (exporting parent module but not re-exporting children)
- Null safety: Use `?.` for potentially null receivers, `??` for default values

**Testing During Fix:**
- After each task batch, run `flutter analyze 2>&1 | grep "^  error" | wc -l` to track progress
- If stuck on an error, check the full context: `flutter analyze 2>&1 | grep "ERROR_KEYWORD"`
