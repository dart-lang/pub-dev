//
//  Generated code. Do not modify.
//  source: google/api/log.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'label.pb.dart' as $65;

///  A description of a log type. Example in YAML format:
///
///      - name: library.googleapis.com/activity_history
///        description: The history of borrowing and returning library items.
///        display_name: Activity
///        labels:
///        - key: /customer_id
///          description: Identifier of a library customer
class LogDescriptor extends $pb.GeneratedMessage {
  factory LogDescriptor({
    $core.String? name,
    $core.Iterable<$65.LabelDescriptor>? labels,
    $core.String? description,
    $core.String? displayName,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (description != null) {
      $result.description = description;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    return $result;
  }
  LogDescriptor._() : super();
  factory LogDescriptor.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LogDescriptor.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogDescriptor',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<$65.LabelDescriptor>(
        2, _omitFieldNames ? '' : 'labels', $pb.PbFieldType.PM,
        subBuilder: $65.LabelDescriptor.create)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'displayName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LogDescriptor clone() => LogDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LogDescriptor copyWith(void Function(LogDescriptor) updates) =>
      super.copyWith((message) => updates(message as LogDescriptor))
          as LogDescriptor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogDescriptor create() => LogDescriptor._();
  LogDescriptor createEmptyInstance() => create();
  static $pb.PbList<LogDescriptor> createRepeated() =>
      $pb.PbList<LogDescriptor>();
  @$core.pragma('dart2js:noInline')
  static LogDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogDescriptor>(create);
  static LogDescriptor? _defaultInstance;

  /// The name of the log. It must be less than 512 characters long and can
  /// include the following characters: upper- and lower-case alphanumeric
  /// characters [A-Za-z0-9], and punctuation characters including
  /// slash, underscore, hyphen, period [/_-.].
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// The set of labels that are available to describe a specific log entry.
  /// Runtime requests that contain labels not specified here are
  /// considered invalid.
  @$pb.TagNumber(2)
  $core.List<$65.LabelDescriptor> get labels => $_getList(1);

  /// A human-readable description of this log. This information appears in
  /// the documentation and can contain details.
  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  /// The human-readable name for this log. This information appears on
  /// the user interface and should be concise.
  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => clearField(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
