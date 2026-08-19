//
//  Generated code. Do not modify.
//  source: google/api/client.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The organization for which the client libraries are being published.
/// Affects the url where generated docs are published, etc.
class ClientLibraryOrganization extends $pb.ProtobufEnum {
  static const ClientLibraryOrganization
      CLIENT_LIBRARY_ORGANIZATION_UNSPECIFIED = ClientLibraryOrganization._(
          0, _omitEnumNames ? '' : 'CLIENT_LIBRARY_ORGANIZATION_UNSPECIFIED');
  static const ClientLibraryOrganization CLOUD =
      ClientLibraryOrganization._(1, _omitEnumNames ? '' : 'CLOUD');
  static const ClientLibraryOrganization ADS =
      ClientLibraryOrganization._(2, _omitEnumNames ? '' : 'ADS');
  static const ClientLibraryOrganization PHOTOS =
      ClientLibraryOrganization._(3, _omitEnumNames ? '' : 'PHOTOS');
  static const ClientLibraryOrganization STREET_VIEW =
      ClientLibraryOrganization._(4, _omitEnumNames ? '' : 'STREET_VIEW');
  static const ClientLibraryOrganization SHOPPING =
      ClientLibraryOrganization._(5, _omitEnumNames ? '' : 'SHOPPING');
  static const ClientLibraryOrganization GEO =
      ClientLibraryOrganization._(6, _omitEnumNames ? '' : 'GEO');
  static const ClientLibraryOrganization GENERATIVE_AI =
      ClientLibraryOrganization._(7, _omitEnumNames ? '' : 'GENERATIVE_AI');

  static const $core.List<ClientLibraryOrganization> values =
      <ClientLibraryOrganization>[
    CLIENT_LIBRARY_ORGANIZATION_UNSPECIFIED,
    CLOUD,
    ADS,
    PHOTOS,
    STREET_VIEW,
    SHOPPING,
    GEO,
    GENERATIVE_AI,
  ];

  static final $core.Map<$core.int, ClientLibraryOrganization> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ClientLibraryOrganization? valueOf($core.int value) => _byValue[value];

  const ClientLibraryOrganization._($core.int v, $core.String n) : super(v, n);
}

/// To where should client libraries be published?
class ClientLibraryDestination extends $pb.ProtobufEnum {
  static const ClientLibraryDestination CLIENT_LIBRARY_DESTINATION_UNSPECIFIED =
      ClientLibraryDestination._(
          0, _omitEnumNames ? '' : 'CLIENT_LIBRARY_DESTINATION_UNSPECIFIED');
  static const ClientLibraryDestination GITHUB =
      ClientLibraryDestination._(10, _omitEnumNames ? '' : 'GITHUB');
  static const ClientLibraryDestination PACKAGE_MANAGER =
      ClientLibraryDestination._(20, _omitEnumNames ? '' : 'PACKAGE_MANAGER');

  static const $core.List<ClientLibraryDestination> values =
      <ClientLibraryDestination>[
    CLIENT_LIBRARY_DESTINATION_UNSPECIFIED,
    GITHUB,
    PACKAGE_MANAGER,
  ];

  static final $core.Map<$core.int, ClientLibraryDestination> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ClientLibraryDestination? valueOf($core.int value) => _byValue[value];

  const ClientLibraryDestination._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
