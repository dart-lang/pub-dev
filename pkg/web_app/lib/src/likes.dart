// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
// TODO: migrate to package:web
// ignore: deprecated_member_use
import 'dart:html';

import 'package:_pub_shared/format/number_format.dart';
import 'package:mdc_web/mdc_web.dart' show MDCIconButtonToggle;

import '_dom_helper.dart';
import 'account.dart';
import 'api_client/api_client.dart' deferred as api_client;

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
  for (final buttonAndLabel
      in document.querySelectorAll('.like-button-and-label')) {
    final likeButton = buttonAndLabel
        .querySelector('.like-button-and-label--button') as ButtonElement?;
    if (likeButton == null) continue;

    final countLabel =
        buttonAndLabel.querySelector('.like-button-and-label--count');
    if (countLabel == null) continue;

    final package = countLabel.dataset['package'];
    if (package == null || package.isEmpty) continue;

    final originalCount = int.tryParse(countLabel.dataset['value'] ?? '');
    if (originalCount == null) continue;

    var likesDelta = 0;

    void updateLabels() {
      final likesCount = originalCount + likesDelta;
      // keep in-sync with app/lib/frontend/templates/views/pkg/liked_package_list.dart
      countLabel.innerText = formatWithSuffix(likesCount);

      // keep in-sync with app/lib/frontend/templates/views/pkg/labeled_scores.dart
      final formatted = compactFormat(likesCount);
      final labeledScoreLikeString = '${formatted.value}${formatted.suffix}';
      final labeledLikes = querySelectorAll('.packages-score-like')
          .where((e) => e.dataset['package'] == package)
          .toList();
      for (final labeledLike in labeledLikes) {
        labeledLike.querySelector('.packages-score-value-number')?.text =
            labeledScoreLikeString;
      }

      // keep in-sync with app/lib/frontend/templates/views/pkg/score_tab.dart
      querySelector('.score-key-figure--likes')
          ?.querySelector('.score-key-figure-value')
          ?.text = labeledScoreLikeString;
    }

    final iconButtonToggle = MDCIconButtonToggle(likeButton);
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
        updateLabels();
        _enqueue(() => api_client.client.likePackage(package));
      } else {
        // The button has shifted to off.
        likesDelta--;
        updateLabels();
        _enqueue(() => api_client.client.unlikePackage(package));
      }
    });
  }
}
