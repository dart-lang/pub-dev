//
//  Generated code. Do not modify.
//  source: google/protobuf/any_test.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'any.pb.dart' as $49;

class TestAny extends $pb.GeneratedMessage {
  factory TestAny({
    $core.int? int32Value,
    $49.Any? anyValue,
    $core.Iterable<$49.Any>? repeatedAnyValue,
    $core.String? text,
  }) {
    final $result = create();
    if (int32Value != null) {
      $result.int32Value = int32Value;
    }
    if (anyValue != null) {
      $result.anyValue = anyValue;
    }
    if (repeatedAnyValue != null) {
      $result.repeatedAnyValue.addAll(repeatedAnyValue);
    }
    if (text != null) {
      $result.text = text;
    }
    return $result;
  }
  TestAny._() : super();
  factory TestAny.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAny.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAny',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'protobuf_unittest'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'int32Value', $pb.PbFieldType.O3)
    ..aOM<$49.Any>(2, _omitFieldNames ? '' : 'anyValue',
        subBuilder: $49.Any.create)
    ..pc<$49.Any>(
        3, _omitFieldNames ? '' : 'repeatedAnyValue', $pb.PbFieldType.PM,
        subBuilder: $49.Any.create)
    ..aOS(4, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAny clone() => TestAny()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAny copyWith(void Function(TestAny) updates) =>
      super.copyWith((message) => updates(message as TestAny)) as TestAny;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAny create() => TestAny._();
  TestAny createEmptyInstance() => create();
  static $pb.PbList<TestAny> createRepeated() => $pb.PbList<TestAny>();
  @$core.pragma('dart2js:noInline')
  static TestAny getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestAny>(create);
  static TestAny? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get int32Value => $_getIZ(0);
  @$pb.TagNumber(1)
  set int32Value($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasInt32Value() => $_has(0);
  @$pb.TagNumber(1)
  void clearInt32Value() => clearField(1);

  @$pb.TagNumber(2)
  $49.Any get anyValue => $_getN(1);
  @$pb.TagNumber(2)
  set anyValue($49.Any v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasAnyValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnyValue() => clearField(2);
  @$pb.TagNumber(2)
  $49.Any ensureAnyValue() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$49.Any> get repeatedAnyValue => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get text => $_getSZ(3);
  @$pb.TagNumber(4)
  set text($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasText() => $_has(3);
  @$pb.TagNumber(4)
  void clearText() => clearField(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
