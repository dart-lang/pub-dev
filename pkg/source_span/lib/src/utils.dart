// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Returns the minimum of [obj1] and [obj2] according to
/// [Comparable.compareTo].
Comparable min(Comparable obj1, Comparable obj2) =>
    obj1.compareTo(obj2) > 0 ? obj2 : obj1;

/// Returns the maximum of [obj1] and [obj2] according to
/// [Comparable.compareTo].
Comparable max(Comparable obj1, Comparable obj2) =>
    obj1.compareTo(obj2) > 0 ? obj1 : obj2;

/// Finds a line in [context] containing [text] at the specified [column].
///
/// Returns the index in [context] where that line begins, or null if none
/// exists.
int findLineStart(String context, String text, int column) {
  var isEmpty = text == '';
  var index = context.indexOf(text);
  while (index != -1) {
    var lineStart = context.lastIndexOf('\n', index) + 1;
    var textColumn = index - lineStart;
    if (column == textColumn || (isEmpty && column == textColumn + 1)) {
      return lineStart;
    }
    index = context.indexOf(text, index + 1);
  }
  return null;
}
