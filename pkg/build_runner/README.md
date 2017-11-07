# [![Build Status](https://travis-ci.org/dart-lang/build.svg?branch=master)](https://travis-ci.org/dart-lang/build)

# `build_runner`

This package provides a concrete way of generating files using Dart code,
outside of `pub`. These files are generated directly on disk in the current
package folder, and rebuilds are _incremental_.

## Running Builds

In order to run a build, you write a script to do the work. Every package which
*uses* a builder must have it's own script, they cannot be reused from other
packages. Often a package which defines a `Builder` will have an example you can
reference, but a unique script must be written for the consuming packages as
well.

The script will use one of the three top level functions defined by this
library:

- **build**: Runs a single build and exits.
- **watch**: Continuously runs builds as you edit files and allow serving assets
  as a `shelf` handler.

All three of these methods have a single required argument, a
`List<BuildAction>`. Each of these `BuildActions`s may run in parallel, but they
may only read outputs from steps earlier in the list.

A `BuildAction` is a combination of a single `Builder` and a single `InputSet`.
The `Builder` is what will actually generate outputs, and the `InputSet`
determines what the primary inputs to that `Builder` will be.

Lets look at a very simple example, with a single `BuildAction`. You can ignore
the `CopyBuilder` for now, just know that its a `Builder` which copies files:

```dart
import 'package:build_runner/build_runner.dart';

main() async {
  await build([new CopyBuilder('.copy'), 'my_package', ['lib/*.dart']]);
}
```

The above example would copy all `*.dart` files directly under `lib` to
corresponding `*.dart.copy` files. Each time you run a build, it will check for
any changes to the input files, and rerun the `CopyBuilder` only for the inputs
that actually changed.

A build with multiple steps may look like:

```dart
main() async {
  await build([
    new BuildACtion(new CopyBuilder('.copy1'), 'my_package', inputs: ['lib/*.dart']),
    new BuildACtion(new CopyBuilder('.copy2'), 'my_package', inputs: ['lib/*.dart']),
  ]);}
```

Lets say however, that you want to make a copy of one of your copies. Since
subsequent `BuildActions` can read the outputs of previous actions the input
globs need only to match the extension of the previous output.

```dart
main() async {
  await build([
    new BuildAction(new CopyBuilder('.copy'), 'my_package', inputs: ['lib/*.dart']),
    new BuildAction(new CopyBuilder('.bak'), 'my_package', inputs: ['lib/*.dart.copy']),
  ]);}
```

This time, all the `*.dart.copy` files will be created first, and then the next
`BuildAction` will read those in and create additional `*.dart.copy.bak` files.

**Note**: Any time you change your build script (or any of its dependencies),
the next build will be a full rebuild. This is because the system has no way
of knowing how that change may have affected the outputs.

### Inputs

Valid inputs follow the general dart package rules. You can read any files under
the top level `lib` folder any package dependency, and you can read all files
from the current package.

In general it is best to be as specific as possible with your `InputSet`s,
because all matching files will be provided to `declareOutputs`.

### Outputs

You may only output files in the current package, but anywhere in the current
package is allowed.

You are not allowed to overwrite existing files, only create new ones.

Outputs from previous builds will not be treated as inputs to later ones.

### Source control

This package creates a top level `.dart_tool` folder in your package, which
should not be submitted to your source control repo (likely this just means
adding '.dart_tool' to your '.gitignore' file).

When it comes to generated files it is generally best to not submit them to
source control, but a specific `Builder` may provide a recommendation otherwise.

It should be noted that if you do submit generated files to your repo then when
you change branches or merge in changes you may get a warning on your next build
about declared outputs that already exist. This will be followed up with a
prompt to delete those files. You can type `l` to list the files, and then type
`y` to delete them if everything looks correct. If you think something is wrong
you can type `n` to abandon the build without taking any action.

### Publishing packages

In general generated files should be published with your package, but this may
not always be the case. Some `Builder`s may provide a recommendation for this as
well.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/dart-lang/build/issues
