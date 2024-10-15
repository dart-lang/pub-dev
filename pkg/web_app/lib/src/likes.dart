// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:_pub_shared/format/number_format.dart';
import 'package:mdc_web/mdc_web.dart' show MDCIconButtonToggle;

import '_dom_helper.dart';
import 'account.dart';
import 'api_client/api_client.dart' deferred as api_client;
import 'page_data.dart';

Future<void> _done = Future.value();

/// Ensure only one task runs at the same time.
void _enqueue(Future<void> Function() task) {
  _done = _done.then((_) => task(),
      onError: (Object? e) => print('Action failed: $e'));
}

void setupLikesList() {
  document.querySelectorAll('.-pub-like-button').forEach((likeButton) {
    final package = likeButton.dataset['package']!;

    likeButton.onClick.listen((Event e) async {
      await api_client.loadLibrary();
      final text = likeButton.querySelector('.-pub-like-button-label')!;
      final img =
          likeButton.querySelector('.-pub-like-button-img') as ImageElement;
      if (text.innerText == 'LIKE') {
        text.innerText = 'UNLIKE';
        img.src = likeButton.dataset['thumb_up_filled'];
        _enqueue(() => api_client.client.likePackage(package));
      } else {
        text.innerText = 'LIKE';
        img.src = likeButton.dataset['thumb_up_outlined'];
        _enqueue(() => api_client.client.unlikePackage(package));
      }
    });
  });
}

void setupLikes() {
  final likes = document.querySelector('#likes-count');
  final likeButton =
      document.querySelector('#-pub-like-icon-button') as ButtonElement?;

  // If `likeButton` is not on this page we assume the page doesn't display a
  // `like package` button.
  if (likeButton == null) return;

  final iconButtonToggle = MDCIconButtonToggle(likeButton);
  var likesDelta = 0;

  // keep in-sync with app/lib/frontend/templates/views/shared/detail/header.dart
  String likesString() {
    final likesCount = pageData.pkgData!.likes + likesDelta;
    return formatWithSuffix(likesCount);
  }

  iconButtonToggle.listen(MDCIconButtonToggle.changeEvent, (Event e) async {
    if (isNotAuthenticated) {
      iconButtonToggle.on = false;
      final content = ParagraphElement()
        ..text = 'You need to be signed-in to like packages. '
            'Would you like to visit the authentication page?';
      final redirect = await modalConfirm(content);
      if (redirect) {
        document.getElementById('-account-login')?.click();
      }
      return;
    }
    likeButton.blur();
    await api_client.loadLibrary();
    if (iconButtonToggle.on ?? false) {
      // The button has shifted to on.
      likesDelta++;
      likes!.innerText = likesString();
      _enqueue(() => api_client.client.likePackage(pageData.pkgData!.package));
    } else {
      // The button has shifted to off.
      likesDelta--;
      likes!.innerText = likesString();
      _enqueue(
          () => api_client.client.unlikePackage(pageData.pkgData!.package));
    }
  });
}
