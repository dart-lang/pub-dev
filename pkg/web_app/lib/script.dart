// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:mdc_web/mdc_web.dart' as mdc;
import 'package:web_app/likes.dart';
import 'src/account.dart';
import 'src/dartdoc_status.dart';
import 'src/foldable.dart';
import 'src/hoverable.dart';
import 'src/issues.dart';
import 'src/mobile_nav.dart';
import 'src/scroll.dart';
import 'src/search.dart';
import 'src/tabs.dart';

void main() {
  window.onLoad.listen((_) => mdc.autoInit());
  setupTabs();
  setupSearch();
  setupScroll();
  setupFoldable();
  setupHoverable();
  setupMobileNav();
  setupIssues();
  updateDartdocStatus();
  setupAccount();
  setupLikes();
  setupLikesList();
}
