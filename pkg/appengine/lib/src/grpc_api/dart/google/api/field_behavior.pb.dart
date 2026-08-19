//
//  Generated code. Do not modify.
//  source: google/api/field_behavior.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'field_behavior.pbenum.dart';

export 'field_behavior.pbenum.dart';

class Field_behavior {
  static final fieldBehavior = $pb.Extension<FieldBehavior>.repeated(
      _omitMessageNames ? '' : 'google.protobuf.FieldOptions',
      _omitFieldNames ? '' : 'fieldBehavior',
      1052,
      $pb.PbFieldType.PE,
      check: $pb.getCheckFunction($pb.PbFieldType.PE),
      valueOf: FieldBehavior.valueOf,
      enumValues: FieldBehavior.values);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(fieldBehavior);
  }
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
