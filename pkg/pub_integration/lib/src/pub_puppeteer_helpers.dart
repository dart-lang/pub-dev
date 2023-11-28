// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:io';

import 'package:puppeteer/puppeteer.dart';

import 'test_browser.dart';

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
  Future<void> saveScreenshot(String path) async {
    await File(path).writeAsBytes(await screenshot());
  }

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
    await _waitConfirmDialogThenConfirmOp();
  }

  Future<void> invitePackageAdmin({
    required String package,
    required String invitedEmail,
  }) async {
    await gotoOrigin('/packages/$package/admin');
    await waitAndClick('#-pkg-admin-invite-uploader-button');
    await _waitAndType('#-pkg-admin-invite-uploader-input', invitedEmail);
    await _waitConfirmDialogThenConfirmOp();
  }

  Future<List<String>> listPackageUploaderEmails({
    required String package,
  }) async {
    await gotoOrigin('/packages/$package/admin');
    final table = await $('#-pkg-admin-uploaders-table');
    final buttons = await table.$$('.-pub-remove-uploader-button');
    final emails = <String>[];
    for (final button in buttons) {
      final email = await button.attributeValue('data-email');
      emails.add(email!);
    }
    return emails;
  }

  Future<void> deletePackageAdmin({
    required String package,
    required String email,
  }) async {
    await gotoOrigin('/packages/$package/admin');
    final table = await $('#-pkg-admin-uploaders-table');
    final buttons = await table.$$('.-pub-remove-uploader-button');
    var clicked = false;
    for (final button in buttons) {
      final buttonEmail = await button.attributeValue('data-email');
      if (email == buttonEmail) {
        await button.click();
        clicked = true;
        break;
      }
    }
    if (!clicked) {
      throw Exception('Email "$email" was not found in the uploaders list.');
    }
    await _waitConfirmDialogThenConfirmOp();
  }

  Future<void> acceptConsent({
    required String consentId,
  }) async {
    await gotoOrigin('/consent?id=$consentId');
    await waitAndClick('#-admin-consent-accept-button');
    await waitAndClickOnDialogOk();
    await _waitForModelHidden();
  }

  Future<void> _waitConfirmDialogThenConfirmOp() async {
    // Click ok in the dialog to confirm
    await waitAndClickOnDialogOk(waitForOneResponse: true);
    // Click ok on the popup saying it was done
    await waitAndClickOnDialogOk();
    await _waitForModelHidden();
  }

  Future<void> waitForNavigationUntilIdle() async {
    await waitForNavigation(wait: Until.networkIdle);
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> reloadUntilIdle() async {
    await reload(wait: Until.networkIdle);
    await Future.delayed(Duration(seconds: 1));
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
    await Future.delayed(Duration(milliseconds: 100));
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
    await waitAndClick(
      '.-pub-dom-dialog-ok-button',
      waitForOneResponse: waitForOneResponse,
    );
  }

  Future<void> _waitForModelHidden() async {
    try {
      await waitForSelector(
        '.mdc-dialog',
        hidden: true,
        timeout: Duration(seconds: 5),
      );
      return;
    } on TimeoutException catch (_) {
      // ignore the exception
    }

    // return if the dialog is no longer present
    final dialogs = await $$('.mdc-dialog');
    if (dialogs.isEmpty) {
      return;
    }

    // Click on the neutral area of the page (on the background element that
    // makes the UI behind the modal dialog darker). This should make the dialog
    // disappear.
    await mouse.click(Point(1, 1));

    // second attempt to wait for the dialog to disappear
    await waitForSelector(
      '.mdc-dialog',
      hidden: true,
      timeout: Duration(seconds: 5),
    );
  }
}
