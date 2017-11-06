// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:analyzer/analyzer.dart';
import 'package:package_resolver/package_resolver.dart';
import 'package:source_span/source_span.dart';

import 'string_literal_iterator.dart';

/// Runs [code] in an isolate.
///
/// [code] should be the contents of a Dart entrypoint. It may contain imports;
/// they will be resolved in the same context as the host isolate. [message] is
/// passed to the [main] method of the code being run; the caller is responsible
/// for using this to establish communication with the isolate.
///
/// If [resolver] is passed, its package resolution strategy is used to resolve
/// code in the spawned isolate. It defaults to [PackageResolver.current].
Future<Isolate> runInIsolate(String code, message,
    {PackageResolver resolver, bool checked, SendPort onExit}) async {
  resolver ??= PackageResolver.current;
  return await Isolate.spawnUri(
      new Uri.dataFromString(code,
          mimeType: 'application/dart', encoding: UTF8),
      [],
      message,
      packageRoot: await resolver.packageRoot,
      packageConfig: await resolver.packageConfigUri,
      checked: checked,
      onExit: onExit);
}

// TODO(nweiz): Move this into the analyzer once it starts using SourceSpan
// (issue 22977).
/// Takes a span whose source is the value of a string that has been parsed from
/// a Dart file and returns the corresponding span from within that Dart file.
///
/// For example, suppose a Dart file contains `@Eval("1 + a")`. The
/// [StringLiteral] `"1 + a"` is extracted; this is [context]. Its contents are
/// then parsed, producing an error pointing to [span]:
///
///     line 1, column 5:
///     1 + a
///         ^
///
/// This span isn't very useful, since it only shows the location within the
/// [StringLiteral]'s value. So it's passed to [contextualizeSpan] along with
/// [context] and [file] (which contains the source of the entire Dart file),
/// which then returns:
///
///     line 4, column 12 of file.dart:
///     @Eval("1 + a")
///                ^
///
/// This properly handles multiline literals, adjacent literals, and literals
/// containing escape sequences. It does not support interpolated literals.
///
/// This will return `null` if [context] contains an invalid string or does not
/// contain [span].
SourceSpan contextualizeSpan(
    SourceSpan span, StringLiteral context, SourceFile file) {
  var contextRunes = new StringLiteralIterator(context)..moveNext();

  for (var i = 0; i < span.start.offset; i++) {
    if (!contextRunes.moveNext()) return null;
  }

  var start = contextRunes.offset;
  for (var spanRune in span.text.runes) {
    if (spanRune != contextRunes.current) return null;
    contextRunes.moveNext();
  }

  return file.span(start, contextRunes.offset);
}
