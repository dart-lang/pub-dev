// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

import 'package:pub_dev/service/youtube/backend.dart';

import '../../shared/test_services.dart';

void main() {
  testWithProfile('when a key is specified, it has items', fn: () async {
    if (Platform.environment.containsKey('YOUTUBE_API_KEY')) {
      final videos = youtubeBackend.getTopPackageOfWeekVideos(count: 100);
      expect(videos, hasLength(greaterThan(5)));
    }
  });
}
