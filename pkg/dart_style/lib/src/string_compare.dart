library dart_style.src.string_compare;

/// Returns `true` if [c] represents a whitespace code unit allowed in Dart
/// source code.
bool _isWhitespace(int c) => (c <= 0x000D && c >= 0x0009) || c == 0x0020;

/// Returns the index of the next non-whitespace character.
///
/// Returns `true` if current contains a non-whitespace character.
/// Returns `false` if no characters are left.
int _moveNextNonWhitespace(String str, int len, int i) {
  while (i < len && _isWhitespace(str.codeUnitAt(i))) {
    i++;
  }
  return i;
}

/// Returns `true` if the strings are equal ignoring whitespace characters.
bool equalIgnoringWhitespace(String str1, String str2) {
  // Benchmarks showed about a 20% regression in formatter performance when
  // when we use the simpler to implement solution of stripping all
  // whitespace characters and checking string equality. This solution is
  // faster due to lower memory usage and poor performance concatting strings
  // together one rune at a time.

  var len1 = str1.length;
  var len2 = str2.length;
  var i1 = 0;
  var i2 = 0;

  while (true) {
    i1 = _moveNextNonWhitespace(str1, len1, i1);
    i2 = _moveNextNonWhitespace(str2, len2, i2);
    if (i1 >= len1 || i2 >= len2) {
      return (i1 >= len1) == (i2 >= len2);
    }

    if (str1[i1] != str2[i2]) return false;
    i1++;
    i2++;
  }
}
