// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:build_runner/build_runner.dart';
import 'package:json_serializable/json_serializable.dart';
import 'package:source_gen/source_gen.dart';

final List<BuildAction> buildActions = [
  new BuildAction(
      new PartBuilder(const [
        const JsonSerializableGenerator(),
        const JsonLiteralGenerator()
      ], header: _copyrightHeader, requireLibraryDirective: false),
      'pub_dartlang_org',
      inputs: const ['lib/shared/*.dart', 'lib/search/backend*.dart'])
];

final _copyrightHeader =
    '''// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

$defaultFileHeader
// ignore_for_file: prefer_final_locals
''';
