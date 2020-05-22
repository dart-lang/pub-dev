// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;

import '../secret/backend.dart';

/// Sets the announcement backend service.
void registerAnnouncementBackend(AnnouncementBackend backend) =>
    ss.register(#_announcementBackend, backend);

/// The active announcement backend service.
AnnouncementBackend get announcementBackend =>
    ss.lookup(#_announcementBackend) as AnnouncementBackend;

/// Represents the backend for the announcement handling and related utilities.
class AnnouncementBackend {
  String _announcementHtml;
  Timer _updateTimer;

  /// Loads the active announcement from Datastore.
  Future<void> update() async {
    final value = await secretBackend.lookup(SecretKey.announcement);
    if (value != null && value.trim().isNotEmpty) {
      _announcementHtml = value.trim();
    }
  }

  /// Sets a timer to update announcements regularly.
  void scheduleRegularUpdates() {
    _updateTimer = Timer.periodic(Duration(minutes: 10), (_) async {
      await update();
    });
  }

  /// Cancel timer and free resources.
  Future<void> close() async {
    _updateTimer?.cancel();
    _updateTimer = null;
  }

  /// Returns the current announcement in sanitized HTML (if it is loaded).
  ///
  /// May be `null` if there is nothing to display.
  String getAnnouncementHtml() {
    return _announcementHtml;
  }

  /// Sets the current announcement.
  /// [value] must be sanitized HTML from trusted source.
  Future<void> setAnnouncementHtml(String value) async {
    _announcementHtml = value;
  }
}
