// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_dev/shared/popularity_storage.dart';

import 'search_service.dart';

part 'models.g.dart';

@JsonSerializable()
class SearchSnapshot {
  DateTime? updated;
  Map<String, PackageDocument>? documents;

  SearchSnapshot._(this.updated, this.documents);

  factory SearchSnapshot() => SearchSnapshot._(clock.now().toUtc(), {});

  factory SearchSnapshot.fromJson(Map<String, dynamic> json) =>
      _$SearchSnapshotFromJson(json);

  void add(PackageDocument doc) {
    updated = clock.now().toUtc();
    documents![doc.package] = doc;
  }

  void remove(String packageName) {
    updated = clock.now().toUtc();
    documents!.remove(packageName);
  }

  /// Updates the PackageDocument.likeScore for each package in the snapshot.
  /// The score is normalized into the range of [0.0 - 1.0] using the
  /// ordered list of packages by like counts (same like count gets the same score).
  void updateLikeScores() {
    documents!.values.updateLikeScores();
  }

  /// Updates all popularity values to the currently cached one, otherwise
  /// only updated package would have been on their new values.
  void updatePopularityScores() {
    for (final d in documents!.values) {
      if (popularityStorage.isInvalid) {
        d.popularityScore = d.likeScore;
      } else {
        d.popularityScore = popularityStorage.lookup(d.package);
      }
    }
  }

  Map<String, dynamic> toJson() => _$SearchSnapshotToJson(this);
}

extension UpdateLikesExt on Iterable<PackageDocument> {
  /// Updates the PackageDocument.likeScore for each package in the snapshot.
  /// The score is normalized into the range of [0.0 - 1.0] using the
  /// ordered list of packages by like counts (same like count gets the same score).
  void updateLikeScores() {
    final sortedByLikes = List<PackageDocument>.from(this)
      ..sort((a, b) => a.likeCount.compareTo(b.likeCount));
    for (var i = 0; i < sortedByLikes.length; i++) {
      if (i > 0 &&
          sortedByLikes[i - 1].likeCount == sortedByLikes[i].likeCount) {
        sortedByLikes[i].likeScore = sortedByLikes[i - 1].likeScore;
      } else {
        sortedByLikes[i].likeScore = (i + 1) / sortedByLikes.length;
      }
    }
  }
}
