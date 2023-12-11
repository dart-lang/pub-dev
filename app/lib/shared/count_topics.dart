// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../frontend/static_files.dart';

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

typedef CanonicalTopic = ({
  String topic,
  String description,
  Set<String> aliases,
});

final canonicalTopics = () {
  try {
    final f = File(p.join(resolveAppDir(), '../doc/topics.yaml'));
    final root = loadYamlNode(f.readAsStringSync(), sourceUrl: f.uri);
    if (root is! YamlMap) {
      throw SourceSpanFormatException('expected a map', root.span);
    }
    if (root.keys.length > 1) {
      throw SourceSpanFormatException(
        'only the "topic" key is allowed',
        root.span,
      );
    }

    final topics = root.expectListOfObjects('topics');
    return UnmodifiableListView(topics.map<CanonicalTopic>((entry) {
      final topic = entry.expectString('topic', maxLength: 32);
      if (!isValidTopicFormat(topic)) {
        throw SourceSpanFormatException('must be valid topic', entry.span);
      }
      if (entry.keys.length > 3) {
        throw SourceSpanFormatException(
          'only keys "topic", "description" and "aliases" are allowed',
          entry.span,
        );
      }
      return (
        topic: topic,
        description: entry.expectString('description', maxLength: 160),
        aliases: Set.unmodifiable(entry.expectList('aliases').nodes.map((node) {
          final value = node.value;
          if (value is! String) {
            throw SourceSpanFormatException('must be a string', node.span);
          }
          if (!isValidTopicFormat(value)) {
            throw SourceSpanFormatException('must be valid topic', node.span);
          }
          return value;
        })),
      );
    }).toList(growable: false));
  } on Exception catch (e, st) {
    _log.shout('failed to load doc/topics.yaml', e, st);

    // This is sad, but we can just ignore it!
    return UnmodifiableListView(<CanonicalTopic>[]);
  }
}();

/// True, if [topic] is formatted like a valid topic.
bool isValidTopicFormat(String topic) =>
    RegExp(r'^[a-z0-9-]{2,32}$').hasMatch(topic) &&
    !topic.contains('--') &&
    topic.startsWith(RegExp(r'^[a-z]')) &&
    !topic.endsWith('-');

extension on YamlMap {
  YamlNode expectProperty(String key) {
    if (nodes[key] case final YamlNode v) return v;
    throw SourceSpanFormatException('expected a "$key" property', span);
  }

  YamlList expectList(String key) {
    final value = expectProperty(key);
    if (value case final YamlList v) return v;
    throw SourceSpanFormatException('"$key" must be a list', value.span);
  }

  Iterable<YamlMap> expectListOfObjects(String key) sync* {
    for (final entry in expectList(key).nodes) {
      if (entry is! YamlMap) {
        throw SourceSpanFormatException('expected an object', entry.span);
      }
      yield entry;
    }
  }

  String expectString(String key, {int? maxLength}) {
    final node = expectProperty(key);
    final value = node.value;
    if (value is! String) {
      throw SourceSpanFormatException('"$key" must be a string', node.span);
    }
    if (maxLength != null && value.length > maxLength) {
      throw SourceSpanFormatException(
        '"$key" must be shorter than $maxLength',
        node.span,
      );
    }
    return value;
  }
}
