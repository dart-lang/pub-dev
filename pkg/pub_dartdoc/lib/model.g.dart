// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals

part of 'model.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

PubDartdocData _$PubDartdocDataFromJson(Map<String, dynamic> json) {
  return new PubDartdocData(
      apiElements: (json['apiElements'] as List)
          ?.map((e) => e == null
              ? null
              : new ApiElement.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$PubDartdocDataSerializerMixin {
  List<ApiElement> get apiElements;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'apiElements': apiElements};
}

ApiElement _$ApiElementFromJson(Map<String, dynamic> json) {
  return new ApiElement(
      name: json['name'] as String,
      kind: json['kind'] as String,
      parent: json['parent'] as String,
      source: json['source'] as String,
      href: json['href'] as String,
      documentation: json['documentation'] as String);
}

abstract class _$ApiElementSerializerMixin {
  String get name;
  String get kind;
  String get parent;
  String get source;
  String get href;
  String get documentation;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{
      'name': name,
      'kind': kind,
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('parent', parent);
    val['source'] = source;
    writeNotNull('href', href);
    writeNotNull('documentation', documentation);
    return val;
  }
}
