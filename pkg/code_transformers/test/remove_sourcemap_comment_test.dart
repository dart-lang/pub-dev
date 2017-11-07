// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
library code_transformers.test.remove_sourcemap_comment_test;

import 'package:barback/barback.dart';
import 'package:code_transformers/src/remove_sourcemap_comment.dart';
import 'package:test/test.dart';
import 'package:transformer_test/utils.dart';

final phases = [
  [
    new RemoveSourcemapComment.asPlugin(
        new BarbackSettings({}, BarbackMode.RELEASE))
  ]
];

void main() {
  testPhases('removes sourcemap comments', phases, {
    'a|web/test.js': '''
          var i = 0;
          //# sourceMappingURL=*.map''',
  }, {
    'a|web/test.js': '''
          var i = 0;''',
  });
}
