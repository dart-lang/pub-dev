// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:puppeteer/puppeteer.dart';

import 'headless_env.dart';

const webmastersReadonlyScope =
    'https://www.googleapis.com/auth/webmasters.readonly';

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

Future<void> _waitABit() => Future.delayed(Duration(milliseconds: 400));

extension PubPageExt on Page {
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
        return;
      }
    }
    throw Exception('Button with label "$label" is not on the page.');
  }

  /// Triggers a fake-auth-based sign-in.
  Future<void> fakeAuthSignIn({
    required String email,
    List<String>? scopes,
    String? go,
  }) async {
    final url = Uri(
      path: '/sign-in',
      queryParameters: {
        'fake-email': email,
        if (scopes != null && scopes.isEmpty) 'scope': scopes.join(' '),
        if (go != null) 'go': go,
      },
    ).toString();
    await gotoOrigin(url);
  }

  Future<void> createPublisher({
    required String publisherId,
  }) async {
    await gotoOrigin('/create-publisher?domain=$publisherId');
    await _waitABit();
    await click('#-admin-create-publisher');
    await _waitABit();
    await clickOnButtonWithLabel('ok');
    await _waitABit();
  }

  Future<void> setPackagePublisher({
    required String package,
    required String publisherId,
  }) async {
    await gotoOrigin('/packages/$package/admin');
    await _waitABit();
    await click('#-admin-set-publisher-input');
    await _waitABit();
    await click('li[data-value="$publisherId"]');
    await _waitABit();
    await click('#-admin-set-publisher-button');
    await _waitABit();
    await clickOnButtonWithLabel('ok');
    await _waitABit();
  }

  Future<Map<String, String>> listPublisherMembers({
    required String publisherId,
  }) async {
    final result = <String, String>{};
    await gotoOrigin('/publishers/$publisherId/admin');
    await _waitABit();
    final rows = await $$('#-pub-publisher-admin-members-table tbody tr');
    for (final row in rows) {
      final cols = await row.$$('td');
      result[await cols[0].textContent()] = await cols[1].textContent();
    }
    return result;
  }

  Future<void> invitePublisherMember({
    required String publisherId,
    required String invitedEmail,
  }) async {
    await gotoOrigin('/publishers/$publisherId/admin');
    await _waitABit();
    await click('#-admin-add-member-button');
    await _waitABit();
    await type('#-admin-invite-member-input', invitedEmail);
    await _waitABit();
    await clickOnButtonWithLabel('add');
    await _waitABit();
    await clickOnButtonWithLabel('ok');
    await _waitABit();
  }

  Future<void> acceptConsent({
    required String consentId,
  }) async {
    await gotoOrigin('/consent?id=$consentId');
    await click('#-admin-consent-accept-button');
    await _waitABit();
    await clickOnButtonWithLabel('ok');
    await _waitABit();
  }
}
