//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/operation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Defines the importance of the data contained in the operation.
class Operation_Importance extends $pb.ProtobufEnum {
  static const Operation_Importance LOW =
      Operation_Importance._(0, _omitEnumNames ? '' : 'LOW');
  static const Operation_Importance HIGH =
      Operation_Importance._(1, _omitEnumNames ? '' : 'HIGH');

  static const $core.List<Operation_Importance> values = <Operation_Importance>[
    LOW,
    HIGH,
  ];

  static final $core.Map<$core.int, Operation_Importance> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Operation_Importance? valueOf($core.int value) => _byValue[value];

  const Operation_Importance._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
