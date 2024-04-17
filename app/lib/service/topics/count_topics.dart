// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/topics/models.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';

import '../../frontend/static_files.dart';

final topicsJsonFileName = 'topics.json';

final _log = Logger('count_topics');

Future<void> countTopics() async {
  final topics = <String, int>{};

  final pq = dbService.query<Package>();
  await for (final p in pq.run()) {
    final v =
        await packageBackend.lookupPackageVersion(p.name!, p.latestVersion!);

    if (v!.pubspec!.topics != null) {
      for (final t in v.pubspec!.topics!) {
        topics.update(t, (value) => value + 1, ifAbsent: () => 1);
      }
    }
  }

  final reportsBucket =
      storageService.bucket(activeConfiguration.reportsBucketName!);
  await uploadBytesWithRetry(
      reportsBucket, topicsJsonFileName, jsonUtf8Encoder.convert(topics));
}

void _verifyContent(CanonicalTopicFileContent content) {
  for (final topic in content.topics) {
    if (topic.topic.length > 32) {
      throw FormatException(
          '"${topic.topic}" must be shorter than 32 characters.');
    }
    if (!isValidTopicFormat(topic.topic)) {
      throw FormatException('"${topic.topic}" must be valid topic.');
    }
    if (topic.description.length > 160) {
      throw FormatException(
          '"${topic.topic}" description must be shorter than 160 characters.');
    }
    for (final alias in topic.aliases) {
      if (!isValidTopicFormat(alias)) {
        throw FormatException(
            '"${topic.topic}" must have valid aliases ("$alias").');
      }
    }
  }
}

final canonicalTopics = () {
  try {
    final f = File(p.join(resolveAppDir(), '../doc/topics.yaml'));
    final content = CanonicalTopicFileContent.fromYaml(f.readAsStringSync());
    _verifyContent(content);
    return content;
  } on Exception catch (e, st) {
    _log.shout('failed to load doc/topics.yaml', e, st);

    // This is sad, but we can just ignore it!
    return CanonicalTopicFileContent(topics: <CanonicalTopic>[]);
  }
}();

/// True, if [topic] is formatted like a valid topic.
bool isValidTopicFormat(String topic) =>
    RegExp(r'^[a-z0-9-]{2,32}$').hasMatch(topic) &&
    !topic.contains('--') &&
    topic.startsWith(RegExp(r'^[a-z]')) &&
    !topic.endsWith('-');
