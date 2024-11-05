// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'completion.g.dart';

@JsonSerializable()
class CompletionData {
  final List<CompletionRule> completions;

  CompletionData({
    required this.completions,
  });

  factory CompletionData.fromJson(Map<String, dynamic> json) =>
      _$CompletionDataFromJson(json);
  Map<String, dynamic> toJson() => _$CompletionDataToJson(this);
}

/// The match trigger automatic completion (except empty match).
/// Example: `platform:` or `platform:win`
/// Match and an option must be combined to form a keyword.
/// Example: `platform:windows`
@JsonSerializable()
class CompletionRule {
  final Set<String> match;
  final List<String> options;

  /// Add whitespace when completing.
  final bool terminal;

  /// Only display this when forced to match.
  final bool forcedOnly;

  CompletionRule({
    this.match = const <String>{},
    this.options = const <String>[],
    this.terminal = true,
    this.forcedOnly = false,
  });

  factory CompletionRule.fromJson(Map<String, dynamic> json) =>
      _$CompletionRuleFromJson(json);
  Map<String, dynamic> toJson() => _$CompletionRuleToJson(this);
}
