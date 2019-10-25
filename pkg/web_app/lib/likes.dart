// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:intl/intl.dart';
import 'package:mdc_web/mdc_web.dart';

import 'src/account.dart';
import 'src/page_data.dart';

Future _done;

void setupLikes() {
  final likes = document.querySelector('#likes');
  final toggleButton = document.querySelector('#thumb-up') as ButtonElement;

  if (toggleButton == null) return;

  final iconButtonToggle = MDCIconButtonToggle(toggleButton);
  int likesDelta = 0;

  String likesString() {
    final likesCount = pageData.pkgData.likes + likesDelta;
    return '${NumberFormat.compact().format(likesCount)}'
        ' ${likesCount == 1 ? 'Like' : 'Likes'}';
  }

  iconButtonToggle.listen(MDCIconButtonToggle.changeEvent, (Event e) {
    toggleButton.blur();
    if (iconButtonToggle.on) {
      // The button has shifted to on.
      likesDelta++;
      likes.innerHtml = likesString();
      _like(pageData.pkgData.package);
    } else {
      // The button has shifted to off.
      likesDelta--;
      likes.innerHtml = likesString();
      _unlike(pageData.pkgData.package);
    }
  });
}

void _unlike(String package) async {
  final d = _done;
  _done = () async {
    try {
      await d;
      await client.unlikePackage(package);
    } on Error catch (e) {
      print('Error $e');
    }
  }();
}

void _like(String package) async {
  final d = _done;
  _done = () async {
    try {
      await d;
      await client.likePackage(package);
    } on Error catch (e) {
      print('Error $e');
    }
  }();
}
