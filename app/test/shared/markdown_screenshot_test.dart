// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'package:test/test.dart';

import 'package:pub_dev/shared/markdown.dart';

void main() {
  group('not screenshots', () {
    test('not linking to the same image', () {
      final images = extractScreenshotImages(
          '[![alt text](link/to/img.png)](link/to/other-img.png)');
      expect(images, isEmpty);
    });

    test('alt text without screenshot', () {
      final images = extractScreenshotImages('![alt text](link/to/img.png)');
      expect(images, isEmpty);
    });
  });

  group('link to image', () {
    test('relative link', () {
      final images = extractScreenshotImages(
          '[![alt text](link/to/img.png)](link/to/img.png)');
      expect(images.single.toJson(), {
        'url': 'link/to/img.png',
        'title': 'alt text',
      });
    });

    test('second link', () {
      final images = extractScreenshotImages(
          '[![alt text](link/to/other-img.png) ![alt text 2](link/to/img.png)](link/to/img.png)');
      expect(images.single.toJson(), {
        'url': 'link/to/img.png',
        'title': 'alt text 2',
      });
    });
  });

  group('alt text with screenshot', () {
    test('relative link', () {
      final images = extractScreenshotImages(
          '<img src="link/to/img.png" data-pub-role="screenshot">');

      // Currently our markdown parsing will remove the data- attributes.
      // TODO: enable markdown parsing with inlined data-pub-role attributes.
      expect(images, isEmpty);
    });
  });
}
