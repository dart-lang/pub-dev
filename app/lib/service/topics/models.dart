// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'models.g.dart';

@JsonSerializable(
  checked: true,
  explicitToJson: true,
  disallowUnrecognizedKeys: true,
)
class CanonicalTopicFileContent {
  final List<CanonicalTopic> topics;

  CanonicalTopicFileContent({
    required this.topics,
  });

  factory CanonicalTopicFileContent.fromJson(Map<String, Object?> json) =>
      _$CanonicalTopicFileContentFromJson(json);

  factory CanonicalTopicFileContent.fromYaml(String content) {
    return CanonicalTopicFileContent.fromJson(
        json.decode(json.encode(loadYaml(content))) as Map<String, Object?>);
  }

  Map<String, Object?> toJson() => _$CanonicalTopicFileContentToJson(this);
}

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
