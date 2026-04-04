# Development Setup Guide

This file documents important setup and configuration for developers working on Moovie.

## Environment Requirements

- **Ruby**: 3.2.0 (managed via rbenv)
- **Flutter**: ^3.11.4
- **Dart**: ^3.11.4

## Ruby Setup

We use rbenv to manage Ruby versions. Ensure you have Ruby 3.2.0 installed:

```bash
rbenv versions          # List installed versions
rbenv install 3.2.0    # Install if missing
rbenv local 3.2.0      # Set version for this project
ruby --version         # Verify
```

The `.ruby-version` file pins the project to Ruby 3.2.0.

## Fastlane Setup

All build automation and IDE configuration runs through Fastlane:

```bash
bundle install                    # Install Ruby gems (one-time)
bundle exec fastlane setup_env    # Configure environment variables (interactive)
bundle exec fastlane setup_ide    # Generate IDE run configurations
bundle exec fastlane lint         # Run Flutter linter
bundle exec fastlane test         # Run tests
```

**Always use `bundle exec`** to ensure the correct gem versions are used.

### setup_env Lane

The `setup_env` lane prompts you to enter credentials and generates the `secrets/.env` file:

```bash
bundle exec fastlane setup_env
```

This will ask for:
- **TMDB API Key** — Your TMDB bearer token
- **Backend URL** — The API endpoint for the Moovie backend

The values are securely prompted (hidden for API keys) and saved to `secrets/.env`.

## Dry Run Mode

All release lanes support a `dry_run` parameter to test the full build process without submitting to stores:

```bash
# Test build without TestFlight submission
bundle exec fastlane ios release flavor:prod dry_run:true

# Test build without Google Play submission
bundle exec fastlane android release flavor:prod dry_run:true
```

Dry run mode:
- ✅ Builds the app successfully
- ❌ Skips TestFlight/Google Play submission
- ❌ Does NOT create/push GitHub tags or releases
- ❌ Does NOT increment version numbers

Use this to test the entire build pipeline before actual production submission.

## Secrets Management

Sensitive files live in the `secrets/` folder (ignored by git):

- `secrets/.env` — Environment variables (copy from `.env.example`)
- `secrets/android/` — Android keystore and signing configs
- `secrets/ios/` — iOS certificates and provisioning profiles

These files are required for release builds but are never committed.

## IDE Configuration

Run this after checkout to auto-generate IDE run configurations:

```bash
bundle exec fastlane setup_ide
```

This creates `.idea/runConfigurations/` with Dev, Staging, and Prod buttons for Android Studio/IntelliJ. Reload the IDE to see them.

## Flavors

The app builds in three flavors (dev, staging, prod) with separate entry points and configurations:

| Flavor | Entry point | Config |
|--------|-------------|--------|
| dev | `lib/main_dev.dart` | Connects to dev backend |
| staging | `lib/main_staging.dart` | Connects to staging backend |
| prod | `lib/main.dart` | Production configuration |

## Build Folders to Clean

If you encounter build issues, clean these directories:

```bash
rm -rf build/
rm -rf .dart_tool/
rm -rf ios/Pods/
rm -rf android/.gradle/
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Then regenerate IDE configs:

```bash
bundle exec fastlane setup_ide
```
