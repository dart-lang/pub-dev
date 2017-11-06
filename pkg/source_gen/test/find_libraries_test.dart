// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('!browser')
library source_gen.test.find_libraries;

import 'package:analyzer/src/generated/engine.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'analysis_utils.dart';
import 'src/io.dart';
import 'test_utils.dart';

void main() {
  group('check source files against expected libraries', () {
    AnalysisContext context;

    setUp(() async {
      if (context == null) {
        var projectPath = getPackagePath();

        var foundFiles = await getDartFiles(projectPath,
            searchList: [p.join(getPackagePath(), 'test', 'test_files')]);

        context =
            await getAnalysisContextForProjectPath(projectPath, foundFiles);
      }
    });

    _testFileMap.forEach((inputPath, expectedLibPath) {
      test(inputPath, () {
        var fullInputPath = _testFilePath(inputPath);

        var libElement = getLibraryElementForSourceFile(context, fullInputPath);

        var fullLibPath = _testFilePath(expectedLibPath);

        expect(p.fromUri(libElement.source.uri), fullLibPath);
      });
    });
  });
}

String _testFilePath(String name) =>
    p.join(getPackagePath(), 'test', 'test_files', name);

const _testFileMap = const {
  'annotated_classes.dart': 'annotated_classes.dart',
  'annotated_classes_part.dart': 'annotated_classes.dart',
  'annotations.dart': 'annotations.dart',
  'annotation_part.dart': 'annotations.dart',
};
