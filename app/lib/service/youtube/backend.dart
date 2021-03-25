// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/youtube/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:meta/meta.dart';
import 'package:retry/retry.dart';

import '../../tool/utils/http.dart';
import '../secret/backend.dart';

/// The playlist ID for the Package of the Week channel.
const powPlaylistId = 'PLjxrf2q8roU1quF6ny8oFHJ2gBdrYN_AK';

/// Sets the Youtube backend service.
void registerYoutubeBackend(YoutubeBackend backend) =>
    ss.register(#_youtubeBackend, backend);

/// The active Youtube backend service.
YoutubeBackend get youtubeBackend =>
    ss.lookup(#_youtubeBackend) as YoutubeBackend;

/// Represents the backend for the Youtube handling and related utilities.
class YoutubeBackend {
  List<PkgOfWeekVideo> _packageOfWeekVideos;
  Timer _updateTimer;

  /// Loads the data from Youtube and caches locally.
  Future<void> update() async {
    /*
    await retry(() async {
      final apiKey = Platform.environment['YOUTUBE_API_KEY'] ??
          await secretBackend.lookup(SecretKey.youtubeApiKey);
      if (apiKey == null || apiKey.isEmpty) return;

      final httpClient = httpRetryClient();
      final apiClient = clientViaApiKey(apiKey, baseClient: httpClient);
      final youtube = YoutubeApi(apiClient);
      await _updatePoWVideos(youtube);
      httpClient.close();
    });*/
  }

  Future _updatePoWVideos(YoutubeApi youtube) async {
    final videos = <PkgOfWeekVideo>[];
    String nextPageToken;
    for (var check = true; check && videos.length < 50;) {
      final rs = await youtube.playlistItems.list(
        'snippet,contentDetails',
        playlistId: powPlaylistId,
      );
      videos.addAll(rs.items.map(
        (i) => PkgOfWeekVideo(
          videoId: i.contentDetails.videoId,
          title: i.snippet.title,
          description: (i.snippet.description ?? '').trim().split('\n').first,
          thumbnailUrl: i.snippet.thumbnails.high.url,
        ),
      ));
      // next page
      nextPageToken = rs.nextPageToken;
      check = nextPageToken != null && nextPageToken.isNotEmpty;
    }
    setPackageOfWeekVideos(videos);
  }

  /// Sets a timer to update data from Youtube regularly.
  void scheduleRegularUpdates() {
    _updateTimer = Timer.periodic(Duration(minutes: 60), (_) async {
      await update();
    });
  }

  /// Sets the list of PoW videos to a fixed value.
  void setPackageOfWeekVideos(List<PkgOfWeekVideo> videos) {
    _packageOfWeekVideos = videos;
  }

  /// Returns a randomized selection from the list of videos.
  /// - The first item will be always kept as the first selected.
  /// - The second item will be selected from items #1-#3. (from the last month)
  /// - The rest of the items selection will be selected randomly.
  /// - Random seed changes hourly.
  List<PkgOfWeekVideo> getTopPackageOfWeekVideos({
    int count = 4,
    math.Random random,
  }) {
    return const <PkgOfWeekVideo>[];
    /*
    if (_packageOfWeekVideos == null) {
      return const <PkgOfWeekVideo>[];
    }
    final now = DateTime.now().toUtc();
    random ??= math.Random(
        now.year * 1000 + now.month * 100 + now.day * 10 + now.hour);
    final selectable = List<PkgOfWeekVideo>.from(_packageOfWeekVideos);
    final selected = <PkgOfWeekVideo>[];
    while (selected.length < count && selectable.isNotEmpty) {
      if (selected.isEmpty) {
        selected.add(selectable.removeAt(0));
      } else if (selected.length == 1) {
        final s =
            selectable.removeAt(random.nextInt(math.min(3, selectable.length)));
        selected.add(s);
      } else {
        selected.add(selectable.removeAt(random.nextInt(selectable.length)));
      }
    }
    return selected;*/
  }

  /// Cancel timer and free resources.
  Future<void> close() async {
    _updateTimer?.cancel();
    _updateTimer = null;
  }
}

class PkgOfWeekVideo {
  final String videoId;
  final String title;
  final String description;
  final String thumbnailUrl;

  PkgOfWeekVideo({
    @required this.videoId,
    @required this.title,
    @required this.description,
    @required this.thumbnailUrl,
  });

  String get videoUrl => Uri(
        scheme: 'https',
        host: 'youtube.com',
        path: '/watch',
        queryParameters: {
          'v': videoId,
          'list': powPlaylistId,
        },
      ).toString();
}
