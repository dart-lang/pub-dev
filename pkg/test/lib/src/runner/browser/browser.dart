// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:stack_trace/stack_trace.dart';

import '../../utils.dart';
import '../application_exception.dart';

typedef Future<Process> StartBrowserFn();

/// An interface for running browser instances.
///
/// This is intentionally coarse-grained: browsers are controlled primary from
/// inside a single tab. Thus this interface only provides support for closing
/// the browser and seeing if it closes itself.
///
/// Any errors starting or running the browser process are reported through
/// [onExit].
abstract class Browser {
  String get name;

  /// The Observatory URL for this browser.
  ///
  /// This will return `null` for browsers that aren't running the Dart VM, or
  /// if the Observatory URL can't be found.
  Future<Uri> get observatoryUrl => null;

  /// The remote debugger URL for this browser.
  ///
  /// This will return `null` for browsers that don't support remote debugging,
  /// or if the remote debugging URL can't be found.
  Future<Uri> get remoteDebuggerUrl => null;

  /// The underlying process.
  ///
  /// This will fire once the process has started successfully.
  Future<Process> get _process => _processCompleter.future;
  final _processCompleter = new Completer<Process>();

  /// Whether [close] has been called.
  var _closed = false;

  /// A future that completes when the browser exits.
  ///
  /// If there's a problem starting or running the browser, this will complete
  /// with an error.
  Future get onExit => _onExitCompleter.future;
  final _onExitCompleter = new Completer();

  Future _drainAndIgnore(Stream s) async {
    try {
      await s.drain();
    } on StateError catch (_) {}
  }

  /// Creates a new browser.
  ///
  /// This is intended to be called by subclasses. They pass in [startBrowser],
  /// which asynchronously returns the browser process. Any errors in
  /// [startBrowser] (even those raised asynchronously after it returns) are
  /// piped to [onExit] and will cause the browser to be killed.
  Browser(Future<Process> startBrowser()) {
    // Don't return a Future here because there's no need for the caller to wait
    // for the process to actually start. They should just wait for the HTTP
    // request instead.
    runZoned(() async {
      var process = await startBrowser();
      _processCompleter.complete(process);

      // If we don't drain the stdout and stderr the process can hang.
      await Future.wait(
          [_drainAndIgnore(process.stdout), _drainAndIgnore(process.stderr)]);

      var exitCode = await process.exitCode;

      // This hack dodges an otherwise intractable race condition. When the user
      // presses Control-C, the signal is sent to the browser and the test
      // runner at the same time. It's possible for the browser to exit before
      // the [Browser.close] is called, which would trigger the error below.
      //
      // A negative exit code signals that the process exited due to a signal.
      // However, it's possible that this signal didn't come from the user's
      // Control-C, in which case we do want to throw the error. The only way to
      // resolve the ambiguity is to wait a brief amount of time and see if this
      // browser is actually closed.
      if (!_closed && exitCode < 0) {
        await new Future.delayed(new Duration(milliseconds: 200));
      }

      if (!_closed && exitCode != 0) {
        throw new ApplicationException(
            "$name failed with exit code $exitCode.");
      }

      _onExitCompleter.complete();
    }, onError: (error, stackTrace) {
      // Ignore any errors after the browser has been closed.
      if (_closed) return;

      // Make sure the process dies even if the error wasn't fatal.
      _process.then((process) => process.kill());

      if (stackTrace == null) stackTrace = new Trace.current();
      if (_onExitCompleter.isCompleted) return;
      _onExitCompleter.completeError(
          new ApplicationException(
              "Failed to run $name: ${getErrorMessage(error)}."),
          stackTrace);
    });
  }

  /// Kills the browser process.
  ///
  /// Returns the same [Future] as [onExit], except that it won't emit
  /// exceptions.
  Future close() {
    _closed = true;

    _process.then((process) {
      // Dartium has a difficult time being killed on Linux. To ensure it is
      // properly closed, find all children processes and kill those first.
      try {
        if (Platform.isLinux) {
          var result = Process.runSync('pgrep', ['-P', '${process.pid}']);
          for (var pid in '${result.stdout}'.split('\n')) {
            Process.runSync('kill', ['-9', pid]);
          }
        }
      } catch (e) {
        print('Failed to kill browser children: $e');
      }
      process.kill();
    });

    // Swallow exceptions. The user should explicitly use [onExit] for these.
    return onExit.catchError((_) {});
  }
}
