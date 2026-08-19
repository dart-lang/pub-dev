//
//  Generated code. Do not modify.
//  source: google/appengine/legacy/audit_data.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Admin Console legacy audit log.
class AuditData extends $pb.GeneratedMessage {
  factory AuditData({
    $core.String? eventMessage,
    $core.Map<$core.String, $core.String>? eventData,
  }) {
    final $result = create();
    if (eventMessage != null) {
      $result.eventMessage = eventMessage;
    }
    if (eventData != null) {
      $result.eventData.addAll(eventData);
    }
    return $result;
  }
  AuditData._() : super();
  factory AuditData.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuditData.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuditData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.legacy'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventMessage')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'eventData',
        entryClassName: 'AuditData.EventDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.appengine.legacy'))
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuditData clone() => AuditData()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuditData copyWith(void Function(AuditData) updates) =>
      super.copyWith((message) => updates(message as AuditData)) as AuditData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditData create() => AuditData._();
  AuditData createEmptyInstance() => create();
  static $pb.PbList<AuditData> createRepeated() => $pb.PbList<AuditData>();
  @$core.pragma('dart2js:noInline')
  static AuditData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuditData>(create);
  static AuditData? _defaultInstance;

  /// Text description of the admin event.
  /// This is the "Event" column in Admin Console's Admin Logs.
  @$pb.TagNumber(1)
  $core.String get eventMessage => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventMessage($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEventMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventMessage() => clearField(1);

  /// Arbitrary event data.
  /// This is the "Result" column in Admin Console's Admin Logs.
  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get eventData => $_getMap(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
