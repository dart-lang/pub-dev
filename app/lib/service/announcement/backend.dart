// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:sanitize_html/sanitize_html.dart';

import '../../shared/cached_value.dart';
import '../secret/backend.dart';

/// Sets the announcement backend service.
void registerAnnouncementBackend(AnnouncementBackend backend) =>
    ss.register(#_announcementBackend, backend);

/// The active announcement backend service.
AnnouncementBackend get announcementBackend =>
    ss.lookup(#_announcementBackend) as AnnouncementBackend;

/// Represents the backend for the announcement handling and related utilities.
class AnnouncementBackend {
  final _announcementHtml = CachedValue<String>(
    name: 'announcement-html',
    maxAge: Duration(hours: 12),
    interval: Duration(minutes: 30),
    updateFn: () async {
      final value = await secretBackend.lookup(SecretKey.announcement);
      if (value != null && value.trim().isNotEmpty) {
        return sanitizeHtml(value.trim());
      } else {
        return null;
      }
    },
  );

  /// Update announcements regularly.
  Future<void> start() async {
    await _announcementHtml.update();
  }

  /// Cancel updates and free resources.
  Future<void> close() async {
    await _announcementHtml.close();
  }

  /// Returns the current announcement in sanitized HTML (if it is loaded).
  ///
  /// May be `null` if there is nothing to display.
  String? getAnnouncementHtml() {
    return _announcementHtml.isAvailable ? _announcementHtml.value : null;
  }
}
