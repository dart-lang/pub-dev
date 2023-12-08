// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:mdc_web/mdc_web.dart' as mdc show autoInit;
import 'src/account.dart';
import 'src/foldable.dart';
import 'src/hoverable.dart';
import 'src/issues.dart';
import 'src/likes.dart';
import 'src/mobile_nav.dart';
import 'src/page_updater.dart';
import 'src/screenshot_carousel.dart';
import 'src/scroll.dart';
import 'src/search.dart';

void main() {
  window.onLoad.listen((_) => mdc.autoInit());
  setupAccount();
  _setupAllEvents();
  setupPageUpdater(_setupAllEvents);
  // event triggered after a page is displayed:
  // - after the initial load or,
  // - from cache via back button.
  window.onPageShow.listen((_) {
    adjustQueryTextAfterPageShow();
  });
}

void _setupAllEvents() {
  setupSearch();
  setupScroll();
  setupFoldable();
  setupHoverable();
  setupMobileNav();
  setupIssues();
  setupLikes();
  setupLikesList();
  setupScreenshotCarousel();
}
