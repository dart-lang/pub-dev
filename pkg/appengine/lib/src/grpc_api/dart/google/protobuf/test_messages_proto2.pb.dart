//
//  Generated code. Do not modify.
//  source: google/protobuf/test_messages_proto2.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'test_messages_proto2.pbenum.dart';

export 'test_messages_proto2.pbenum.dart';

class TestAllTypesProto2_NestedMessage extends $pb.GeneratedMessage {
  factory TestAllTypesProto2_NestedMessage({
    $core.int? a,
    TestAllTypesProto2? corecursive,
  }) {
    final $result = create();
    if (a != null) {
      $result.a = a;
    }
    if (corecursive != null) {
      $result.corecursive = corecursive;
    }
    return $result;
  }
  TestAllTypesProto2_NestedMessage._() : super();
  factory TestAllTypesProto2_NestedMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllTypesProto2_NestedMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllTypesProto2.NestedMessage',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'a', $pb.PbFieldType.O3)
    ..aOM<TestAllTypesProto2>(2, _omitFieldNames ? '' : 'corecursive',
        subBuilder: TestAllTypesProto2.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_NestedMessage clone() =>
      TestAllTypesProto2_NestedMessage()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_NestedMessage copyWith(
          void Function(TestAllTypesProto2_NestedMessage) updates) =>
      super.copyWith(
              (message) => updates(message as TestAllTypesProto2_NestedMessage))
          as TestAllTypesProto2_NestedMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_NestedMessage create() =>
      TestAllTypesProto2_NestedMessage._();
  TestAllTypesProto2_NestedMessage createEmptyInstance() => create();
  static $pb.PbList<TestAllTypesProto2_NestedMessage> createRepeated() =>
      $pb.PbList<TestAllTypesProto2_NestedMessage>();
  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_NestedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestAllTypesProto2_NestedMessage>(
          create);
  static TestAllTypesProto2_NestedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get a => $_getIZ(0);
  @$pb.TagNumber(1)
  set a($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasA() => $_has(0);
  @$pb.TagNumber(1)
  void clearA() => clearField(1);

  @$pb.TagNumber(2)
  TestAllTypesProto2 get corecursive => $_getN(1);
  @$pb.TagNumber(2)
  set corecursive(TestAllTypesProto2 v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCorecursive() => $_has(1);
  @$pb.TagNumber(2)
  void clearCorecursive() => clearField(2);
  @$pb.TagNumber(2)
  TestAllTypesProto2 ensureCorecursive() => $_ensure(1);
}

/// groups
class TestAllTypesProto2_Data extends $pb.GeneratedMessage {
  factory TestAllTypesProto2_Data({
    $core.int? groupInt32,
    $core.int? groupUint32,
  }) {
    final $result = create();
    if (groupInt32 != null) {
      $result.groupInt32 = groupInt32;
    }
    if (groupUint32 != null) {
      $result.groupUint32 = groupUint32;
    }
    return $result;
  }
  TestAllTypesProto2_Data._() : super();
  factory TestAllTypesProto2_Data.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllTypesProto2_Data.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllTypesProto2.Data',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(202, _omitFieldNames ? '' : 'groupInt32', $pb.PbFieldType.O3)
    ..a<$core.int>(
        203, _omitFieldNames ? '' : 'groupUint32', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_Data clone() =>
      TestAllTypesProto2_Data()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_Data copyWith(
          void Function(TestAllTypesProto2_Data) updates) =>
      super.copyWith((message) => updates(message as TestAllTypesProto2_Data))
          as TestAllTypesProto2_Data;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_Data create() => TestAllTypesProto2_Data._();
  TestAllTypesProto2_Data createEmptyInstance() => create();
  static $pb.PbList<TestAllTypesProto2_Data> createRepeated() =>
      $pb.PbList<TestAllTypesProto2_Data>();
  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_Data getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestAllTypesProto2_Data>(create);
  static TestAllTypesProto2_Data? _defaultInstance;

  @$pb.TagNumber(202)
  $core.int get groupInt32 => $_getIZ(0);
  @$pb.TagNumber(202)
  set groupInt32($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(202)
  $core.bool hasGroupInt32() => $_has(0);
  @$pb.TagNumber(202)
  void clearGroupInt32() => clearField(202);

  @$pb.TagNumber(203)
  $core.int get groupUint32 => $_getIZ(1);
  @$pb.TagNumber(203)
  set groupUint32($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(203)
  $core.bool hasGroupUint32() => $_has(1);
  @$pb.TagNumber(203)
  void clearGroupUint32() => clearField(203);
}

class TestAllTypesProto2_MultiWordGroupField extends $pb.GeneratedMessage {
  factory TestAllTypesProto2_MultiWordGroupField({
    $core.int? groupInt32,
    $core.int? groupUint32,
  }) {
    final $result = create();
    if (groupInt32 != null) {
      $result.groupInt32 = groupInt32;
    }
    if (groupUint32 != null) {
      $result.groupUint32 = groupUint32;
    }
    return $result;
  }
  TestAllTypesProto2_MultiWordGroupField._() : super();
  factory TestAllTypesProto2_MultiWordGroupField.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllTypesProto2_MultiWordGroupField.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllTypesProto2.MultiWordGroupField',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(205, _omitFieldNames ? '' : 'groupInt32', $pb.PbFieldType.O3)
    ..a<$core.int>(
        206, _omitFieldNames ? '' : 'groupUint32', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_MultiWordGroupField clone() =>
      TestAllTypesProto2_MultiWordGroupField()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_MultiWordGroupField copyWith(
          void Function(TestAllTypesProto2_MultiWordGroupField) updates) =>
      super.copyWith((message) =>
              updates(message as TestAllTypesProto2_MultiWordGroupField))
          as TestAllTypesProto2_MultiWordGroupField;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_MultiWordGroupField create() =>
      TestAllTypesProto2_MultiWordGroupField._();
  TestAllTypesProto2_MultiWordGroupField createEmptyInstance() => create();
  static $pb.PbList<TestAllTypesProto2_MultiWordGroupField> createRepeated() =>
      $pb.PbList<TestAllTypesProto2_MultiWordGroupField>();
  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_MultiWordGroupField getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TestAllTypesProto2_MultiWordGroupField>(create);
  static TestAllTypesProto2_MultiWordGroupField? _defaultInstance;

  @$pb.TagNumber(205)
  $core.int get groupInt32 => $_getIZ(0);
  @$pb.TagNumber(205)
  set groupInt32($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(205)
  $core.bool hasGroupInt32() => $_has(0);
  @$pb.TagNumber(205)
  void clearGroupInt32() => clearField(205);

  @$pb.TagNumber(206)
  $core.int get groupUint32 => $_getIZ(1);
  @$pb.TagNumber(206)
  set groupUint32($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(206)
  $core.bool hasGroupUint32() => $_has(1);
  @$pb.TagNumber(206)
  void clearGroupUint32() => clearField(206);
}

/// message_set test case.
class TestAllTypesProto2_MessageSetCorrect extends $pb.$_MessageSet {
  factory TestAllTypesProto2_MessageSetCorrect() => create();
  TestAllTypesProto2_MessageSetCorrect._() : super();
  factory TestAllTypesProto2_MessageSetCorrect.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllTypesProto2_MessageSetCorrect.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllTypesProto2.MessageSetCorrect',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_MessageSetCorrect clone() =>
      TestAllTypesProto2_MessageSetCorrect()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_MessageSetCorrect copyWith(
          void Function(TestAllTypesProto2_MessageSetCorrect) updates) =>
      super.copyWith((message) =>
              updates(message as TestAllTypesProto2_MessageSetCorrect))
          as TestAllTypesProto2_MessageSetCorrect;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_MessageSetCorrect create() =>
      TestAllTypesProto2_MessageSetCorrect._();
  TestAllTypesProto2_MessageSetCorrect createEmptyInstance() => create();
  static $pb.PbList<TestAllTypesProto2_MessageSetCorrect> createRepeated() =>
      $pb.PbList<TestAllTypesProto2_MessageSetCorrect>();
  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_MessageSetCorrect getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TestAllTypesProto2_MessageSetCorrect>(create);
  static TestAllTypesProto2_MessageSetCorrect? _defaultInstance;
}

class TestAllTypesProto2_MessageSetCorrectExtension1
    extends $pb.GeneratedMessage {
  factory TestAllTypesProto2_MessageSetCorrectExtension1({
    $core.String? str,
  }) {
    final $result = create();
    if (str != null) {
      $result.str = str;
    }
    return $result;
  }
  TestAllTypesProto2_MessageSetCorrectExtension1._() : super();
  factory TestAllTypesProto2_MessageSetCorrectExtension1.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllTypesProto2_MessageSetCorrectExtension1.fromJson(
          $core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllTypesProto2.MessageSetCorrectExtension1',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..aOS(25, _omitFieldNames ? '' : 'str')
    ..hasRequiredFields = false;
  static final messageSetExtension = $pb.Extension<
          TestAllTypesProto2_MessageSetCorrectExtension1>(
      _omitMessageNames
          ? ''
          : 'protobuf_test_messages.proto2.TestAllTypesProto2.MessageSetCorrect',
      _omitFieldNames ? '' : 'messageSetExtension',
      1547769,
      $pb.PbFieldType.OM,
      defaultOrMaker: TestAllTypesProto2_MessageSetCorrectExtension1.getDefault,
      subBuilder: TestAllTypesProto2_MessageSetCorrectExtension1.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_MessageSetCorrectExtension1 clone() =>
      TestAllTypesProto2_MessageSetCorrectExtension1()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_MessageSetCorrectExtension1 copyWith(
          void Function(TestAllTypesProto2_MessageSetCorrectExtension1)
              updates) =>
      super.copyWith((message) => updates(
              message as TestAllTypesProto2_MessageSetCorrectExtension1))
          as TestAllTypesProto2_MessageSetCorrectExtension1;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_MessageSetCorrectExtension1 create() =>
      TestAllTypesProto2_MessageSetCorrectExtension1._();
  TestAllTypesProto2_MessageSetCorrectExtension1 createEmptyInstance() =>
      create();
  static $pb.PbList<TestAllTypesProto2_MessageSetCorrectExtension1>
      createRepeated() =>
          $pb.PbList<TestAllTypesProto2_MessageSetCorrectExtension1>();
  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_MessageSetCorrectExtension1 getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TestAllTypesProto2_MessageSetCorrectExtension1>(create);
  static TestAllTypesProto2_MessageSetCorrectExtension1? _defaultInstance;

  @$pb.TagNumber(25)
  $core.String get str => $_getSZ(0);
  @$pb.TagNumber(25)
  set str($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(25)
  $core.bool hasStr() => $_has(0);
  @$pb.TagNumber(25)
  void clearStr() => clearField(25);
}

class TestAllTypesProto2_MessageSetCorrectExtension2
    extends $pb.GeneratedMessage {
  factory TestAllTypesProto2_MessageSetCorrectExtension2({
    $core.int? i,
  }) {
    final $result = create();
    if (i != null) {
      $result.i = i;
    }
    return $result;
  }
  TestAllTypesProto2_MessageSetCorrectExtension2._() : super();
  factory TestAllTypesProto2_MessageSetCorrectExtension2.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllTypesProto2_MessageSetCorrectExtension2.fromJson(
          $core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllTypesProto2.MessageSetCorrectExtension2',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'i', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;
  static final messageSetExtension = $pb.Extension<
          TestAllTypesProto2_MessageSetCorrectExtension2>(
      _omitMessageNames
          ? ''
          : 'protobuf_test_messages.proto2.TestAllTypesProto2.MessageSetCorrect',
      _omitFieldNames ? '' : 'messageSetExtension',
      4135312,
      $pb.PbFieldType.OM,
      defaultOrMaker: TestAllTypesProto2_MessageSetCorrectExtension2.getDefault,
      subBuilder: TestAllTypesProto2_MessageSetCorrectExtension2.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_MessageSetCorrectExtension2 clone() =>
      TestAllTypesProto2_MessageSetCorrectExtension2()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2_MessageSetCorrectExtension2 copyWith(
          void Function(TestAllTypesProto2_MessageSetCorrectExtension2)
              updates) =>
      super.copyWith((message) => updates(
              message as TestAllTypesProto2_MessageSetCorrectExtension2))
          as TestAllTypesProto2_MessageSetCorrectExtension2;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_MessageSetCorrectExtension2 create() =>
      TestAllTypesProto2_MessageSetCorrectExtension2._();
  TestAllTypesProto2_MessageSetCorrectExtension2 createEmptyInstance() =>
      create();
  static $pb.PbList<TestAllTypesProto2_MessageSetCorrectExtension2>
      createRepeated() =>
          $pb.PbList<TestAllTypesProto2_MessageSetCorrectExtension2>();
  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2_MessageSetCorrectExtension2 getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TestAllTypesProto2_MessageSetCorrectExtension2>(create);
  static TestAllTypesProto2_MessageSetCorrectExtension2? _defaultInstance;

  @$pb.TagNumber(9)
  $core.int get i => $_getIZ(0);
  @$pb.TagNumber(9)
  set i($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasI() => $_has(0);
  @$pb.TagNumber(9)
  void clearI() => clearField(9);
}

enum TestAllTypesProto2_OneofField {
  oneofUint32,
  oneofNestedMessage,
  oneofString,
  oneofBytes,
  oneofBool,
  oneofUint64,
  oneofFloat,
  oneofDouble,
  oneofEnum,
  notSet
}

///  This proto includes every type of field in both singular and repeated
///  forms.
///
///  Also, crucially, all messages and enums in this file are eventually
///  submessages of this message.  So for example, a fuzz test of TestAllTypes
///  could trigger bugs that occur in any message type in this file.  We verify
///  this stays true in a unit test.
class TestAllTypesProto2 extends $pb.GeneratedMessage {
  factory TestAllTypesProto2({
    $core.int? optionalInt32,
    $fixnum.Int64? optionalInt64,
    $core.int? optionalUint32,
    $fixnum.Int64? optionalUint64,
    $core.int? optionalSint32,
    $fixnum.Int64? optionalSint64,
    $core.int? optionalFixed32,
    $fixnum.Int64? optionalFixed64,
    $core.int? optionalSfixed32,
    $fixnum.Int64? optionalSfixed64,
    $core.double? optionalFloat,
    $core.double? optionalDouble,
    $core.bool? optionalBool,
    $core.String? optionalString,
    $core.List<$core.int>? optionalBytes,
    TestAllTypesProto2_NestedMessage? optionalNestedMessage,
    ForeignMessageProto2? optionalForeignMessage,
    TestAllTypesProto2_NestedEnum? optionalNestedEnum,
    ForeignEnumProto2? optionalForeignEnum,
    $core.String? optionalStringPiece,
    $core.String? optionalCord,
    TestAllTypesProto2? recursiveMessage,
    $core.Iterable<$core.int>? repeatedInt32,
    $core.Iterable<$fixnum.Int64>? repeatedInt64,
    $core.Iterable<$core.int>? repeatedUint32,
    $core.Iterable<$fixnum.Int64>? repeatedUint64,
    $core.Iterable<$core.int>? repeatedSint32,
    $core.Iterable<$fixnum.Int64>? repeatedSint64,
    $core.Iterable<$core.int>? repeatedFixed32,
    $core.Iterable<$fixnum.Int64>? repeatedFixed64,
    $core.Iterable<$core.int>? repeatedSfixed32,
    $core.Iterable<$fixnum.Int64>? repeatedSfixed64,
    $core.Iterable<$core.double>? repeatedFloat,
    $core.Iterable<$core.double>? repeatedDouble,
    $core.Iterable<$core.bool>? repeatedBool,
    $core.Iterable<$core.String>? repeatedString,
    $core.Iterable<$core.List<$core.int>>? repeatedBytes,
    $core.Iterable<TestAllTypesProto2_NestedMessage>? repeatedNestedMessage,
    $core.Iterable<ForeignMessageProto2>? repeatedForeignMessage,
    $core.Iterable<TestAllTypesProto2_NestedEnum>? repeatedNestedEnum,
    $core.Iterable<ForeignEnumProto2>? repeatedForeignEnum,
    $core.Iterable<$core.String>? repeatedStringPiece,
    $core.Iterable<$core.String>? repeatedCord,
    $core.Map<$core.int, $core.int>? mapInt32Int32,
    $core.Map<$fixnum.Int64, $fixnum.Int64>? mapInt64Int64,
    $core.Map<$core.int, $core.int>? mapUint32Uint32,
    $core.Map<$fixnum.Int64, $fixnum.Int64>? mapUint64Uint64,
    $core.Map<$core.int, $core.int>? mapSint32Sint32,
    $core.Map<$fixnum.Int64, $fixnum.Int64>? mapSint64Sint64,
    $core.Map<$core.int, $core.int>? mapFixed32Fixed32,
    $core.Map<$fixnum.Int64, $fixnum.Int64>? mapFixed64Fixed64,
    $core.Map<$core.int, $core.int>? mapSfixed32Sfixed32,
    $core.Map<$fixnum.Int64, $fixnum.Int64>? mapSfixed64Sfixed64,
    $core.Map<$core.int, $core.double>? mapInt32Float,
    $core.Map<$core.int, $core.double>? mapInt32Double,
    $core.Map<$core.bool, $core.bool>? mapBoolBool,
    $core.Map<$core.String, $core.String>? mapStringString,
    $core.Map<$core.String, $core.List<$core.int>>? mapStringBytes,
    $core.Map<$core.String, TestAllTypesProto2_NestedMessage>?
        mapStringNestedMessage,
    $core.Map<$core.String, ForeignMessageProto2>? mapStringForeignMessage,
    $core.Map<$core.String, TestAllTypesProto2_NestedEnum>? mapStringNestedEnum,
    $core.Map<$core.String, ForeignEnumProto2>? mapStringForeignEnum,
    $core.Iterable<$core.int>? packedInt32,
    $core.Iterable<$fixnum.Int64>? packedInt64,
    $core.Iterable<$core.int>? packedUint32,
    $core.Iterable<$fixnum.Int64>? packedUint64,
    $core.Iterable<$core.int>? packedSint32,
    $core.Iterable<$fixnum.Int64>? packedSint64,
    $core.Iterable<$core.int>? packedFixed32,
    $core.Iterable<$fixnum.Int64>? packedFixed64,
    $core.Iterable<$core.int>? packedSfixed32,
    $core.Iterable<$fixnum.Int64>? packedSfixed64,
    $core.Iterable<$core.double>? packedFloat,
    $core.Iterable<$core.double>? packedDouble,
    $core.Iterable<$core.bool>? packedBool,
    $core.Iterable<TestAllTypesProto2_NestedEnum>? packedNestedEnum,
    $core.Iterable<$core.int>? unpackedInt32,
    $core.Iterable<$fixnum.Int64>? unpackedInt64,
    $core.Iterable<$core.int>? unpackedUint32,
    $core.Iterable<$fixnum.Int64>? unpackedUint64,
    $core.Iterable<$core.int>? unpackedSint32,
    $core.Iterable<$fixnum.Int64>? unpackedSint64,
    $core.Iterable<$core.int>? unpackedFixed32,
    $core.Iterable<$fixnum.Int64>? unpackedFixed64,
    $core.Iterable<$core.int>? unpackedSfixed32,
    $core.Iterable<$fixnum.Int64>? unpackedSfixed64,
    $core.Iterable<$core.double>? unpackedFloat,
    $core.Iterable<$core.double>? unpackedDouble,
    $core.Iterable<$core.bool>? unpackedBool,
    $core.Iterable<TestAllTypesProto2_NestedEnum>? unpackedNestedEnum,
    $core.int? oneofUint32,
    TestAllTypesProto2_NestedMessage? oneofNestedMessage,
    $core.String? oneofString,
    $core.List<$core.int>? oneofBytes,
    $core.bool? oneofBool,
    $fixnum.Int64? oneofUint64,
    $core.double? oneofFloat,
    $core.double? oneofDouble,
    TestAllTypesProto2_NestedEnum? oneofEnum,
    TestAllTypesProto2_Data? data,
    TestAllTypesProto2_MultiWordGroupField? multiWordGroupField,
    $core.int? defaultInt32,
    $fixnum.Int64? defaultInt64,
    $core.int? defaultUint32,
    $fixnum.Int64? defaultUint64,
    $core.int? defaultSint32,
    $fixnum.Int64? defaultSint64,
    $core.int? defaultFixed32,
    $fixnum.Int64? defaultFixed64,
    $core.int? defaultSfixed32,
    $fixnum.Int64? defaultSfixed64,
    $core.double? defaultFloat,
    $core.double? defaultDouble,
    $core.bool? defaultBool,
    $core.String? defaultString,
    $core.List<$core.int>? defaultBytes,
    $core.int? fieldname1,
    $core.int? fieldName2,
    $core.int? fieldName3,
    $core.int? fieldName4,
    $core.int? field0name5,
    $core.int? field0Name6,
    $core.int? fieldName7,
    $core.int? fieldName8,
    $core.int? fieldName9,
    $core.int? fieldName10,
    $core.int? fIELDNAME11,
    $core.int? fIELDName12,
    $core.int? fieldName13,
    $core.int? fieldName14,
    $core.int? fieldName15,
    $core.int? fieldName16,
    $core.int? fieldName17,
    $core.int? fieldName18,
  }) {
    final $result = create();
    if (optionalInt32 != null) {
      $result.optionalInt32 = optionalInt32;
    }
    if (optionalInt64 != null) {
      $result.optionalInt64 = optionalInt64;
    }
    if (optionalUint32 != null) {
      $result.optionalUint32 = optionalUint32;
    }
    if (optionalUint64 != null) {
      $result.optionalUint64 = optionalUint64;
    }
    if (optionalSint32 != null) {
      $result.optionalSint32 = optionalSint32;
    }
    if (optionalSint64 != null) {
      $result.optionalSint64 = optionalSint64;
    }
    if (optionalFixed32 != null) {
      $result.optionalFixed32 = optionalFixed32;
    }
    if (optionalFixed64 != null) {
      $result.optionalFixed64 = optionalFixed64;
    }
    if (optionalSfixed32 != null) {
      $result.optionalSfixed32 = optionalSfixed32;
    }
    if (optionalSfixed64 != null) {
      $result.optionalSfixed64 = optionalSfixed64;
    }
    if (optionalFloat != null) {
      $result.optionalFloat = optionalFloat;
    }
    if (optionalDouble != null) {
      $result.optionalDouble = optionalDouble;
    }
    if (optionalBool != null) {
      $result.optionalBool = optionalBool;
    }
    if (optionalString != null) {
      $result.optionalString = optionalString;
    }
    if (optionalBytes != null) {
      $result.optionalBytes = optionalBytes;
    }
    if (optionalNestedMessage != null) {
      $result.optionalNestedMessage = optionalNestedMessage;
    }
    if (optionalForeignMessage != null) {
      $result.optionalForeignMessage = optionalForeignMessage;
    }
    if (optionalNestedEnum != null) {
      $result.optionalNestedEnum = optionalNestedEnum;
    }
    if (optionalForeignEnum != null) {
      $result.optionalForeignEnum = optionalForeignEnum;
    }
    if (optionalStringPiece != null) {
      $result.optionalStringPiece = optionalStringPiece;
    }
    if (optionalCord != null) {
      $result.optionalCord = optionalCord;
    }
    if (recursiveMessage != null) {
      $result.recursiveMessage = recursiveMessage;
    }
    if (repeatedInt32 != null) {
      $result.repeatedInt32.addAll(repeatedInt32);
    }
    if (repeatedInt64 != null) {
      $result.repeatedInt64.addAll(repeatedInt64);
    }
    if (repeatedUint32 != null) {
      $result.repeatedUint32.addAll(repeatedUint32);
    }
    if (repeatedUint64 != null) {
      $result.repeatedUint64.addAll(repeatedUint64);
    }
    if (repeatedSint32 != null) {
      $result.repeatedSint32.addAll(repeatedSint32);
    }
    if (repeatedSint64 != null) {
      $result.repeatedSint64.addAll(repeatedSint64);
    }
    if (repeatedFixed32 != null) {
      $result.repeatedFixed32.addAll(repeatedFixed32);
    }
    if (repeatedFixed64 != null) {
      $result.repeatedFixed64.addAll(repeatedFixed64);
    }
    if (repeatedSfixed32 != null) {
      $result.repeatedSfixed32.addAll(repeatedSfixed32);
    }
    if (repeatedSfixed64 != null) {
      $result.repeatedSfixed64.addAll(repeatedSfixed64);
    }
    if (repeatedFloat != null) {
      $result.repeatedFloat.addAll(repeatedFloat);
    }
    if (repeatedDouble != null) {
      $result.repeatedDouble.addAll(repeatedDouble);
    }
    if (repeatedBool != null) {
      $result.repeatedBool.addAll(repeatedBool);
    }
    if (repeatedString != null) {
      $result.repeatedString.addAll(repeatedString);
    }
    if (repeatedBytes != null) {
      $result.repeatedBytes.addAll(repeatedBytes);
    }
    if (repeatedNestedMessage != null) {
      $result.repeatedNestedMessage.addAll(repeatedNestedMessage);
    }
    if (repeatedForeignMessage != null) {
      $result.repeatedForeignMessage.addAll(repeatedForeignMessage);
    }
    if (repeatedNestedEnum != null) {
      $result.repeatedNestedEnum.addAll(repeatedNestedEnum);
    }
    if (repeatedForeignEnum != null) {
      $result.repeatedForeignEnum.addAll(repeatedForeignEnum);
    }
    if (repeatedStringPiece != null) {
      $result.repeatedStringPiece.addAll(repeatedStringPiece);
    }
    if (repeatedCord != null) {
      $result.repeatedCord.addAll(repeatedCord);
    }
    if (mapInt32Int32 != null) {
      $result.mapInt32Int32.addAll(mapInt32Int32);
    }
    if (mapInt64Int64 != null) {
      $result.mapInt64Int64.addAll(mapInt64Int64);
    }
    if (mapUint32Uint32 != null) {
      $result.mapUint32Uint32.addAll(mapUint32Uint32);
    }
    if (mapUint64Uint64 != null) {
      $result.mapUint64Uint64.addAll(mapUint64Uint64);
    }
    if (mapSint32Sint32 != null) {
      $result.mapSint32Sint32.addAll(mapSint32Sint32);
    }
    if (mapSint64Sint64 != null) {
      $result.mapSint64Sint64.addAll(mapSint64Sint64);
    }
    if (mapFixed32Fixed32 != null) {
      $result.mapFixed32Fixed32.addAll(mapFixed32Fixed32);
    }
    if (mapFixed64Fixed64 != null) {
      $result.mapFixed64Fixed64.addAll(mapFixed64Fixed64);
    }
    if (mapSfixed32Sfixed32 != null) {
      $result.mapSfixed32Sfixed32.addAll(mapSfixed32Sfixed32);
    }
    if (mapSfixed64Sfixed64 != null) {
      $result.mapSfixed64Sfixed64.addAll(mapSfixed64Sfixed64);
    }
    if (mapInt32Float != null) {
      $result.mapInt32Float.addAll(mapInt32Float);
    }
    if (mapInt32Double != null) {
      $result.mapInt32Double.addAll(mapInt32Double);
    }
    if (mapBoolBool != null) {
      $result.mapBoolBool.addAll(mapBoolBool);
    }
    if (mapStringString != null) {
      $result.mapStringString.addAll(mapStringString);
    }
    if (mapStringBytes != null) {
      $result.mapStringBytes.addAll(mapStringBytes);
    }
    if (mapStringNestedMessage != null) {
      $result.mapStringNestedMessage.addAll(mapStringNestedMessage);
    }
    if (mapStringForeignMessage != null) {
      $result.mapStringForeignMessage.addAll(mapStringForeignMessage);
    }
    if (mapStringNestedEnum != null) {
      $result.mapStringNestedEnum.addAll(mapStringNestedEnum);
    }
    if (mapStringForeignEnum != null) {
      $result.mapStringForeignEnum.addAll(mapStringForeignEnum);
    }
    if (packedInt32 != null) {
      $result.packedInt32.addAll(packedInt32);
    }
    if (packedInt64 != null) {
      $result.packedInt64.addAll(packedInt64);
    }
    if (packedUint32 != null) {
      $result.packedUint32.addAll(packedUint32);
    }
    if (packedUint64 != null) {
      $result.packedUint64.addAll(packedUint64);
    }
    if (packedSint32 != null) {
      $result.packedSint32.addAll(packedSint32);
    }
    if (packedSint64 != null) {
      $result.packedSint64.addAll(packedSint64);
    }
    if (packedFixed32 != null) {
      $result.packedFixed32.addAll(packedFixed32);
    }
    if (packedFixed64 != null) {
      $result.packedFixed64.addAll(packedFixed64);
    }
    if (packedSfixed32 != null) {
      $result.packedSfixed32.addAll(packedSfixed32);
    }
    if (packedSfixed64 != null) {
      $result.packedSfixed64.addAll(packedSfixed64);
    }
    if (packedFloat != null) {
      $result.packedFloat.addAll(packedFloat);
    }
    if (packedDouble != null) {
      $result.packedDouble.addAll(packedDouble);
    }
    if (packedBool != null) {
      $result.packedBool.addAll(packedBool);
    }
    if (packedNestedEnum != null) {
      $result.packedNestedEnum.addAll(packedNestedEnum);
    }
    if (unpackedInt32 != null) {
      $result.unpackedInt32.addAll(unpackedInt32);
    }
    if (unpackedInt64 != null) {
      $result.unpackedInt64.addAll(unpackedInt64);
    }
    if (unpackedUint32 != null) {
      $result.unpackedUint32.addAll(unpackedUint32);
    }
    if (unpackedUint64 != null) {
      $result.unpackedUint64.addAll(unpackedUint64);
    }
    if (unpackedSint32 != null) {
      $result.unpackedSint32.addAll(unpackedSint32);
    }
    if (unpackedSint64 != null) {
      $result.unpackedSint64.addAll(unpackedSint64);
    }
    if (unpackedFixed32 != null) {
      $result.unpackedFixed32.addAll(unpackedFixed32);
    }
    if (unpackedFixed64 != null) {
      $result.unpackedFixed64.addAll(unpackedFixed64);
    }
    if (unpackedSfixed32 != null) {
      $result.unpackedSfixed32.addAll(unpackedSfixed32);
    }
    if (unpackedSfixed64 != null) {
      $result.unpackedSfixed64.addAll(unpackedSfixed64);
    }
    if (unpackedFloat != null) {
      $result.unpackedFloat.addAll(unpackedFloat);
    }
    if (unpackedDouble != null) {
      $result.unpackedDouble.addAll(unpackedDouble);
    }
    if (unpackedBool != null) {
      $result.unpackedBool.addAll(unpackedBool);
    }
    if (unpackedNestedEnum != null) {
      $result.unpackedNestedEnum.addAll(unpackedNestedEnum);
    }
    if (oneofUint32 != null) {
      $result.oneofUint32 = oneofUint32;
    }
    if (oneofNestedMessage != null) {
      $result.oneofNestedMessage = oneofNestedMessage;
    }
    if (oneofString != null) {
      $result.oneofString = oneofString;
    }
    if (oneofBytes != null) {
      $result.oneofBytes = oneofBytes;
    }
    if (oneofBool != null) {
      $result.oneofBool = oneofBool;
    }
    if (oneofUint64 != null) {
      $result.oneofUint64 = oneofUint64;
    }
    if (oneofFloat != null) {
      $result.oneofFloat = oneofFloat;
    }
    if (oneofDouble != null) {
      $result.oneofDouble = oneofDouble;
    }
    if (oneofEnum != null) {
      $result.oneofEnum = oneofEnum;
    }
    if (data != null) {
      $result.data = data;
    }
    if (multiWordGroupField != null) {
      $result.multiWordGroupField = multiWordGroupField;
    }
    if (defaultInt32 != null) {
      $result.defaultInt32 = defaultInt32;
    }
    if (defaultInt64 != null) {
      $result.defaultInt64 = defaultInt64;
    }
    if (defaultUint32 != null) {
      $result.defaultUint32 = defaultUint32;
    }
    if (defaultUint64 != null) {
      $result.defaultUint64 = defaultUint64;
    }
    if (defaultSint32 != null) {
      $result.defaultSint32 = defaultSint32;
    }
    if (defaultSint64 != null) {
      $result.defaultSint64 = defaultSint64;
    }
    if (defaultFixed32 != null) {
      $result.defaultFixed32 = defaultFixed32;
    }
    if (defaultFixed64 != null) {
      $result.defaultFixed64 = defaultFixed64;
    }
    if (defaultSfixed32 != null) {
      $result.defaultSfixed32 = defaultSfixed32;
    }
    if (defaultSfixed64 != null) {
      $result.defaultSfixed64 = defaultSfixed64;
    }
    if (defaultFloat != null) {
      $result.defaultFloat = defaultFloat;
    }
    if (defaultDouble != null) {
      $result.defaultDouble = defaultDouble;
    }
    if (defaultBool != null) {
      $result.defaultBool = defaultBool;
    }
    if (defaultString != null) {
      $result.defaultString = defaultString;
    }
    if (defaultBytes != null) {
      $result.defaultBytes = defaultBytes;
    }
    if (fieldname1 != null) {
      $result.fieldname1 = fieldname1;
    }
    if (fieldName2 != null) {
      $result.fieldName2 = fieldName2;
    }
    if (fieldName3 != null) {
      $result.fieldName3 = fieldName3;
    }
    if (fieldName4 != null) {
      $result.fieldName4 = fieldName4;
    }
    if (field0name5 != null) {
      $result.field0name5 = field0name5;
    }
    if (field0Name6 != null) {
      $result.field0Name6 = field0Name6;
    }
    if (fieldName7 != null) {
      $result.fieldName7 = fieldName7;
    }
    if (fieldName8 != null) {
      $result.fieldName8 = fieldName8;
    }
    if (fieldName9 != null) {
      $result.fieldName9 = fieldName9;
    }
    if (fieldName10 != null) {
      $result.fieldName10 = fieldName10;
    }
    if (fIELDNAME11 != null) {
      $result.fIELDNAME11 = fIELDNAME11;
    }
    if (fIELDName12 != null) {
      $result.fIELDName12 = fIELDName12;
    }
    if (fieldName13 != null) {
      $result.fieldName13 = fieldName13;
    }
    if (fieldName14 != null) {
      $result.fieldName14 = fieldName14;
    }
    if (fieldName15 != null) {
      $result.fieldName15 = fieldName15;
    }
    if (fieldName16 != null) {
      $result.fieldName16 = fieldName16;
    }
    if (fieldName17 != null) {
      $result.fieldName17 = fieldName17;
    }
    if (fieldName18 != null) {
      $result.fieldName18 = fieldName18;
    }
    return $result;
  }
  TestAllTypesProto2._() : super();
  factory TestAllTypesProto2.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllTypesProto2.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, TestAllTypesProto2_OneofField>
      _TestAllTypesProto2_OneofFieldByTag = {
    111: TestAllTypesProto2_OneofField.oneofUint32,
    112: TestAllTypesProto2_OneofField.oneofNestedMessage,
    113: TestAllTypesProto2_OneofField.oneofString,
    114: TestAllTypesProto2_OneofField.oneofBytes,
    115: TestAllTypesProto2_OneofField.oneofBool,
    116: TestAllTypesProto2_OneofField.oneofUint64,
    117: TestAllTypesProto2_OneofField.oneofFloat,
    118: TestAllTypesProto2_OneofField.oneofDouble,
    119: TestAllTypesProto2_OneofField.oneofEnum,
    0: TestAllTypesProto2_OneofField.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllTypesProto2',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..oo(0, [111, 112, 113, 114, 115, 116, 117, 118, 119])
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'optionalInt32', $pb.PbFieldType.O3)
    ..aInt64(2, _omitFieldNames ? '' : 'optionalInt64')
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'optionalUint32', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'optionalUint64', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'optionalSint32', $pb.PbFieldType.OS3)
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'optionalSint64', $pb.PbFieldType.OS6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'optionalFixed32', $pb.PbFieldType.OF3)
    ..a<$fixnum.Int64>(
        8, _omitFieldNames ? '' : 'optionalFixed64', $pb.PbFieldType.OF6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'optionalSfixed32', $pb.PbFieldType.OSF3)
    ..a<$fixnum.Int64>(
        10, _omitFieldNames ? '' : 'optionalSfixed64', $pb.PbFieldType.OSF6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'optionalFloat', $pb.PbFieldType.OF)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'optionalDouble', $pb.PbFieldType.OD)
    ..aOB(13, _omitFieldNames ? '' : 'optionalBool')
    ..aOS(14, _omitFieldNames ? '' : 'optionalString')
    ..a<$core.List<$core.int>>(
        15, _omitFieldNames ? '' : 'optionalBytes', $pb.PbFieldType.OY)
    ..aOM<TestAllTypesProto2_NestedMessage>(
        18, _omitFieldNames ? '' : 'optionalNestedMessage',
        subBuilder: TestAllTypesProto2_NestedMessage.create)
    ..aOM<ForeignMessageProto2>(
        19, _omitFieldNames ? '' : 'optionalForeignMessage',
        subBuilder: ForeignMessageProto2.create)
    ..e<TestAllTypesProto2_NestedEnum>(
        21, _omitFieldNames ? '' : 'optionalNestedEnum', $pb.PbFieldType.OE,
        defaultOrMaker: TestAllTypesProto2_NestedEnum.FOO,
        valueOf: TestAllTypesProto2_NestedEnum.valueOf,
        enumValues: TestAllTypesProto2_NestedEnum.values)
    ..e<ForeignEnumProto2>(
        22, _omitFieldNames ? '' : 'optionalForeignEnum', $pb.PbFieldType.OE,
        defaultOrMaker: ForeignEnumProto2.FOREIGN_FOO,
        valueOf: ForeignEnumProto2.valueOf,
        enumValues: ForeignEnumProto2.values)
    ..aOS(24, _omitFieldNames ? '' : 'optionalStringPiece')
    ..aOS(25, _omitFieldNames ? '' : 'optionalCord')
    ..aOM<TestAllTypesProto2>(27, _omitFieldNames ? '' : 'recursiveMessage',
        subBuilder: TestAllTypesProto2.create)
    ..p<$core.int>(
        31, _omitFieldNames ? '' : 'repeatedInt32', $pb.PbFieldType.P3)
    ..p<$fixnum.Int64>(
        32, _omitFieldNames ? '' : 'repeatedInt64', $pb.PbFieldType.P6)
    ..p<$core.int>(
        33, _omitFieldNames ? '' : 'repeatedUint32', $pb.PbFieldType.PU3)
    ..p<$fixnum.Int64>(
        34, _omitFieldNames ? '' : 'repeatedUint64', $pb.PbFieldType.PU6)
    ..p<$core.int>(
        35, _omitFieldNames ? '' : 'repeatedSint32', $pb.PbFieldType.PS3)
    ..p<$fixnum.Int64>(
        36, _omitFieldNames ? '' : 'repeatedSint64', $pb.PbFieldType.PS6)
    ..p<$core.int>(
        37, _omitFieldNames ? '' : 'repeatedFixed32', $pb.PbFieldType.PF3)
    ..p<$fixnum.Int64>(
        38, _omitFieldNames ? '' : 'repeatedFixed64', $pb.PbFieldType.PF6)
    ..p<$core.int>(
        39, _omitFieldNames ? '' : 'repeatedSfixed32', $pb.PbFieldType.PSF3)
    ..p<$fixnum.Int64>(
        40, _omitFieldNames ? '' : 'repeatedSfixed64', $pb.PbFieldType.PSF6)
    ..p<$core.double>(
        41, _omitFieldNames ? '' : 'repeatedFloat', $pb.PbFieldType.PF)
    ..p<$core.double>(
        42, _omitFieldNames ? '' : 'repeatedDouble', $pb.PbFieldType.PD)
    ..p<$core.bool>(
        43, _omitFieldNames ? '' : 'repeatedBool', $pb.PbFieldType.PB)
    ..pPS(44, _omitFieldNames ? '' : 'repeatedString')
    ..p<$core.List<$core.int>>(
        45, _omitFieldNames ? '' : 'repeatedBytes', $pb.PbFieldType.PY)
    ..pc<TestAllTypesProto2_NestedMessage>(
        48, _omitFieldNames ? '' : 'repeatedNestedMessage', $pb.PbFieldType.PM,
        subBuilder: TestAllTypesProto2_NestedMessage.create)
    ..pc<ForeignMessageProto2>(
        49, _omitFieldNames ? '' : 'repeatedForeignMessage', $pb.PbFieldType.PM,
        subBuilder: ForeignMessageProto2.create)
    ..pc<TestAllTypesProto2_NestedEnum>(
        51, _omitFieldNames ? '' : 'repeatedNestedEnum', $pb.PbFieldType.PE,
        valueOf: TestAllTypesProto2_NestedEnum.valueOf,
        enumValues: TestAllTypesProto2_NestedEnum.values,
        defaultEnumValue: TestAllTypesProto2_NestedEnum.FOO)
    ..pc<ForeignEnumProto2>(
        52, _omitFieldNames ? '' : 'repeatedForeignEnum', $pb.PbFieldType.PE,
        valueOf: ForeignEnumProto2.valueOf,
        enumValues: ForeignEnumProto2.values,
        defaultEnumValue: ForeignEnumProto2.FOREIGN_FOO)
    ..pPS(54, _omitFieldNames ? '' : 'repeatedStringPiece')
    ..pPS(55, _omitFieldNames ? '' : 'repeatedCord')
    ..m<$core.int, $core.int>(56, _omitFieldNames ? '' : 'mapInt32Int32',
        entryClassName: 'TestAllTypesProto2.MapInt32Int32Entry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$fixnum.Int64, $fixnum.Int64>(
        57, _omitFieldNames ? '' : 'mapInt64Int64',
        entryClassName: 'TestAllTypesProto2.MapInt64Int64Entry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.O6,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.int, $core.int>(58, _omitFieldNames ? '' : 'mapUint32Uint32',
        entryClassName: 'TestAllTypesProto2.MapUint32Uint32Entry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$fixnum.Int64, $fixnum.Int64>(
        59, _omitFieldNames ? '' : 'mapUint64Uint64',
        entryClassName: 'TestAllTypesProto2.MapUint64Uint64Entry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OU6,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.int, $core.int>(60, _omitFieldNames ? '' : 'mapSint32Sint32',
        entryClassName: 'TestAllTypesProto2.MapSint32Sint32Entry',
        keyFieldType: $pb.PbFieldType.OS3,
        valueFieldType: $pb.PbFieldType.OS3,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$fixnum.Int64, $fixnum.Int64>(
        61, _omitFieldNames ? '' : 'mapSint64Sint64',
        entryClassName: 'TestAllTypesProto2.MapSint64Sint64Entry',
        keyFieldType: $pb.PbFieldType.OS6,
        valueFieldType: $pb.PbFieldType.OS6,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.int, $core.int>(62, _omitFieldNames ? '' : 'mapFixed32Fixed32',
        entryClassName: 'TestAllTypesProto2.MapFixed32Fixed32Entry',
        keyFieldType: $pb.PbFieldType.OF3,
        valueFieldType: $pb.PbFieldType.OF3,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$fixnum.Int64, $fixnum.Int64>(
        63, _omitFieldNames ? '' : 'mapFixed64Fixed64',
        entryClassName: 'TestAllTypesProto2.MapFixed64Fixed64Entry',
        keyFieldType: $pb.PbFieldType.OF6,
        valueFieldType: $pb.PbFieldType.OF6,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.int, $core.int>(64, _omitFieldNames ? '' : 'mapSfixed32Sfixed32',
        entryClassName: 'TestAllTypesProto2.MapSfixed32Sfixed32Entry',
        keyFieldType: $pb.PbFieldType.OSF3,
        valueFieldType: $pb.PbFieldType.OSF3,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$fixnum.Int64, $fixnum.Int64>(
        65, _omitFieldNames ? '' : 'mapSfixed64Sfixed64',
        entryClassName: 'TestAllTypesProto2.MapSfixed64Sfixed64Entry',
        keyFieldType: $pb.PbFieldType.OSF6,
        valueFieldType: $pb.PbFieldType.OSF6,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.int, $core.double>(66, _omitFieldNames ? '' : 'mapInt32Float',
        entryClassName: 'TestAllTypesProto2.MapInt32FloatEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OF,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.int, $core.double>(67, _omitFieldNames ? '' : 'mapInt32Double',
        entryClassName: 'TestAllTypesProto2.MapInt32DoubleEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.bool, $core.bool>(68, _omitFieldNames ? '' : 'mapBoolBool',
        entryClassName: 'TestAllTypesProto2.MapBoolBoolEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OB,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.String, $core.String>(
        69, _omitFieldNames ? '' : 'mapStringString',
        entryClassName: 'TestAllTypesProto2.MapStringStringEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.String, $core.List<$core.int>>(
        70, _omitFieldNames ? '' : 'mapStringBytes',
        entryClassName: 'TestAllTypesProto2.MapStringBytesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OY,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.String, TestAllTypesProto2_NestedMessage>(
        71, _omitFieldNames ? '' : 'mapStringNestedMessage',
        entryClassName: 'TestAllTypesProto2.MapStringNestedMessageEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: TestAllTypesProto2_NestedMessage.create,
        valueDefaultOrMaker: TestAllTypesProto2_NestedMessage.getDefault,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.String, ForeignMessageProto2>(
        72, _omitFieldNames ? '' : 'mapStringForeignMessage',
        entryClassName: 'TestAllTypesProto2.MapStringForeignMessageEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: ForeignMessageProto2.create,
        valueDefaultOrMaker: ForeignMessageProto2.getDefault,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.String, TestAllTypesProto2_NestedEnum>(
        73, _omitFieldNames ? '' : 'mapStringNestedEnum',
        entryClassName: 'TestAllTypesProto2.MapStringNestedEnumEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: TestAllTypesProto2_NestedEnum.valueOf,
        enumValues: TestAllTypesProto2_NestedEnum.values,
        valueDefaultOrMaker: TestAllTypesProto2_NestedEnum.FOO,
        defaultEnumValue: TestAllTypesProto2_NestedEnum.FOO,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..m<$core.String, ForeignEnumProto2>(
        74, _omitFieldNames ? '' : 'mapStringForeignEnum',
        entryClassName: 'TestAllTypesProto2.MapStringForeignEnumEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: ForeignEnumProto2.valueOf,
        enumValues: ForeignEnumProto2.values,
        valueDefaultOrMaker: ForeignEnumProto2.FOREIGN_FOO,
        defaultEnumValue: ForeignEnumProto2.FOREIGN_FOO,
        packageName: const $pb.PackageName('protobuf_test_messages.proto2'))
    ..p<$core.int>(75, _omitFieldNames ? '' : 'packedInt32', $pb.PbFieldType.K3)
    ..p<$fixnum.Int64>(
        76, _omitFieldNames ? '' : 'packedInt64', $pb.PbFieldType.K6)
    ..p<$core.int>(
        77, _omitFieldNames ? '' : 'packedUint32', $pb.PbFieldType.KU3)
    ..p<$fixnum.Int64>(
        78, _omitFieldNames ? '' : 'packedUint64', $pb.PbFieldType.KU6)
    ..p<$core.int>(
        79, _omitFieldNames ? '' : 'packedSint32', $pb.PbFieldType.KS3)
    ..p<$fixnum.Int64>(
        80, _omitFieldNames ? '' : 'packedSint64', $pb.PbFieldType.KS6)
    ..p<$core.int>(
        81, _omitFieldNames ? '' : 'packedFixed32', $pb.PbFieldType.KF3)
    ..p<$fixnum.Int64>(
        82, _omitFieldNames ? '' : 'packedFixed64', $pb.PbFieldType.KF6)
    ..p<$core.int>(
        83, _omitFieldNames ? '' : 'packedSfixed32', $pb.PbFieldType.KSF3)
    ..p<$fixnum.Int64>(
        84, _omitFieldNames ? '' : 'packedSfixed64', $pb.PbFieldType.KSF6)
    ..p<$core.double>(
        85, _omitFieldNames ? '' : 'packedFloat', $pb.PbFieldType.KF)
    ..p<$core.double>(
        86, _omitFieldNames ? '' : 'packedDouble', $pb.PbFieldType.KD)
    ..p<$core.bool>(87, _omitFieldNames ? '' : 'packedBool', $pb.PbFieldType.KB)
    ..pc<TestAllTypesProto2_NestedEnum>(
        88, _omitFieldNames ? '' : 'packedNestedEnum', $pb.PbFieldType.KE,
        valueOf: TestAllTypesProto2_NestedEnum.valueOf,
        enumValues: TestAllTypesProto2_NestedEnum.values,
        defaultEnumValue: TestAllTypesProto2_NestedEnum.FOO)
    ..p<$core.int>(
        89, _omitFieldNames ? '' : 'unpackedInt32', $pb.PbFieldType.P3)
    ..p<$fixnum.Int64>(
        90, _omitFieldNames ? '' : 'unpackedInt64', $pb.PbFieldType.P6)
    ..p<$core.int>(
        91, _omitFieldNames ? '' : 'unpackedUint32', $pb.PbFieldType.PU3)
    ..p<$fixnum.Int64>(
        92, _omitFieldNames ? '' : 'unpackedUint64', $pb.PbFieldType.PU6)
    ..p<$core.int>(
        93, _omitFieldNames ? '' : 'unpackedSint32', $pb.PbFieldType.PS3)
    ..p<$fixnum.Int64>(
        94, _omitFieldNames ? '' : 'unpackedSint64', $pb.PbFieldType.PS6)
    ..p<$core.int>(
        95, _omitFieldNames ? '' : 'unpackedFixed32', $pb.PbFieldType.PF3)
    ..p<$fixnum.Int64>(
        96, _omitFieldNames ? '' : 'unpackedFixed64', $pb.PbFieldType.PF6)
    ..p<$core.int>(
        97, _omitFieldNames ? '' : 'unpackedSfixed32', $pb.PbFieldType.PSF3)
    ..p<$fixnum.Int64>(
        98, _omitFieldNames ? '' : 'unpackedSfixed64', $pb.PbFieldType.PSF6)
    ..p<$core.double>(
        99, _omitFieldNames ? '' : 'unpackedFloat', $pb.PbFieldType.PF)
    ..p<$core.double>(
        100, _omitFieldNames ? '' : 'unpackedDouble', $pb.PbFieldType.PD)
    ..p<$core.bool>(
        101, _omitFieldNames ? '' : 'unpackedBool', $pb.PbFieldType.PB)
    ..pc<TestAllTypesProto2_NestedEnum>(
        102, _omitFieldNames ? '' : 'unpackedNestedEnum', $pb.PbFieldType.PE,
        valueOf: TestAllTypesProto2_NestedEnum.valueOf,
        enumValues: TestAllTypesProto2_NestedEnum.values,
        defaultEnumValue: TestAllTypesProto2_NestedEnum.FOO)
    ..a<$core.int>(
        111, _omitFieldNames ? '' : 'oneofUint32', $pb.PbFieldType.OU3)
    ..aOM<TestAllTypesProto2_NestedMessage>(
        112, _omitFieldNames ? '' : 'oneofNestedMessage',
        subBuilder: TestAllTypesProto2_NestedMessage.create)
    ..aOS(113, _omitFieldNames ? '' : 'oneofString')
    ..a<$core.List<$core.int>>(
        114, _omitFieldNames ? '' : 'oneofBytes', $pb.PbFieldType.OY)
    ..aOB(115, _omitFieldNames ? '' : 'oneofBool')
    ..a<$fixnum.Int64>(
        116, _omitFieldNames ? '' : 'oneofUint64', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(
        117, _omitFieldNames ? '' : 'oneofFloat', $pb.PbFieldType.OF)
    ..a<$core.double>(
        118, _omitFieldNames ? '' : 'oneofDouble', $pb.PbFieldType.OD)
    ..e<TestAllTypesProto2_NestedEnum>(
        119, _omitFieldNames ? '' : 'oneofEnum', $pb.PbFieldType.OE,
        defaultOrMaker: TestAllTypesProto2_NestedEnum.FOO,
        valueOf: TestAllTypesProto2_NestedEnum.valueOf,
        enumValues: TestAllTypesProto2_NestedEnum.values)
    ..a<TestAllTypesProto2_Data>(
        201, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OG,
        subBuilder: TestAllTypesProto2_Data.create,
        defaultOrMaker: TestAllTypesProto2_Data.getDefault)
    ..a<TestAllTypesProto2_MultiWordGroupField>(
        204, _omitFieldNames ? '' : 'multiwordgroupfield', $pb.PbFieldType.OG,
        subBuilder: TestAllTypesProto2_MultiWordGroupField.create,
        defaultOrMaker: TestAllTypesProto2_MultiWordGroupField.getDefault)
    ..a<$core.int>(
        241, _omitFieldNames ? '' : 'defaultInt32', $pb.PbFieldType.O3,
        defaultOrMaker: -123456789)
    ..a<$fixnum.Int64>(
        242, _omitFieldNames ? '' : 'defaultInt64', $pb.PbFieldType.O6,
        defaultOrMaker: $pb.parseLongInt('-9123456789123456789'))
    ..a<$core.int>(
        243, _omitFieldNames ? '' : 'defaultUint32', $pb.PbFieldType.OU3,
        defaultOrMaker: 2123456789)
    ..a<$fixnum.Int64>(
        244, _omitFieldNames ? '' : 'defaultUint64', $pb.PbFieldType.OU6,
        defaultOrMaker: $pb.parseLongInt('10123456789123456789'))
    ..a<$core.int>(
        245, _omitFieldNames ? '' : 'defaultSint32', $pb.PbFieldType.OS3,
        defaultOrMaker: -123456789)
    ..a<$fixnum.Int64>(
        246, _omitFieldNames ? '' : 'defaultSint64', $pb.PbFieldType.OS6,
        defaultOrMaker: $pb.parseLongInt('-9123456789123456789'))
    ..a<$core.int>(
        247, _omitFieldNames ? '' : 'defaultFixed32', $pb.PbFieldType.OF3,
        defaultOrMaker: 2123456789)
    ..a<$fixnum.Int64>(
        248, _omitFieldNames ? '' : 'defaultFixed64', $pb.PbFieldType.OF6,
        defaultOrMaker: $pb.parseLongInt('10123456789123456789'))
    ..a<$core.int>(
        249, _omitFieldNames ? '' : 'defaultSfixed32', $pb.PbFieldType.OSF3,
        defaultOrMaker: -123456789)
    ..a<$fixnum.Int64>(
        250, _omitFieldNames ? '' : 'defaultSfixed64', $pb.PbFieldType.OSF6,
        defaultOrMaker: $pb.parseLongInt('-9123456789123456789'))
    ..a<$core.double>(
        251, _omitFieldNames ? '' : 'defaultFloat', $pb.PbFieldType.OF,
        defaultOrMaker: 9e+09)
    ..a<$core.double>(
        252, _omitFieldNames ? '' : 'defaultDouble', $pb.PbFieldType.OD,
        defaultOrMaker: 7e+22)
    ..a<$core.bool>(
        253, _omitFieldNames ? '' : 'defaultBool', $pb.PbFieldType.OB,
        defaultOrMaker: true)
    ..a<$core.String>(
        254, _omitFieldNames ? '' : 'defaultString', $pb.PbFieldType.OS,
        defaultOrMaker: 'Rosebud')
    ..a<$core.List<$core.int>>(
        255, _omitFieldNames ? '' : 'defaultBytes', $pb.PbFieldType.OY,
        defaultOrMaker: () => <$core.int>[0x6a, 0x6f, 0x73, 0x68, 0x75, 0x61])
    ..a<$core.int>(401, _omitFieldNames ? '' : 'fieldname1', $pb.PbFieldType.O3)
    ..a<$core.int>(402, _omitFieldNames ? '' : 'fieldName2', $pb.PbFieldType.O3)
    ..a<$core.int>(403, _omitFieldNames ? '' : 'FieldName3', $pb.PbFieldType.O3)
    ..a<$core.int>(404, _omitFieldNames ? '' : 'fieldName4', $pb.PbFieldType.O3,
        protoName: 'field__name4_')
    ..a<$core.int>(
        405, _omitFieldNames ? '' : 'field0name5', $pb.PbFieldType.O3)
    ..a<$core.int>(
        406, _omitFieldNames ? '' : 'field0Name6', $pb.PbFieldType.O3,
        protoName: 'field_0_name6')
    ..a<$core.int>(407, _omitFieldNames ? '' : 'fieldName7', $pb.PbFieldType.O3,
        protoName: 'fieldName7')
    ..a<$core.int>(408, _omitFieldNames ? '' : 'FieldName8', $pb.PbFieldType.O3,
        protoName: 'FieldName8')
    ..a<$core.int>(409, _omitFieldNames ? '' : 'fieldName9', $pb.PbFieldType.O3,
        protoName: 'field_Name9')
    ..a<$core.int>(
        410, _omitFieldNames ? '' : 'FieldName10', $pb.PbFieldType.O3,
        protoName: 'Field_Name10')
    ..a<$core.int>(
        411, _omitFieldNames ? '' : 'FIELDNAME11', $pb.PbFieldType.O3,
        protoName: 'FIELD_NAME11')
    ..a<$core.int>(
        412, _omitFieldNames ? '' : 'FIELDName12', $pb.PbFieldType.O3,
        protoName: 'FIELD_name12')
    ..a<$core.int>(
        413, _omitFieldNames ? '' : 'FieldName13', $pb.PbFieldType.O3,
        protoName: '__field_name13')
    ..a<$core.int>(
        414, _omitFieldNames ? '' : 'FieldName14', $pb.PbFieldType.O3,
        protoName: '__Field_name14')
    ..a<$core.int>(
        415, _omitFieldNames ? '' : 'fieldName15', $pb.PbFieldType.O3,
        protoName: 'field__name15')
    ..a<$core.int>(
        416, _omitFieldNames ? '' : 'fieldName16', $pb.PbFieldType.O3,
        protoName: 'field__Name16')
    ..a<$core.int>(
        417, _omitFieldNames ? '' : 'fieldName17', $pb.PbFieldType.O3,
        protoName: 'field_name17__')
    ..a<$core.int>(
        418, _omitFieldNames ? '' : 'FieldName18', $pb.PbFieldType.O3,
        protoName: 'Field_name18__')
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2 clone() => TestAllTypesProto2()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllTypesProto2 copyWith(void Function(TestAllTypesProto2) updates) =>
      super.copyWith((message) => updates(message as TestAllTypesProto2))
          as TestAllTypesProto2;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2 create() => TestAllTypesProto2._();
  TestAllTypesProto2 createEmptyInstance() => create();
  static $pb.PbList<TestAllTypesProto2> createRepeated() =>
      $pb.PbList<TestAllTypesProto2>();
  @$core.pragma('dart2js:noInline')
  static TestAllTypesProto2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestAllTypesProto2>(create);
  static TestAllTypesProto2? _defaultInstance;

  TestAllTypesProto2_OneofField whichOneofField() =>
      _TestAllTypesProto2_OneofFieldByTag[$_whichOneof(0)]!;
  void clearOneofField() => clearField($_whichOneof(0));

  /// Singular
  @$pb.TagNumber(1)
  $core.int get optionalInt32 => $_getIZ(0);
  @$pb.TagNumber(1)
  set optionalInt32($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasOptionalInt32() => $_has(0);
  @$pb.TagNumber(1)
  void clearOptionalInt32() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get optionalInt64 => $_getI64(1);
  @$pb.TagNumber(2)
  set optionalInt64($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOptionalInt64() => $_has(1);
  @$pb.TagNumber(2)
  void clearOptionalInt64() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get optionalUint32 => $_getIZ(2);
  @$pb.TagNumber(3)
  set optionalUint32($core.int v) {
    $_setUnsignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOptionalUint32() => $_has(2);
  @$pb.TagNumber(3)
  void clearOptionalUint32() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get optionalUint64 => $_getI64(3);
  @$pb.TagNumber(4)
  set optionalUint64($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasOptionalUint64() => $_has(3);
  @$pb.TagNumber(4)
  void clearOptionalUint64() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get optionalSint32 => $_getIZ(4);
  @$pb.TagNumber(5)
  set optionalSint32($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasOptionalSint32() => $_has(4);
  @$pb.TagNumber(5)
  void clearOptionalSint32() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get optionalSint64 => $_getI64(5);
  @$pb.TagNumber(6)
  set optionalSint64($fixnum.Int64 v) {
    $_setInt64(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasOptionalSint64() => $_has(5);
  @$pb.TagNumber(6)
  void clearOptionalSint64() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get optionalFixed32 => $_getIZ(6);
  @$pb.TagNumber(7)
  set optionalFixed32($core.int v) {
    $_setUnsignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasOptionalFixed32() => $_has(6);
  @$pb.TagNumber(7)
  void clearOptionalFixed32() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get optionalFixed64 => $_getI64(7);
  @$pb.TagNumber(8)
  set optionalFixed64($fixnum.Int64 v) {
    $_setInt64(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasOptionalFixed64() => $_has(7);
  @$pb.TagNumber(8)
  void clearOptionalFixed64() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get optionalSfixed32 => $_getIZ(8);
  @$pb.TagNumber(9)
  set optionalSfixed32($core.int v) {
    $_setSignedInt32(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasOptionalSfixed32() => $_has(8);
  @$pb.TagNumber(9)
  void clearOptionalSfixed32() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get optionalSfixed64 => $_getI64(9);
  @$pb.TagNumber(10)
  set optionalSfixed64($fixnum.Int64 v) {
    $_setInt64(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasOptionalSfixed64() => $_has(9);
  @$pb.TagNumber(10)
  void clearOptionalSfixed64() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get optionalFloat => $_getN(10);
  @$pb.TagNumber(11)
  set optionalFloat($core.double v) {
    $_setFloat(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasOptionalFloat() => $_has(10);
  @$pb.TagNumber(11)
  void clearOptionalFloat() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get optionalDouble => $_getN(11);
  @$pb.TagNumber(12)
  set optionalDouble($core.double v) {
    $_setDouble(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasOptionalDouble() => $_has(11);
  @$pb.TagNumber(12)
  void clearOptionalDouble() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get optionalBool => $_getBF(12);
  @$pb.TagNumber(13)
  set optionalBool($core.bool v) {
    $_setBool(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasOptionalBool() => $_has(12);
  @$pb.TagNumber(13)
  void clearOptionalBool() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get optionalString => $_getSZ(13);
  @$pb.TagNumber(14)
  set optionalString($core.String v) {
    $_setString(13, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasOptionalString() => $_has(13);
  @$pb.TagNumber(14)
  void clearOptionalString() => clearField(14);

  @$pb.TagNumber(15)
  $core.List<$core.int> get optionalBytes => $_getN(14);
  @$pb.TagNumber(15)
  set optionalBytes($core.List<$core.int> v) {
    $_setBytes(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasOptionalBytes() => $_has(14);
  @$pb.TagNumber(15)
  void clearOptionalBytes() => clearField(15);

  @$pb.TagNumber(18)
  TestAllTypesProto2_NestedMessage get optionalNestedMessage => $_getN(15);
  @$pb.TagNumber(18)
  set optionalNestedMessage(TestAllTypesProto2_NestedMessage v) {
    setField(18, v);
  }

  @$pb.TagNumber(18)
  $core.bool hasOptionalNestedMessage() => $_has(15);
  @$pb.TagNumber(18)
  void clearOptionalNestedMessage() => clearField(18);
  @$pb.TagNumber(18)
  TestAllTypesProto2_NestedMessage ensureOptionalNestedMessage() =>
      $_ensure(15);

  @$pb.TagNumber(19)
  ForeignMessageProto2 get optionalForeignMessage => $_getN(16);
  @$pb.TagNumber(19)
  set optionalForeignMessage(ForeignMessageProto2 v) {
    setField(19, v);
  }

  @$pb.TagNumber(19)
  $core.bool hasOptionalForeignMessage() => $_has(16);
  @$pb.TagNumber(19)
  void clearOptionalForeignMessage() => clearField(19);
  @$pb.TagNumber(19)
  ForeignMessageProto2 ensureOptionalForeignMessage() => $_ensure(16);

  @$pb.TagNumber(21)
  TestAllTypesProto2_NestedEnum get optionalNestedEnum => $_getN(17);
  @$pb.TagNumber(21)
  set optionalNestedEnum(TestAllTypesProto2_NestedEnum v) {
    setField(21, v);
  }

  @$pb.TagNumber(21)
  $core.bool hasOptionalNestedEnum() => $_has(17);
  @$pb.TagNumber(21)
  void clearOptionalNestedEnum() => clearField(21);

  @$pb.TagNumber(22)
  ForeignEnumProto2 get optionalForeignEnum => $_getN(18);
  @$pb.TagNumber(22)
  set optionalForeignEnum(ForeignEnumProto2 v) {
    setField(22, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasOptionalForeignEnum() => $_has(18);
  @$pb.TagNumber(22)
  void clearOptionalForeignEnum() => clearField(22);

  @$pb.TagNumber(24)
  $core.String get optionalStringPiece => $_getSZ(19);
  @$pb.TagNumber(24)
  set optionalStringPiece($core.String v) {
    $_setString(19, v);
  }

  @$pb.TagNumber(24)
  $core.bool hasOptionalStringPiece() => $_has(19);
  @$pb.TagNumber(24)
  void clearOptionalStringPiece() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get optionalCord => $_getSZ(20);
  @$pb.TagNumber(25)
  set optionalCord($core.String v) {
    $_setString(20, v);
  }

  @$pb.TagNumber(25)
  $core.bool hasOptionalCord() => $_has(20);
  @$pb.TagNumber(25)
  void clearOptionalCord() => clearField(25);

  @$pb.TagNumber(27)
  TestAllTypesProto2 get recursiveMessage => $_getN(21);
  @$pb.TagNumber(27)
  set recursiveMessage(TestAllTypesProto2 v) {
    setField(27, v);
  }

  @$pb.TagNumber(27)
  $core.bool hasRecursiveMessage() => $_has(21);
  @$pb.TagNumber(27)
  void clearRecursiveMessage() => clearField(27);
  @$pb.TagNumber(27)
  TestAllTypesProto2 ensureRecursiveMessage() => $_ensure(21);

  /// Repeated
  @$pb.TagNumber(31)
  $core.List<$core.int> get repeatedInt32 => $_getList(22);

  @$pb.TagNumber(32)
  $core.List<$fixnum.Int64> get repeatedInt64 => $_getList(23);

  @$pb.TagNumber(33)
  $core.List<$core.int> get repeatedUint32 => $_getList(24);

  @$pb.TagNumber(34)
  $core.List<$fixnum.Int64> get repeatedUint64 => $_getList(25);

  @$pb.TagNumber(35)
  $core.List<$core.int> get repeatedSint32 => $_getList(26);

  @$pb.TagNumber(36)
  $core.List<$fixnum.Int64> get repeatedSint64 => $_getList(27);

  @$pb.TagNumber(37)
  $core.List<$core.int> get repeatedFixed32 => $_getList(28);

  @$pb.TagNumber(38)
  $core.List<$fixnum.Int64> get repeatedFixed64 => $_getList(29);

  @$pb.TagNumber(39)
  $core.List<$core.int> get repeatedSfixed32 => $_getList(30);

  @$pb.TagNumber(40)
  $core.List<$fixnum.Int64> get repeatedSfixed64 => $_getList(31);

  @$pb.TagNumber(41)
  $core.List<$core.double> get repeatedFloat => $_getList(32);

  @$pb.TagNumber(42)
  $core.List<$core.double> get repeatedDouble => $_getList(33);

  @$pb.TagNumber(43)
  $core.List<$core.bool> get repeatedBool => $_getList(34);

  @$pb.TagNumber(44)
  $core.List<$core.String> get repeatedString => $_getList(35);

  @$pb.TagNumber(45)
  $core.List<$core.List<$core.int>> get repeatedBytes => $_getList(36);

  @$pb.TagNumber(48)
  $core.List<TestAllTypesProto2_NestedMessage> get repeatedNestedMessage =>
      $_getList(37);

  @$pb.TagNumber(49)
  $core.List<ForeignMessageProto2> get repeatedForeignMessage => $_getList(38);

  @$pb.TagNumber(51)
  $core.List<TestAllTypesProto2_NestedEnum> get repeatedNestedEnum =>
      $_getList(39);

  @$pb.TagNumber(52)
  $core.List<ForeignEnumProto2> get repeatedForeignEnum => $_getList(40);

  @$pb.TagNumber(54)
  $core.List<$core.String> get repeatedStringPiece => $_getList(41);

  @$pb.TagNumber(55)
  $core.List<$core.String> get repeatedCord => $_getList(42);

  /// Map
  @$pb.TagNumber(56)
  $core.Map<$core.int, $core.int> get mapInt32Int32 => $_getMap(43);

  @$pb.TagNumber(57)
  $core.Map<$fixnum.Int64, $fixnum.Int64> get mapInt64Int64 => $_getMap(44);

  @$pb.TagNumber(58)
  $core.Map<$core.int, $core.int> get mapUint32Uint32 => $_getMap(45);

  @$pb.TagNumber(59)
  $core.Map<$fixnum.Int64, $fixnum.Int64> get mapUint64Uint64 => $_getMap(46);

  @$pb.TagNumber(60)
  $core.Map<$core.int, $core.int> get mapSint32Sint32 => $_getMap(47);

  @$pb.TagNumber(61)
  $core.Map<$fixnum.Int64, $fixnum.Int64> get mapSint64Sint64 => $_getMap(48);

  @$pb.TagNumber(62)
  $core.Map<$core.int, $core.int> get mapFixed32Fixed32 => $_getMap(49);

  @$pb.TagNumber(63)
  $core.Map<$fixnum.Int64, $fixnum.Int64> get mapFixed64Fixed64 => $_getMap(50);

  @$pb.TagNumber(64)
  $core.Map<$core.int, $core.int> get mapSfixed32Sfixed32 => $_getMap(51);

  @$pb.TagNumber(65)
  $core.Map<$fixnum.Int64, $fixnum.Int64> get mapSfixed64Sfixed64 =>
      $_getMap(52);

  @$pb.TagNumber(66)
  $core.Map<$core.int, $core.double> get mapInt32Float => $_getMap(53);

  @$pb.TagNumber(67)
  $core.Map<$core.int, $core.double> get mapInt32Double => $_getMap(54);

  @$pb.TagNumber(68)
  $core.Map<$core.bool, $core.bool> get mapBoolBool => $_getMap(55);

  @$pb.TagNumber(69)
  $core.Map<$core.String, $core.String> get mapStringString => $_getMap(56);

  @$pb.TagNumber(70)
  $core.Map<$core.String, $core.List<$core.int>> get mapStringBytes =>
      $_getMap(57);

  @$pb.TagNumber(71)
  $core.Map<$core.String, TestAllTypesProto2_NestedMessage>
      get mapStringNestedMessage => $_getMap(58);

  @$pb.TagNumber(72)
  $core.Map<$core.String, ForeignMessageProto2> get mapStringForeignMessage =>
      $_getMap(59);

  @$pb.TagNumber(73)
  $core.Map<$core.String, TestAllTypesProto2_NestedEnum>
      get mapStringNestedEnum => $_getMap(60);

  @$pb.TagNumber(74)
  $core.Map<$core.String, ForeignEnumProto2> get mapStringForeignEnum =>
      $_getMap(61);

  /// Packed
  @$pb.TagNumber(75)
  $core.List<$core.int> get packedInt32 => $_getList(62);

  @$pb.TagNumber(76)
  $core.List<$fixnum.Int64> get packedInt64 => $_getList(63);

  @$pb.TagNumber(77)
  $core.List<$core.int> get packedUint32 => $_getList(64);

  @$pb.TagNumber(78)
  $core.List<$fixnum.Int64> get packedUint64 => $_getList(65);

  @$pb.TagNumber(79)
  $core.List<$core.int> get packedSint32 => $_getList(66);

  @$pb.TagNumber(80)
  $core.List<$fixnum.Int64> get packedSint64 => $_getList(67);

  @$pb.TagNumber(81)
  $core.List<$core.int> get packedFixed32 => $_getList(68);

  @$pb.TagNumber(82)
  $core.List<$fixnum.Int64> get packedFixed64 => $_getList(69);

  @$pb.TagNumber(83)
  $core.List<$core.int> get packedSfixed32 => $_getList(70);

  @$pb.TagNumber(84)
  $core.List<$fixnum.Int64> get packedSfixed64 => $_getList(71);

  @$pb.TagNumber(85)
  $core.List<$core.double> get packedFloat => $_getList(72);

  @$pb.TagNumber(86)
  $core.List<$core.double> get packedDouble => $_getList(73);

  @$pb.TagNumber(87)
  $core.List<$core.bool> get packedBool => $_getList(74);

  @$pb.TagNumber(88)
  $core.List<TestAllTypesProto2_NestedEnum> get packedNestedEnum =>
      $_getList(75);

  /// Unpacked
  @$pb.TagNumber(89)
  $core.List<$core.int> get unpackedInt32 => $_getList(76);

  @$pb.TagNumber(90)
  $core.List<$fixnum.Int64> get unpackedInt64 => $_getList(77);

  @$pb.TagNumber(91)
  $core.List<$core.int> get unpackedUint32 => $_getList(78);

  @$pb.TagNumber(92)
  $core.List<$fixnum.Int64> get unpackedUint64 => $_getList(79);

  @$pb.TagNumber(93)
  $core.List<$core.int> get unpackedSint32 => $_getList(80);

  @$pb.TagNumber(94)
  $core.List<$fixnum.Int64> get unpackedSint64 => $_getList(81);

  @$pb.TagNumber(95)
  $core.List<$core.int> get unpackedFixed32 => $_getList(82);

  @$pb.TagNumber(96)
  $core.List<$fixnum.Int64> get unpackedFixed64 => $_getList(83);

  @$pb.TagNumber(97)
  $core.List<$core.int> get unpackedSfixed32 => $_getList(84);

  @$pb.TagNumber(98)
  $core.List<$fixnum.Int64> get unpackedSfixed64 => $_getList(85);

  @$pb.TagNumber(99)
  $core.List<$core.double> get unpackedFloat => $_getList(86);

  @$pb.TagNumber(100)
  $core.List<$core.double> get unpackedDouble => $_getList(87);

  @$pb.TagNumber(101)
  $core.List<$core.bool> get unpackedBool => $_getList(88);

  @$pb.TagNumber(102)
  $core.List<TestAllTypesProto2_NestedEnum> get unpackedNestedEnum =>
      $_getList(89);

  @$pb.TagNumber(111)
  $core.int get oneofUint32 => $_getIZ(90);
  @$pb.TagNumber(111)
  set oneofUint32($core.int v) {
    $_setUnsignedInt32(90, v);
  }

  @$pb.TagNumber(111)
  $core.bool hasOneofUint32() => $_has(90);
  @$pb.TagNumber(111)
  void clearOneofUint32() => clearField(111);

  @$pb.TagNumber(112)
  TestAllTypesProto2_NestedMessage get oneofNestedMessage => $_getN(91);
  @$pb.TagNumber(112)
  set oneofNestedMessage(TestAllTypesProto2_NestedMessage v) {
    setField(112, v);
  }

  @$pb.TagNumber(112)
  $core.bool hasOneofNestedMessage() => $_has(91);
  @$pb.TagNumber(112)
  void clearOneofNestedMessage() => clearField(112);
  @$pb.TagNumber(112)
  TestAllTypesProto2_NestedMessage ensureOneofNestedMessage() => $_ensure(91);

  @$pb.TagNumber(113)
  $core.String get oneofString => $_getSZ(92);
  @$pb.TagNumber(113)
  set oneofString($core.String v) {
    $_setString(92, v);
  }

  @$pb.TagNumber(113)
  $core.bool hasOneofString() => $_has(92);
  @$pb.TagNumber(113)
  void clearOneofString() => clearField(113);

  @$pb.TagNumber(114)
  $core.List<$core.int> get oneofBytes => $_getN(93);
  @$pb.TagNumber(114)
  set oneofBytes($core.List<$core.int> v) {
    $_setBytes(93, v);
  }

  @$pb.TagNumber(114)
  $core.bool hasOneofBytes() => $_has(93);
  @$pb.TagNumber(114)
  void clearOneofBytes() => clearField(114);

  @$pb.TagNumber(115)
  $core.bool get oneofBool => $_getBF(94);
  @$pb.TagNumber(115)
  set oneofBool($core.bool v) {
    $_setBool(94, v);
  }

  @$pb.TagNumber(115)
  $core.bool hasOneofBool() => $_has(94);
  @$pb.TagNumber(115)
  void clearOneofBool() => clearField(115);

  @$pb.TagNumber(116)
  $fixnum.Int64 get oneofUint64 => $_getI64(95);
  @$pb.TagNumber(116)
  set oneofUint64($fixnum.Int64 v) {
    $_setInt64(95, v);
  }

  @$pb.TagNumber(116)
  $core.bool hasOneofUint64() => $_has(95);
  @$pb.TagNumber(116)
  void clearOneofUint64() => clearField(116);

  @$pb.TagNumber(117)
  $core.double get oneofFloat => $_getN(96);
  @$pb.TagNumber(117)
  set oneofFloat($core.double v) {
    $_setFloat(96, v);
  }

  @$pb.TagNumber(117)
  $core.bool hasOneofFloat() => $_has(96);
  @$pb.TagNumber(117)
  void clearOneofFloat() => clearField(117);

  @$pb.TagNumber(118)
  $core.double get oneofDouble => $_getN(97);
  @$pb.TagNumber(118)
  set oneofDouble($core.double v) {
    $_setDouble(97, v);
  }

  @$pb.TagNumber(118)
  $core.bool hasOneofDouble() => $_has(97);
  @$pb.TagNumber(118)
  void clearOneofDouble() => clearField(118);

  @$pb.TagNumber(119)
  TestAllTypesProto2_NestedEnum get oneofEnum => $_getN(98);
  @$pb.TagNumber(119)
  set oneofEnum(TestAllTypesProto2_NestedEnum v) {
    setField(119, v);
  }

  @$pb.TagNumber(119)
  $core.bool hasOneofEnum() => $_has(98);
  @$pb.TagNumber(119)
  void clearOneofEnum() => clearField(119);

  @$pb.TagNumber(201)
  TestAllTypesProto2_Data get data => $_getN(99);
  @$pb.TagNumber(201)
  set data(TestAllTypesProto2_Data v) {
    setField(201, v);
  }

  @$pb.TagNumber(201)
  $core.bool hasData() => $_has(99);
  @$pb.TagNumber(201)
  void clearData() => clearField(201);

  @$pb.TagNumber(204)
  TestAllTypesProto2_MultiWordGroupField get multiWordGroupField => $_getN(100);
  @$pb.TagNumber(204)
  set multiWordGroupField(TestAllTypesProto2_MultiWordGroupField v) {
    setField(204, v);
  }

  @$pb.TagNumber(204)
  $core.bool hasMultiWordGroupField() => $_has(100);
  @$pb.TagNumber(204)
  void clearMultiWordGroupField() => clearField(204);

  /// default values
  @$pb.TagNumber(241)
  $core.int get defaultInt32 => $_getI(101, -123456789);
  @$pb.TagNumber(241)
  set defaultInt32($core.int v) {
    $_setSignedInt32(101, v);
  }

  @$pb.TagNumber(241)
  $core.bool hasDefaultInt32() => $_has(101);
  @$pb.TagNumber(241)
  void clearDefaultInt32() => clearField(241);

  @$pb.TagNumber(242)
  $fixnum.Int64 get defaultInt64 => $_getI64(102);
  @$pb.TagNumber(242)
  set defaultInt64($fixnum.Int64 v) {
    $_setInt64(102, v);
  }

  @$pb.TagNumber(242)
  $core.bool hasDefaultInt64() => $_has(102);
  @$pb.TagNumber(242)
  void clearDefaultInt64() => clearField(242);

  @$pb.TagNumber(243)
  $core.int get defaultUint32 => $_getI(103, 2123456789);
  @$pb.TagNumber(243)
  set defaultUint32($core.int v) {
    $_setUnsignedInt32(103, v);
  }

  @$pb.TagNumber(243)
  $core.bool hasDefaultUint32() => $_has(103);
  @$pb.TagNumber(243)
  void clearDefaultUint32() => clearField(243);

  @$pb.TagNumber(244)
  $fixnum.Int64 get defaultUint64 => $_getI64(104);
  @$pb.TagNumber(244)
  set defaultUint64($fixnum.Int64 v) {
    $_setInt64(104, v);
  }

  @$pb.TagNumber(244)
  $core.bool hasDefaultUint64() => $_has(104);
  @$pb.TagNumber(244)
  void clearDefaultUint64() => clearField(244);

  @$pb.TagNumber(245)
  $core.int get defaultSint32 => $_getI(105, -123456789);
  @$pb.TagNumber(245)
  set defaultSint32($core.int v) {
    $_setSignedInt32(105, v);
  }

  @$pb.TagNumber(245)
  $core.bool hasDefaultSint32() => $_has(105);
  @$pb.TagNumber(245)
  void clearDefaultSint32() => clearField(245);

  @$pb.TagNumber(246)
  $fixnum.Int64 get defaultSint64 => $_getI64(106);
  @$pb.TagNumber(246)
  set defaultSint64($fixnum.Int64 v) {
    $_setInt64(106, v);
  }

  @$pb.TagNumber(246)
  $core.bool hasDefaultSint64() => $_has(106);
  @$pb.TagNumber(246)
  void clearDefaultSint64() => clearField(246);

  @$pb.TagNumber(247)
  $core.int get defaultFixed32 => $_getI(107, 2123456789);
  @$pb.TagNumber(247)
  set defaultFixed32($core.int v) {
    $_setUnsignedInt32(107, v);
  }

  @$pb.TagNumber(247)
  $core.bool hasDefaultFixed32() => $_has(107);
  @$pb.TagNumber(247)
  void clearDefaultFixed32() => clearField(247);

  @$pb.TagNumber(248)
  $fixnum.Int64 get defaultFixed64 => $_getI64(108);
  @$pb.TagNumber(248)
  set defaultFixed64($fixnum.Int64 v) {
    $_setInt64(108, v);
  }

  @$pb.TagNumber(248)
  $core.bool hasDefaultFixed64() => $_has(108);
  @$pb.TagNumber(248)
  void clearDefaultFixed64() => clearField(248);

  @$pb.TagNumber(249)
  $core.int get defaultSfixed32 => $_getI(109, -123456789);
  @$pb.TagNumber(249)
  set defaultSfixed32($core.int v) {
    $_setSignedInt32(109, v);
  }

  @$pb.TagNumber(249)
  $core.bool hasDefaultSfixed32() => $_has(109);
  @$pb.TagNumber(249)
  void clearDefaultSfixed32() => clearField(249);

  @$pb.TagNumber(250)
  $fixnum.Int64 get defaultSfixed64 => $_getI64(110);
  @$pb.TagNumber(250)
  set defaultSfixed64($fixnum.Int64 v) {
    $_setInt64(110, v);
  }

  @$pb.TagNumber(250)
  $core.bool hasDefaultSfixed64() => $_has(110);
  @$pb.TagNumber(250)
  void clearDefaultSfixed64() => clearField(250);

  @$pb.TagNumber(251)
  $core.double get defaultFloat => $_getN(111);
  @$pb.TagNumber(251)
  set defaultFloat($core.double v) {
    $_setFloat(111, v);
  }

  @$pb.TagNumber(251)
  $core.bool hasDefaultFloat() => $_has(111);
  @$pb.TagNumber(251)
  void clearDefaultFloat() => clearField(251);

  @$pb.TagNumber(252)
  $core.double get defaultDouble => $_getN(112);
  @$pb.TagNumber(252)
  set defaultDouble($core.double v) {
    $_setDouble(112, v);
  }

  @$pb.TagNumber(252)
  $core.bool hasDefaultDouble() => $_has(112);
  @$pb.TagNumber(252)
  void clearDefaultDouble() => clearField(252);

  @$pb.TagNumber(253)
  $core.bool get defaultBool => $_getB(113, true);
  @$pb.TagNumber(253)
  set defaultBool($core.bool v) {
    $_setBool(113, v);
  }

  @$pb.TagNumber(253)
  $core.bool hasDefaultBool() => $_has(113);
  @$pb.TagNumber(253)
  void clearDefaultBool() => clearField(253);

  @$pb.TagNumber(254)
  $core.String get defaultString => $_getS(114, 'Rosebud');
  @$pb.TagNumber(254)
  set defaultString($core.String v) {
    $_setString(114, v);
  }

  @$pb.TagNumber(254)
  $core.bool hasDefaultString() => $_has(114);
  @$pb.TagNumber(254)
  void clearDefaultString() => clearField(254);

  @$pb.TagNumber(255)
  $core.List<$core.int> get defaultBytes => $_getN(115);
  @$pb.TagNumber(255)
  set defaultBytes($core.List<$core.int> v) {
    $_setBytes(115, v);
  }

  @$pb.TagNumber(255)
  $core.bool hasDefaultBytes() => $_has(115);
  @$pb.TagNumber(255)
  void clearDefaultBytes() => clearField(255);

  /// Test field-name-to-JSON-name convention.
  /// (protobuf says names can be any valid C/C++ identifier.)
  @$pb.TagNumber(401)
  $core.int get fieldname1 => $_getIZ(116);
  @$pb.TagNumber(401)
  set fieldname1($core.int v) {
    $_setSignedInt32(116, v);
  }

  @$pb.TagNumber(401)
  $core.bool hasFieldname1() => $_has(116);
  @$pb.TagNumber(401)
  void clearFieldname1() => clearField(401);

  @$pb.TagNumber(402)
  $core.int get fieldName2 => $_getIZ(117);
  @$pb.TagNumber(402)
  set fieldName2($core.int v) {
    $_setSignedInt32(117, v);
  }

  @$pb.TagNumber(402)
  $core.bool hasFieldName2() => $_has(117);
  @$pb.TagNumber(402)
  void clearFieldName2() => clearField(402);

  @$pb.TagNumber(403)
  $core.int get fieldName3 => $_getIZ(118);
  @$pb.TagNumber(403)
  set fieldName3($core.int v) {
    $_setSignedInt32(118, v);
  }

  @$pb.TagNumber(403)
  $core.bool hasFieldName3() => $_has(118);
  @$pb.TagNumber(403)
  void clearFieldName3() => clearField(403);

  @$pb.TagNumber(404)
  $core.int get fieldName4 => $_getIZ(119);
  @$pb.TagNumber(404)
  set fieldName4($core.int v) {
    $_setSignedInt32(119, v);
  }

  @$pb.TagNumber(404)
  $core.bool hasFieldName4() => $_has(119);
  @$pb.TagNumber(404)
  void clearFieldName4() => clearField(404);

  @$pb.TagNumber(405)
  $core.int get field0name5 => $_getIZ(120);
  @$pb.TagNumber(405)
  set field0name5($core.int v) {
    $_setSignedInt32(120, v);
  }

  @$pb.TagNumber(405)
  $core.bool hasField0name5() => $_has(120);
  @$pb.TagNumber(405)
  void clearField0name5() => clearField(405);

  @$pb.TagNumber(406)
  $core.int get field0Name6 => $_getIZ(121);
  @$pb.TagNumber(406)
  set field0Name6($core.int v) {
    $_setSignedInt32(121, v);
  }

  @$pb.TagNumber(406)
  $core.bool hasField0Name6() => $_has(121);
  @$pb.TagNumber(406)
  void clearField0Name6() => clearField(406);

  @$pb.TagNumber(407)
  $core.int get fieldName7 => $_getIZ(122);
  @$pb.TagNumber(407)
  set fieldName7($core.int v) {
    $_setSignedInt32(122, v);
  }

  @$pb.TagNumber(407)
  $core.bool hasFieldName7() => $_has(122);
  @$pb.TagNumber(407)
  void clearFieldName7() => clearField(407);

  @$pb.TagNumber(408)
  $core.int get fieldName8 => $_getIZ(123);
  @$pb.TagNumber(408)
  set fieldName8($core.int v) {
    $_setSignedInt32(123, v);
  }

  @$pb.TagNumber(408)
  $core.bool hasFieldName8() => $_has(123);
  @$pb.TagNumber(408)
  void clearFieldName8() => clearField(408);

  @$pb.TagNumber(409)
  $core.int get fieldName9 => $_getIZ(124);
  @$pb.TagNumber(409)
  set fieldName9($core.int v) {
    $_setSignedInt32(124, v);
  }

  @$pb.TagNumber(409)
  $core.bool hasFieldName9() => $_has(124);
  @$pb.TagNumber(409)
  void clearFieldName9() => clearField(409);

  @$pb.TagNumber(410)
  $core.int get fieldName10 => $_getIZ(125);
  @$pb.TagNumber(410)
  set fieldName10($core.int v) {
    $_setSignedInt32(125, v);
  }

  @$pb.TagNumber(410)
  $core.bool hasFieldName10() => $_has(125);
  @$pb.TagNumber(410)
  void clearFieldName10() => clearField(410);

  @$pb.TagNumber(411)
  $core.int get fIELDNAME11 => $_getIZ(126);
  @$pb.TagNumber(411)
  set fIELDNAME11($core.int v) {
    $_setSignedInt32(126, v);
  }

  @$pb.TagNumber(411)
  $core.bool hasFIELDNAME11() => $_has(126);
  @$pb.TagNumber(411)
  void clearFIELDNAME11() => clearField(411);

  @$pb.TagNumber(412)
  $core.int get fIELDName12 => $_getIZ(127);
  @$pb.TagNumber(412)
  set fIELDName12($core.int v) {
    $_setSignedInt32(127, v);
  }

  @$pb.TagNumber(412)
  $core.bool hasFIELDName12() => $_has(127);
  @$pb.TagNumber(412)
  void clearFIELDName12() => clearField(412);

  @$pb.TagNumber(413)
  $core.int get fieldName13 => $_getIZ(128);
  @$pb.TagNumber(413)
  set fieldName13($core.int v) {
    $_setSignedInt32(128, v);
  }

  @$pb.TagNumber(413)
  $core.bool hasFieldName13() => $_has(128);
  @$pb.TagNumber(413)
  void clearFieldName13() => clearField(413);

  @$pb.TagNumber(414)
  $core.int get fieldName14 => $_getIZ(129);
  @$pb.TagNumber(414)
  set fieldName14($core.int v) {
    $_setSignedInt32(129, v);
  }

  @$pb.TagNumber(414)
  $core.bool hasFieldName14() => $_has(129);
  @$pb.TagNumber(414)
  void clearFieldName14() => clearField(414);

  @$pb.TagNumber(415)
  $core.int get fieldName15 => $_getIZ(130);
  @$pb.TagNumber(415)
  set fieldName15($core.int v) {
    $_setSignedInt32(130, v);
  }

  @$pb.TagNumber(415)
  $core.bool hasFieldName15() => $_has(130);
  @$pb.TagNumber(415)
  void clearFieldName15() => clearField(415);

  @$pb.TagNumber(416)
  $core.int get fieldName16 => $_getIZ(131);
  @$pb.TagNumber(416)
  set fieldName16($core.int v) {
    $_setSignedInt32(131, v);
  }

  @$pb.TagNumber(416)
  $core.bool hasFieldName16() => $_has(131);
  @$pb.TagNumber(416)
  void clearFieldName16() => clearField(416);

  @$pb.TagNumber(417)
  $core.int get fieldName17 => $_getIZ(132);
  @$pb.TagNumber(417)
  set fieldName17($core.int v) {
    $_setSignedInt32(132, v);
  }

  @$pb.TagNumber(417)
  $core.bool hasFieldName17() => $_has(132);
  @$pb.TagNumber(417)
  void clearFieldName17() => clearField(417);

  @$pb.TagNumber(418)
  $core.int get fieldName18 => $_getIZ(133);
  @$pb.TagNumber(418)
  set fieldName18($core.int v) {
    $_setSignedInt32(133, v);
  }

  @$pb.TagNumber(418)
  $core.bool hasFieldName18() => $_has(133);
  @$pb.TagNumber(418)
  void clearFieldName18() => clearField(418);
}

class ForeignMessageProto2 extends $pb.GeneratedMessage {
  factory ForeignMessageProto2({
    $core.int? c,
  }) {
    final $result = create();
    if (c != null) {
      $result.c = c;
    }
    return $result;
  }
  ForeignMessageProto2._() : super();
  factory ForeignMessageProto2.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ForeignMessageProto2.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ForeignMessageProto2',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'c', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ForeignMessageProto2 clone() =>
      ForeignMessageProto2()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ForeignMessageProto2 copyWith(void Function(ForeignMessageProto2) updates) =>
      super.copyWith((message) => updates(message as ForeignMessageProto2))
          as ForeignMessageProto2;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForeignMessageProto2 create() => ForeignMessageProto2._();
  ForeignMessageProto2 createEmptyInstance() => create();
  static $pb.PbList<ForeignMessageProto2> createRepeated() =>
      $pb.PbList<ForeignMessageProto2>();
  @$core.pragma('dart2js:noInline')
  static ForeignMessageProto2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ForeignMessageProto2>(create);
  static ForeignMessageProto2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get c => $_getIZ(0);
  @$pb.TagNumber(1)
  set c($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasC() => $_has(0);
  @$pb.TagNumber(1)
  void clearC() => clearField(1);
}

class GroupField extends $pb.GeneratedMessage {
  factory GroupField({
    $core.int? groupInt32,
    $core.int? groupUint32,
  }) {
    final $result = create();
    if (groupInt32 != null) {
      $result.groupInt32 = groupInt32;
    }
    if (groupUint32 != null) {
      $result.groupUint32 = groupUint32;
    }
    return $result;
  }
  GroupField._() : super();
  factory GroupField.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GroupField.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GroupField',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(122, _omitFieldNames ? '' : 'groupInt32', $pb.PbFieldType.O3)
    ..a<$core.int>(
        123, _omitFieldNames ? '' : 'groupUint32', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GroupField clone() => GroupField()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GroupField copyWith(void Function(GroupField) updates) =>
      super.copyWith((message) => updates(message as GroupField)) as GroupField;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupField create() => GroupField._();
  GroupField createEmptyInstance() => create();
  static $pb.PbList<GroupField> createRepeated() => $pb.PbList<GroupField>();
  @$core.pragma('dart2js:noInline')
  static GroupField getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GroupField>(create);
  static GroupField? _defaultInstance;

  @$pb.TagNumber(122)
  $core.int get groupInt32 => $_getIZ(0);
  @$pb.TagNumber(122)
  set groupInt32($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(122)
  $core.bool hasGroupInt32() => $_has(0);
  @$pb.TagNumber(122)
  void clearGroupInt32() => clearField(122);

  @$pb.TagNumber(123)
  $core.int get groupUint32 => $_getIZ(1);
  @$pb.TagNumber(123)
  set groupUint32($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(123)
  $core.bool hasGroupUint32() => $_has(1);
  @$pb.TagNumber(123)
  void clearGroupUint32() => clearField(123);
}

class UnknownToTestAllTypes_OptionalGroup extends $pb.GeneratedMessage {
  factory UnknownToTestAllTypes_OptionalGroup({
    $core.int? a,
  }) {
    final $result = create();
    if (a != null) {
      $result.a = a;
    }
    return $result;
  }
  UnknownToTestAllTypes_OptionalGroup._() : super();
  factory UnknownToTestAllTypes_OptionalGroup.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UnknownToTestAllTypes_OptionalGroup.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnknownToTestAllTypes.OptionalGroup',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'a', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UnknownToTestAllTypes_OptionalGroup clone() =>
      UnknownToTestAllTypes_OptionalGroup()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UnknownToTestAllTypes_OptionalGroup copyWith(
          void Function(UnknownToTestAllTypes_OptionalGroup) updates) =>
      super.copyWith((message) =>
              updates(message as UnknownToTestAllTypes_OptionalGroup))
          as UnknownToTestAllTypes_OptionalGroup;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnknownToTestAllTypes_OptionalGroup create() =>
      UnknownToTestAllTypes_OptionalGroup._();
  UnknownToTestAllTypes_OptionalGroup createEmptyInstance() => create();
  static $pb.PbList<UnknownToTestAllTypes_OptionalGroup> createRepeated() =>
      $pb.PbList<UnknownToTestAllTypes_OptionalGroup>();
  @$core.pragma('dart2js:noInline')
  static UnknownToTestAllTypes_OptionalGroup getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UnknownToTestAllTypes_OptionalGroup>(create);
  static UnknownToTestAllTypes_OptionalGroup? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get a => $_getIZ(0);
  @$pb.TagNumber(1)
  set a($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasA() => $_has(0);
  @$pb.TagNumber(1)
  void clearA() => clearField(1);
}

class UnknownToTestAllTypes extends $pb.GeneratedMessage {
  factory UnknownToTestAllTypes({
    $core.int? optionalInt32,
    $core.String? optionalString,
    ForeignMessageProto2? nestedMessage,
    UnknownToTestAllTypes_OptionalGroup? optionalGroup,
    $core.bool? optionalBool,
    $core.Iterable<$core.int>? repeatedInt32,
  }) {
    final $result = create();
    if (optionalInt32 != null) {
      $result.optionalInt32 = optionalInt32;
    }
    if (optionalString != null) {
      $result.optionalString = optionalString;
    }
    if (nestedMessage != null) {
      $result.nestedMessage = nestedMessage;
    }
    if (optionalGroup != null) {
      $result.optionalGroup = optionalGroup;
    }
    if (optionalBool != null) {
      $result.optionalBool = optionalBool;
    }
    if (repeatedInt32 != null) {
      $result.repeatedInt32.addAll(repeatedInt32);
    }
    return $result;
  }
  UnknownToTestAllTypes._() : super();
  factory UnknownToTestAllTypes.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UnknownToTestAllTypes.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnknownToTestAllTypes',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1001, _omitFieldNames ? '' : 'optionalInt32', $pb.PbFieldType.O3)
    ..aOS(1002, _omitFieldNames ? '' : 'optionalString')
    ..aOM<ForeignMessageProto2>(1003, _omitFieldNames ? '' : 'nestedMessage',
        subBuilder: ForeignMessageProto2.create)
    ..a<UnknownToTestAllTypes_OptionalGroup>(
        1004, _omitFieldNames ? '' : 'optionalgroup', $pb.PbFieldType.OG,
        subBuilder: UnknownToTestAllTypes_OptionalGroup.create,
        defaultOrMaker: UnknownToTestAllTypes_OptionalGroup.getDefault)
    ..aOB(1006, _omitFieldNames ? '' : 'optionalBool')
    ..p<$core.int>(
        1011, _omitFieldNames ? '' : 'repeatedInt32', $pb.PbFieldType.P3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UnknownToTestAllTypes clone() =>
      UnknownToTestAllTypes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UnknownToTestAllTypes copyWith(
          void Function(UnknownToTestAllTypes) updates) =>
      super.copyWith((message) => updates(message as UnknownToTestAllTypes))
          as UnknownToTestAllTypes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnknownToTestAllTypes create() => UnknownToTestAllTypes._();
  UnknownToTestAllTypes createEmptyInstance() => create();
  static $pb.PbList<UnknownToTestAllTypes> createRepeated() =>
      $pb.PbList<UnknownToTestAllTypes>();
  @$core.pragma('dart2js:noInline')
  static UnknownToTestAllTypes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnknownToTestAllTypes>(create);
  static UnknownToTestAllTypes? _defaultInstance;

  @$pb.TagNumber(1001)
  $core.int get optionalInt32 => $_getIZ(0);
  @$pb.TagNumber(1001)
  set optionalInt32($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1001)
  $core.bool hasOptionalInt32() => $_has(0);
  @$pb.TagNumber(1001)
  void clearOptionalInt32() => clearField(1001);

  @$pb.TagNumber(1002)
  $core.String get optionalString => $_getSZ(1);
  @$pb.TagNumber(1002)
  set optionalString($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(1002)
  $core.bool hasOptionalString() => $_has(1);
  @$pb.TagNumber(1002)
  void clearOptionalString() => clearField(1002);

  @$pb.TagNumber(1003)
  ForeignMessageProto2 get nestedMessage => $_getN(2);
  @$pb.TagNumber(1003)
  set nestedMessage(ForeignMessageProto2 v) {
    setField(1003, v);
  }

  @$pb.TagNumber(1003)
  $core.bool hasNestedMessage() => $_has(2);
  @$pb.TagNumber(1003)
  void clearNestedMessage() => clearField(1003);
  @$pb.TagNumber(1003)
  ForeignMessageProto2 ensureNestedMessage() => $_ensure(2);

  @$pb.TagNumber(1004)
  UnknownToTestAllTypes_OptionalGroup get optionalGroup => $_getN(3);
  @$pb.TagNumber(1004)
  set optionalGroup(UnknownToTestAllTypes_OptionalGroup v) {
    setField(1004, v);
  }

  @$pb.TagNumber(1004)
  $core.bool hasOptionalGroup() => $_has(3);
  @$pb.TagNumber(1004)
  void clearOptionalGroup() => clearField(1004);

  @$pb.TagNumber(1006)
  $core.bool get optionalBool => $_getBF(4);
  @$pb.TagNumber(1006)
  set optionalBool($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(1006)
  $core.bool hasOptionalBool() => $_has(4);
  @$pb.TagNumber(1006)
  void clearOptionalBool() => clearField(1006);

  @$pb.TagNumber(1011)
  $core.List<$core.int> get repeatedInt32 => $_getList(5);
}

class NullHypothesisProto2 extends $pb.GeneratedMessage {
  factory NullHypothesisProto2() => create();
  NullHypothesisProto2._() : super();
  factory NullHypothesisProto2.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NullHypothesisProto2.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NullHypothesisProto2',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NullHypothesisProto2 clone() =>
      NullHypothesisProto2()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NullHypothesisProto2 copyWith(void Function(NullHypothesisProto2) updates) =>
      super.copyWith((message) => updates(message as NullHypothesisProto2))
          as NullHypothesisProto2;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NullHypothesisProto2 create() => NullHypothesisProto2._();
  NullHypothesisProto2 createEmptyInstance() => create();
  static $pb.PbList<NullHypothesisProto2> createRepeated() =>
      $pb.PbList<NullHypothesisProto2>();
  @$core.pragma('dart2js:noInline')
  static NullHypothesisProto2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NullHypothesisProto2>(create);
  static NullHypothesisProto2? _defaultInstance;
}

class EnumOnlyProto2 extends $pb.GeneratedMessage {
  factory EnumOnlyProto2() => create();
  EnumOnlyProto2._() : super();
  factory EnumOnlyProto2.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnumOnlyProto2.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnumOnlyProto2',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnumOnlyProto2 clone() => EnumOnlyProto2()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnumOnlyProto2 copyWith(void Function(EnumOnlyProto2) updates) =>
      super.copyWith((message) => updates(message as EnumOnlyProto2))
          as EnumOnlyProto2;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnumOnlyProto2 create() => EnumOnlyProto2._();
  EnumOnlyProto2 createEmptyInstance() => create();
  static $pb.PbList<EnumOnlyProto2> createRepeated() =>
      $pb.PbList<EnumOnlyProto2>();
  @$core.pragma('dart2js:noInline')
  static EnumOnlyProto2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnumOnlyProto2>(create);
  static EnumOnlyProto2? _defaultInstance;
}

class OneStringProto2 extends $pb.GeneratedMessage {
  factory OneStringProto2({
    $core.String? data,
  }) {
    final $result = create();
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  OneStringProto2._() : super();
  factory OneStringProto2.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OneStringProto2.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OneStringProto2',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'data')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OneStringProto2 clone() => OneStringProto2()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OneStringProto2 copyWith(void Function(OneStringProto2) updates) =>
      super.copyWith((message) => updates(message as OneStringProto2))
          as OneStringProto2;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OneStringProto2 create() => OneStringProto2._();
  OneStringProto2 createEmptyInstance() => create();
  static $pb.PbList<OneStringProto2> createRepeated() =>
      $pb.PbList<OneStringProto2>();
  @$core.pragma('dart2js:noInline')
  static OneStringProto2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OneStringProto2>(create);
  static OneStringProto2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get data => $_getSZ(0);
  @$pb.TagNumber(1)
  set data($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);
}

class ProtoWithKeywords extends $pb.GeneratedMessage {
  factory ProtoWithKeywords({
    $core.int? inline,
    $core.String? concept,
    $core.Iterable<$core.String>? requires,
  }) {
    final $result = create();
    if (inline != null) {
      $result.inline = inline;
    }
    if (concept != null) {
      $result.concept = concept;
    }
    if (requires != null) {
      $result.requires.addAll(requires);
    }
    return $result;
  }
  ProtoWithKeywords._() : super();
  factory ProtoWithKeywords.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ProtoWithKeywords.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoWithKeywords',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'inline', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'concept')
    ..pPS(3, _omitFieldNames ? '' : 'requires')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ProtoWithKeywords clone() => ProtoWithKeywords()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ProtoWithKeywords copyWith(void Function(ProtoWithKeywords) updates) =>
      super.copyWith((message) => updates(message as ProtoWithKeywords))
          as ProtoWithKeywords;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoWithKeywords create() => ProtoWithKeywords._();
  ProtoWithKeywords createEmptyInstance() => create();
  static $pb.PbList<ProtoWithKeywords> createRepeated() =>
      $pb.PbList<ProtoWithKeywords>();
  @$core.pragma('dart2js:noInline')
  static ProtoWithKeywords getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoWithKeywords>(create);
  static ProtoWithKeywords? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get inline => $_getIZ(0);
  @$pb.TagNumber(1)
  set inline($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasInline() => $_has(0);
  @$pb.TagNumber(1)
  void clearInline() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get concept => $_getSZ(1);
  @$pb.TagNumber(2)
  set concept($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasConcept() => $_has(1);
  @$pb.TagNumber(2)
  void clearConcept() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get requires => $_getList(2);
}

class TestAllRequiredTypesProto2_NestedMessage extends $pb.GeneratedMessage {
  factory TestAllRequiredTypesProto2_NestedMessage({
    $core.int? a,
    TestAllRequiredTypesProto2? corecursive,
    TestAllRequiredTypesProto2? optionalCorecursive,
  }) {
    final $result = create();
    if (a != null) {
      $result.a = a;
    }
    if (corecursive != null) {
      $result.corecursive = corecursive;
    }
    if (optionalCorecursive != null) {
      $result.optionalCorecursive = optionalCorecursive;
    }
    return $result;
  }
  TestAllRequiredTypesProto2_NestedMessage._() : super();
  factory TestAllRequiredTypesProto2_NestedMessage.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllRequiredTypesProto2_NestedMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllRequiredTypesProto2.NestedMessage',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'a', $pb.PbFieldType.Q3)
    ..aQM<TestAllRequiredTypesProto2>(2, _omitFieldNames ? '' : 'corecursive',
        subBuilder: TestAllRequiredTypesProto2.create)
    ..aOM<TestAllRequiredTypesProto2>(
        3, _omitFieldNames ? '' : 'optionalCorecursive',
        subBuilder: TestAllRequiredTypesProto2.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2_NestedMessage clone() =>
      TestAllRequiredTypesProto2_NestedMessage()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2_NestedMessage copyWith(
          void Function(TestAllRequiredTypesProto2_NestedMessage) updates) =>
      super.copyWith((message) =>
              updates(message as TestAllRequiredTypesProto2_NestedMessage))
          as TestAllRequiredTypesProto2_NestedMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2_NestedMessage create() =>
      TestAllRequiredTypesProto2_NestedMessage._();
  TestAllRequiredTypesProto2_NestedMessage createEmptyInstance() => create();
  static $pb.PbList<TestAllRequiredTypesProto2_NestedMessage>
      createRepeated() =>
          $pb.PbList<TestAllRequiredTypesProto2_NestedMessage>();
  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2_NestedMessage getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TestAllRequiredTypesProto2_NestedMessage>(create);
  static TestAllRequiredTypesProto2_NestedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get a => $_getIZ(0);
  @$pb.TagNumber(1)
  set a($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasA() => $_has(0);
  @$pb.TagNumber(1)
  void clearA() => clearField(1);

  @$pb.TagNumber(2)
  TestAllRequiredTypesProto2 get corecursive => $_getN(1);
  @$pb.TagNumber(2)
  set corecursive(TestAllRequiredTypesProto2 v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCorecursive() => $_has(1);
  @$pb.TagNumber(2)
  void clearCorecursive() => clearField(2);
  @$pb.TagNumber(2)
  TestAllRequiredTypesProto2 ensureCorecursive() => $_ensure(1);

  @$pb.TagNumber(3)
  TestAllRequiredTypesProto2 get optionalCorecursive => $_getN(2);
  @$pb.TagNumber(3)
  set optionalCorecursive(TestAllRequiredTypesProto2 v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOptionalCorecursive() => $_has(2);
  @$pb.TagNumber(3)
  void clearOptionalCorecursive() => clearField(3);
  @$pb.TagNumber(3)
  TestAllRequiredTypesProto2 ensureOptionalCorecursive() => $_ensure(2);
}

/// groups
class TestAllRequiredTypesProto2_Data extends $pb.GeneratedMessage {
  factory TestAllRequiredTypesProto2_Data({
    $core.int? groupInt32,
    $core.int? groupUint32,
  }) {
    final $result = create();
    if (groupInt32 != null) {
      $result.groupInt32 = groupInt32;
    }
    if (groupUint32 != null) {
      $result.groupUint32 = groupUint32;
    }
    return $result;
  }
  TestAllRequiredTypesProto2_Data._() : super();
  factory TestAllRequiredTypesProto2_Data.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllRequiredTypesProto2_Data.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllRequiredTypesProto2.Data',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(202, _omitFieldNames ? '' : 'groupInt32', $pb.PbFieldType.Q3)
    ..a<$core.int>(
        203, _omitFieldNames ? '' : 'groupUint32', $pb.PbFieldType.QU3);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2_Data clone() =>
      TestAllRequiredTypesProto2_Data()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2_Data copyWith(
          void Function(TestAllRequiredTypesProto2_Data) updates) =>
      super.copyWith(
              (message) => updates(message as TestAllRequiredTypesProto2_Data))
          as TestAllRequiredTypesProto2_Data;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2_Data create() =>
      TestAllRequiredTypesProto2_Data._();
  TestAllRequiredTypesProto2_Data createEmptyInstance() => create();
  static $pb.PbList<TestAllRequiredTypesProto2_Data> createRepeated() =>
      $pb.PbList<TestAllRequiredTypesProto2_Data>();
  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2_Data getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestAllRequiredTypesProto2_Data>(
          create);
  static TestAllRequiredTypesProto2_Data? _defaultInstance;

  @$pb.TagNumber(202)
  $core.int get groupInt32 => $_getIZ(0);
  @$pb.TagNumber(202)
  set groupInt32($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(202)
  $core.bool hasGroupInt32() => $_has(0);
  @$pb.TagNumber(202)
  void clearGroupInt32() => clearField(202);

  @$pb.TagNumber(203)
  $core.int get groupUint32 => $_getIZ(1);
  @$pb.TagNumber(203)
  set groupUint32($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(203)
  $core.bool hasGroupUint32() => $_has(1);
  @$pb.TagNumber(203)
  void clearGroupUint32() => clearField(203);
}

/// message_set test case.
class TestAllRequiredTypesProto2_MessageSetCorrect extends $pb.$_MessageSet {
  factory TestAllRequiredTypesProto2_MessageSetCorrect() => create();
  TestAllRequiredTypesProto2_MessageSetCorrect._() : super();
  factory TestAllRequiredTypesProto2_MessageSetCorrect.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllRequiredTypesProto2_MessageSetCorrect.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllRequiredTypesProto2.MessageSetCorrect',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2_MessageSetCorrect clone() =>
      TestAllRequiredTypesProto2_MessageSetCorrect()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2_MessageSetCorrect copyWith(
          void Function(TestAllRequiredTypesProto2_MessageSetCorrect)
              updates) =>
      super.copyWith((message) =>
              updates(message as TestAllRequiredTypesProto2_MessageSetCorrect))
          as TestAllRequiredTypesProto2_MessageSetCorrect;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2_MessageSetCorrect create() =>
      TestAllRequiredTypesProto2_MessageSetCorrect._();
  TestAllRequiredTypesProto2_MessageSetCorrect createEmptyInstance() =>
      create();
  static $pb.PbList<TestAllRequiredTypesProto2_MessageSetCorrect>
      createRepeated() =>
          $pb.PbList<TestAllRequiredTypesProto2_MessageSetCorrect>();
  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2_MessageSetCorrect getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TestAllRequiredTypesProto2_MessageSetCorrect>(create);
  static TestAllRequiredTypesProto2_MessageSetCorrect? _defaultInstance;
}

class TestAllRequiredTypesProto2_MessageSetCorrectExtension1
    extends $pb.GeneratedMessage {
  factory TestAllRequiredTypesProto2_MessageSetCorrectExtension1({
    $core.String? str,
  }) {
    final $result = create();
    if (str != null) {
      $result.str = str;
    }
    return $result;
  }
  TestAllRequiredTypesProto2_MessageSetCorrectExtension1._() : super();
  factory TestAllRequiredTypesProto2_MessageSetCorrectExtension1.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllRequiredTypesProto2_MessageSetCorrectExtension1.fromJson(
          $core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'TestAllRequiredTypesProto2.MessageSetCorrectExtension1',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..aQS(25, _omitFieldNames ? '' : 'str');
  static final messageSetExtension = $pb.Extension<
          TestAllRequiredTypesProto2_MessageSetCorrectExtension1>(
      _omitMessageNames
          ? ''
          : 'protobuf_test_messages.proto2.TestAllRequiredTypesProto2.MessageSetCorrect',
      _omitFieldNames ? '' : 'messageSetExtension',
      1547769,
      $pb.PbFieldType.OM,
      defaultOrMaker:
          TestAllRequiredTypesProto2_MessageSetCorrectExtension1.getDefault,
      subBuilder:
          TestAllRequiredTypesProto2_MessageSetCorrectExtension1.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2_MessageSetCorrectExtension1 clone() =>
      TestAllRequiredTypesProto2_MessageSetCorrectExtension1()
        ..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2_MessageSetCorrectExtension1 copyWith(
          void Function(TestAllRequiredTypesProto2_MessageSetCorrectExtension1)
              updates) =>
      super.copyWith((message) => updates(message
              as TestAllRequiredTypesProto2_MessageSetCorrectExtension1))
          as TestAllRequiredTypesProto2_MessageSetCorrectExtension1;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2_MessageSetCorrectExtension1 create() =>
      TestAllRequiredTypesProto2_MessageSetCorrectExtension1._();
  TestAllRequiredTypesProto2_MessageSetCorrectExtension1
      createEmptyInstance() => create();
  static $pb.PbList<TestAllRequiredTypesProto2_MessageSetCorrectExtension1>
      createRepeated() =>
          $pb.PbList<TestAllRequiredTypesProto2_MessageSetCorrectExtension1>();
  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2_MessageSetCorrectExtension1 getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TestAllRequiredTypesProto2_MessageSetCorrectExtension1>(create);
  static TestAllRequiredTypesProto2_MessageSetCorrectExtension1?
      _defaultInstance;

  @$pb.TagNumber(25)
  $core.String get str => $_getSZ(0);
  @$pb.TagNumber(25)
  set str($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(25)
  $core.bool hasStr() => $_has(0);
  @$pb.TagNumber(25)
  void clearStr() => clearField(25);
}

class TestAllRequiredTypesProto2_MessageSetCorrectExtension2
    extends $pb.GeneratedMessage {
  factory TestAllRequiredTypesProto2_MessageSetCorrectExtension2({
    $core.int? i,
  }) {
    final $result = create();
    if (i != null) {
      $result.i = i;
    }
    return $result;
  }
  TestAllRequiredTypesProto2_MessageSetCorrectExtension2._() : super();
  factory TestAllRequiredTypesProto2_MessageSetCorrectExtension2.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllRequiredTypesProto2_MessageSetCorrectExtension2.fromJson(
          $core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'TestAllRequiredTypesProto2.MessageSetCorrectExtension2',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'i', $pb.PbFieldType.Q3);
  static final messageSetExtension = $pb.Extension<
          TestAllRequiredTypesProto2_MessageSetCorrectExtension2>(
      _omitMessageNames
          ? ''
          : 'protobuf_test_messages.proto2.TestAllRequiredTypesProto2.MessageSetCorrect',
      _omitFieldNames ? '' : 'messageSetExtension',
      4135312,
      $pb.PbFieldType.OM,
      defaultOrMaker:
          TestAllRequiredTypesProto2_MessageSetCorrectExtension2.getDefault,
      subBuilder:
          TestAllRequiredTypesProto2_MessageSetCorrectExtension2.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2_MessageSetCorrectExtension2 clone() =>
      TestAllRequiredTypesProto2_MessageSetCorrectExtension2()
        ..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2_MessageSetCorrectExtension2 copyWith(
          void Function(TestAllRequiredTypesProto2_MessageSetCorrectExtension2)
              updates) =>
      super.copyWith((message) => updates(message
              as TestAllRequiredTypesProto2_MessageSetCorrectExtension2))
          as TestAllRequiredTypesProto2_MessageSetCorrectExtension2;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2_MessageSetCorrectExtension2 create() =>
      TestAllRequiredTypesProto2_MessageSetCorrectExtension2._();
  TestAllRequiredTypesProto2_MessageSetCorrectExtension2
      createEmptyInstance() => create();
  static $pb.PbList<TestAllRequiredTypesProto2_MessageSetCorrectExtension2>
      createRepeated() =>
          $pb.PbList<TestAllRequiredTypesProto2_MessageSetCorrectExtension2>();
  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2_MessageSetCorrectExtension2 getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TestAllRequiredTypesProto2_MessageSetCorrectExtension2>(create);
  static TestAllRequiredTypesProto2_MessageSetCorrectExtension2?
      _defaultInstance;

  @$pb.TagNumber(9)
  $core.int get i => $_getIZ(0);
  @$pb.TagNumber(9)
  set i($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasI() => $_has(0);
  @$pb.TagNumber(9)
  void clearI() => clearField(9);
}

class TestAllRequiredTypesProto2 extends $pb.GeneratedMessage {
  factory TestAllRequiredTypesProto2({
    $core.int? requiredInt32,
    $fixnum.Int64? requiredInt64,
    $core.int? requiredUint32,
    $fixnum.Int64? requiredUint64,
    $core.int? requiredSint32,
    $fixnum.Int64? requiredSint64,
    $core.int? requiredFixed32,
    $fixnum.Int64? requiredFixed64,
    $core.int? requiredSfixed32,
    $fixnum.Int64? requiredSfixed64,
    $core.double? requiredFloat,
    $core.double? requiredDouble,
    $core.bool? requiredBool,
    $core.String? requiredString,
    $core.List<$core.int>? requiredBytes,
    TestAllRequiredTypesProto2_NestedMessage? requiredNestedMessage,
    ForeignMessageProto2? requiredForeignMessage,
    TestAllRequiredTypesProto2_NestedEnum? requiredNestedEnum,
    ForeignEnumProto2? requiredForeignEnum,
    $core.String? requiredStringPiece,
    $core.String? requiredCord,
    TestAllRequiredTypesProto2? recursiveMessage,
    TestAllRequiredTypesProto2? optionalRecursiveMessage,
    TestAllRequiredTypesProto2_Data? data,
    $core.int? defaultInt32,
    $fixnum.Int64? defaultInt64,
    $core.int? defaultUint32,
    $fixnum.Int64? defaultUint64,
    $core.int? defaultSint32,
    $fixnum.Int64? defaultSint64,
    $core.int? defaultFixed32,
    $fixnum.Int64? defaultFixed64,
    $core.int? defaultSfixed32,
    $fixnum.Int64? defaultSfixed64,
    $core.double? defaultFloat,
    $core.double? defaultDouble,
    $core.bool? defaultBool,
    $core.String? defaultString,
    $core.List<$core.int>? defaultBytes,
  }) {
    final $result = create();
    if (requiredInt32 != null) {
      $result.requiredInt32 = requiredInt32;
    }
    if (requiredInt64 != null) {
      $result.requiredInt64 = requiredInt64;
    }
    if (requiredUint32 != null) {
      $result.requiredUint32 = requiredUint32;
    }
    if (requiredUint64 != null) {
      $result.requiredUint64 = requiredUint64;
    }
    if (requiredSint32 != null) {
      $result.requiredSint32 = requiredSint32;
    }
    if (requiredSint64 != null) {
      $result.requiredSint64 = requiredSint64;
    }
    if (requiredFixed32 != null) {
      $result.requiredFixed32 = requiredFixed32;
    }
    if (requiredFixed64 != null) {
      $result.requiredFixed64 = requiredFixed64;
    }
    if (requiredSfixed32 != null) {
      $result.requiredSfixed32 = requiredSfixed32;
    }
    if (requiredSfixed64 != null) {
      $result.requiredSfixed64 = requiredSfixed64;
    }
    if (requiredFloat != null) {
      $result.requiredFloat = requiredFloat;
    }
    if (requiredDouble != null) {
      $result.requiredDouble = requiredDouble;
    }
    if (requiredBool != null) {
      $result.requiredBool = requiredBool;
    }
    if (requiredString != null) {
      $result.requiredString = requiredString;
    }
    if (requiredBytes != null) {
      $result.requiredBytes = requiredBytes;
    }
    if (requiredNestedMessage != null) {
      $result.requiredNestedMessage = requiredNestedMessage;
    }
    if (requiredForeignMessage != null) {
      $result.requiredForeignMessage = requiredForeignMessage;
    }
    if (requiredNestedEnum != null) {
      $result.requiredNestedEnum = requiredNestedEnum;
    }
    if (requiredForeignEnum != null) {
      $result.requiredForeignEnum = requiredForeignEnum;
    }
    if (requiredStringPiece != null) {
      $result.requiredStringPiece = requiredStringPiece;
    }
    if (requiredCord != null) {
      $result.requiredCord = requiredCord;
    }
    if (recursiveMessage != null) {
      $result.recursiveMessage = recursiveMessage;
    }
    if (optionalRecursiveMessage != null) {
      $result.optionalRecursiveMessage = optionalRecursiveMessage;
    }
    if (data != null) {
      $result.data = data;
    }
    if (defaultInt32 != null) {
      $result.defaultInt32 = defaultInt32;
    }
    if (defaultInt64 != null) {
      $result.defaultInt64 = defaultInt64;
    }
    if (defaultUint32 != null) {
      $result.defaultUint32 = defaultUint32;
    }
    if (defaultUint64 != null) {
      $result.defaultUint64 = defaultUint64;
    }
    if (defaultSint32 != null) {
      $result.defaultSint32 = defaultSint32;
    }
    if (defaultSint64 != null) {
      $result.defaultSint64 = defaultSint64;
    }
    if (defaultFixed32 != null) {
      $result.defaultFixed32 = defaultFixed32;
    }
    if (defaultFixed64 != null) {
      $result.defaultFixed64 = defaultFixed64;
    }
    if (defaultSfixed32 != null) {
      $result.defaultSfixed32 = defaultSfixed32;
    }
    if (defaultSfixed64 != null) {
      $result.defaultSfixed64 = defaultSfixed64;
    }
    if (defaultFloat != null) {
      $result.defaultFloat = defaultFloat;
    }
    if (defaultDouble != null) {
      $result.defaultDouble = defaultDouble;
    }
    if (defaultBool != null) {
      $result.defaultBool = defaultBool;
    }
    if (defaultString != null) {
      $result.defaultString = defaultString;
    }
    if (defaultBytes != null) {
      $result.defaultBytes = defaultBytes;
    }
    return $result;
  }
  TestAllRequiredTypesProto2._() : super();
  factory TestAllRequiredTypesProto2.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestAllRequiredTypesProto2.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllRequiredTypesProto2',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'protobuf_test_messages.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'requiredInt32', $pb.PbFieldType.Q3)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'requiredInt64', $pb.PbFieldType.Q6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'requiredUint32', $pb.PbFieldType.QU3)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'requiredUint64', $pb.PbFieldType.QU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'requiredSint32', $pb.PbFieldType.QS3)
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'requiredSint64', $pb.PbFieldType.QS6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'requiredFixed32', $pb.PbFieldType.QF3)
    ..a<$fixnum.Int64>(
        8, _omitFieldNames ? '' : 'requiredFixed64', $pb.PbFieldType.QF6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'requiredSfixed32', $pb.PbFieldType.QSF3)
    ..a<$fixnum.Int64>(
        10, _omitFieldNames ? '' : 'requiredSfixed64', $pb.PbFieldType.QSF6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'requiredFloat', $pb.PbFieldType.QF)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'requiredDouble', $pb.PbFieldType.QD)
    ..a<$core.bool>(
        13, _omitFieldNames ? '' : 'requiredBool', $pb.PbFieldType.QB)
    ..aQS(14, _omitFieldNames ? '' : 'requiredString')
    ..a<$core.List<$core.int>>(
        15, _omitFieldNames ? '' : 'requiredBytes', $pb.PbFieldType.QY)
    ..aQM<TestAllRequiredTypesProto2_NestedMessage>(
        18, _omitFieldNames ? '' : 'requiredNestedMessage',
        subBuilder: TestAllRequiredTypesProto2_NestedMessage.create)
    ..aQM<ForeignMessageProto2>(
        19, _omitFieldNames ? '' : 'requiredForeignMessage',
        subBuilder: ForeignMessageProto2.create)
    ..e<TestAllRequiredTypesProto2_NestedEnum>(
        21, _omitFieldNames ? '' : 'requiredNestedEnum', $pb.PbFieldType.QE,
        defaultOrMaker: TestAllRequiredTypesProto2_NestedEnum.FOO,
        valueOf: TestAllRequiredTypesProto2_NestedEnum.valueOf,
        enumValues: TestAllRequiredTypesProto2_NestedEnum.values)
    ..e<ForeignEnumProto2>(
        22, _omitFieldNames ? '' : 'requiredForeignEnum', $pb.PbFieldType.QE,
        defaultOrMaker: ForeignEnumProto2.FOREIGN_FOO,
        valueOf: ForeignEnumProto2.valueOf,
        enumValues: ForeignEnumProto2.values)
    ..aQS(24, _omitFieldNames ? '' : 'requiredStringPiece')
    ..aQS(25, _omitFieldNames ? '' : 'requiredCord')
    ..aQM<TestAllRequiredTypesProto2>(
        27, _omitFieldNames ? '' : 'recursiveMessage',
        subBuilder: TestAllRequiredTypesProto2.create)
    ..aOM<TestAllRequiredTypesProto2>(
        28, _omitFieldNames ? '' : 'optionalRecursiveMessage',
        subBuilder: TestAllRequiredTypesProto2.create)
    ..a<TestAllRequiredTypesProto2_Data>(
        201, _omitFieldNames ? '' : 'data', $pb.PbFieldType.QG,
        subBuilder: TestAllRequiredTypesProto2_Data.create,
        defaultOrMaker: TestAllRequiredTypesProto2_Data.getDefault)
    ..a<$core.int>(
        241, _omitFieldNames ? '' : 'defaultInt32', $pb.PbFieldType.Q3,
        defaultOrMaker: -123456789)
    ..a<$fixnum.Int64>(
        242, _omitFieldNames ? '' : 'defaultInt64', $pb.PbFieldType.Q6,
        defaultOrMaker: $pb.parseLongInt('-9123456789123456789'))
    ..a<$core.int>(
        243, _omitFieldNames ? '' : 'defaultUint32', $pb.PbFieldType.QU3,
        defaultOrMaker: 2123456789)
    ..a<$fixnum.Int64>(
        244, _omitFieldNames ? '' : 'defaultUint64', $pb.PbFieldType.QU6,
        defaultOrMaker: $pb.parseLongInt('10123456789123456789'))
    ..a<$core.int>(
        245, _omitFieldNames ? '' : 'defaultSint32', $pb.PbFieldType.QS3,
        defaultOrMaker: -123456789)
    ..a<$fixnum.Int64>(
        246, _omitFieldNames ? '' : 'defaultSint64', $pb.PbFieldType.QS6,
        defaultOrMaker: $pb.parseLongInt('-9123456789123456789'))
    ..a<$core.int>(
        247, _omitFieldNames ? '' : 'defaultFixed32', $pb.PbFieldType.QF3,
        defaultOrMaker: 2123456789)
    ..a<$fixnum.Int64>(
        248, _omitFieldNames ? '' : 'defaultFixed64', $pb.PbFieldType.QF6,
        defaultOrMaker: $pb.parseLongInt('10123456789123456789'))
    ..a<$core.int>(
        249, _omitFieldNames ? '' : 'defaultSfixed32', $pb.PbFieldType.QSF3,
        defaultOrMaker: -123456789)
    ..a<$fixnum.Int64>(
        250, _omitFieldNames ? '' : 'defaultSfixed64', $pb.PbFieldType.QSF6,
        defaultOrMaker: $pb.parseLongInt('-9123456789123456789'))
    ..a<$core.double>(
        251, _omitFieldNames ? '' : 'defaultFloat', $pb.PbFieldType.QF,
        defaultOrMaker: 9e+09)
    ..a<$core.double>(
        252, _omitFieldNames ? '' : 'defaultDouble', $pb.PbFieldType.QD,
        defaultOrMaker: 7e+22)
    ..a<$core.bool>(
        253, _omitFieldNames ? '' : 'defaultBool', $pb.PbFieldType.QB,
        defaultOrMaker: true)
    ..a<$core.String>(
        254, _omitFieldNames ? '' : 'defaultString', $pb.PbFieldType.QS,
        defaultOrMaker: 'Rosebud')
    ..a<$core.List<$core.int>>(
        255, _omitFieldNames ? '' : 'defaultBytes', $pb.PbFieldType.QY,
        defaultOrMaker: () => <$core.int>[0x6a, 0x6f, 0x73, 0x68, 0x75, 0x61])
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2 clone() =>
      TestAllRequiredTypesProto2()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestAllRequiredTypesProto2 copyWith(
          void Function(TestAllRequiredTypesProto2) updates) =>
      super.copyWith(
              (message) => updates(message as TestAllRequiredTypesProto2))
          as TestAllRequiredTypesProto2;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2 create() => TestAllRequiredTypesProto2._();
  TestAllRequiredTypesProto2 createEmptyInstance() => create();
  static $pb.PbList<TestAllRequiredTypesProto2> createRepeated() =>
      $pb.PbList<TestAllRequiredTypesProto2>();
  @$core.pragma('dart2js:noInline')
  static TestAllRequiredTypesProto2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestAllRequiredTypesProto2>(create);
  static TestAllRequiredTypesProto2? _defaultInstance;

  /// Singular
  @$pb.TagNumber(1)
  $core.int get requiredInt32 => $_getIZ(0);
  @$pb.TagNumber(1)
  set requiredInt32($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRequiredInt32() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequiredInt32() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get requiredInt64 => $_getI64(1);
  @$pb.TagNumber(2)
  set requiredInt64($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRequiredInt64() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequiredInt64() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get requiredUint32 => $_getIZ(2);
  @$pb.TagNumber(3)
  set requiredUint32($core.int v) {
    $_setUnsignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRequiredUint32() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequiredUint32() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get requiredUint64 => $_getI64(3);
  @$pb.TagNumber(4)
  set requiredUint64($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasRequiredUint64() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequiredUint64() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get requiredSint32 => $_getIZ(4);
  @$pb.TagNumber(5)
  set requiredSint32($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasRequiredSint32() => $_has(4);
  @$pb.TagNumber(5)
  void clearRequiredSint32() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get requiredSint64 => $_getI64(5);
  @$pb.TagNumber(6)
  set requiredSint64($fixnum.Int64 v) {
    $_setInt64(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasRequiredSint64() => $_has(5);
  @$pb.TagNumber(6)
  void clearRequiredSint64() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get requiredFixed32 => $_getIZ(6);
  @$pb.TagNumber(7)
  set requiredFixed32($core.int v) {
    $_setUnsignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasRequiredFixed32() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequiredFixed32() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get requiredFixed64 => $_getI64(7);
  @$pb.TagNumber(8)
  set requiredFixed64($fixnum.Int64 v) {
    $_setInt64(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasRequiredFixed64() => $_has(7);
  @$pb.TagNumber(8)
  void clearRequiredFixed64() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get requiredSfixed32 => $_getIZ(8);
  @$pb.TagNumber(9)
  set requiredSfixed32($core.int v) {
    $_setSignedInt32(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasRequiredSfixed32() => $_has(8);
  @$pb.TagNumber(9)
  void clearRequiredSfixed32() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get requiredSfixed64 => $_getI64(9);
  @$pb.TagNumber(10)
  set requiredSfixed64($fixnum.Int64 v) {
    $_setInt64(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasRequiredSfixed64() => $_has(9);
  @$pb.TagNumber(10)
  void clearRequiredSfixed64() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get requiredFloat => $_getN(10);
  @$pb.TagNumber(11)
  set requiredFloat($core.double v) {
    $_setFloat(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasRequiredFloat() => $_has(10);
  @$pb.TagNumber(11)
  void clearRequiredFloat() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get requiredDouble => $_getN(11);
  @$pb.TagNumber(12)
  set requiredDouble($core.double v) {
    $_setDouble(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasRequiredDouble() => $_has(11);
  @$pb.TagNumber(12)
  void clearRequiredDouble() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get requiredBool => $_getBF(12);
  @$pb.TagNumber(13)
  set requiredBool($core.bool v) {
    $_setBool(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasRequiredBool() => $_has(12);
  @$pb.TagNumber(13)
  void clearRequiredBool() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get requiredString => $_getSZ(13);
  @$pb.TagNumber(14)
  set requiredString($core.String v) {
    $_setString(13, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasRequiredString() => $_has(13);
  @$pb.TagNumber(14)
  void clearRequiredString() => clearField(14);

  @$pb.TagNumber(15)
  $core.List<$core.int> get requiredBytes => $_getN(14);
  @$pb.TagNumber(15)
  set requiredBytes($core.List<$core.int> v) {
    $_setBytes(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasRequiredBytes() => $_has(14);
  @$pb.TagNumber(15)
  void clearRequiredBytes() => clearField(15);

  @$pb.TagNumber(18)
  TestAllRequiredTypesProto2_NestedMessage get requiredNestedMessage =>
      $_getN(15);
  @$pb.TagNumber(18)
  set requiredNestedMessage(TestAllRequiredTypesProto2_NestedMessage v) {
    setField(18, v);
  }

  @$pb.TagNumber(18)
  $core.bool hasRequiredNestedMessage() => $_has(15);
  @$pb.TagNumber(18)
  void clearRequiredNestedMessage() => clearField(18);
  @$pb.TagNumber(18)
  TestAllRequiredTypesProto2_NestedMessage ensureRequiredNestedMessage() =>
      $_ensure(15);

  @$pb.TagNumber(19)
  ForeignMessageProto2 get requiredForeignMessage => $_getN(16);
  @$pb.TagNumber(19)
  set requiredForeignMessage(ForeignMessageProto2 v) {
    setField(19, v);
  }

  @$pb.TagNumber(19)
  $core.bool hasRequiredForeignMessage() => $_has(16);
  @$pb.TagNumber(19)
  void clearRequiredForeignMessage() => clearField(19);
  @$pb.TagNumber(19)
  ForeignMessageProto2 ensureRequiredForeignMessage() => $_ensure(16);

  @$pb.TagNumber(21)
  TestAllRequiredTypesProto2_NestedEnum get requiredNestedEnum => $_getN(17);
  @$pb.TagNumber(21)
  set requiredNestedEnum(TestAllRequiredTypesProto2_NestedEnum v) {
    setField(21, v);
  }

  @$pb.TagNumber(21)
  $core.bool hasRequiredNestedEnum() => $_has(17);
  @$pb.TagNumber(21)
  void clearRequiredNestedEnum() => clearField(21);

  @$pb.TagNumber(22)
  ForeignEnumProto2 get requiredForeignEnum => $_getN(18);
  @$pb.TagNumber(22)
  set requiredForeignEnum(ForeignEnumProto2 v) {
    setField(22, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasRequiredForeignEnum() => $_has(18);
  @$pb.TagNumber(22)
  void clearRequiredForeignEnum() => clearField(22);

  @$pb.TagNumber(24)
  $core.String get requiredStringPiece => $_getSZ(19);
  @$pb.TagNumber(24)
  set requiredStringPiece($core.String v) {
    $_setString(19, v);
  }

  @$pb.TagNumber(24)
  $core.bool hasRequiredStringPiece() => $_has(19);
  @$pb.TagNumber(24)
  void clearRequiredStringPiece() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get requiredCord => $_getSZ(20);
  @$pb.TagNumber(25)
  set requiredCord($core.String v) {
    $_setString(20, v);
  }

  @$pb.TagNumber(25)
  $core.bool hasRequiredCord() => $_has(20);
  @$pb.TagNumber(25)
  void clearRequiredCord() => clearField(25);

  @$pb.TagNumber(27)
  TestAllRequiredTypesProto2 get recursiveMessage => $_getN(21);
  @$pb.TagNumber(27)
  set recursiveMessage(TestAllRequiredTypesProto2 v) {
    setField(27, v);
  }

  @$pb.TagNumber(27)
  $core.bool hasRecursiveMessage() => $_has(21);
  @$pb.TagNumber(27)
  void clearRecursiveMessage() => clearField(27);
  @$pb.TagNumber(27)
  TestAllRequiredTypesProto2 ensureRecursiveMessage() => $_ensure(21);

  @$pb.TagNumber(28)
  TestAllRequiredTypesProto2 get optionalRecursiveMessage => $_getN(22);
  @$pb.TagNumber(28)
  set optionalRecursiveMessage(TestAllRequiredTypesProto2 v) {
    setField(28, v);
  }

  @$pb.TagNumber(28)
  $core.bool hasOptionalRecursiveMessage() => $_has(22);
  @$pb.TagNumber(28)
  void clearOptionalRecursiveMessage() => clearField(28);
  @$pb.TagNumber(28)
  TestAllRequiredTypesProto2 ensureOptionalRecursiveMessage() => $_ensure(22);

  @$pb.TagNumber(201)
  TestAllRequiredTypesProto2_Data get data => $_getN(23);
  @$pb.TagNumber(201)
  set data(TestAllRequiredTypesProto2_Data v) {
    setField(201, v);
  }

  @$pb.TagNumber(201)
  $core.bool hasData() => $_has(23);
  @$pb.TagNumber(201)
  void clearData() => clearField(201);

  /// default values
  @$pb.TagNumber(241)
  $core.int get defaultInt32 => $_getI(24, -123456789);
  @$pb.TagNumber(241)
  set defaultInt32($core.int v) {
    $_setSignedInt32(24, v);
  }

  @$pb.TagNumber(241)
  $core.bool hasDefaultInt32() => $_has(24);
  @$pb.TagNumber(241)
  void clearDefaultInt32() => clearField(241);

  @$pb.TagNumber(242)
  $fixnum.Int64 get defaultInt64 => $_getI64(25);
  @$pb.TagNumber(242)
  set defaultInt64($fixnum.Int64 v) {
    $_setInt64(25, v);
  }

  @$pb.TagNumber(242)
  $core.bool hasDefaultInt64() => $_has(25);
  @$pb.TagNumber(242)
  void clearDefaultInt64() => clearField(242);

  @$pb.TagNumber(243)
  $core.int get defaultUint32 => $_getI(26, 2123456789);
  @$pb.TagNumber(243)
  set defaultUint32($core.int v) {
    $_setUnsignedInt32(26, v);
  }

  @$pb.TagNumber(243)
  $core.bool hasDefaultUint32() => $_has(26);
  @$pb.TagNumber(243)
  void clearDefaultUint32() => clearField(243);

  @$pb.TagNumber(244)
  $fixnum.Int64 get defaultUint64 => $_getI64(27);
  @$pb.TagNumber(244)
  set defaultUint64($fixnum.Int64 v) {
    $_setInt64(27, v);
  }

  @$pb.TagNumber(244)
  $core.bool hasDefaultUint64() => $_has(27);
  @$pb.TagNumber(244)
  void clearDefaultUint64() => clearField(244);

  @$pb.TagNumber(245)
  $core.int get defaultSint32 => $_getI(28, -123456789);
  @$pb.TagNumber(245)
  set defaultSint32($core.int v) {
    $_setSignedInt32(28, v);
  }

  @$pb.TagNumber(245)
  $core.bool hasDefaultSint32() => $_has(28);
  @$pb.TagNumber(245)
  void clearDefaultSint32() => clearField(245);

  @$pb.TagNumber(246)
  $fixnum.Int64 get defaultSint64 => $_getI64(29);
  @$pb.TagNumber(246)
  set defaultSint64($fixnum.Int64 v) {
    $_setInt64(29, v);
  }

  @$pb.TagNumber(246)
  $core.bool hasDefaultSint64() => $_has(29);
  @$pb.TagNumber(246)
  void clearDefaultSint64() => clearField(246);

  @$pb.TagNumber(247)
  $core.int get defaultFixed32 => $_getI(30, 2123456789);
  @$pb.TagNumber(247)
  set defaultFixed32($core.int v) {
    $_setUnsignedInt32(30, v);
  }

  @$pb.TagNumber(247)
  $core.bool hasDefaultFixed32() => $_has(30);
  @$pb.TagNumber(247)
  void clearDefaultFixed32() => clearField(247);

  @$pb.TagNumber(248)
  $fixnum.Int64 get defaultFixed64 => $_getI64(31);
  @$pb.TagNumber(248)
  set defaultFixed64($fixnum.Int64 v) {
    $_setInt64(31, v);
  }

  @$pb.TagNumber(248)
  $core.bool hasDefaultFixed64() => $_has(31);
  @$pb.TagNumber(248)
  void clearDefaultFixed64() => clearField(248);

  @$pb.TagNumber(249)
  $core.int get defaultSfixed32 => $_getI(32, -123456789);
  @$pb.TagNumber(249)
  set defaultSfixed32($core.int v) {
    $_setSignedInt32(32, v);
  }

  @$pb.TagNumber(249)
  $core.bool hasDefaultSfixed32() => $_has(32);
  @$pb.TagNumber(249)
  void clearDefaultSfixed32() => clearField(249);

  @$pb.TagNumber(250)
  $fixnum.Int64 get defaultSfixed64 => $_getI64(33);
  @$pb.TagNumber(250)
  set defaultSfixed64($fixnum.Int64 v) {
    $_setInt64(33, v);
  }

  @$pb.TagNumber(250)
  $core.bool hasDefaultSfixed64() => $_has(33);
  @$pb.TagNumber(250)
  void clearDefaultSfixed64() => clearField(250);

  @$pb.TagNumber(251)
  $core.double get defaultFloat => $_getN(34);
  @$pb.TagNumber(251)
  set defaultFloat($core.double v) {
    $_setFloat(34, v);
  }

  @$pb.TagNumber(251)
  $core.bool hasDefaultFloat() => $_has(34);
  @$pb.TagNumber(251)
  void clearDefaultFloat() => clearField(251);

  @$pb.TagNumber(252)
  $core.double get defaultDouble => $_getN(35);
  @$pb.TagNumber(252)
  set defaultDouble($core.double v) {
    $_setDouble(35, v);
  }

  @$pb.TagNumber(252)
  $core.bool hasDefaultDouble() => $_has(35);
  @$pb.TagNumber(252)
  void clearDefaultDouble() => clearField(252);

  @$pb.TagNumber(253)
  $core.bool get defaultBool => $_getB(36, true);
  @$pb.TagNumber(253)
  set defaultBool($core.bool v) {
    $_setBool(36, v);
  }

  @$pb.TagNumber(253)
  $core.bool hasDefaultBool() => $_has(36);
  @$pb.TagNumber(253)
  void clearDefaultBool() => clearField(253);

  @$pb.TagNumber(254)
  $core.String get defaultString => $_getS(37, 'Rosebud');
  @$pb.TagNumber(254)
  set defaultString($core.String v) {
    $_setString(37, v);
  }

  @$pb.TagNumber(254)
  $core.bool hasDefaultString() => $_has(37);
  @$pb.TagNumber(254)
  void clearDefaultString() => clearField(254);

  @$pb.TagNumber(255)
  $core.List<$core.int> get defaultBytes => $_getN(38);
  @$pb.TagNumber(255)
  set defaultBytes($core.List<$core.int> v) {
    $_setBytes(38, v);
  }

  @$pb.TagNumber(255)
  $core.bool hasDefaultBytes() => $_has(38);
  @$pb.TagNumber(255)
  void clearDefaultBytes() => clearField(255);
}

class Test_messages_proto2 {
  static final extensionInt32 = $pb.Extension<$core.int>(
      _omitMessageNames
          ? ''
          : 'protobuf_test_messages.proto2.TestAllTypesProto2',
      _omitFieldNames ? '' : 'extensionInt32',
      120,
      $pb.PbFieldType.O3);
  static final groupField = $pb.Extension<GroupField>(
      _omitMessageNames
          ? ''
          : 'protobuf_test_messages.proto2.TestAllTypesProto2',
      _omitFieldNames ? '' : 'groupField',
      121,
      $pb.PbFieldType.OG,
      defaultOrMaker: GroupField.getDefault,
      subBuilder: GroupField.create);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(extensionInt32);
    registry.add(groupField);
  }
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
