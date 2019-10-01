// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'pub_dartdoc_data.g.dart';

@JsonSerializable()
class PubDartdocData {
  /// Coverage may be non-existent in `pub-data.json` created with runtime
  /// before version `2019.09.30`.
  /// TODO: remove this note after we've deprecated that runtime version.
  final Coverage coverage;
  final List<ApiElement> apiElements;

  PubDartdocData({
    @required this.coverage,
    @required this.apiElements,
  });

  factory PubDartdocData.fromJson(Map<String, dynamic> json) =>
      _$PubDartdocDataFromJson(json);

  Map<String, dynamic> toJson() => _$PubDartdocDataToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ApiElement {
  /// The last part of the [qualifiedName].
  final String name;
  final String kind;
  final String parent;
  final String source;
  final String href;
  String documentation;

  ApiElement({
    @required this.name,
    @required this.kind,
    @required this.parent,
    @required this.source,
    @required this.href,
    @required this.documentation,
  });

  factory ApiElement.fromJson(Map<String, dynamic> json) {
    // Previous data entries may contain the fully qualified name, we need to
    // transform them to the simple version.
    if (json.containsKey('name')) {
      json['name'] = (json['name'] as String).split('.').last;
    }
    return _$ApiElementFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiElementToJson(this);

  String get qualifiedName => parent == null ? name : '$parent.$name';
}

/// The documentation coverage numbers and the derived scores.
@JsonSerializable()
class Coverage {
  /// The number of API elements.
  final int total;

  /// The number of API elements with accepted documentation.
  final int documented;

  Coverage({
    @required this.total,
    @required this.documented,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) =>
      _$CoverageFromJson(json);

  Map<String, dynamic> toJson() => _$CoverageToJson(this);

  /// The coverage percent [0.0 - 1.0].
  double get percent {
    if (total == documented) {
      // this also handles total == 0
      return 1.0;
    } else {
      return documented / total;
    }
  }

  /// The coverage score [0.0 - 1.0].
  double get score {
    // 0.01 percent -> 0.03 score -> 9.7 penalty
    // 0.02 percent -> 0.06 score -> 9.4 penalty
    // 0.03 percent -> 0.09 score -> 9.1 penalty
    // 0.05 percent -> 0.14 score -> 8.6 penalty
    // 0.10 percent -> 0.27 score -> 7.3 penalty
    // 0.20 percent -> 0.49 score -> 5.1 penalty
    // 0.30 percent -> 0.66 score -> 3.4 penalty
    // 0.50 percent -> 0.88 score -> 1.2 penalty
    // 0.75 percent -> 0.98 score -> 0.2 penalty
    return 1.0 - pow(1.0 - percent, 3);
  }

  /// The coverage penalty [0.0 - 10.0].
  double get penalty {
    // Reducing coverage penalty in order to ease-in the introduction of it.
    final fullPenalty = (1.0 - score) * 10.0;
    return max(0.0, fullPenalty - 9.0);
  }
}
