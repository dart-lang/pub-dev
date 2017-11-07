// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:charcode/ascii.dart';

import 'line_scanner.dart';
import 'span_scanner.dart';

// TODO(nweiz): Currently this duplicates code in line_scanner.dart. Once
// sdk#23770 is fully complete, we should move the shared code into a mixin.

/// A regular expression matching newlines across platforms.
final _newlineRegExp = new RegExp(r"\r\n?|\n");

/// A [SpanScanner] that tracks the line and column eagerly, like [LineScanner].
class EagerSpanScanner extends SpanScanner {
  int get line => _line;
  int _line = 0;

  int get column => _column;
  int _column = 0;

  LineScannerState get state =>
      new _EagerSpanScannerState(this, position, line, column);

  bool get _betweenCRLF => peekChar(-1) == $cr && peekChar() == $lf;

  set state(LineScannerState state) {
    if (state is! _EagerSpanScannerState ||
        !identical((state as _EagerSpanScannerState)._scanner, this)) {
      throw new ArgumentError("The given LineScannerState was not returned by "
          "this LineScanner.");
    }

    super.position = state.position;
    _line = state.line;
    _column = state.column;
  }

  set position(int newPosition) {
    var oldPosition = position;
    super.position = newPosition;

    if (newPosition > oldPosition) {
      var newlines = _newlinesIn(string.substring(oldPosition, newPosition));
      _line += newlines.length;
      if (newlines.isEmpty) {
        _column += newPosition - oldPosition;
      } else {
        _column = newPosition - newlines.last.end;
      }
    } else {
      var newlines = _newlinesIn(string.substring(newPosition, oldPosition));
      if (_betweenCRLF) newlines.removeLast();

      _line -= newlines.length;
      if (newlines.isEmpty) {
        _column -= oldPosition - newPosition;
      } else {
        _column = newPosition -
            string.lastIndexOf(_newlineRegExp, newPosition) - 1;
      }
    }
  }

  EagerSpanScanner(String string, {sourceUrl, int position})
      : super(string, sourceUrl: sourceUrl, position: position);

  bool scanChar(int character) {
    if (!super.scanChar(character)) return false;
    _adjustLineAndColumn(character);
    return true;
  }

  int readChar() {
    var character = super.readChar();
    _adjustLineAndColumn(character);
    return character;
  }

  /// Adjusts [_line] and [_column] after having consumed [character].
  void _adjustLineAndColumn(int character) {
    if (character == $lf || (character == $cr && peekChar() != $lf)) {
      _line += 1;
      _column = 0;
    } else {
      _column += 1;
    }
  }

  bool scan(Pattern pattern) {
    if (!super.scan(pattern)) return false;

    var newlines = _newlinesIn(lastMatch[0]);
    _line += newlines.length;
    if (newlines.isEmpty) {
      _column += lastMatch[0].length;
    } else {
      _column = lastMatch[0].length - newlines.last.end;
    }

    return true;
  }

  /// Returns a list of [Match]es describing all the newlines in [text], which
  /// is assumed to end at [position].
  List<Match> _newlinesIn(String text) {
    var newlines = _newlineRegExp.allMatches(text).toList();
    if (_betweenCRLF) newlines.removeLast();
    return newlines;
  }
}

/// A class representing the state of an [EagerSpanScanner].
class _EagerSpanScannerState implements LineScannerState {
  final EagerSpanScanner _scanner;
  final int position;
  final int line;
  final int column;

  _EagerSpanScannerState(this._scanner, this.position, this.line, this.column);
}

