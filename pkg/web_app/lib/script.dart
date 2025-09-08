// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mdc_web/mdc_web.dart' as mdc show autoInit;
import 'package:web/web.dart';

import 'src/account.dart';
import 'src/foldable.dart';
import 'src/hoverable.dart';
import 'src/issues.dart';
import 'src/likes.dart';
import 'src/mobile_nav.dart';
import 'src/page_updater.dart';
import 'src/screenshot_carousel.dart';
import 'src/search.dart';
import 'src/widget/widget.dart' show setupWidgets;

void main() {
  window.onLoad.listen((_) => mdc.autoInit());
  setupAccount();
  _setupAllEvents();
  setupPageUpdater(_setupAllEvents);
  // event triggered after a page is displayed:
  // - after the initial load or,
  // - from cache via back button.
  EventStreamProviders.pageShowEvent.forTarget(window).listen((_) {
    adjustQueryTextAfterPageShow();
  });
  _setupDarkThemeButton();
}

void _setupAllEvents() {
  setupSearch();
  setupFoldable();
  setupHoverable();
  setupMobileNav();
  setupIssues();
  setupLikes();
  setupLikesList();
  setupScreenshotCarousel();
  setupWidgets();
}

void _setupDarkThemeButton() {
  final button = document.querySelector('button.-pub-theme-toggle');
  if (button != null) {
    button.onClick.listen((_) {
      final classes = document.body!.classList;
      final isCurrentlyDark = classes.contains('dark-theme');
      window.localStorage.setItem(
        'colorTheme',
        isCurrentlyDark ? 'false' : 'true',
      );
      classes.toggle('dark-theme');
      classes.toggle('light-theme');
    });
  }
}
