// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:puppeteer/puppeteer.dart';

import 'headless_env.dart';

class ListingPageInfo {
  final int totalCount;
  final List<String> packageNames;
  final List<String> openSections;

  ListingPageInfo({
    required this.totalCount,
    required this.packageNames,
    required this.openSections,
  });
}

/// Returns the list of packages on the listing page.
Future<ListingPageInfo> listingPageInfo(Page page) async {
  final countElem = await page.$('.listing-info-count .count');
  final totalCount = int.parse(await countElem.textContent());
  final packageNames = <String>[];
  for (final item in await page.$$('.packages .packages-title a')) {
    packageNames.add(await item.textContent());
  }
  final openSections = <String>[];
  for (final item in await page.$$('.search-form-section.-active')) {
    final p = await item.attributeValue('data-section-tag');
    if (p is String && p.isNotEmpty) {
      openSections.add(p);
    }
  }
  return ListingPageInfo(
    totalCount: totalCount,
    packageNames: packageNames,
    openSections: openSections,
  );
}

extension PageExt on Page {
  Future<void> focusAndType(String selector, String text) async {
    await focus(selector);
    await keyboard.sendCharacter(text);
  }

  Future<void> clickOnButtonWithLabel(String label) async {
    final buttons = await $$('button');
    for (final button in buttons) {
      final text = (await button.textContent()).trim();
      if (text.toLowerCase() == label.toLowerCase()) {
        await button.click();
        break;
      }
    }
  }
}
