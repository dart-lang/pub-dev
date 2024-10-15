// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:_pub_shared/data/page_data.dart';

/// The server-provided config/data for the current page.
///
/// This is the `<meta name="pub-page-data" content="[json-data]">` embedded in
/// the `head` section of the HTML page.
final PageData pageData = _extractData();

PageData _extractData() {
  final meta = document.head?.querySelector('meta[name="pub-page-data"]');
  if (meta != null) {
    try {
      final text = meta.getAttribute('content')!;
      final map = pageDataJsonCodec.decode(text) as Map<String, Object?>;
      return PageData.fromJson(map);
    } catch (_) {
      // ignore exception
    }
  }
  return PageData();
}
