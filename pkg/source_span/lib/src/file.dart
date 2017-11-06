// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;
import 'dart:typed_data';

import 'location.dart';
import 'location_mixin.dart';
import 'span.dart';
import 'span_mixin.dart';
import 'span_with_context.dart';

// Constants to determine end-of-lines.
const int _LF = 10;
const int _CR = 13;

/// A class representing a source file.
///
/// This doesn't necessarily have to correspond to a file on disk, just a chunk
/// of text usually with a URL associated with it.
class SourceFile {
  /// The URL where the source file is located.
  ///
  /// This may be null, indicating that the URL is unknown or unavailable.
  final Uri url;

  /// An array of offsets for each line beginning in the file.
  ///
  /// Each offset refers to the first character *after* the newline. If the
  /// source file has a trailing newline, the final offset won't actually be in
  /// the file.
  final _lineStarts = <int>[0];

  /// The code points of the characters in the file.
  final Uint32List _decodedChars;

  /// The length of the file in characters.
  int get length => _decodedChars.length;

  /// The number of lines in the file.
  int get lines => _lineStarts.length;

  /// The line that the offset fell on the last time [getLine] was called.
  ///
  /// In many cases, sequential calls to getLine() are for nearby, usually
  /// increasing offsets. In that case, we can find the line for an offset
  /// quickly by first checking to see if the offset is on the same line as the
  /// previous result.
  int _cachedLine;

  /// This constructor is deprecated.
  ///
  /// Use [new SourceFile.fromString] instead.
  @Deprecated("Will be removed in 2.0.0")
  SourceFile(String text, {url})
      : this.decoded(text.runes, url: url);

  /// Creates a new source file from [text].
  ///
  /// [url] may be either a [String], a [Uri], or `null`.
  SourceFile.fromString(String text, {url})
      : this.decoded(text.codeUnits, url: url);

  /// Creates a new source file from a list of decoded code units.
  ///
  /// [url] may be either a [String], a [Uri], or `null`.
  ///
  /// Currently, if [decodedChars] contains characters larger than `0xFFFF`,
  /// they'll be treated as single characters rather than being split into
  /// surrogate pairs. **This behavior is deprecated**. For
  /// forwards-compatibility, callers should only pass in characters less than
  /// or equal to `0xFFFF`.
  SourceFile.decoded(Iterable<int> decodedChars, {url})
      : url = url is String ? Uri.parse(url) : url,
        _decodedChars = new Uint32List.fromList(decodedChars.toList()) {
    for (var i = 0; i < _decodedChars.length; i++) {
      var c = _decodedChars[i];
      if (c == _CR) {
        // Return not followed by newline is treated as a newline
        var j = i + 1;
        if (j >= _decodedChars.length || _decodedChars[j] != _LF) c = _LF;
      }
      if (c == _LF) _lineStarts.add(i + 1);
    }
  }

  /// Returns a span in [this] from [start] to [end] (exclusive).
  ///
  /// If [end] isn't passed, it defaults to the end of the file.
  FileSpan span(int start, [int end]) {
    if (end == null) end = length - 1;
    return new _FileSpan(this, start, end);
  }

  /// Returns a location in [this] at [offset].
  FileLocation location(int offset) => new FileLocation._(this, offset);

  /// Gets the 0-based line corresponding to [offset].
  int getLine(int offset) {
    if (offset < 0) {
      throw new RangeError("Offset may not be negative, was $offset.");
    } else if (offset > length) {
      throw new RangeError("Offset $offset must not be greater than the number "
          "of characters in the file, $length.");
    }

    if (offset < _lineStarts.first) return -1;
    if (offset >= _lineStarts.last) return _lineStarts.length - 1;

    if (_isNearCachedLine(offset)) return _cachedLine;

    _cachedLine = _binarySearch(offset) - 1;
    return _cachedLine;
  }

  /// Returns `true` if [offset] is near [_cachedLine].
  ///
  /// Checks on [_cachedLine] and the next line. If it's on the next line, it
  /// updates [_cachedLine] to point to that.
  bool _isNearCachedLine(int offset) {
    if (_cachedLine == null) return false;

    // See if it's before the cached line.
    if (offset < _lineStarts[_cachedLine]) return false;

    // See if it's on the cached line.
    if (_cachedLine >= _lineStarts.length - 1 ||
        offset < _lineStarts[_cachedLine + 1]) {
      return true;
    }

    // See if it's on the next line.
    if (_cachedLine >= _lineStarts.length - 2 ||
        offset < _lineStarts[_cachedLine + 2]) {
      _cachedLine++;
      return true;
    }

    return false;
  }

  /// Binary search through [_lineStarts] to find the line containing [offset].
  ///
  /// Returns the index of the line in [_lineStarts].
  int _binarySearch(int offset) {
    int min = 0;
    int max = _lineStarts.length - 1;
    while (min < max) {
      var half = min + ((max - min) ~/ 2);
      if (_lineStarts[half] > offset) {
        max = half;
      } else {
        min = half + 1;
      }
    }

    return max;
  }

  /// Gets the 0-based column corresponding to [offset].
  ///
  /// If [line] is passed, it's assumed to be the line containing [offset] and
  /// is used to more efficiently compute the column.
  int getColumn(int offset, {int line}) {
    if (offset < 0) {
      throw new RangeError("Offset may not be negative, was $offset.");
    } else if (offset > length) {
      throw new RangeError("Offset $offset must be not be greater than the "
          "number of characters in the file, $length.");
    }

    if (line == null) {
      line = getLine(offset);
    } else if (line < 0) {
      throw new RangeError("Line may not be negative, was $line.");
    } else if (line >= lines) {
      throw new RangeError("Line $line must be less than the number of "
          "lines in the file, $lines.");
    }

    var lineStart = _lineStarts[line];
    if (lineStart > offset) {
      throw new RangeError("Line $line comes after offset $offset.");
    }

    return offset - lineStart;
  }

  /// Gets the offset for a [line] and [column].
  ///
  /// [column] defaults to 0.
  int getOffset(int line, [int column]) {
    if (column == null) column = 0;

    if (line < 0) {
      throw new RangeError("Line may not be negative, was $line.");
    } else if (line >= lines) {
      throw new RangeError("Line $line must be less than the number of "
          "lines in the file, $lines.");
    } else if (column < 0) {
      throw new RangeError("Column may not be negative, was $column.");
    }

    var result = _lineStarts[line] + column;
    if (result > length ||
        (line + 1 < lines && result >= _lineStarts[line + 1])) {
      throw new RangeError("Line $line doesn't have $column columns.");
    }

    return result;
  }

  /// Returns the text of the file from [start] to [end] (exclusive).
  ///
  /// If [end] isn't passed, it defaults to the end of the file.
  String getText(int start, [int end]) =>
      new String.fromCharCodes(_decodedChars.sublist(start, end));
}

/// A [SourceLocation] within a [SourceFile].
///
/// Unlike the base [SourceLocation], [FileLocation] lazily computes its line
/// and column values based on its offset and the contents of [file].
///
/// A [FileLocation] can be created using [SourceFile.location].
class FileLocation extends SourceLocationMixin implements SourceLocation {
  /// The [file] that [this] belongs to.
  final SourceFile file;

  final int offset;
  Uri get sourceUrl => file.url;
  int get line => file.getLine(offset);
  int get column => file.getColumn(offset);

  FileLocation._(this.file, this.offset) {
    if (offset < 0) {
      throw new RangeError("Offset may not be negative, was $offset.");
    } else if (offset > file.length) {
      throw new RangeError("Offset $offset must not be greater than the number "
          "of characters in the file, ${file.length}.");
    }
  }

  FileSpan pointSpan() => new _FileSpan(file, offset, offset);
}

/// A [SourceSpan] within a [SourceFile].
///
/// Unlike the base [SourceSpan], [FileSpan] lazily computes its line and column
/// values based on its offset and the contents of [file]. [FileSpan.message] is
/// also able to provide more context then [SourceSpan.message], and
/// [FileSpan.union] will return a [FileSpan] if possible.
///
/// A [FileSpan] can be created using [SourceFile.span].
abstract class FileSpan implements SourceSpanWithContext {
  /// The [file] that [this] belongs to.
  SourceFile get file;

  FileLocation get start;
  FileLocation get end;

  /// Returns a new span that covers both [this] and [other].
  ///
  /// Unlike [union], [other] may be disjoint from [this]. If it is, the text
  /// between the two will be covered by the returned span.
  FileSpan expand(FileSpan other);
}

/// The implementation of [FileSpan].
///
/// This is split into a separate class so that `is _FileSpan` checks can be run
/// to make certain operations more efficient. If we used `is FileSpan`, that
/// would break if external classes implemented the interface.
class _FileSpan extends SourceSpanMixin implements FileSpan {
  final SourceFile file;

  /// The offset of the beginning of the span.
  ///
  /// [start] is lazily generated from this to avoid allocating unnecessary
  /// objects.
  final int _start;

  /// The offset of the end of the span.
  ///
  /// [end] is lazily generated from this to avoid allocating unnecessary
  /// objects.
  final int _end;

  Uri get sourceUrl => file.url;
  int get length => _end - _start;
  FileLocation get start => new FileLocation._(file, _start);
  FileLocation get end => new FileLocation._(file, _end);
  String get text => file.getText(_start, _end);
  String get context => file.getText(file.getOffset(start.line),
      end.line == file.lines - 1 ? null : file.getOffset(end.line + 1));

  _FileSpan(this.file, this._start, this._end) {
    if (_end < _start) {
      throw new ArgumentError('End $_end must come after start $_start.');
    } else if (_end > file.length) {
      throw new RangeError("End $_end must not be greater than the number "
          "of characters in the file, ${file.length}.");
    } else if (_start < 0) {
      throw new RangeError("Start may not be negative, was $_start.");
    }
  }

  int compareTo(SourceSpan other) {
    if (other is! _FileSpan) return super.compareTo(other);

    _FileSpan otherFile = other;
    var result = _start.compareTo(otherFile._start);
    return result == 0 ? _end.compareTo(otherFile._end) : result;
  }

  SourceSpan union(SourceSpan other) {
    if (other is! FileSpan) return super.union(other);

    
    _FileSpan span = expand(other);

    if (other is _FileSpan) {
      if (this._start > other._end || other._start > this._end) {
        throw new ArgumentError("Spans $this and $other are disjoint.");
      }
    } else {
      if (this._start > other.end.offset || other.start.offset > this._end) {
        throw new ArgumentError("Spans $this and $other are disjoint.");
      }
    }

    return span;
  }

  bool operator ==(other) {
    if (other is! FileSpan) return super == other;
    if (other is! _FileSpan) {
      return super == other && sourceUrl == other.sourceUrl;
    }

    return _start == other._start && _end == other._end &&
        sourceUrl == other.sourceUrl;
  }

  // Eliminates dart2js warning about overriding `==`, but not `hashCode`
  int get hashCode => super.hashCode;

  /// Returns a new span that covers both [this] and [other].
  ///
  /// Unlike [union], [other] may be disjoint from [this]. If it is, the text
  /// between the two will be covered by the returned span.
  FileSpan expand(FileSpan other) {
    if (sourceUrl != other.sourceUrl) {
      throw new ArgumentError("Source URLs \"${sourceUrl}\" and "
          " \"${other.sourceUrl}\" don't match.");
    }

    if (other is _FileSpan) {
      var start = math.min(this._start, other._start);
      var end = math.max(this._end, other._end);
      return new _FileSpan(file, start, end);
    } else {
      var start = math.min(this._start, other.start.offset);
      var end = math.max(this._end, other.end.offset);
      return new _FileSpan(file, start, end);
    }
  }
}
