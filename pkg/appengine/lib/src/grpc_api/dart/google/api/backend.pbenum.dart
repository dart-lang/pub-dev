//
//  Generated code. Do not modify.
//  source: google/api/backend.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  Path Translation specifies how to combine the backend address with the
///  request path in order to produce the appropriate forwarding URL for the
///  request.
///
///  Path Translation is applicable only to HTTP-based backends. Backends which
///  do not accept requests over HTTP/HTTPS should leave `path_translation`
///  unspecified.
class BackendRule_PathTranslation extends $pb.ProtobufEnum {
  static const BackendRule_PathTranslation PATH_TRANSLATION_UNSPECIFIED =
      BackendRule_PathTranslation._(
          0, _omitEnumNames ? '' : 'PATH_TRANSLATION_UNSPECIFIED');
  static const BackendRule_PathTranslation CONSTANT_ADDRESS =
      BackendRule_PathTranslation._(
          1, _omitEnumNames ? '' : 'CONSTANT_ADDRESS');
  static const BackendRule_PathTranslation APPEND_PATH_TO_ADDRESS =
      BackendRule_PathTranslation._(
          2, _omitEnumNames ? '' : 'APPEND_PATH_TO_ADDRESS');

  static const $core.List<BackendRule_PathTranslation> values =
      <BackendRule_PathTranslation>[
    PATH_TRANSLATION_UNSPECIFIED,
    CONSTANT_ADDRESS,
    APPEND_PATH_TO_ADDRESS,
  ];

  static final $core.Map<$core.int, BackendRule_PathTranslation> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static BackendRule_PathTranslation? valueOf($core.int value) =>
      _byValue[value];

  const BackendRule_PathTranslation._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
