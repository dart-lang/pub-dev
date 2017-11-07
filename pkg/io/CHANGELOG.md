## 0.3.0

- **BREAKING CHANGE**: The `arguments` argument to `ProcessManager.spawn` is
  now positional (not named) and required. This makes it more similar to the
  built-in `Process.start`, and easier to use as a drop in replacement:

```dart
processManager.spawn('dart', ['--version']);
```

- Fixed a bug where processes created from `ProcessManager.spawn` could not
  have their `stdout`/`stderr` read through their respective getters (a runtime
  error was always thrown).

- Added `ProcessMangaer#spawnBackground`, which does not forward `stdin`.

- Added `ProcessManager#spawnDetached`, which does not forward any I/O.

- Added the `shellSplit()` function, which parses a list of arguments in the
  same manner as [the POSIX shell][what_is_posix_shell].
  
[what_is_posix_shell]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/contents.html

## 0.2.0

- Initial commit of...
   - `FutureOr<bool> String isExecutable(path)`.
   - `ExitCode`
   - `ProcessManager` and `Spawn`
   - `sharedStdIn` and `SharedStdIn`
   - `ansi.dart` library with support for formatting terminal output
