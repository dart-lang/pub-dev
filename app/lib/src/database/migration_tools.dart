// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:crypto/crypto.dart';

/// Returns the content of `sha256sum.txt` for the migration [files]
/// (file name and content), sorted by name.
String buildSha256sum(Iterable<({String name, List<int> bytes})> files) {
  final sorted = files.toList()..sort((a, b) => a.name.compareTo(b.name));
  final sb = StringBuffer();
  for (final file in sorted) {
    sb.writeln('${sha256.convert(file.bytes)}  ${file.name}');
  }
  return sb.toString();
}
