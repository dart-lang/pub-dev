//
//  Generated code. Do not modify.
//  source: google/appengine/v1/location.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Metadata for the given [google.cloud.location.Location][google.cloud.location.Location].
class LocationMetadata extends $pb.GeneratedMessage {
  factory LocationMetadata({
    $core.bool? standardEnvironmentAvailable,
    $core.bool? flexibleEnvironmentAvailable,
    $core.bool? searchApiAvailable,
  }) {
    final $result = create();
    if (standardEnvironmentAvailable != null) {
      $result.standardEnvironmentAvailable = standardEnvironmentAvailable;
    }
    if (flexibleEnvironmentAvailable != null) {
      $result.flexibleEnvironmentAvailable = flexibleEnvironmentAvailable;
    }
    if (searchApiAvailable != null) {
      $result.searchApiAvailable = searchApiAvailable;
    }
    return $result;
  }
  LocationMetadata._() : super();
  factory LocationMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LocationMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LocationMetadata',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.appengine.v1'),
      createEmptyInstance: create)
    ..aOB(2, _omitFieldNames ? '' : 'standardEnvironmentAvailable')
    ..aOB(4, _omitFieldNames ? '' : 'flexibleEnvironmentAvailable')
    ..aOB(6, _omitFieldNames ? '' : 'searchApiAvailable')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LocationMetadata clone() => LocationMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LocationMetadata copyWith(void Function(LocationMetadata) updates) =>
      super.copyWith((message) => updates(message as LocationMetadata))
          as LocationMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LocationMetadata create() => LocationMetadata._();
  LocationMetadata createEmptyInstance() => create();
  static $pb.PbList<LocationMetadata> createRepeated() =>
      $pb.PbList<LocationMetadata>();
  @$core.pragma('dart2js:noInline')
  static LocationMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LocationMetadata>(create);
  static LocationMetadata? _defaultInstance;

  ///  App Engine standard environment is available in the given location.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(2)
  $core.bool get standardEnvironmentAvailable => $_getBF(0);
  @$pb.TagNumber(2)
  set standardEnvironmentAvailable($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasStandardEnvironmentAvailable() => $_has(0);
  @$pb.TagNumber(2)
  void clearStandardEnvironmentAvailable() => clearField(2);

  ///  App Engine flexible environment is available in the given location.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(4)
  $core.bool get flexibleEnvironmentAvailable => $_getBF(1);
  @$pb.TagNumber(4)
  set flexibleEnvironmentAvailable($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFlexibleEnvironmentAvailable() => $_has(1);
  @$pb.TagNumber(4)
  void clearFlexibleEnvironmentAvailable() => clearField(4);

  /// Output only. [Search API](https://cloud.google.com/appengine/docs/standard/python/search)
  /// is available in the given location.
  @$pb.TagNumber(6)
  $core.bool get searchApiAvailable => $_getBF(2);
  @$pb.TagNumber(6)
  set searchApiAvailable($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSearchApiAvailable() => $_has(2);
  @$pb.TagNumber(6)
  void clearSearchApiAvailable() => clearField(6);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
