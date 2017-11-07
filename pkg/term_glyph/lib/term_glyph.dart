// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

export 'src/generated.dart';

import 'src/generated.dart';

/// Returns [glyph] if Unicode glyph are allowed, and [alternative] if they
/// aren't.
String glyphOrAscii(String glyph, String alternative) =>
    ascii ? alternative : glyph;
