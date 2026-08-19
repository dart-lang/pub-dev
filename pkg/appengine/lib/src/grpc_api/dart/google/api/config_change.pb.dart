//
//  Generated code. Do not modify.
//  source: google/api/config_change.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'config_change.pbenum.dart';

export 'config_change.pbenum.dart';

///  Output generated from semantically comparing two versions of a service
///  configuration.
///
///  Includes detailed information about a field that have changed with
///  applicable advice about potential consequences for the change, such as
///  backwards-incompatibility.
class ConfigChange extends $pb.GeneratedMessage {
  factory ConfigChange({
    $core.String? element,
    $core.String? oldValue,
    $core.String? newValue,
    ChangeType? changeType,
    $core.Iterable<Advice>? advices,
  }) {
    final $result = create();
    if (element != null) {
      $result.element = element;
    }
    if (oldValue != null) {
      $result.oldValue = oldValue;
    }
    if (newValue != null) {
      $result.newValue = newValue;
    }
    if (changeType != null) {
      $result.changeType = changeType;
    }
    if (advices != null) {
      $result.advices.addAll(advices);
    }
    return $result;
  }
  ConfigChange._() : super();
  factory ConfigChange.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ConfigChange.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfigChange',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'element')
    ..aOS(2, _omitFieldNames ? '' : 'oldValue')
    ..aOS(3, _omitFieldNames ? '' : 'newValue')
    ..e<ChangeType>(4, _omitFieldNames ? '' : 'changeType', $pb.PbFieldType.OE,
        defaultOrMaker: ChangeType.CHANGE_TYPE_UNSPECIFIED,
        valueOf: ChangeType.valueOf,
        enumValues: ChangeType.values)
    ..pc<Advice>(5, _omitFieldNames ? '' : 'advices', $pb.PbFieldType.PM,
        subBuilder: Advice.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ConfigChange clone() => ConfigChange()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ConfigChange copyWith(void Function(ConfigChange) updates) =>
      super.copyWith((message) => updates(message as ConfigChange))
          as ConfigChange;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfigChange create() => ConfigChange._();
  ConfigChange createEmptyInstance() => create();
  static $pb.PbList<ConfigChange> createRepeated() =>
      $pb.PbList<ConfigChange>();
  @$core.pragma('dart2js:noInline')
  static ConfigChange getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfigChange>(create);
  static ConfigChange? _defaultInstance;

  /// Object hierarchy path to the change, with levels separated by a '.'
  /// character. For repeated fields, an applicable unique identifier field is
  /// used for the index (usually selector, name, or id). For maps, the term
  /// 'key' is used. If the field has no unique identifier, the numeric index
  /// is used.
  /// Examples:
  /// - visibility.rules[selector=="google.LibraryService.ListBooks"].restriction
  /// - quota.metric_rules[selector=="google"].metric_costs[key=="reads"].value
  /// - logging.producer_destinations[0]
  @$pb.TagNumber(1)
  $core.String get element => $_getSZ(0);
  @$pb.TagNumber(1)
  set element($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasElement() => $_has(0);
  @$pb.TagNumber(1)
  void clearElement() => clearField(1);

  /// Value of the changed object in the old Service configuration,
  /// in JSON format. This field will not be populated if ChangeType == ADDED.
  @$pb.TagNumber(2)
  $core.String get oldValue => $_getSZ(1);
  @$pb.TagNumber(2)
  set oldValue($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOldValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearOldValue() => clearField(2);

  /// Value of the changed object in the new Service configuration,
  /// in JSON format. This field will not be populated if ChangeType == REMOVED.
  @$pb.TagNumber(3)
  $core.String get newValue => $_getSZ(2);
  @$pb.TagNumber(3)
  set newValue($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNewValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewValue() => clearField(3);

  /// The type for this change, either ADDED, REMOVED, or MODIFIED.
  @$pb.TagNumber(4)
  ChangeType get changeType => $_getN(3);
  @$pb.TagNumber(4)
  set changeType(ChangeType v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasChangeType() => $_has(3);
  @$pb.TagNumber(4)
  void clearChangeType() => clearField(4);

  /// Collection of advice provided for this change, useful for determining the
  /// possible impact of this change.
  @$pb.TagNumber(5)
  $core.List<Advice> get advices => $_getList(4);
}

/// Generated advice about this change, used for providing more
/// information about how a change will affect the existing service.
class Advice extends $pb.GeneratedMessage {
  factory Advice({
    $core.String? description,
  }) {
    final $result = create();
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  Advice._() : super();
  factory Advice.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Advice.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Advice',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Advice clone() => Advice()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Advice copyWith(void Function(Advice) updates) =>
      super.copyWith((message) => updates(message as Advice)) as Advice;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Advice create() => Advice._();
  Advice createEmptyInstance() => create();
  static $pb.PbList<Advice> createRepeated() => $pb.PbList<Advice>();
  @$core.pragma('dart2js:noInline')
  static Advice getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Advice>(create);
  static Advice? _defaultInstance;

  /// Useful description for why this advice was applied and what actions should
  /// be taken to mitigate any implied risks.
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(2)
  set description($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
