// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals

part of 'backend.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

SearchSnapshot _$SearchSnapshotFromJson(Map<String, dynamic> json) =>
    new SearchSnapshot()
      ..updated = DateTime.parse(json['updated'] as String)
      ..documents = (json['documents'] as Map<String, dynamic>).map((k, e) =>
          new MapEntry(
              k, new PackageDocument.fromJson(e as Map<String, dynamic>)));

abstract class _$SearchSnapshotSerializerMixin {
  DateTime get updated;
  Map<String, PackageDocument> get documents;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'updated': updated.toIso8601String(),
        'documents': documents
      };
}
