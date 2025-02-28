// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:puppeteer/puppeteer.dart';

// Default screen with 16:10 ratio.
final desktopDeviceViewport = DeviceViewport(width: 1280, height: 800);

final _screenshotDir = Platform.environment['PUB_SCREENSHOT_DIR'];
final _isScreenshotDirSet =
    _screenshotDir != null && _screenshotDir!.isNotEmpty;

// Set this variable to enable screenshot files to be updated with new takes.
// The default is to throw an exception to prevent accidental overrides from
// separate tests.
final _allowScreeshotUpdates =
    Platform.environment['PUB_SCREENSHOT_UPDATE'] == '1';

// Note: The default values are the last, so we don't need reset
//       the original values after taking the screenshots.
final _themes = ['dark', 'light'];
final _viewports = {
  'mobile': DeviceViewport(width: 400, height: 800),
  'tablet': DeviceViewport(width: 768, height: 1024),
  'desktop': desktopDeviceViewport,
};

extension ScreenshotPageExt on Page {
  Future<void> writeScreenshotToFile(String path) async {
    await File(path).writeAsBytes(await screenshot());
  }

  /// Takes screenshots **if** `PUB_SCREENSHOT_DIR` environment variable is set.
  ///
  /// Iterates over viewports and themes, and generates screenshot files with the
  /// following pattern:
  /// - `PUB_SCREENSHOT_DIR/$prefix-desktop-dark.png`
  /// - `PUB_SCREENSHOT_DIR/$prefix-desktop-light.png`
  /// - `PUB_SCREENSHOT_DIR/$prefix-mobile-dark.png`
  /// - `PUB_SCREENSHOT_DIR/$prefix-mobile-light.png`
  /// - `PUB_SCREENSHOT_DIR/$prefix-tablet-dark.png`
  /// - `PUB_SCREENSHOT_DIR/$prefix-tablet-light.png`
  Future<void> takeScreenshots({
    required String selector,
    required String prefix,
  }) async {
    final handle = await $(selector);
    await handle.takeScreenshots(prefix);
  }
}

extension ScreenshotElementHandleExt on ElementHandle {
  /// Takes screenshots **if** `PUB_SCREENSHOT_DIR` environment variable is set.
  ///
  /// Iterates over viewports and themes, and generates screenshot files with the
  /// following pattern:
  /// - `PUB_SCREENSHOT_DIR/$prefix-desktop-dark.png`
  /// - `PUB_SCREENSHOT_DIR/$prefix-desktop-light.png`
  /// - `PUB_SCREENSHOT_DIR/$prefix-mobile-dark.png`
  /// - `PUB_SCREENSHOT_DIR/$prefix-mobile-light.png`
  /// - `PUB_SCREENSHOT_DIR/$prefix-tablet-dark.png`
  /// - `PUB_SCREENSHOT_DIR/$prefix-tablet-light.png`
  Future<void> takeScreenshots(String prefix) async {
    final body = await page.$('body');
    final bodyClassAttr =
        (await body.evaluate('el => el.getAttribute("class")')) as String;
    final bodyClasses = [
      ...bodyClassAttr.split(' '),
      '-pub-ongoing-screenshot',
    ];

    for (final vp in _viewports.entries) {
      await page.setViewport(vp.value);

      for (final theme in _themes) {
        final newClasses = [
          ...bodyClasses.where((c) => !c.endsWith('-theme')),
          '$theme-theme',
        ];
        await body.evaluate('(el, v) => el.setAttribute("class", v)',
            args: [newClasses.join(' ')]);

        // The presence of the element is verified, continue only if screenshots are enabled.
        if (!_isScreenshotDirSet) continue;

        // Arbitrary delay in the hope that potential ongoing updates complete.
        await Future.delayed(Duration(milliseconds: 500));

        final path = p.join(_screenshotDir!, '$prefix-${vp.key}-$theme.png');
        await _writeScreenshotToFile(path);
      }
    }

    // restore the original body class attributes
    await body.evaluate('(el, v) => el.setAttribute("class", v)',
        args: [bodyClassAttr]);
  }

  Future<void> _writeScreenshotToFile(String path) async {
    final file = File(path);
    final exists = await file.exists();
    if (exists && !_allowScreeshotUpdates) {
      throw Exception('Screenshot update is detected in: $path');
    }
    await file.parent.create(recursive: true);
    await File(path).writeAsBytes(await screenshot());
  }
}
