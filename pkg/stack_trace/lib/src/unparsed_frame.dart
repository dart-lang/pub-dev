// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'frame.dart';

/// A frame that failed to parse.
///
/// The [member] property contains the original frame's contents.
class UnparsedFrame implements Frame {
  final Uri uri = new Uri(path: "unparsed");
  final int line = null;
  final int column = null;
  final bool isCore = false;
  final String library = "unparsed";
  final String package = null;
  final String location = "unparsed";

  final String member;

  UnparsedFrame(this.member);

  String toString() => member;
}
