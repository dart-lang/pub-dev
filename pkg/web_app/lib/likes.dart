// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:intl/intl.dart';
import 'package:mdc_web/mdc_web.dart';

import 'src/account.dart';
import 'src/page_data.dart';

Future<void> _done = Future.value();

/// Ensure only one task runs at the same time.
void _enqueue(Future<void> Function() task) {
  _done = _done.then((_) => task(), onError: (e) => print('Action failed: $e'));
}

void setupLikes() {
  final likes = document.querySelector('#likes-count');
  final likeButton =
      document.querySelector('#-pub-like-button') as ButtonElement;

  // If `likeButton` is not on this page we assume the page doesn't display a
  // `like package` button.
  if (likeButton == null) return;

  final iconButtonToggle = MDCIconButtonToggle(likeButton);
  int likesDelta = 0;

  String likesString() {
    final likesCount = pageData.pkgData.likes + likesDelta;
    return '${NumberFormat.compact().format(likesCount)}'
        ' ${likesCount == 1 ? 'like' : 'likes'}';
  }

  iconButtonToggle.listen(MDCIconButtonToggle.changeEvent, (Event e) {
    likeButton.blur();
    if (iconButtonToggle.on) {
      // The button has shifted to on.
      likesDelta++;
      likes.innerText = likesString();
      _enqueue(() => client.likePackage(pageData.pkgData.package));
    } else {
      // The button has shifted to off.
      likesDelta--;
      likes.innerText = likesString();
      _enqueue(() => client.unlikePackage(pageData.pkgData.package));
    }
  });
}
