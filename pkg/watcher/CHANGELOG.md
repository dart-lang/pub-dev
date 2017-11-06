# 0.9.7+4

* Declare support for `async` 2.0.0.

# 0.9.7+3

* Fix a crashing bug on Linux.

# 0.9.7+2

* Narrow the constraint on `async` to reflect the APIs this package is actually
  using.

# 0.9.7+1

* Fix all strong-mode warnings.

# 0.9.7

* Fix a bug in `FileWatcher` where events could be added after watchers were
  closed.

# 0.9.6

* Add a `Watcher` interface that encompasses watching both files and
  directories.

* Add `FileWatcher` and `PollingFileWatcher` classes for watching changes to
  individual files.

* Deprecate `DirectoryWatcher.directory`. Use `DirectoryWatcher.path` instead.

# 0.9.5

* Fix bugs where events could be added after watchers were closed.

# 0.9.4

* Treat add events for known files as modifications instead of discarding them
  on Mac OS.

# 0.9.3

* Improved support for Windows via `WindowsDirectoryWatcher`.

* Simplified `PollingDirectoryWatcher`.

* Fixed bugs in `MacOSDirectoryWatcher`
