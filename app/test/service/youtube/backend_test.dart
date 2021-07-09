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

  testWithProfile('randomization', fn: () async {
    youtubeBackend.setPackageOfWeekVideos(List<PkgOfWeekVideo>.generate(
      10,
      (index) => PkgOfWeekVideo(
        videoId: 'v$index',
        title: 'title',
        description: 'description',
        thumbnailUrl: 'https://youtube.com/thumbnailUrl',
      ),
    ));
    final selected = youtubeBackend.getTopPackageOfWeekVideos();
    expect(selected[0].videoId, 'v0');
    expect(int.parse(selected[1].videoId.substring(1)), lessThan(4));
    expect(
        selected.map((s) => int.parse(s.videoId.substring(1))).toSet().length,
        4);
  });
}
