// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library dart_style.src.dart_formatter;

import 'dart:math' as math;

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/scanner/reader.dart';
import 'package:analyzer/src/dart/scanner/scanner.dart';
import 'package:analyzer/src/generated/parser.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/string_source.dart';

import 'error_listener.dart';
import 'exceptions.dart';
import 'source_code.dart';
import 'source_visitor.dart';
import 'string_compare.dart' as string_compare;

/// Dart source code formatter.
class DartFormatter {
  /// The string that newlines should use.
  ///
  /// If not explicitly provided, this is inferred from the source text. If the
  /// first newline is `\r\n` (Windows), it will use that. Otherwise, it uses
  /// Unix-style line endings (`\n`).
  String lineEnding;

  /// The number of characters allowed in a single line.
  final int pageWidth;

  /// The number of characters of indentation to prefix the output lines with.
  final int indent;

  /// Creates a new formatter for Dart code.
  ///
  /// If [lineEnding] is given, that will be used for any newlines in the
  /// output. Otherwise, the line separator will be inferred from the line
  /// endings in the source file.
  ///
  /// If [indent] is given, that many levels of indentation will be prefixed
  /// before each resulting line in the output.
  DartFormatter({this.lineEnding, int pageWidth, this.indent: 0})
      : this.pageWidth = (pageWidth == null) ? 80 : pageWidth;

  /// Formats the given [source] string containing an entire Dart compilation
  /// unit.
  ///
  /// If [uri] is given, it is a [String] or [Uri] used to identify the file
  /// being formatted in error messages.
  String format(String source, {uri}) {
    if (uri == null) {
      // Do nothing.
    } else if (uri is Uri) {
      uri = uri.toString();
    } else if (uri is String) {
      // Do nothing.
    } else {
      throw new ArgumentError("uri must be `null`, a Uri, or a String.");
    }

    return formatSource(
            new SourceCode(source, uri: uri, isCompilationUnit: true))
        .text;
  }

  /// Formats the given [source] string containing a single Dart statement.
  String formatStatement(String source) {
    return formatSource(new SourceCode(source, isCompilationUnit: false)).text;
  }

  /// Formats the given [source].
  ///
  /// Returns a new [SourceCode] containing the formatted code and the resulting
  /// selection, if any.
  SourceCode formatSource(SourceCode source) {
    var errorListener = new ErrorListener();

    // Tokenize the source.
    var reader = new CharSequenceReader(source.text);
    var stringSource = new StringSource(source.text, source.uri);
    var scanner = new Scanner(stringSource, reader, errorListener);
    var startToken = scanner.tokenize();
    var lineInfo = new LineInfo(scanner.lineStarts);

    // Infer the line ending if not given one. Do it here since now we know
    // where the lines start.
    if (lineEnding == null) {
      // If the first newline is "\r\n", use that. Otherwise, use "\n".
      if (scanner.lineStarts.length > 1 &&
          scanner.lineStarts[1] >= 2 &&
          source.text[scanner.lineStarts[1] - 2] == '\r') {
        lineEnding = "\r\n";
      } else {
        lineEnding = "\n";
      }
    }

    errorListener.throwIfErrors();

    // Parse it.
    var parser = new Parser(stringSource, errorListener);
    parser.enableAssertInitializer = true;

    AstNode node;
    if (source.isCompilationUnit) {
      node = parser.parseCompilationUnit(startToken);
    } else {
      node = parser.parseStatement(startToken);

      // Make sure we consumed all of the source.
      var token = node.endToken.next;
      if (token.type != TokenType.EOF) {
        var error = new AnalysisError(
            stringSource,
            token.offset,
            math.max(token.length, 1),
            ParserErrorCode.UNEXPECTED_TOKEN,
            [token.lexeme]);

        throw new FormatterException([error]);
      }
    }

    errorListener.throwIfErrors();

    // Format it.
    var visitor = new SourceVisitor(this, lineInfo, source);
    var output = visitor.run(node);
    if (!string_compare.equalIgnoringWhitespace(source.text, output.text)) {
      throw new UnexpectedOutputException(source.text, output.text);
    }

    return output;
  }
}
