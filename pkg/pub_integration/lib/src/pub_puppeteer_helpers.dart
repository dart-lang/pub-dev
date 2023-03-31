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

extension PubPageExt on Page {
  Future<void> waitFocusAndType(String selector, String text) async {
    await waitForSelector(selector, timeout: Duration(seconds: 5));
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
    await waitAndClick('#-admin-create-publisher');
    await waitAndClickOnDialogOk();
    await _waitForModelHidden();
  }

  Future<void> setPackagePublisher({
    required String package,
    required String publisherId,
  }) async {
    await gotoOrigin('/packages/$package/admin');
    await waitAndClick('#-admin-set-publisher-input');
    await waitAndClick('li[data-value="$publisherId"]');
    await waitAndClick('#-admin-set-publisher-button');
    await waitAndClickOnDialogOk();
    await _waitForModelHidden();
  }

  Future<Map<String, String>> listPublisherMembers({
    required String publisherId,
  }) async {
    final result = <String, String>{};
    await gotoOrigin('/publishers/$publisherId/admin');
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
    await waitAndClick('#-admin-add-member-button');
    await _waitAndType('#-admin-invite-member-input', invitedEmail);
    await waitAndClickOnDialogOk(waitForOneResponse: true);
    await waitAndClickOnDialogOk();
    await _waitForModelHidden();
  }

  Future<void> acceptConsent({
    required String consentId,
  }) async {
    await gotoOrigin('/consent?id=$consentId');
    await waitAndClick('#-admin-consent-accept-button');
    await waitAndClickOnDialogOk();
    await _waitForModelHidden();
  }

  Future<void> waitAndClick(
    String selector, {
    bool? waitForOneResponse,
  }) async {
    await waitForSelector(
      selector,
      timeout: Duration(seconds: 5),
    );
    Future? future;
    if (waitForOneResponse ?? false) {
      future = frameManager.networkManager.onResponse.first;
    }
    await click(selector);
    if (future != null) {
      await future;
    }
  }

  Future<void> _waitAndType(String selector, String text) async {
    await waitForSelector(
      selector,
      timeout: Duration(seconds: 5),
    );
    await type(selector, text);
  }

  Future<void> waitAndClickOnDialogOk({
    bool? waitForOneResponse,
  }) async {
    // For some reason MDC Dialog trigger a client-side error when we are trying
    // to click on the button too early.
    // The error (`FocusTrap: Element must have at least one focusable child.`)
    // seems to be absent if we allow some time to pass before clicking on it.
    await Future.delayed(Duration(milliseconds: 500));
    await waitAndClick(
      '.-pub-dom-dialog-ok-button',
      waitForOneResponse: waitForOneResponse,
    );
  }

  Future<void> _waitForModelHidden() async {
    await waitForSelector('.mdc-dialog', hidden: true);
  }
}
