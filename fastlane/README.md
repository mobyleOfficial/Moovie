fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### setup_ide

```sh
[bundle exec] fastlane setup_ide
```

Setup IDE run configurations

### setup_env

```sh
[bundle exec] fastlane setup_env
```

Configure environment variables (secrets/.env) - interactive

### setup_ci_env

```sh
[bundle exec] fastlane setup_ci_env
```

Setup environment for CI builds (from environment variables)

### codegen

```sh
[bundle exec] fastlane codegen
```

Run code generation (build_runner) for all packages

### test

```sh
[bundle exec] fastlane test
```

Run tests

### lint

```sh
[bundle exec] fastlane lint
```

Run linter (dart analyze)

### clean

```sh
[bundle exec] fastlane clean
```

Clean iOS and Android build artifacts

----


## iOS

### ios build

```sh
[bundle exec] fastlane ios build
```

Build iOS app for a given flavor

### ios deploy_testflight

```sh
[bundle exec] fastlane ios deploy_testflight
```

Deploy iOS to TestFlight

----


## Android

### android build

```sh
[bundle exec] fastlane android build
```

Build Android app for a given flavor

### android deploy_play

```sh
[bundle exec] fastlane android deploy_play
```

Deploy Android to Google Play

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
