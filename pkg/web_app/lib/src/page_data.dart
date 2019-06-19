// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:html';

import 'package:client_data/page_data.dart';

PageData _data;

/// The server-provided config/data of the current page.
PageData get pageData {
  return _data ??= _extractData() ?? PageData();
}

PageData _extractData() {
  final scripts = document.body.children
      .where((e) => e.tagName.toLowerCase() == 'script')
      .where((e) => e.attributes['type'] == 'application/ld+json');
  for (final script in scripts) {
    try {
      final map = json.decode(script.text) as Map<String, dynamic>;
      print(map);
      if (map['@context'] == 'https://pub.dev') {
        final json = map['data'] as Map<String, dynamic>;
        return PageData.fromJson(json);
      }
    } catch (_) {
      // ignore exception
    }
  }
  return null;
}
