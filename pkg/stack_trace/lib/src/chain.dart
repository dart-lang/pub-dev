// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'frame.dart';
import 'lazy_chain.dart';
import 'stack_zone_specification.dart';
import 'trace.dart';
import 'utils.dart';

/// A function that handles errors in the zone wrapped by [Chain.capture].
@Deprecated("Will be removed in stack_trace 2.0.0.")
typedef void ChainHandler(error, Chain chain);

/// An opaque key used to track the current [StackZoneSpecification].
final _specKey = new Object();

/// A chain of stack traces.
///
/// A stack chain is a collection of one or more stack traces that collectively
/// represent the path from [main] through nested function calls to a particular
/// code location, usually where an error was thrown. Multiple stack traces are
/// necessary when using asynchronous functions, since the program's stack is
/// reset before each asynchronous callback is run.
///
/// Stack chains can be automatically tracked using [Chain.capture]. This sets
/// up a new [Zone] in which the current stack chain is tracked and can be
/// accessed using [new Chain.current]. Any errors that would be top-leveled in
/// the zone can be handled, along with their associated chains, with the
/// `onError` callback. For example:
///
///     Chain.capture(() {
///       // ...
///     }, onError: (error, stackChain) {
///       print("Caught error $error\n"
///             "$stackChain");
///     });
class Chain implements StackTrace {
  /// The stack traces that make up this chain.
  ///
  /// Like the frames in a stack trace, the traces are ordered from most local
  /// to least local. The first one is the trace where the actual exception was
  /// raised, the second one is where that callback was scheduled, and so on.
  final List<Trace> traces;

  /// The [StackZoneSpecification] for the current zone.
  static StackZoneSpecification get _currentSpec => Zone.current[_specKey];

  /// If [when] is `true`, runs [callback] in a [Zone] in which the current
  /// stack chain is tracked and automatically associated with (most) errors.
  ///
  /// If [when] is `false`, this does not track stack chains. Instead, it's
  /// identical to [runZoned], except that it wraps any errors in [new
  /// Chain.forTrace]—which will only wrap the trace unless there's a different
  /// [Chain.capture] active. This makes it easy for the caller to only capture
  /// stack chains in debug mode or during development.
  ///
  /// If [onError] is passed, any error in the zone that would otherwise go
  /// unhandled is passed to it, along with the [Chain] associated with that
  /// error. Note that if [callback] produces multiple unhandled errors,
  /// [onError] may be called more than once. If [onError] isn't passed, the
  /// parent Zone's `unhandledErrorHandler` will be called with the error and
  /// its chain.
  ///
  /// Note that even if [onError] isn't passed, this zone will still be an error
  /// zone. This means that any errors that would cross the zone boundary are
  /// considered unhandled.
  ///
  /// If [callback] returns a value, it will be returned by [capture] as well.
  static T capture<T>(T callback(),
      {void onError(error, Chain chain), bool when: true}) {
    if (!when) {
      var newOnError;
      if (onError != null) {
        newOnError = (error, stackTrace) {
          onError(
              error,
              stackTrace == null
                  ? new Chain.current()
                  : new Chain.forTrace(stackTrace));
        };
      }

      return runZoned(callback, onError: newOnError);
    }

    var spec = new StackZoneSpecification(onError);
    return runZoned(() {
      try {
        return callback();
      } catch (error, stackTrace) {
        // TODO(nweiz): Don't special-case this when issue 19566 is fixed.
        Zone.current.handleUncaughtError(error, stackTrace);
        return null;
      }
    },
        zoneSpecification: spec.toSpec(),
        zoneValues: {_specKey: spec, StackZoneSpecification.disableKey: false});
  }

  /// If [when] is `true` and this is called within a [Chain.capture] zone, runs
  /// [callback] in a [Zone] in which chain capturing is disabled.
  ///
  /// If [callback] returns a value, it will be returned by [disable] as well.
  static T disable<T>(T callback(), {bool when: true}) {
    var zoneValues =
        when ? {_specKey: null, StackZoneSpecification.disableKey: true} : null;

    return runZoned(callback, zoneValues: zoneValues);
  }

  /// Returns [futureOrStream] unmodified.
  ///
  /// Prior to Dart 1.7, this was necessary to ensure that stack traces for
  /// exceptions reported with [Completer.completeError] and
  /// [StreamController.addError] were tracked correctly.
  @Deprecated("Chain.track is not necessary in Dart 1.7+.")
  static track(futureOrStream) => futureOrStream;

  /// Returns the current stack chain.
  ///
  /// By default, the first frame of the first trace will be the line where
  /// [Chain.current] is called. If [level] is passed, the first trace will
  /// start that many frames up instead.
  ///
  /// If this is called outside of a [capture] zone, it just returns a
  /// single-trace chain.
  factory Chain.current([int level = 0]) {
    if (_currentSpec != null) return _currentSpec.currentChain(level + 1);

    var chain = new Chain.forTrace(StackTrace.current);
    return new LazyChain(() {
      // JS includes a frame for the call to StackTrace.current, but the VM
      // doesn't, so we skip an extra frame in a JS context.
      var first = new Trace(
          chain.traces.first.frames.skip(level + (inJS ? 2 : 1)),
          original: chain.traces.first.original.toString());
      return new Chain([first]..addAll(chain.traces.skip(1)));
    });
  }

  /// Returns the stack chain associated with [trace].
  ///
  /// The first stack trace in the returned chain will always be [trace]
  /// (converted to a [Trace] if necessary). If there is no chain associated
  /// with [trace] or if this is called outside of a [capture] zone, this just
  /// returns a single-trace chain containing [trace].
  ///
  /// If [trace] is already a [Chain], it will be returned as-is.
  factory Chain.forTrace(StackTrace trace) {
    if (trace is Chain) return trace;
    if (_currentSpec != null) return _currentSpec.chainFor(trace);
    if (trace is Trace) return new Chain([trace]);
    return new LazyChain(() => new Chain.parse(trace.toString()));
  }

  /// Parses a string representation of a stack chain.
  ///
  /// If [chain] is the output of a call to [Chain.toString], it will be parsed
  /// as a full stack chain. Otherwise, it will be parsed as in [Trace.parse]
  /// and returned as a single-trace chain.
  factory Chain.parse(String chain) {
    if (chain.isEmpty) return new Chain([]);
    if (chain.contains(vmChainGap)) {
      return new Chain(
          chain.split(vmChainGap).map((trace) => new Trace.parseVM(trace)));
    }
    if (!chain.contains(chainGap)) return new Chain([new Trace.parse(chain)]);

    return new Chain(
        chain.split(chainGap).map((trace) => new Trace.parseFriendly(trace)));
  }

  /// Returns a new [Chain] comprised of [traces].
  Chain(Iterable<Trace> traces) : traces = new List<Trace>.unmodifiable(traces);

  /// Returns a terser version of [this].
  ///
  /// This calls [Trace.terse] on every trace in [traces], and discards any
  /// trace that contain only internal frames.
  ///
  /// This won't do anything with a raw JavaScript trace, since there's no way
  /// to determine which frames come from which Dart libraries. However, the
  /// [`source_map_stack_trace`][source_map_stack_trace] package can be used to
  /// convert JavaScript traces into Dart-style traces.
  ///
  /// [source_map_stack_trace]: https://pub.dartlang.org/packages/source_map_stack_trace
  Chain get terse => foldFrames((_) => false, terse: true);

  /// Returns a new [Chain] based on [this] where multiple stack frames matching
  /// [predicate] are folded together.
  ///
  /// This means that whenever there are multiple frames in a row that match
  /// [predicate], only the last one is kept. In addition, traces that are
  /// composed entirely of frames matching [predicate] are omitted.
  ///
  /// This is useful for limiting the amount of library code that appears in a
  /// stack trace by only showing user code and code that's called by user code.
  ///
  /// If [terse] is true, this will also fold together frames from the core
  /// library or from this package, and simplify core library frames as in
  /// [Trace.terse].
  Chain foldFrames(bool predicate(Frame frame), {bool terse: false}) {
    var foldedTraces =
        traces.map((trace) => trace.foldFrames(predicate, terse: terse));
    var nonEmptyTraces = foldedTraces.where((trace) {
      // Ignore traces that contain only folded frames.
      if (trace.frames.length > 1) return true;
      if (trace.frames.isEmpty) return false;

      // In terse mode, the trace may have removed an outer folded frame,
      // leaving a single non-folded frame. We can detect a folded frame because
      // it has no line information.
      if (!terse) return false;
      return trace.frames.single.line != null;
    });

    // If all the traces contain only internal processing, preserve the last
    // (top-most) one so that the chain isn't empty.
    if (nonEmptyTraces.isEmpty && foldedTraces.isNotEmpty) {
      return new Chain([foldedTraces.last]);
    }

    return new Chain(nonEmptyTraces);
  }

  /// Converts [this] to a [Trace].
  ///
  /// The trace version of a chain is just the concatenation of all the traces
  /// in the chain.
  Trace toTrace() => new Trace(traces.expand((trace) => trace.frames));

  String toString() {
    // Figure out the longest path so we know how much to pad.
    var longest = traces.map((trace) {
      return trace.frames
          .map((frame) => frame.location.length)
          .fold(0, math.max);
    }).fold(0, math.max);

    // Don't call out to [Trace.toString] here because that doesn't ensure that
    // padding is consistent across all traces.
    return traces.map((trace) {
      return trace.frames.map((frame) {
        return '${frame.location.padRight(longest)}  ${frame.member}\n';
      }).join();
    }).join(chainGap);
  }
}
