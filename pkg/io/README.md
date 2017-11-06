Contains utilities for the Dart VM's `dart:io`.

[![Build Status](https://travis-ci.org/dart-lang/io.svg?branch=master)](https://travis-ci.org/dart-lang/io)

## Contributing

> **NOTE**: Due to the changing nature of the Dart SDK (towards 2.0.0), running
> `dartfmt` requires the local executable:

```sh
$ pub run dart_style:format
```

## Usage - `io.dart`

### Files

#### `isExecutable`
 
Returns whether a provided file path is considered _executable_ on the host
operating system.

### Processes

#### `ExitCode`

An `enum`-like class that contains known exit codes.

#### `ProcessManager`

A higher-level service for spawning and communicating with processes.

##### Use `spawn` to create a process with std[in|out|err] forwarded by default

```dart
/// Runs `dartfmt` commands and `pub publish`.
Future<Null> main() async {
  final manager = new ProcessManager();
  
  // Runs dartfmt --version and outputs the result via stdout.
  print('Running dartfmt --version');
  var spawn = await manager.spawn('dartfmt', arguments: ['--version']);
  await spawn.exitCode;
  
  // Runs dartfmt -n . and outputs the result via stdout.
  print('Running dartfmt -n .');
  spawn = await manager.spawn('dartfmt', arguments: ['-n', '.']);
  await spawn.exitCode;
  
  // Runs pub publish. Upon hitting a blocking stdin state, you may directly
  // output to the processes's stdin via your own, similar to how a bash or
  // shell script would spawn a process.
  print('Running pub publish');
  spawn = await manager.spawn('pub', arguments: ['publish']);
  await spawn.exitCode;
  
  // Closes stdin for the entire program.
  await sharedStdIn.terminate();
}
```

#### `sharedStdIn`

A safer version of the default `stdin` stream from `dart:io` that allows a
subscriber to cancel their subscription, and then allows a _new_ subscriber to
start listening. This differs from the default behavior where only a single
listener is ever allowed in the application lifecycle:

```dart
test('should allow multiple subscribers', () async {
  final logs = <String>[];
  final asUtf8 = sharedStdIn.transform(UTF8.decoder);
  // Wait for input for the user.
  logs.add(await asUtf8.first);
  // Wait for more input for the user.
  logs.add(await asUtf8.first);
  expect(logs, ['Hello World', 'Goodbye World']);
});
```

For testing, an instance of `SharedStdIn` may be created directly.

## Usage - `ansi.dart`

```dart
import 'dart:io' as io;
import 'package:io/ansi.dart';

void main() {
  // To use one style, call the `wrap` method on one of the provided top-level
  // values.
  io.stderr.writeln(red.wrap("Bad error!"));

  // To use multiple styles, call `wrapWith`.
  print(wrapWith('** Important **', [red, styleBold, styleUnderlined]));

  // The wrap functions will simply return the provided value unchanged if
  // `ansiOutputEnabled` is false.
  //
  // You can override the value `ansiOutputEnabled` by wrapping code in
  // `overrideAnsiOutput`.
  overrideAnsiOutput(false, () {
    assert('Normal text' == green.wrap('Normal text'));
  });
}
```
