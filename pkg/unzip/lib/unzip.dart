// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'src/reader.dart' show ZipReader;

/// Provides stream-based reading of ZIP archives through [ZipReader].
export 'src/reader.dart'
    show ZipReader, ZipFile, ZipFormatException;
export 'src/struct.dart' show FileHeader;
