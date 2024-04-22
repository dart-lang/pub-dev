// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/frontend/static_files.dart';
import 'package:yaml/yaml.dart';

part 'models.g.dart';

final _log = Logger('topics');

late final canonicalTopics = () {
  try {
    final f = File(p.join(resolveAppDir(), '../doc/topics.yaml'));
    return CanonicalTopicFileContent.fromYaml(f.readAsStringSync());
  } on Exception catch (e, st) {
    _log.shout('failed to load doc/topics.yaml', e, st);

    // This is sad, but we can just ignore it!
    return CanonicalTopicFileContent(topics: <CanonicalTopic>[]);
  }
}();

@JsonSerializable(
  checked: true,
  explicitToJson: true,
  disallowUnrecognizedKeys: true,
)
class CanonicalTopicFileContent {
  final List<CanonicalTopic> topics;

  CanonicalTopicFileContent({
    required this.topics,
  }) {
    // verify that content is with the correct semantics
    for (final topic in topics) {
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
    // also check for alias map built successfully
    if (aliasToCanonicalMap.isEmpty) {
      throw FormatException('Expected to have at least one alias.');
    }
  }

  factory CanonicalTopicFileContent.fromJson(Map<String, Object?> json) =>
      _$CanonicalTopicFileContentFromJson(json);

  factory CanonicalTopicFileContent.fromYaml(String content) {
    return CanonicalTopicFileContent.fromJson(
        json.decode(json.encode(loadYaml(content))) as Map<String, Object?>);
  }

  Map<String, Object?> toJson() => _$CanonicalTopicFileContentToJson(this);

  late final aliasToCanonicalMap = () {
    final map = <String, String>{};
    for (final t in topics) {
      for (final alias in t.aliases) {
        if (map.containsKey(alias)) {
          throw FormatException('"$alias" has more than one canonical topic.');
        }
        map[alias] = t.topic;
      }
    }
    return map;
  }();
}

/// True, if [topic] is formatted like a valid topic.
@visibleForTesting
bool isValidTopicFormat(String topic) =>
    RegExp(r'^[a-z0-9-]{2,32}$').hasMatch(topic) &&
    !topic.contains('--') &&
    topic.startsWith(RegExp(r'^[a-z]')) &&
    !topic.endsWith('-');

@JsonSerializable(
  checked: true,
  explicitToJson: true,
  disallowUnrecognizedKeys: true,
)
class CanonicalTopic {
  final String topic;
  final String description;
  final Set<String> aliases;

  CanonicalTopic({
    required this.topic,
    required this.description,
    required this.aliases,
  });

  factory CanonicalTopic.fromJson(Map<String, Object?> json) =>
      _$CanonicalTopicFromJson(json);

  Map<String, Object?> toJson() => _$CanonicalTopicToJson(this);
}
