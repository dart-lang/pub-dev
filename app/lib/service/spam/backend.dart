// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';

import '../secret/backend.dart';

/// Sets the spam backend service.
void registerSpamBackend(SpamBackend backend) =>
    ss.register(#_spamBackend, backend);

/// The active spam backend service.
SpamBackend get spamBackend => ss.lookup(#_spamBackend) as SpamBackend;

/// Represents the backend for the spam filtering and related config handling.
class SpamBackend {
  List<String> _spamWords;
  Timer _updateTimer;

  /// Loads the active spam config from Datastore.
  Future<void> update() async {
    final value = await secretBackend.lookup(SecretKey.spamWords);
    if (value != null && value.trim().isNotEmpty) {
      _spamWords = _parseSpamWords(value.trim());
    } else {
      _spamWords = null;
    }
  }

  /// Sets a timer to update spam config regularly.
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

  /// Sets the current spam config.
  void setSpamConfig({@required List<String> spamWords}) async {
    _spamWords = spamWords?.map((e) => e.toLowerCase())?.toList();
  }

  /// Decides whether the provided content is spam.
  bool isSpam(String content) {
    if (content == null) return false;
    final lc = content.toLowerCase();
    return _spamWords != null && _spamWords.any(lc.contains);
  }
}

List<String> _parseSpamWords(String value) {
  if (value.startsWith('[') && value.endsWith(']')) {
    final list = json.decode(value) as List;
    return list
        .where((e) => e != null)
        .map((s) => s.toString())
        .where((s) => s.isNotEmpty)
        .toList();
  } else {
    return value.split(' ').where((s) => s.isNotEmpty).toList();
  }
}
