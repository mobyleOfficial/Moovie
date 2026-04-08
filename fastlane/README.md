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

Configure environment variables (secrets/.env)

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

### ios release

```sh
[bundle exec] fastlane ios release
```

Release iOS (build + prepare for upload)

----


## Android

### android build

```sh
[bundle exec] fastlane android build
```

Build Android app for a given flavor

### android release

```sh
[bundle exec] fastlane android release
```

Release Android (build + prepare for upload)

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
