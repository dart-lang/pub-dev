// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';
import 'package:test/test.dart';

void main() {
  group('REST API', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(documents: [
        PackageDocument(
          package: 'cloud_firestore',
          version: '0.7.2',
          description: compactDescription(
              'Flutter plugin for Cloud Firestore, a cloud-hosted, noSQL database '
              'with live synchronization and offline support on Android and iOS.'),
          readme: compactReadme('''# Cloud Firestore Plugin for Flutter

A Flutter plugin to use the [Cloud Firestore API](https://firebase.google.com/docs/firestore/).

[![pub package](https://img.shields.io/pub/v/cloud_firestore.svg)](https://pub.dartlang.org/packages/cloud_firestore)

For Flutter plugins for other Firebase products, see [FlutterFire.md](https://github.com/flutter/plugins/blob/master/FlutterFire.md).

*Note*: This plugin is still under development, and some APIs might not be available yet. [Feedback](https://github.com/flutter/flutter/issues) and [Pull Requests](https://github.com/flutter/plugins/pulls) are most welcome!

Recent versions (0.3.x and 0.4.x) of this plugin require [extensible codec functionality](https://github.com/flutter/flutter/pull/15414) that is not yet released to the [beta channel](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels) of Flutter. If you're encountering issues using those versions, consider switching to the dev channel.'''),
        ),
        PackageDocument(
          package: 'currency_cloud',
          version: '0.2.1',
          description: compactDescription(
              'A dart library for the Currency Cloud service. It operates as a '
              'wrapper for the Currency Cloud REST API.'),
          readme: compactReadme(
              'Currency Cloud Dart API A dart library for the Currency Cloud '
              'service Usage A simple usage example'),
        ),
      ]);
    });

    test('REST API', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'rest api', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'currency_cloud',
            'score': 1.0,
          },
          {
            'package': 'cloud_firestore', // finds `rest` in name
            'score': closeTo(0.72, 0.01),
          },
        ],
      });
    });
  });
}
