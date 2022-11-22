// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  Future _checkFiles(String path) async {
    final dir = Directory(path);
    await for (final f in dir.list(recursive: true)) {
      if (f is File) {
        final content = await f.readAsString();
        // ignore innerHtml from package:html in dartdoc_page.dart
        if (content.contains('package:html') &&
            !content.contains('dart:html') &&
            f.path.endsWith('dartdoc_page.dart')) {
          continue;
        }
        expect(content, isNot(contains('innerHtml')));
        expect(content, isNot(contains('innerHTML')));
        // TODO: decide how to filter setInnerHtml (which may have a validator)
      }
    }
  }

  test('no innerHtml use in app', () async {
    await _checkFiles('../../app/lib/');
    await _checkFiles('../../pkg/_pub_shared/lib');
  });

  test('no innerHtml use in pkg/web_app', () async {
    await _checkFiles('lib/');
  });
}
