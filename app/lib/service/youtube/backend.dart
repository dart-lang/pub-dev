// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

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
    await retry(() async {
      final apiKey = Platform.environment['YOUTUBE_API_KEY'] ??
          await secretBackend.lookup(SecretKey.youtubeApiKey);
      if (apiKey == null || apiKey.isEmpty) return;

      final httpClient = httpRetryClient();
      final apiClient = clientViaApiKey(apiKey, baseClient: httpClient);
      final youtube = YoutubeApi(apiClient);
      await _updatePoWVideos(youtube);
      httpClient.close();
    });
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

  // TODO: implement randomized selection (but always keep the first item)
  List<PkgOfWeekVideo> getTopPackageOfWeekVideos({int count = 4}) {
    if (_packageOfWeekVideos == null) {
      return const <PkgOfWeekVideo>[];
    }
    return _packageOfWeekVideos.take(count).toList();
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
