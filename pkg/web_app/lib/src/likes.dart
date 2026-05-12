// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/format/number_format.dart';
import 'package:web/web.dart';

import '_dom_helper.dart';
import 'account.dart';
import 'api_client/api_client.dart' deferred as api_client;
import 'web_util.dart';

Future<void> _done = Future.value();

/// Ensure only one task runs at the same time.
void _enqueue(Future<void> Function() task) {
  _done = _done.then(
    (_) => task(),
    onError: (Object? e) => print('Action failed: $e'),
  );
}

void setupLikesList() {
  document
      .querySelectorAll('.-pub-like-button')
      .toElementList<HTMLElement>()
      .forEach((likeButton) {
        final package = likeButton.dataset['package'];

        likeButton.onClick.listen((Event e) async {
          await api_client.loadLibrary();
          final text = likeButton.querySelector('.-pub-like-button-label')!;
          final img =
              likeButton.querySelector('.-pub-like-button-img')
                  as HTMLImageElement;
          if (text.textContent == 'LIKE') {
            text.textContent = 'UNLIKE';
            img.src = likeButton.dataset['thumb_up_filled'];
            _enqueue(() => api_client.client.likePackage(package));
          } else {
            text.textContent = 'LIKE';
            img.src = likeButton.dataset['thumb_up_outlined'];
            _enqueue(() => api_client.client.unlikePackage(package));
          }
        });
      });
}

void setupLikes() {
  for (final likeButton
      in document
          .querySelectorAll('.like-button-and-label--button')
          .toElementList<HTMLElement>()) {
    final package = likeButton.getAttribute('data-package');
    final originalCount = int.tryParse(
      likeButton.getAttribute('data-value') ?? '',
    );

    if (package == null || package.isEmpty || originalCount == null) {
      continue;
    }

    var likesDelta = 0;

    void updateLabels() {
      final likesCount = originalCount + likesDelta;
      final countLabel = likeButton.parentElement?.querySelector(
        '.like-button-and-label--count',
      );
      if (countLabel != null) {
        // keep in-sync with app/lib/frontend/templates/views/pkg/liked_package_list.dart
        countLabel.textContent = formatWithSuffix(likesCount);
      }

      // keep in-sync with app/lib/frontend/templates/views/pkg/labeled_scores.dart
      final formatted = compactFormat(likesCount);
      final labeledScoreLikeString = '${formatted.value}${formatted.suffix}';
      final labeledLikes = document
          .querySelectorAll('.packages-score-like')
          .toElementList<HTMLElement>()
          .where((e) => e.dataset['package'] == package)
          .toList();
      for (final labeledLike in labeledLikes) {
        labeledLike.querySelector('.packages-score-value-number')?.textContent =
            labeledScoreLikeString;
      }

      // keep in-sync with app/lib/frontend/templates/views/pkg/score_tab.dart
      document
              .querySelector('.score-key-figure--likes')
              ?.querySelector('.score-key-figure-value')
              ?.textContent =
          labeledScoreLikeString;
    }

    likeButton.onClick.listen((Event e) async {
      if (isNotAuthenticated) {
        final content = HTMLParagraphElement()
          ..textContent =
              'You need to be signed-in to like packages. '
              'Would you like to visit the authentication page?';
        final redirect = await modalConfirm(content);
        if (redirect) {
          (document.getElementById('-account-login') as HTMLElement?)?.click();
        }
        return;
      }
      likeButton.classList.toggle('-pub-icon-button--on');
      likeButton.blur();
      await api_client.loadLibrary();
      if (likeButton.classList.contains('-pub-icon-button--on')) {
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
