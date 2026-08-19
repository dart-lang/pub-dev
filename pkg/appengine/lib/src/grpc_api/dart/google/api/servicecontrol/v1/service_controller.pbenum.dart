//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/service_controller.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The type of the consumer as defined in
/// [Google Resource Manager](https://cloud.google.com/resource-manager/).
class CheckResponse_ConsumerInfo_ConsumerType extends $pb.ProtobufEnum {
  static const CheckResponse_ConsumerInfo_ConsumerType
      CONSUMER_TYPE_UNSPECIFIED = CheckResponse_ConsumerInfo_ConsumerType._(
          0, _omitEnumNames ? '' : 'CONSUMER_TYPE_UNSPECIFIED');
  static const CheckResponse_ConsumerInfo_ConsumerType PROJECT =
      CheckResponse_ConsumerInfo_ConsumerType._(
          1, _omitEnumNames ? '' : 'PROJECT');
  static const CheckResponse_ConsumerInfo_ConsumerType FOLDER =
      CheckResponse_ConsumerInfo_ConsumerType._(
          2, _omitEnumNames ? '' : 'FOLDER');
  static const CheckResponse_ConsumerInfo_ConsumerType ORGANIZATION =
      CheckResponse_ConsumerInfo_ConsumerType._(
          3, _omitEnumNames ? '' : 'ORGANIZATION');
  static const CheckResponse_ConsumerInfo_ConsumerType SERVICE_SPECIFIC =
      CheckResponse_ConsumerInfo_ConsumerType._(
          4, _omitEnumNames ? '' : 'SERVICE_SPECIFIC');

  static const $core.List<CheckResponse_ConsumerInfo_ConsumerType> values =
      <CheckResponse_ConsumerInfo_ConsumerType>[
    CONSUMER_TYPE_UNSPECIFIED,
    PROJECT,
    FOLDER,
    ORGANIZATION,
    SERVICE_SPECIFIC,
  ];

  static final $core.Map<$core.int, CheckResponse_ConsumerInfo_ConsumerType>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static CheckResponse_ConsumerInfo_ConsumerType? valueOf($core.int value) =>
      _byValue[value];

  const CheckResponse_ConsumerInfo_ConsumerType._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
