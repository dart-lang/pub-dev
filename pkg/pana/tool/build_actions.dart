// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:build_runner/build_runner.dart';
import 'package:json_serializable/generators.dart';
import 'package:source_gen/source_gen.dart';

import 'version_generator.dart';
import 'version_helper.dart';

final List<BuildAction> buildActions = [
  new BuildAction(
      new PartBuilder([
        new JsonSerializableGenerator.withDefaultHelpers([
          new VersionHelper(),
          new VersionConstraintHelper(),
        ]),
        new PackageVersionGenerator()
      ], header: _copyrightHeader),
      'pana',
      inputs: const [
        'lib/src/analyzer_output.dart',
        'lib/src/fitness.dart',
        'lib/src/license.dart',
        'lib/src/platform.dart',
        'lib/src/pub_summary.dart',
        'lib/src/summary.dart',
        'lib/src/version.dart',
      ])
];

final _copyrightHeader =
    '''// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

$defaultFileHeader
''';
