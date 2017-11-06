// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:stack_trace/stack_trace.dart';

import '../backend/invoker.dart';
import '../util/stack_trace_mapper.dart';

/// Converts [trace] into a Dart stack trace
StackTraceMapper _mapper;

/// The list of packages to fold when producing [Chain]s.
Set<String> _exceptPackages = new Set.from(['test', 'stream_channel']);

/// If non-empty, all packages not in this list will be folded when producing
/// [Chain]s.
Set<String> _onlyPackages = new Set();

/// Configure the resources used for test chaining.
///
/// [mapper] is used to convert traces into Dart stack traces.
/// [exceptPackages] is the list of packages to fold when producing a [Chain].
/// [onlyPackages] is the list of packages to keep in a [Chain]. If non-empty,
/// all packages not in this will be folded.
void configureTestChaining(
    {StackTraceMapper mapper,
    Set<String> exceptPackages,
    Set<String> onlyPackages}) {
  if (mapper != null) _mapper = mapper;
  if (exceptPackages != null) _exceptPackages = exceptPackages;
  if (onlyPackages != null) _onlyPackages = onlyPackages;
}

/// Returns [stackTrace] converted to a [Chain] with all irrelevant frames
/// folded together.
///
/// If [verbose] is `true`, returns the chain for [stackTrace] unmodified.
Chain terseChain(StackTrace stackTrace, {bool verbose: false}) {
  var testTrace = _mapper?.mapStackTrace(stackTrace) ?? stackTrace;
  if (verbose) return new Chain.forTrace(testTrace);
  return new Chain.forTrace(testTrace).foldFrames((frame) {
    if (_onlyPackages.isNotEmpty) {
      return !_onlyPackages.contains(frame.package);
    }
    return _exceptPackages.contains(frame.package);
  }, terse: true);
}

/// Converts [stackTrace] to a [Chain] following the test's configuration.
Chain testChain(StackTrace stackTrace) => terseChain(stackTrace,
    verbose: Invoker.current?.liveTest?.test?.metadata?.verboseTrace ?? true);
