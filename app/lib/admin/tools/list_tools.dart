// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/admin/backend.dart';

/// Sets the private Secret value.
Future<String> executeListTools(List<String> args) async {
  return '''
Available admin tools:

${availableTools.keys.join('\n')}
''';
}
