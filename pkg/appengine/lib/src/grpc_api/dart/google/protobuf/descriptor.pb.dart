//
//  Generated code. Do not modify.
//  source: google/protobuf/descriptor.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'descriptor.pbenum.dart';

export 'descriptor.pbenum.dart';

/// The protocol compiler can output a FileDescriptorSet containing the .proto
/// files it parses.
class FileDescriptorSet extends $pb.GeneratedMessage {
  factory FileDescriptorSet({
    $core.Iterable<FileDescriptorProto>? file,
  }) {
    final $result = create();
    if (file != null) {
      $result.file.addAll(file);
    }
    return $result;
  }
  FileDescriptorSet._() : super();
  factory FileDescriptorSet.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FileDescriptorSet.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileDescriptorSet',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..pc<FileDescriptorProto>(
        1, _omitFieldNames ? '' : 'file', $pb.PbFieldType.PM,
        subBuilder: FileDescriptorProto.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FileDescriptorSet clone() => FileDescriptorSet()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FileDescriptorSet copyWith(void Function(FileDescriptorSet) updates) =>
      super.copyWith((message) => updates(message as FileDescriptorSet))
          as FileDescriptorSet;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileDescriptorSet create() => FileDescriptorSet._();
  FileDescriptorSet createEmptyInstance() => create();
  static $pb.PbList<FileDescriptorSet> createRepeated() =>
      $pb.PbList<FileDescriptorSet>();
  @$core.pragma('dart2js:noInline')
  static FileDescriptorSet getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileDescriptorSet>(create);
  static FileDescriptorSet? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FileDescriptorProto> get file => $_getList(0);
}

/// Describes a complete .proto file.
class FileDescriptorProto extends $pb.GeneratedMessage {
  factory FileDescriptorProto({
    $core.String? name,
    $core.String? package,
    $core.Iterable<$core.String>? dependency,
    $core.Iterable<DescriptorProto>? messageType,
    $core.Iterable<EnumDescriptorProto>? enumType,
    $core.Iterable<ServiceDescriptorProto>? service,
    $core.Iterable<FieldDescriptorProto>? extension,
    FileOptions? options,
    SourceCodeInfo? sourceCodeInfo,
    $core.Iterable<$core.int>? publicDependency,
    $core.Iterable<$core.int>? weakDependency,
    $core.String? syntax,
    Edition? edition,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (package != null) {
      $result.package = package;
    }
    if (dependency != null) {
      $result.dependency.addAll(dependency);
    }
    if (messageType != null) {
      $result.messageType.addAll(messageType);
    }
    if (enumType != null) {
      $result.enumType.addAll(enumType);
    }
    if (service != null) {
      $result.service.addAll(service);
    }
    if (extension != null) {
      $result.extension.addAll(extension);
    }
    if (options != null) {
      $result.options = options;
    }
    if (sourceCodeInfo != null) {
      $result.sourceCodeInfo = sourceCodeInfo;
    }
    if (publicDependency != null) {
      $result.publicDependency.addAll(publicDependency);
    }
    if (weakDependency != null) {
      $result.weakDependency.addAll(weakDependency);
    }
    if (syntax != null) {
      $result.syntax = syntax;
    }
    if (edition != null) {
      $result.edition = edition;
    }
    return $result;
  }
  FileDescriptorProto._() : super();
  factory FileDescriptorProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FileDescriptorProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileDescriptorProto',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'package')
    ..pPS(3, _omitFieldNames ? '' : 'dependency')
    ..pc<DescriptorProto>(
        4, _omitFieldNames ? '' : 'messageType', $pb.PbFieldType.PM,
        subBuilder: DescriptorProto.create)
    ..pc<EnumDescriptorProto>(
        5, _omitFieldNames ? '' : 'enumType', $pb.PbFieldType.PM,
        subBuilder: EnumDescriptorProto.create)
    ..pc<ServiceDescriptorProto>(
        6, _omitFieldNames ? '' : 'service', $pb.PbFieldType.PM,
        subBuilder: ServiceDescriptorProto.create)
    ..pc<FieldDescriptorProto>(
        7, _omitFieldNames ? '' : 'extension', $pb.PbFieldType.PM,
        subBuilder: FieldDescriptorProto.create)
    ..aOM<FileOptions>(8, _omitFieldNames ? '' : 'options',
        subBuilder: FileOptions.create)
    ..aOM<SourceCodeInfo>(9, _omitFieldNames ? '' : 'sourceCodeInfo',
        subBuilder: SourceCodeInfo.create)
    ..p<$core.int>(
        10, _omitFieldNames ? '' : 'publicDependency', $pb.PbFieldType.P3)
    ..p<$core.int>(
        11, _omitFieldNames ? '' : 'weakDependency', $pb.PbFieldType.P3)
    ..aOS(12, _omitFieldNames ? '' : 'syntax')
    ..e<Edition>(14, _omitFieldNames ? '' : 'edition', $pb.PbFieldType.OE,
        defaultOrMaker: Edition.EDITION_UNKNOWN,
        valueOf: Edition.valueOf,
        enumValues: Edition.values);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FileDescriptorProto clone() => FileDescriptorProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FileDescriptorProto copyWith(void Function(FileDescriptorProto) updates) =>
      super.copyWith((message) => updates(message as FileDescriptorProto))
          as FileDescriptorProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileDescriptorProto create() => FileDescriptorProto._();
  FileDescriptorProto createEmptyInstance() => create();
  static $pb.PbList<FileDescriptorProto> createRepeated() =>
      $pb.PbList<FileDescriptorProto>();
  @$core.pragma('dart2js:noInline')
  static FileDescriptorProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileDescriptorProto>(create);
  static FileDescriptorProto? _defaultInstance;

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

  @$pb.TagNumber(2)
  $core.String get package => $_getSZ(1);
  @$pb.TagNumber(2)
  set package($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPackage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPackage() => clearField(2);

  /// Names of files imported by this file.
  @$pb.TagNumber(3)
  $core.List<$core.String> get dependency => $_getList(2);

  /// All top-level definitions in this file.
  @$pb.TagNumber(4)
  $core.List<DescriptorProto> get messageType => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<EnumDescriptorProto> get enumType => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<ServiceDescriptorProto> get service => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<FieldDescriptorProto> get extension => $_getList(6);

  @$pb.TagNumber(8)
  FileOptions get options => $_getN(7);
  @$pb.TagNumber(8)
  set options(FileOptions v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasOptions() => $_has(7);
  @$pb.TagNumber(8)
  void clearOptions() => clearField(8);
  @$pb.TagNumber(8)
  FileOptions ensureOptions() => $_ensure(7);

  /// This field contains optional information about the original source code.
  /// You may safely remove this entire field without harming runtime
  /// functionality of the descriptors -- the information is needed only by
  /// development tools.
  @$pb.TagNumber(9)
  SourceCodeInfo get sourceCodeInfo => $_getN(8);
  @$pb.TagNumber(9)
  set sourceCodeInfo(SourceCodeInfo v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasSourceCodeInfo() => $_has(8);
  @$pb.TagNumber(9)
  void clearSourceCodeInfo() => clearField(9);
  @$pb.TagNumber(9)
  SourceCodeInfo ensureSourceCodeInfo() => $_ensure(8);

  /// Indexes of the public imported files in the dependency list above.
  @$pb.TagNumber(10)
  $core.List<$core.int> get publicDependency => $_getList(9);

  /// Indexes of the weak imported files in the dependency list.
  /// For Google-internal migration only. Do not use.
  @$pb.TagNumber(11)
  $core.List<$core.int> get weakDependency => $_getList(10);

  ///  The syntax of the proto file.
  ///  The supported values are "proto2", "proto3", and "editions".
  ///
  ///  If `edition` is present, this value must be "editions".
  @$pb.TagNumber(12)
  $core.String get syntax => $_getSZ(11);
  @$pb.TagNumber(12)
  set syntax($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasSyntax() => $_has(11);
  @$pb.TagNumber(12)
  void clearSyntax() => clearField(12);

  /// The edition of the proto file.
  @$pb.TagNumber(14)
  Edition get edition => $_getN(12);
  @$pb.TagNumber(14)
  set edition(Edition v) {
    setField(14, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasEdition() => $_has(12);
  @$pb.TagNumber(14)
  void clearEdition() => clearField(14);
}

class DescriptorProto_ExtensionRange extends $pb.GeneratedMessage {
  factory DescriptorProto_ExtensionRange({
    $core.int? start,
    $core.int? end,
    ExtensionRangeOptions? options,
  }) {
    final $result = create();
    if (start != null) {
      $result.start = start;
    }
    if (end != null) {
      $result.end = end;
    }
    if (options != null) {
      $result.options = options;
    }
    return $result;
  }
  DescriptorProto_ExtensionRange._() : super();
  factory DescriptorProto_ExtensionRange.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DescriptorProto_ExtensionRange.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DescriptorProto.ExtensionRange',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'start', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'end', $pb.PbFieldType.O3)
    ..aOM<ExtensionRangeOptions>(3, _omitFieldNames ? '' : 'options',
        subBuilder: ExtensionRangeOptions.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DescriptorProto_ExtensionRange clone() =>
      DescriptorProto_ExtensionRange()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DescriptorProto_ExtensionRange copyWith(
          void Function(DescriptorProto_ExtensionRange) updates) =>
      super.copyWith(
              (message) => updates(message as DescriptorProto_ExtensionRange))
          as DescriptorProto_ExtensionRange;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DescriptorProto_ExtensionRange create() =>
      DescriptorProto_ExtensionRange._();
  DescriptorProto_ExtensionRange createEmptyInstance() => create();
  static $pb.PbList<DescriptorProto_ExtensionRange> createRepeated() =>
      $pb.PbList<DescriptorProto_ExtensionRange>();
  @$core.pragma('dart2js:noInline')
  static DescriptorProto_ExtensionRange getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DescriptorProto_ExtensionRange>(create);
  static DescriptorProto_ExtensionRange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get start => $_getIZ(0);
  @$pb.TagNumber(1)
  set start($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get end => $_getIZ(1);
  @$pb.TagNumber(2)
  set end($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);

  @$pb.TagNumber(3)
  ExtensionRangeOptions get options => $_getN(2);
  @$pb.TagNumber(3)
  set options(ExtensionRangeOptions v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOptions() => $_has(2);
  @$pb.TagNumber(3)
  void clearOptions() => clearField(3);
  @$pb.TagNumber(3)
  ExtensionRangeOptions ensureOptions() => $_ensure(2);
}

/// Range of reserved tag numbers. Reserved tag numbers may not be used by
/// fields or extension ranges in the same message. Reserved ranges may
/// not overlap.
class DescriptorProto_ReservedRange extends $pb.GeneratedMessage {
  factory DescriptorProto_ReservedRange({
    $core.int? start,
    $core.int? end,
  }) {
    final $result = create();
    if (start != null) {
      $result.start = start;
    }
    if (end != null) {
      $result.end = end;
    }
    return $result;
  }
  DescriptorProto_ReservedRange._() : super();
  factory DescriptorProto_ReservedRange.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DescriptorProto_ReservedRange.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DescriptorProto.ReservedRange',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'start', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'end', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DescriptorProto_ReservedRange clone() =>
      DescriptorProto_ReservedRange()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DescriptorProto_ReservedRange copyWith(
          void Function(DescriptorProto_ReservedRange) updates) =>
      super.copyWith(
              (message) => updates(message as DescriptorProto_ReservedRange))
          as DescriptorProto_ReservedRange;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DescriptorProto_ReservedRange create() =>
      DescriptorProto_ReservedRange._();
  DescriptorProto_ReservedRange createEmptyInstance() => create();
  static $pb.PbList<DescriptorProto_ReservedRange> createRepeated() =>
      $pb.PbList<DescriptorProto_ReservedRange>();
  @$core.pragma('dart2js:noInline')
  static DescriptorProto_ReservedRange getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DescriptorProto_ReservedRange>(create);
  static DescriptorProto_ReservedRange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get start => $_getIZ(0);
  @$pb.TagNumber(1)
  set start($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get end => $_getIZ(1);
  @$pb.TagNumber(2)
  set end($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);
}

/// Describes a message type.
class DescriptorProto extends $pb.GeneratedMessage {
  factory DescriptorProto({
    $core.String? name,
    $core.Iterable<FieldDescriptorProto>? field,
    $core.Iterable<DescriptorProto>? nestedType,
    $core.Iterable<EnumDescriptorProto>? enumType,
    $core.Iterable<DescriptorProto_ExtensionRange>? extensionRange,
    $core.Iterable<FieldDescriptorProto>? extension,
    MessageOptions? options,
    $core.Iterable<OneofDescriptorProto>? oneofDecl,
    $core.Iterable<DescriptorProto_ReservedRange>? reservedRange,
    $core.Iterable<$core.String>? reservedName,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (field != null) {
      $result.field.addAll(field);
    }
    if (nestedType != null) {
      $result.nestedType.addAll(nestedType);
    }
    if (enumType != null) {
      $result.enumType.addAll(enumType);
    }
    if (extensionRange != null) {
      $result.extensionRange.addAll(extensionRange);
    }
    if (extension != null) {
      $result.extension.addAll(extension);
    }
    if (options != null) {
      $result.options = options;
    }
    if (oneofDecl != null) {
      $result.oneofDecl.addAll(oneofDecl);
    }
    if (reservedRange != null) {
      $result.reservedRange.addAll(reservedRange);
    }
    if (reservedName != null) {
      $result.reservedName.addAll(reservedName);
    }
    return $result;
  }
  DescriptorProto._() : super();
  factory DescriptorProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DescriptorProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DescriptorProto',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<FieldDescriptorProto>(
        2, _omitFieldNames ? '' : 'field', $pb.PbFieldType.PM,
        subBuilder: FieldDescriptorProto.create)
    ..pc<DescriptorProto>(
        3, _omitFieldNames ? '' : 'nestedType', $pb.PbFieldType.PM,
        subBuilder: DescriptorProto.create)
    ..pc<EnumDescriptorProto>(
        4, _omitFieldNames ? '' : 'enumType', $pb.PbFieldType.PM,
        subBuilder: EnumDescriptorProto.create)
    ..pc<DescriptorProto_ExtensionRange>(
        5, _omitFieldNames ? '' : 'extensionRange', $pb.PbFieldType.PM,
        subBuilder: DescriptorProto_ExtensionRange.create)
    ..pc<FieldDescriptorProto>(
        6, _omitFieldNames ? '' : 'extension', $pb.PbFieldType.PM,
        subBuilder: FieldDescriptorProto.create)
    ..aOM<MessageOptions>(7, _omitFieldNames ? '' : 'options',
        subBuilder: MessageOptions.create)
    ..pc<OneofDescriptorProto>(
        8, _omitFieldNames ? '' : 'oneofDecl', $pb.PbFieldType.PM,
        subBuilder: OneofDescriptorProto.create)
    ..pc<DescriptorProto_ReservedRange>(
        9, _omitFieldNames ? '' : 'reservedRange', $pb.PbFieldType.PM,
        subBuilder: DescriptorProto_ReservedRange.create)
    ..pPS(10, _omitFieldNames ? '' : 'reservedName');

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DescriptorProto clone() => DescriptorProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DescriptorProto copyWith(void Function(DescriptorProto) updates) =>
      super.copyWith((message) => updates(message as DescriptorProto))
          as DescriptorProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DescriptorProto create() => DescriptorProto._();
  DescriptorProto createEmptyInstance() => create();
  static $pb.PbList<DescriptorProto> createRepeated() =>
      $pb.PbList<DescriptorProto>();
  @$core.pragma('dart2js:noInline')
  static DescriptorProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DescriptorProto>(create);
  static DescriptorProto? _defaultInstance;

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

  @$pb.TagNumber(2)
  $core.List<FieldDescriptorProto> get field => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<DescriptorProto> get nestedType => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<EnumDescriptorProto> get enumType => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<DescriptorProto_ExtensionRange> get extensionRange => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<FieldDescriptorProto> get extension => $_getList(5);

  @$pb.TagNumber(7)
  MessageOptions get options => $_getN(6);
  @$pb.TagNumber(7)
  set options(MessageOptions v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasOptions() => $_has(6);
  @$pb.TagNumber(7)
  void clearOptions() => clearField(7);
  @$pb.TagNumber(7)
  MessageOptions ensureOptions() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.List<OneofDescriptorProto> get oneofDecl => $_getList(7);

  @$pb.TagNumber(9)
  $core.List<DescriptorProto_ReservedRange> get reservedRange => $_getList(8);

  /// Reserved field names, which may not be used by fields in the same message.
  /// A given name may only be reserved once.
  @$pb.TagNumber(10)
  $core.List<$core.String> get reservedName => $_getList(9);
}

class ExtensionRangeOptions_Declaration extends $pb.GeneratedMessage {
  factory ExtensionRangeOptions_Declaration({
    $core.int? number,
    $core.String? fullName,
    $core.String? type,
    $core.bool? reserved,
    $core.bool? repeated,
  }) {
    final $result = create();
    if (number != null) {
      $result.number = number;
    }
    if (fullName != null) {
      $result.fullName = fullName;
    }
    if (type != null) {
      $result.type = type;
    }
    if (reserved != null) {
      $result.reserved = reserved;
    }
    if (repeated != null) {
      $result.repeated = repeated;
    }
    return $result;
  }
  ExtensionRangeOptions_Declaration._() : super();
  factory ExtensionRangeOptions_Declaration.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExtensionRangeOptions_Declaration.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExtensionRangeOptions.Declaration',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'number', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'fullName')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOB(5, _omitFieldNames ? '' : 'reserved')
    ..aOB(6, _omitFieldNames ? '' : 'repeated')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExtensionRangeOptions_Declaration clone() =>
      ExtensionRangeOptions_Declaration()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExtensionRangeOptions_Declaration copyWith(
          void Function(ExtensionRangeOptions_Declaration) updates) =>
      super.copyWith((message) =>
              updates(message as ExtensionRangeOptions_Declaration))
          as ExtensionRangeOptions_Declaration;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExtensionRangeOptions_Declaration create() =>
      ExtensionRangeOptions_Declaration._();
  ExtensionRangeOptions_Declaration createEmptyInstance() => create();
  static $pb.PbList<ExtensionRangeOptions_Declaration> createRepeated() =>
      $pb.PbList<ExtensionRangeOptions_Declaration>();
  @$core.pragma('dart2js:noInline')
  static ExtensionRangeOptions_Declaration getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExtensionRangeOptions_Declaration>(
          create);
  static ExtensionRangeOptions_Declaration? _defaultInstance;

  /// The extension number declared within the extension range.
  @$pb.TagNumber(1)
  $core.int get number => $_getIZ(0);
  @$pb.TagNumber(1)
  set number($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearNumber() => clearField(1);

  /// The fully-qualified name of the extension field. There must be a leading
  /// dot in front of the full name.
  @$pb.TagNumber(2)
  $core.String get fullName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fullName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFullName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFullName() => clearField(2);

  /// The fully-qualified type name of the extension field. Unlike
  /// Metadata.type, Declaration.type must have a leading dot for messages
  /// and enums.
  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  /// If true, indicates that the number is reserved in the extension range,
  /// and any extension field with the number will fail to compile. Set this
  /// when a declared extension field is deleted.
  @$pb.TagNumber(5)
  $core.bool get reserved => $_getBF(3);
  @$pb.TagNumber(5)
  set reserved($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasReserved() => $_has(3);
  @$pb.TagNumber(5)
  void clearReserved() => clearField(5);

  /// If true, indicates that the extension must be defined as repeated.
  /// Otherwise the extension must be defined as optional.
  @$pb.TagNumber(6)
  $core.bool get repeated => $_getBF(4);
  @$pb.TagNumber(6)
  set repeated($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasRepeated() => $_has(4);
  @$pb.TagNumber(6)
  void clearRepeated() => clearField(6);
}

class ExtensionRangeOptions extends $pb.GeneratedMessage {
  factory ExtensionRangeOptions({
    $core.Iterable<ExtensionRangeOptions_Declaration>? declaration,
    ExtensionRangeOptions_VerificationState? verification,
    FeatureSet? features,
    $core.Iterable<UninterpretedOption>? uninterpretedOption,
  }) {
    final $result = create();
    if (declaration != null) {
      $result.declaration.addAll(declaration);
    }
    if (verification != null) {
      $result.verification = verification;
    }
    if (features != null) {
      $result.features = features;
    }
    if (uninterpretedOption != null) {
      $result.uninterpretedOption.addAll(uninterpretedOption);
    }
    return $result;
  }
  ExtensionRangeOptions._() : super();
  factory ExtensionRangeOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExtensionRangeOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExtensionRangeOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..pc<ExtensionRangeOptions_Declaration>(
        2, _omitFieldNames ? '' : 'declaration', $pb.PbFieldType.PM,
        subBuilder: ExtensionRangeOptions_Declaration.create)
    ..e<ExtensionRangeOptions_VerificationState>(
        3, _omitFieldNames ? '' : 'verification', $pb.PbFieldType.OE,
        defaultOrMaker: ExtensionRangeOptions_VerificationState.UNVERIFIED,
        valueOf: ExtensionRangeOptions_VerificationState.valueOf,
        enumValues: ExtensionRangeOptions_VerificationState.values)
    ..aOM<FeatureSet>(50, _omitFieldNames ? '' : 'features',
        subBuilder: FeatureSet.create)
    ..pc<UninterpretedOption>(
        999, _omitFieldNames ? '' : 'uninterpretedOption', $pb.PbFieldType.PM,
        subBuilder: UninterpretedOption.create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExtensionRangeOptions clone() =>
      ExtensionRangeOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExtensionRangeOptions copyWith(
          void Function(ExtensionRangeOptions) updates) =>
      super.copyWith((message) => updates(message as ExtensionRangeOptions))
          as ExtensionRangeOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExtensionRangeOptions create() => ExtensionRangeOptions._();
  ExtensionRangeOptions createEmptyInstance() => create();
  static $pb.PbList<ExtensionRangeOptions> createRepeated() =>
      $pb.PbList<ExtensionRangeOptions>();
  @$core.pragma('dart2js:noInline')
  static ExtensionRangeOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExtensionRangeOptions>(create);
  static ExtensionRangeOptions? _defaultInstance;

  /// For external users: DO NOT USE. We are in the process of open sourcing
  /// extension declaration and executing internal cleanups before it can be
  /// used externally.
  @$pb.TagNumber(2)
  $core.List<ExtensionRangeOptions_Declaration> get declaration => $_getList(0);

  /// The verification state of the range.
  /// TODO: flip the default to DECLARATION once all empty ranges
  /// are marked as UNVERIFIED.
  @$pb.TagNumber(3)
  ExtensionRangeOptions_VerificationState get verification => $_getN(1);
  @$pb.TagNumber(3)
  set verification(ExtensionRangeOptions_VerificationState v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasVerification() => $_has(1);
  @$pb.TagNumber(3)
  void clearVerification() => clearField(3);

  /// Any features defined in the specific edition.
  @$pb.TagNumber(50)
  FeatureSet get features => $_getN(2);
  @$pb.TagNumber(50)
  set features(FeatureSet v) {
    setField(50, v);
  }

  @$pb.TagNumber(50)
  $core.bool hasFeatures() => $_has(2);
  @$pb.TagNumber(50)
  void clearFeatures() => clearField(50);
  @$pb.TagNumber(50)
  FeatureSet ensureFeatures() => $_ensure(2);

  /// The parser stores options it doesn't recognize here. See above.
  @$pb.TagNumber(999)
  $core.List<UninterpretedOption> get uninterpretedOption => $_getList(3);
}

/// Describes a field within a message.
class FieldDescriptorProto extends $pb.GeneratedMessage {
  factory FieldDescriptorProto({
    $core.String? name,
    $core.String? extendee,
    $core.int? number,
    FieldDescriptorProto_Label? label,
    FieldDescriptorProto_Type? type,
    $core.String? typeName,
    $core.String? defaultValue,
    FieldOptions? options,
    $core.int? oneofIndex,
    $core.String? jsonName,
    $core.bool? proto3Optional,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (extendee != null) {
      $result.extendee = extendee;
    }
    if (number != null) {
      $result.number = number;
    }
    if (label != null) {
      $result.label = label;
    }
    if (type != null) {
      $result.type = type;
    }
    if (typeName != null) {
      $result.typeName = typeName;
    }
    if (defaultValue != null) {
      $result.defaultValue = defaultValue;
    }
    if (options != null) {
      $result.options = options;
    }
    if (oneofIndex != null) {
      $result.oneofIndex = oneofIndex;
    }
    if (jsonName != null) {
      $result.jsonName = jsonName;
    }
    if (proto3Optional != null) {
      $result.proto3Optional = proto3Optional;
    }
    return $result;
  }
  FieldDescriptorProto._() : super();
  factory FieldDescriptorProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FieldDescriptorProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FieldDescriptorProto',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'extendee')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'number', $pb.PbFieldType.O3)
    ..e<FieldDescriptorProto_Label>(
        4, _omitFieldNames ? '' : 'label', $pb.PbFieldType.OE,
        defaultOrMaker: FieldDescriptorProto_Label.LABEL_OPTIONAL,
        valueOf: FieldDescriptorProto_Label.valueOf,
        enumValues: FieldDescriptorProto_Label.values)
    ..e<FieldDescriptorProto_Type>(
        5, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: FieldDescriptorProto_Type.TYPE_DOUBLE,
        valueOf: FieldDescriptorProto_Type.valueOf,
        enumValues: FieldDescriptorProto_Type.values)
    ..aOS(6, _omitFieldNames ? '' : 'typeName')
    ..aOS(7, _omitFieldNames ? '' : 'defaultValue')
    ..aOM<FieldOptions>(8, _omitFieldNames ? '' : 'options',
        subBuilder: FieldOptions.create)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'oneofIndex', $pb.PbFieldType.O3)
    ..aOS(10, _omitFieldNames ? '' : 'jsonName')
    ..aOB(17, _omitFieldNames ? '' : 'proto3Optional');

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FieldDescriptorProto clone() =>
      FieldDescriptorProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FieldDescriptorProto copyWith(void Function(FieldDescriptorProto) updates) =>
      super.copyWith((message) => updates(message as FieldDescriptorProto))
          as FieldDescriptorProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FieldDescriptorProto create() => FieldDescriptorProto._();
  FieldDescriptorProto createEmptyInstance() => create();
  static $pb.PbList<FieldDescriptorProto> createRepeated() =>
      $pb.PbList<FieldDescriptorProto>();
  @$core.pragma('dart2js:noInline')
  static FieldDescriptorProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FieldDescriptorProto>(create);
  static FieldDescriptorProto? _defaultInstance;

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

  /// For extensions, this is the name of the type being extended.  It is
  /// resolved in the same manner as type_name.
  @$pb.TagNumber(2)
  $core.String get extendee => $_getSZ(1);
  @$pb.TagNumber(2)
  set extendee($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasExtendee() => $_has(1);
  @$pb.TagNumber(2)
  void clearExtendee() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get number => $_getIZ(2);
  @$pb.TagNumber(3)
  set number($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumber() => clearField(3);

  @$pb.TagNumber(4)
  FieldDescriptorProto_Label get label => $_getN(3);
  @$pb.TagNumber(4)
  set label(FieldDescriptorProto_Label v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasLabel() => $_has(3);
  @$pb.TagNumber(4)
  void clearLabel() => clearField(4);

  /// If type_name is set, this need not be set.  If both this and type_name
  /// are set, this must be one of TYPE_ENUM, TYPE_MESSAGE or TYPE_GROUP.
  @$pb.TagNumber(5)
  FieldDescriptorProto_Type get type => $_getN(4);
  @$pb.TagNumber(5)
  set type(FieldDescriptorProto_Type v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => clearField(5);

  /// For message and enum types, this is the name of the type.  If the name
  /// starts with a '.', it is fully-qualified.  Otherwise, C++-like scoping
  /// rules are used to find the type (i.e. first the nested types within this
  /// message are searched, then within the parent, on up to the root
  /// namespace).
  @$pb.TagNumber(6)
  $core.String get typeName => $_getSZ(5);
  @$pb.TagNumber(6)
  set typeName($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasTypeName() => $_has(5);
  @$pb.TagNumber(6)
  void clearTypeName() => clearField(6);

  /// For numeric types, contains the original text representation of the value.
  /// For booleans, "true" or "false".
  /// For strings, contains the default text contents (not escaped in any way).
  /// For bytes, contains the C escaped value.  All bytes >= 128 are escaped.
  @$pb.TagNumber(7)
  $core.String get defaultValue => $_getSZ(6);
  @$pb.TagNumber(7)
  set defaultValue($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasDefaultValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearDefaultValue() => clearField(7);

  @$pb.TagNumber(8)
  FieldOptions get options => $_getN(7);
  @$pb.TagNumber(8)
  set options(FieldOptions v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasOptions() => $_has(7);
  @$pb.TagNumber(8)
  void clearOptions() => clearField(8);
  @$pb.TagNumber(8)
  FieldOptions ensureOptions() => $_ensure(7);

  /// If set, gives the index of a oneof in the containing type's oneof_decl
  /// list.  This field is a member of that oneof.
  @$pb.TagNumber(9)
  $core.int get oneofIndex => $_getIZ(8);
  @$pb.TagNumber(9)
  set oneofIndex($core.int v) {
    $_setSignedInt32(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasOneofIndex() => $_has(8);
  @$pb.TagNumber(9)
  void clearOneofIndex() => clearField(9);

  /// JSON name of this field. The value is set by protocol compiler. If the
  /// user has set a "json_name" option on this field, that option's value
  /// will be used. Otherwise, it's deduced from the field's name by converting
  /// it to camelCase.
  @$pb.TagNumber(10)
  $core.String get jsonName => $_getSZ(9);
  @$pb.TagNumber(10)
  set jsonName($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasJsonName() => $_has(9);
  @$pb.TagNumber(10)
  void clearJsonName() => clearField(10);

  ///  If true, this is a proto3 "optional". When a proto3 field is optional, it
  ///  tracks presence regardless of field type.
  ///
  ///  When proto3_optional is true, this field must belong to a oneof to signal
  ///  to old proto3 clients that presence is tracked for this field. This oneof
  ///  is known as a "synthetic" oneof, and this field must be its sole member
  ///  (each proto3 optional field gets its own synthetic oneof). Synthetic oneofs
  ///  exist in the descriptor only, and do not generate any API. Synthetic oneofs
  ///  must be ordered after all "real" oneofs.
  ///
  ///  For message fields, proto3_optional doesn't create any semantic change,
  ///  since non-repeated message fields always track presence. However it still
  ///  indicates the semantic detail of whether the user wrote "optional" or not.
  ///  This can be useful for round-tripping the .proto file. For consistency we
  ///  give message fields a synthetic oneof also, even though it is not required
  ///  to track presence. This is especially important because the parser can't
  ///  tell if a field is a message or an enum, so it must always create a
  ///  synthetic oneof.
  ///
  ///  Proto2 optional fields do not set this flag, because they already indicate
  ///  optional with `LABEL_OPTIONAL`.
  @$pb.TagNumber(17)
  $core.bool get proto3Optional => $_getBF(10);
  @$pb.TagNumber(17)
  set proto3Optional($core.bool v) {
    $_setBool(10, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasProto3Optional() => $_has(10);
  @$pb.TagNumber(17)
  void clearProto3Optional() => clearField(17);
}

/// Describes a oneof.
class OneofDescriptorProto extends $pb.GeneratedMessage {
  factory OneofDescriptorProto({
    $core.String? name,
    OneofOptions? options,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (options != null) {
      $result.options = options;
    }
    return $result;
  }
  OneofDescriptorProto._() : super();
  factory OneofDescriptorProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OneofDescriptorProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OneofDescriptorProto',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<OneofOptions>(2, _omitFieldNames ? '' : 'options',
        subBuilder: OneofOptions.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OneofDescriptorProto clone() =>
      OneofDescriptorProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OneofDescriptorProto copyWith(void Function(OneofDescriptorProto) updates) =>
      super.copyWith((message) => updates(message as OneofDescriptorProto))
          as OneofDescriptorProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OneofDescriptorProto create() => OneofDescriptorProto._();
  OneofDescriptorProto createEmptyInstance() => create();
  static $pb.PbList<OneofDescriptorProto> createRepeated() =>
      $pb.PbList<OneofDescriptorProto>();
  @$core.pragma('dart2js:noInline')
  static OneofDescriptorProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OneofDescriptorProto>(create);
  static OneofDescriptorProto? _defaultInstance;

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

  @$pb.TagNumber(2)
  OneofOptions get options => $_getN(1);
  @$pb.TagNumber(2)
  set options(OneofOptions v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOptions() => $_has(1);
  @$pb.TagNumber(2)
  void clearOptions() => clearField(2);
  @$pb.TagNumber(2)
  OneofOptions ensureOptions() => $_ensure(1);
}

///  Range of reserved numeric values. Reserved values may not be used by
///  entries in the same enum. Reserved ranges may not overlap.
///
///  Note that this is distinct from DescriptorProto.ReservedRange in that it
///  is inclusive such that it can appropriately represent the entire int32
///  domain.
class EnumDescriptorProto_EnumReservedRange extends $pb.GeneratedMessage {
  factory EnumDescriptorProto_EnumReservedRange({
    $core.int? start,
    $core.int? end,
  }) {
    final $result = create();
    if (start != null) {
      $result.start = start;
    }
    if (end != null) {
      $result.end = end;
    }
    return $result;
  }
  EnumDescriptorProto_EnumReservedRange._() : super();
  factory EnumDescriptorProto_EnumReservedRange.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnumDescriptorProto_EnumReservedRange.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnumDescriptorProto.EnumReservedRange',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'start', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'end', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnumDescriptorProto_EnumReservedRange clone() =>
      EnumDescriptorProto_EnumReservedRange()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnumDescriptorProto_EnumReservedRange copyWith(
          void Function(EnumDescriptorProto_EnumReservedRange) updates) =>
      super.copyWith((message) =>
              updates(message as EnumDescriptorProto_EnumReservedRange))
          as EnumDescriptorProto_EnumReservedRange;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnumDescriptorProto_EnumReservedRange create() =>
      EnumDescriptorProto_EnumReservedRange._();
  EnumDescriptorProto_EnumReservedRange createEmptyInstance() => create();
  static $pb.PbList<EnumDescriptorProto_EnumReservedRange> createRepeated() =>
      $pb.PbList<EnumDescriptorProto_EnumReservedRange>();
  @$core.pragma('dart2js:noInline')
  static EnumDescriptorProto_EnumReservedRange getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          EnumDescriptorProto_EnumReservedRange>(create);
  static EnumDescriptorProto_EnumReservedRange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get start => $_getIZ(0);
  @$pb.TagNumber(1)
  set start($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get end => $_getIZ(1);
  @$pb.TagNumber(2)
  set end($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);
}

/// Describes an enum type.
class EnumDescriptorProto extends $pb.GeneratedMessage {
  factory EnumDescriptorProto({
    $core.String? name,
    $core.Iterable<EnumValueDescriptorProto>? value,
    EnumOptions? options,
    $core.Iterable<EnumDescriptorProto_EnumReservedRange>? reservedRange,
    $core.Iterable<$core.String>? reservedName,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (value != null) {
      $result.value.addAll(value);
    }
    if (options != null) {
      $result.options = options;
    }
    if (reservedRange != null) {
      $result.reservedRange.addAll(reservedRange);
    }
    if (reservedName != null) {
      $result.reservedName.addAll(reservedName);
    }
    return $result;
  }
  EnumDescriptorProto._() : super();
  factory EnumDescriptorProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnumDescriptorProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnumDescriptorProto',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<EnumValueDescriptorProto>(
        2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.PM,
        subBuilder: EnumValueDescriptorProto.create)
    ..aOM<EnumOptions>(3, _omitFieldNames ? '' : 'options',
        subBuilder: EnumOptions.create)
    ..pc<EnumDescriptorProto_EnumReservedRange>(
        4, _omitFieldNames ? '' : 'reservedRange', $pb.PbFieldType.PM,
        subBuilder: EnumDescriptorProto_EnumReservedRange.create)
    ..pPS(5, _omitFieldNames ? '' : 'reservedName');

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnumDescriptorProto clone() => EnumDescriptorProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnumDescriptorProto copyWith(void Function(EnumDescriptorProto) updates) =>
      super.copyWith((message) => updates(message as EnumDescriptorProto))
          as EnumDescriptorProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnumDescriptorProto create() => EnumDescriptorProto._();
  EnumDescriptorProto createEmptyInstance() => create();
  static $pb.PbList<EnumDescriptorProto> createRepeated() =>
      $pb.PbList<EnumDescriptorProto>();
  @$core.pragma('dart2js:noInline')
  static EnumDescriptorProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnumDescriptorProto>(create);
  static EnumDescriptorProto? _defaultInstance;

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

  @$pb.TagNumber(2)
  $core.List<EnumValueDescriptorProto> get value => $_getList(1);

  @$pb.TagNumber(3)
  EnumOptions get options => $_getN(2);
  @$pb.TagNumber(3)
  set options(EnumOptions v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOptions() => $_has(2);
  @$pb.TagNumber(3)
  void clearOptions() => clearField(3);
  @$pb.TagNumber(3)
  EnumOptions ensureOptions() => $_ensure(2);

  /// Range of reserved numeric values. Reserved numeric values may not be used
  /// by enum values in the same enum declaration. Reserved ranges may not
  /// overlap.
  @$pb.TagNumber(4)
  $core.List<EnumDescriptorProto_EnumReservedRange> get reservedRange =>
      $_getList(3);

  /// Reserved enum value names, which may not be reused. A given name may only
  /// be reserved once.
  @$pb.TagNumber(5)
  $core.List<$core.String> get reservedName => $_getList(4);
}

/// Describes a value within an enum.
class EnumValueDescriptorProto extends $pb.GeneratedMessage {
  factory EnumValueDescriptorProto({
    $core.String? name,
    $core.int? number,
    EnumValueOptions? options,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (number != null) {
      $result.number = number;
    }
    if (options != null) {
      $result.options = options;
    }
    return $result;
  }
  EnumValueDescriptorProto._() : super();
  factory EnumValueDescriptorProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnumValueDescriptorProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnumValueDescriptorProto',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'number', $pb.PbFieldType.O3)
    ..aOM<EnumValueOptions>(3, _omitFieldNames ? '' : 'options',
        subBuilder: EnumValueOptions.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnumValueDescriptorProto clone() =>
      EnumValueDescriptorProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnumValueDescriptorProto copyWith(
          void Function(EnumValueDescriptorProto) updates) =>
      super.copyWith((message) => updates(message as EnumValueDescriptorProto))
          as EnumValueDescriptorProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnumValueDescriptorProto create() => EnumValueDescriptorProto._();
  EnumValueDescriptorProto createEmptyInstance() => create();
  static $pb.PbList<EnumValueDescriptorProto> createRepeated() =>
      $pb.PbList<EnumValueDescriptorProto>();
  @$core.pragma('dart2js:noInline')
  static EnumValueDescriptorProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnumValueDescriptorProto>(create);
  static EnumValueDescriptorProto? _defaultInstance;

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

  @$pb.TagNumber(2)
  $core.int get number => $_getIZ(1);
  @$pb.TagNumber(2)
  set number($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => clearField(2);

  @$pb.TagNumber(3)
  EnumValueOptions get options => $_getN(2);
  @$pb.TagNumber(3)
  set options(EnumValueOptions v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOptions() => $_has(2);
  @$pb.TagNumber(3)
  void clearOptions() => clearField(3);
  @$pb.TagNumber(3)
  EnumValueOptions ensureOptions() => $_ensure(2);
}

/// Describes a service.
class ServiceDescriptorProto extends $pb.GeneratedMessage {
  factory ServiceDescriptorProto({
    $core.String? name,
    $core.Iterable<MethodDescriptorProto>? method,
    ServiceOptions? options,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (method != null) {
      $result.method.addAll(method);
    }
    if (options != null) {
      $result.options = options;
    }
    return $result;
  }
  ServiceDescriptorProto._() : super();
  factory ServiceDescriptorProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ServiceDescriptorProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceDescriptorProto',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<MethodDescriptorProto>(
        2, _omitFieldNames ? '' : 'method', $pb.PbFieldType.PM,
        subBuilder: MethodDescriptorProto.create)
    ..aOM<ServiceOptions>(3, _omitFieldNames ? '' : 'options',
        subBuilder: ServiceOptions.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ServiceDescriptorProto clone() =>
      ServiceDescriptorProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ServiceDescriptorProto copyWith(
          void Function(ServiceDescriptorProto) updates) =>
      super.copyWith((message) => updates(message as ServiceDescriptorProto))
          as ServiceDescriptorProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceDescriptorProto create() => ServiceDescriptorProto._();
  ServiceDescriptorProto createEmptyInstance() => create();
  static $pb.PbList<ServiceDescriptorProto> createRepeated() =>
      $pb.PbList<ServiceDescriptorProto>();
  @$core.pragma('dart2js:noInline')
  static ServiceDescriptorProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceDescriptorProto>(create);
  static ServiceDescriptorProto? _defaultInstance;

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

  @$pb.TagNumber(2)
  $core.List<MethodDescriptorProto> get method => $_getList(1);

  @$pb.TagNumber(3)
  ServiceOptions get options => $_getN(2);
  @$pb.TagNumber(3)
  set options(ServiceOptions v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOptions() => $_has(2);
  @$pb.TagNumber(3)
  void clearOptions() => clearField(3);
  @$pb.TagNumber(3)
  ServiceOptions ensureOptions() => $_ensure(2);
}

/// Describes a method of a service.
class MethodDescriptorProto extends $pb.GeneratedMessage {
  factory MethodDescriptorProto({
    $core.String? name,
    $core.String? inputType,
    $core.String? outputType,
    MethodOptions? options,
    $core.bool? clientStreaming,
    $core.bool? serverStreaming,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (inputType != null) {
      $result.inputType = inputType;
    }
    if (outputType != null) {
      $result.outputType = outputType;
    }
    if (options != null) {
      $result.options = options;
    }
    if (clientStreaming != null) {
      $result.clientStreaming = clientStreaming;
    }
    if (serverStreaming != null) {
      $result.serverStreaming = serverStreaming;
    }
    return $result;
  }
  MethodDescriptorProto._() : super();
  factory MethodDescriptorProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MethodDescriptorProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MethodDescriptorProto',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'inputType')
    ..aOS(3, _omitFieldNames ? '' : 'outputType')
    ..aOM<MethodOptions>(4, _omitFieldNames ? '' : 'options',
        subBuilder: MethodOptions.create)
    ..aOB(5, _omitFieldNames ? '' : 'clientStreaming')
    ..aOB(6, _omitFieldNames ? '' : 'serverStreaming');

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MethodDescriptorProto clone() =>
      MethodDescriptorProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MethodDescriptorProto copyWith(
          void Function(MethodDescriptorProto) updates) =>
      super.copyWith((message) => updates(message as MethodDescriptorProto))
          as MethodDescriptorProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MethodDescriptorProto create() => MethodDescriptorProto._();
  MethodDescriptorProto createEmptyInstance() => create();
  static $pb.PbList<MethodDescriptorProto> createRepeated() =>
      $pb.PbList<MethodDescriptorProto>();
  @$core.pragma('dart2js:noInline')
  static MethodDescriptorProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MethodDescriptorProto>(create);
  static MethodDescriptorProto? _defaultInstance;

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

  /// Input and output type names.  These are resolved in the same way as
  /// FieldDescriptorProto.type_name, but must refer to a message type.
  @$pb.TagNumber(2)
  $core.String get inputType => $_getSZ(1);
  @$pb.TagNumber(2)
  set inputType($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasInputType() => $_has(1);
  @$pb.TagNumber(2)
  void clearInputType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get outputType => $_getSZ(2);
  @$pb.TagNumber(3)
  set outputType($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOutputType() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutputType() => clearField(3);

  @$pb.TagNumber(4)
  MethodOptions get options => $_getN(3);
  @$pb.TagNumber(4)
  set options(MethodOptions v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasOptions() => $_has(3);
  @$pb.TagNumber(4)
  void clearOptions() => clearField(4);
  @$pb.TagNumber(4)
  MethodOptions ensureOptions() => $_ensure(3);

  /// Identifies if client streams multiple client messages
  @$pb.TagNumber(5)
  $core.bool get clientStreaming => $_getBF(4);
  @$pb.TagNumber(5)
  set clientStreaming($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasClientStreaming() => $_has(4);
  @$pb.TagNumber(5)
  void clearClientStreaming() => clearField(5);

  /// Identifies if server streams multiple server messages
  @$pb.TagNumber(6)
  $core.bool get serverStreaming => $_getBF(5);
  @$pb.TagNumber(6)
  set serverStreaming($core.bool v) {
    $_setBool(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasServerStreaming() => $_has(5);
  @$pb.TagNumber(6)
  void clearServerStreaming() => clearField(6);
}

class FileOptions extends $pb.GeneratedMessage {
  factory FileOptions({
    $core.String? javaPackage,
    $core.String? javaOuterClassname,
    FileOptions_OptimizeMode? optimizeFor,
    $core.bool? javaMultipleFiles,
    $core.String? goPackage,
    $core.bool? ccGenericServices,
    $core.bool? javaGenericServices,
    $core.bool? pyGenericServices,
    @$core.Deprecated('This field is deprecated.')
    $core.bool? javaGenerateEqualsAndHash,
    $core.bool? deprecated,
    $core.bool? javaStringCheckUtf8,
    $core.bool? ccEnableArenas,
    $core.String? objcClassPrefix,
    $core.String? csharpNamespace,
    $core.String? swiftPrefix,
    $core.String? phpClassPrefix,
    $core.String? phpNamespace,
    $core.String? phpMetadataNamespace,
    $core.String? rubyPackage,
    FeatureSet? features,
    $core.Iterable<UninterpretedOption>? uninterpretedOption,
  }) {
    final $result = create();
    if (javaPackage != null) {
      $result.javaPackage = javaPackage;
    }
    if (javaOuterClassname != null) {
      $result.javaOuterClassname = javaOuterClassname;
    }
    if (optimizeFor != null) {
      $result.optimizeFor = optimizeFor;
    }
    if (javaMultipleFiles != null) {
      $result.javaMultipleFiles = javaMultipleFiles;
    }
    if (goPackage != null) {
      $result.goPackage = goPackage;
    }
    if (ccGenericServices != null) {
      $result.ccGenericServices = ccGenericServices;
    }
    if (javaGenericServices != null) {
      $result.javaGenericServices = javaGenericServices;
    }
    if (pyGenericServices != null) {
      $result.pyGenericServices = pyGenericServices;
    }
    if (javaGenerateEqualsAndHash != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.javaGenerateEqualsAndHash = javaGenerateEqualsAndHash;
    }
    if (deprecated != null) {
      $result.deprecated = deprecated;
    }
    if (javaStringCheckUtf8 != null) {
      $result.javaStringCheckUtf8 = javaStringCheckUtf8;
    }
    if (ccEnableArenas != null) {
      $result.ccEnableArenas = ccEnableArenas;
    }
    if (objcClassPrefix != null) {
      $result.objcClassPrefix = objcClassPrefix;
    }
    if (csharpNamespace != null) {
      $result.csharpNamespace = csharpNamespace;
    }
    if (swiftPrefix != null) {
      $result.swiftPrefix = swiftPrefix;
    }
    if (phpClassPrefix != null) {
      $result.phpClassPrefix = phpClassPrefix;
    }
    if (phpNamespace != null) {
      $result.phpNamespace = phpNamespace;
    }
    if (phpMetadataNamespace != null) {
      $result.phpMetadataNamespace = phpMetadataNamespace;
    }
    if (rubyPackage != null) {
      $result.rubyPackage = rubyPackage;
    }
    if (features != null) {
      $result.features = features;
    }
    if (uninterpretedOption != null) {
      $result.uninterpretedOption.addAll(uninterpretedOption);
    }
    return $result;
  }
  FileOptions._() : super();
  factory FileOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FileOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'javaPackage')
    ..aOS(8, _omitFieldNames ? '' : 'javaOuterClassname')
    ..e<FileOptions_OptimizeMode>(
        9, _omitFieldNames ? '' : 'optimizeFor', $pb.PbFieldType.OE,
        defaultOrMaker: FileOptions_OptimizeMode.SPEED,
        valueOf: FileOptions_OptimizeMode.valueOf,
        enumValues: FileOptions_OptimizeMode.values)
    ..aOB(10, _omitFieldNames ? '' : 'javaMultipleFiles')
    ..aOS(11, _omitFieldNames ? '' : 'goPackage')
    ..aOB(16, _omitFieldNames ? '' : 'ccGenericServices')
    ..aOB(17, _omitFieldNames ? '' : 'javaGenericServices')
    ..aOB(18, _omitFieldNames ? '' : 'pyGenericServices')
    ..aOB(20, _omitFieldNames ? '' : 'javaGenerateEqualsAndHash')
    ..aOB(23, _omitFieldNames ? '' : 'deprecated')
    ..aOB(27, _omitFieldNames ? '' : 'javaStringCheckUtf8')
    ..a<$core.bool>(
        31, _omitFieldNames ? '' : 'ccEnableArenas', $pb.PbFieldType.OB,
        defaultOrMaker: true)
    ..aOS(36, _omitFieldNames ? '' : 'objcClassPrefix')
    ..aOS(37, _omitFieldNames ? '' : 'csharpNamespace')
    ..aOS(39, _omitFieldNames ? '' : 'swiftPrefix')
    ..aOS(40, _omitFieldNames ? '' : 'phpClassPrefix')
    ..aOS(41, _omitFieldNames ? '' : 'phpNamespace')
    ..aOS(44, _omitFieldNames ? '' : 'phpMetadataNamespace')
    ..aOS(45, _omitFieldNames ? '' : 'rubyPackage')
    ..aOM<FeatureSet>(50, _omitFieldNames ? '' : 'features',
        subBuilder: FeatureSet.create)
    ..pc<UninterpretedOption>(
        999, _omitFieldNames ? '' : 'uninterpretedOption', $pb.PbFieldType.PM,
        subBuilder: UninterpretedOption.create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FileOptions clone() => FileOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FileOptions copyWith(void Function(FileOptions) updates) =>
      super.copyWith((message) => updates(message as FileOptions))
          as FileOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileOptions create() => FileOptions._();
  FileOptions createEmptyInstance() => create();
  static $pb.PbList<FileOptions> createRepeated() => $pb.PbList<FileOptions>();
  @$core.pragma('dart2js:noInline')
  static FileOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileOptions>(create);
  static FileOptions? _defaultInstance;

  /// Sets the Java package where classes generated from this .proto will be
  /// placed.  By default, the proto package is used, but this is often
  /// inappropriate because proto packages do not normally start with backwards
  /// domain names.
  @$pb.TagNumber(1)
  $core.String get javaPackage => $_getSZ(0);
  @$pb.TagNumber(1)
  set javaPackage($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasJavaPackage() => $_has(0);
  @$pb.TagNumber(1)
  void clearJavaPackage() => clearField(1);

  /// Controls the name of the wrapper Java class generated for the .proto file.
  /// That class will always contain the .proto file's getDescriptor() method as
  /// well as any top-level extensions defined in the .proto file.
  /// If java_multiple_files is disabled, then all the other classes from the
  /// .proto file will be nested inside the single wrapper outer class.
  @$pb.TagNumber(8)
  $core.String get javaOuterClassname => $_getSZ(1);
  @$pb.TagNumber(8)
  set javaOuterClassname($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasJavaOuterClassname() => $_has(1);
  @$pb.TagNumber(8)
  void clearJavaOuterClassname() => clearField(8);

  @$pb.TagNumber(9)
  FileOptions_OptimizeMode get optimizeFor => $_getN(2);
  @$pb.TagNumber(9)
  set optimizeFor(FileOptions_OptimizeMode v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasOptimizeFor() => $_has(2);
  @$pb.TagNumber(9)
  void clearOptimizeFor() => clearField(9);

  /// If enabled, then the Java code generator will generate a separate .java
  /// file for each top-level message, enum, and service defined in the .proto
  /// file.  Thus, these types will *not* be nested inside the wrapper class
  /// named by java_outer_classname.  However, the wrapper class will still be
  /// generated to contain the file's getDescriptor() method as well as any
  /// top-level extensions defined in the file.
  @$pb.TagNumber(10)
  $core.bool get javaMultipleFiles => $_getBF(3);
  @$pb.TagNumber(10)
  set javaMultipleFiles($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasJavaMultipleFiles() => $_has(3);
  @$pb.TagNumber(10)
  void clearJavaMultipleFiles() => clearField(10);

  /// Sets the Go package where structs generated from this .proto will be
  /// placed. If omitted, the Go package will be derived from the following:
  ///   - The basename of the package import path, if provided.
  ///   - Otherwise, the package statement in the .proto file, if present.
  ///   - Otherwise, the basename of the .proto file, without extension.
  @$pb.TagNumber(11)
  $core.String get goPackage => $_getSZ(4);
  @$pb.TagNumber(11)
  set goPackage($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasGoPackage() => $_has(4);
  @$pb.TagNumber(11)
  void clearGoPackage() => clearField(11);

  ///  Should generic services be generated in each language?  "Generic" services
  ///  are not specific to any particular RPC system.  They are generated by the
  ///  main code generators in each language (without additional plugins).
  ///  Generic services were the only kind of service generation supported by
  ///  early versions of google.protobuf.
  ///
  ///  Generic services are now considered deprecated in favor of using plugins
  ///  that generate code specific to your particular RPC system.  Therefore,
  ///  these default to false.  Old code which depends on generic services should
  ///  explicitly set them to true.
  @$pb.TagNumber(16)
  $core.bool get ccGenericServices => $_getBF(5);
  @$pb.TagNumber(16)
  set ccGenericServices($core.bool v) {
    $_setBool(5, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasCcGenericServices() => $_has(5);
  @$pb.TagNumber(16)
  void clearCcGenericServices() => clearField(16);

  @$pb.TagNumber(17)
  $core.bool get javaGenericServices => $_getBF(6);
  @$pb.TagNumber(17)
  set javaGenericServices($core.bool v) {
    $_setBool(6, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasJavaGenericServices() => $_has(6);
  @$pb.TagNumber(17)
  void clearJavaGenericServices() => clearField(17);

  @$pb.TagNumber(18)
  $core.bool get pyGenericServices => $_getBF(7);
  @$pb.TagNumber(18)
  set pyGenericServices($core.bool v) {
    $_setBool(7, v);
  }

  @$pb.TagNumber(18)
  $core.bool hasPyGenericServices() => $_has(7);
  @$pb.TagNumber(18)
  void clearPyGenericServices() => clearField(18);

  /// This option does nothing.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(20)
  $core.bool get javaGenerateEqualsAndHash => $_getBF(8);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(20)
  set javaGenerateEqualsAndHash($core.bool v) {
    $_setBool(8, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(20)
  $core.bool hasJavaGenerateEqualsAndHash() => $_has(8);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(20)
  void clearJavaGenerateEqualsAndHash() => clearField(20);

  /// Is this file deprecated?
  /// Depending on the target platform, this can emit Deprecated annotations
  /// for everything in the file, or it will be completely ignored; in the very
  /// least, this is a formalization for deprecating files.
  @$pb.TagNumber(23)
  $core.bool get deprecated => $_getBF(9);
  @$pb.TagNumber(23)
  set deprecated($core.bool v) {
    $_setBool(9, v);
  }

  @$pb.TagNumber(23)
  $core.bool hasDeprecated() => $_has(9);
  @$pb.TagNumber(23)
  void clearDeprecated() => clearField(23);

  ///  A proto2 file can set this to true to opt in to UTF-8 checking for Java,
  ///  which will throw an exception if invalid UTF-8 is parsed from the wire or
  ///  assigned to a string field.
  ///
  ///  TODO: clarify exactly what kinds of field types this option
  ///  applies to, and update these docs accordingly.
  ///
  ///  Proto3 files already perform these checks. Setting the option explicitly to
  ///  false has no effect: it cannot be used to opt proto3 files out of UTF-8
  ///  checks.
  @$pb.TagNumber(27)
  $core.bool get javaStringCheckUtf8 => $_getBF(10);
  @$pb.TagNumber(27)
  set javaStringCheckUtf8($core.bool v) {
    $_setBool(10, v);
  }

  @$pb.TagNumber(27)
  $core.bool hasJavaStringCheckUtf8() => $_has(10);
  @$pb.TagNumber(27)
  void clearJavaStringCheckUtf8() => clearField(27);

  /// Enables the use of arenas for the proto messages in this file. This applies
  /// only to generated classes for C++.
  @$pb.TagNumber(31)
  $core.bool get ccEnableArenas => $_getB(11, true);
  @$pb.TagNumber(31)
  set ccEnableArenas($core.bool v) {
    $_setBool(11, v);
  }

  @$pb.TagNumber(31)
  $core.bool hasCcEnableArenas() => $_has(11);
  @$pb.TagNumber(31)
  void clearCcEnableArenas() => clearField(31);

  /// Sets the objective c class prefix which is prepended to all objective c
  /// generated classes from this .proto. There is no default.
  @$pb.TagNumber(36)
  $core.String get objcClassPrefix => $_getSZ(12);
  @$pb.TagNumber(36)
  set objcClassPrefix($core.String v) {
    $_setString(12, v);
  }

  @$pb.TagNumber(36)
  $core.bool hasObjcClassPrefix() => $_has(12);
  @$pb.TagNumber(36)
  void clearObjcClassPrefix() => clearField(36);

  /// Namespace for generated classes; defaults to the package.
  @$pb.TagNumber(37)
  $core.String get csharpNamespace => $_getSZ(13);
  @$pb.TagNumber(37)
  set csharpNamespace($core.String v) {
    $_setString(13, v);
  }

  @$pb.TagNumber(37)
  $core.bool hasCsharpNamespace() => $_has(13);
  @$pb.TagNumber(37)
  void clearCsharpNamespace() => clearField(37);

  /// By default Swift generators will take the proto package and CamelCase it
  /// replacing '.' with underscore and use that to prefix the types/symbols
  /// defined. When this options is provided, they will use this value instead
  /// to prefix the types/symbols defined.
  @$pb.TagNumber(39)
  $core.String get swiftPrefix => $_getSZ(14);
  @$pb.TagNumber(39)
  set swiftPrefix($core.String v) {
    $_setString(14, v);
  }

  @$pb.TagNumber(39)
  $core.bool hasSwiftPrefix() => $_has(14);
  @$pb.TagNumber(39)
  void clearSwiftPrefix() => clearField(39);

  /// Sets the php class prefix which is prepended to all php generated classes
  /// from this .proto. Default is empty.
  @$pb.TagNumber(40)
  $core.String get phpClassPrefix => $_getSZ(15);
  @$pb.TagNumber(40)
  set phpClassPrefix($core.String v) {
    $_setString(15, v);
  }

  @$pb.TagNumber(40)
  $core.bool hasPhpClassPrefix() => $_has(15);
  @$pb.TagNumber(40)
  void clearPhpClassPrefix() => clearField(40);

  /// Use this option to change the namespace of php generated classes. Default
  /// is empty. When this option is empty, the package name will be used for
  /// determining the namespace.
  @$pb.TagNumber(41)
  $core.String get phpNamespace => $_getSZ(16);
  @$pb.TagNumber(41)
  set phpNamespace($core.String v) {
    $_setString(16, v);
  }

  @$pb.TagNumber(41)
  $core.bool hasPhpNamespace() => $_has(16);
  @$pb.TagNumber(41)
  void clearPhpNamespace() => clearField(41);

  /// Use this option to change the namespace of php generated metadata classes.
  /// Default is empty. When this option is empty, the proto file name will be
  /// used for determining the namespace.
  @$pb.TagNumber(44)
  $core.String get phpMetadataNamespace => $_getSZ(17);
  @$pb.TagNumber(44)
  set phpMetadataNamespace($core.String v) {
    $_setString(17, v);
  }

  @$pb.TagNumber(44)
  $core.bool hasPhpMetadataNamespace() => $_has(17);
  @$pb.TagNumber(44)
  void clearPhpMetadataNamespace() => clearField(44);

  /// Use this option to change the package of ruby generated classes. Default
  /// is empty. When this option is not set, the package name will be used for
  /// determining the ruby package.
  @$pb.TagNumber(45)
  $core.String get rubyPackage => $_getSZ(18);
  @$pb.TagNumber(45)
  set rubyPackage($core.String v) {
    $_setString(18, v);
  }

  @$pb.TagNumber(45)
  $core.bool hasRubyPackage() => $_has(18);
  @$pb.TagNumber(45)
  void clearRubyPackage() => clearField(45);

  /// Any features defined in the specific edition.
  @$pb.TagNumber(50)
  FeatureSet get features => $_getN(19);
  @$pb.TagNumber(50)
  set features(FeatureSet v) {
    setField(50, v);
  }

  @$pb.TagNumber(50)
  $core.bool hasFeatures() => $_has(19);
  @$pb.TagNumber(50)
  void clearFeatures() => clearField(50);
  @$pb.TagNumber(50)
  FeatureSet ensureFeatures() => $_ensure(19);

  /// The parser stores options it doesn't recognize here.
  /// See the documentation for the "Options" section above.
  @$pb.TagNumber(999)
  $core.List<UninterpretedOption> get uninterpretedOption => $_getList(20);
}

class MessageOptions extends $pb.GeneratedMessage {
  factory MessageOptions({
    $core.bool? messageSetWireFormat,
    $core.bool? noStandardDescriptorAccessor,
    $core.bool? deprecated,
    $core.bool? mapEntry,
    @$core.Deprecated('This field is deprecated.')
    $core.bool? deprecatedLegacyJsonFieldConflicts,
    FeatureSet? features,
    $core.Iterable<UninterpretedOption>? uninterpretedOption,
  }) {
    final $result = create();
    if (messageSetWireFormat != null) {
      $result.messageSetWireFormat = messageSetWireFormat;
    }
    if (noStandardDescriptorAccessor != null) {
      $result.noStandardDescriptorAccessor = noStandardDescriptorAccessor;
    }
    if (deprecated != null) {
      $result.deprecated = deprecated;
    }
    if (mapEntry != null) {
      $result.mapEntry = mapEntry;
    }
    if (deprecatedLegacyJsonFieldConflicts != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.deprecatedLegacyJsonFieldConflicts =
          deprecatedLegacyJsonFieldConflicts;
    }
    if (features != null) {
      $result.features = features;
    }
    if (uninterpretedOption != null) {
      $result.uninterpretedOption.addAll(uninterpretedOption);
    }
    return $result;
  }
  MessageOptions._() : super();
  factory MessageOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MessageOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MessageOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'messageSetWireFormat')
    ..aOB(2, _omitFieldNames ? '' : 'noStandardDescriptorAccessor')
    ..aOB(3, _omitFieldNames ? '' : 'deprecated')
    ..aOB(7, _omitFieldNames ? '' : 'mapEntry')
    ..aOB(11, _omitFieldNames ? '' : 'deprecatedLegacyJsonFieldConflicts')
    ..aOM<FeatureSet>(12, _omitFieldNames ? '' : 'features',
        subBuilder: FeatureSet.create)
    ..pc<UninterpretedOption>(
        999, _omitFieldNames ? '' : 'uninterpretedOption', $pb.PbFieldType.PM,
        subBuilder: UninterpretedOption.create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MessageOptions clone() => MessageOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MessageOptions copyWith(void Function(MessageOptions) updates) =>
      super.copyWith((message) => updates(message as MessageOptions))
          as MessageOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MessageOptions create() => MessageOptions._();
  MessageOptions createEmptyInstance() => create();
  static $pb.PbList<MessageOptions> createRepeated() =>
      $pb.PbList<MessageOptions>();
  @$core.pragma('dart2js:noInline')
  static MessageOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MessageOptions>(create);
  static MessageOptions? _defaultInstance;

  ///  Set true to use the old proto1 MessageSet wire format for extensions.
  ///  This is provided for backwards-compatibility with the MessageSet wire
  ///  format.  You should not use this for any other reason:  It's less
  ///  efficient, has fewer features, and is more complicated.
  ///
  ///  The message must be defined exactly as follows:
  ///    message Foo {
  ///      option message_set_wire_format = true;
  ///      extensions 4 to max;
  ///    }
  ///  Note that the message cannot have any defined fields; MessageSets only
  ///  have extensions.
  ///
  ///  All extensions of your type must be singular messages; e.g. they cannot
  ///  be int32s, enums, or repeated messages.
  ///
  ///  Because this is an option, the above two restrictions are not enforced by
  ///  the protocol compiler.
  @$pb.TagNumber(1)
  $core.bool get messageSetWireFormat => $_getBF(0);
  @$pb.TagNumber(1)
  set messageSetWireFormat($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessageSetWireFormat() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageSetWireFormat() => clearField(1);

  /// Disables the generation of the standard "descriptor()" accessor, which can
  /// conflict with a field of the same name.  This is meant to make migration
  /// from proto1 easier; new code should avoid fields named "descriptor".
  @$pb.TagNumber(2)
  $core.bool get noStandardDescriptorAccessor => $_getBF(1);
  @$pb.TagNumber(2)
  set noStandardDescriptorAccessor($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNoStandardDescriptorAccessor() => $_has(1);
  @$pb.TagNumber(2)
  void clearNoStandardDescriptorAccessor() => clearField(2);

  /// Is this message deprecated?
  /// Depending on the target platform, this can emit Deprecated annotations
  /// for the message, or it will be completely ignored; in the very least,
  /// this is a formalization for deprecating messages.
  @$pb.TagNumber(3)
  $core.bool get deprecated => $_getBF(2);
  @$pb.TagNumber(3)
  set deprecated($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDeprecated() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeprecated() => clearField(3);

  ///  Whether the message is an automatically generated map entry type for the
  ///  maps field.
  ///
  ///  For maps fields:
  ///      map<KeyType, ValueType> map_field = 1;
  ///  The parsed descriptor looks like:
  ///      message MapFieldEntry {
  ///          option map_entry = true;
  ///          optional KeyType key = 1;
  ///          optional ValueType value = 2;
  ///      }
  ///      repeated MapFieldEntry map_field = 1;
  ///
  ///  Implementations may choose not to generate the map_entry=true message, but
  ///  use a native map in the target language to hold the keys and values.
  ///  The reflection APIs in such implementations still need to work as
  ///  if the field is a repeated message field.
  ///
  ///  NOTE: Do not set the option in .proto files. Always use the maps syntax
  ///  instead. The option should only be implicitly set by the proto compiler
  ///  parser.
  @$pb.TagNumber(7)
  $core.bool get mapEntry => $_getBF(3);
  @$pb.TagNumber(7)
  set mapEntry($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasMapEntry() => $_has(3);
  @$pb.TagNumber(7)
  void clearMapEntry() => clearField(7);

  ///  Enable the legacy handling of JSON field name conflicts.  This lowercases
  ///  and strips underscored from the fields before comparison in proto3 only.
  ///  The new behavior takes `json_name` into account and applies to proto2 as
  ///  well.
  ///
  ///  This should only be used as a temporary measure against broken builds due
  ///  to the change in behavior for JSON field name conflicts.
  ///
  ///  TODO This is legacy behavior we plan to remove once downstream
  ///  teams have had time to migrate.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(11)
  $core.bool get deprecatedLegacyJsonFieldConflicts => $_getBF(4);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(11)
  set deprecatedLegacyJsonFieldConflicts($core.bool v) {
    $_setBool(4, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(11)
  $core.bool hasDeprecatedLegacyJsonFieldConflicts() => $_has(4);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(11)
  void clearDeprecatedLegacyJsonFieldConflicts() => clearField(11);

  /// Any features defined in the specific edition.
  @$pb.TagNumber(12)
  FeatureSet get features => $_getN(5);
  @$pb.TagNumber(12)
  set features(FeatureSet v) {
    setField(12, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasFeatures() => $_has(5);
  @$pb.TagNumber(12)
  void clearFeatures() => clearField(12);
  @$pb.TagNumber(12)
  FeatureSet ensureFeatures() => $_ensure(5);

  /// The parser stores options it doesn't recognize here. See above.
  @$pb.TagNumber(999)
  $core.List<UninterpretedOption> get uninterpretedOption => $_getList(6);
}

class FieldOptions_EditionDefault extends $pb.GeneratedMessage {
  factory FieldOptions_EditionDefault({
    $core.String? value,
    Edition? edition,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (edition != null) {
      $result.edition = edition;
    }
    return $result;
  }
  FieldOptions_EditionDefault._() : super();
  factory FieldOptions_EditionDefault.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FieldOptions_EditionDefault.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FieldOptions.EditionDefault',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..e<Edition>(3, _omitFieldNames ? '' : 'edition', $pb.PbFieldType.OE,
        defaultOrMaker: Edition.EDITION_UNKNOWN,
        valueOf: Edition.valueOf,
        enumValues: Edition.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FieldOptions_EditionDefault clone() =>
      FieldOptions_EditionDefault()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FieldOptions_EditionDefault copyWith(
          void Function(FieldOptions_EditionDefault) updates) =>
      super.copyWith(
              (message) => updates(message as FieldOptions_EditionDefault))
          as FieldOptions_EditionDefault;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FieldOptions_EditionDefault create() =>
      FieldOptions_EditionDefault._();
  FieldOptions_EditionDefault createEmptyInstance() => create();
  static $pb.PbList<FieldOptions_EditionDefault> createRepeated() =>
      $pb.PbList<FieldOptions_EditionDefault>();
  @$core.pragma('dart2js:noInline')
  static FieldOptions_EditionDefault getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FieldOptions_EditionDefault>(create);
  static FieldOptions_EditionDefault? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(2)
  set value($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  Edition get edition => $_getN(1);
  @$pb.TagNumber(3)
  set edition(Edition v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEdition() => $_has(1);
  @$pb.TagNumber(3)
  void clearEdition() => clearField(3);
}

/// Information about the support window of a feature.
class FieldOptions_FeatureSupport extends $pb.GeneratedMessage {
  factory FieldOptions_FeatureSupport({
    Edition? editionIntroduced,
    Edition? editionDeprecated,
    $core.String? deprecationWarning,
    Edition? editionRemoved,
  }) {
    final $result = create();
    if (editionIntroduced != null) {
      $result.editionIntroduced = editionIntroduced;
    }
    if (editionDeprecated != null) {
      $result.editionDeprecated = editionDeprecated;
    }
    if (deprecationWarning != null) {
      $result.deprecationWarning = deprecationWarning;
    }
    if (editionRemoved != null) {
      $result.editionRemoved = editionRemoved;
    }
    return $result;
  }
  FieldOptions_FeatureSupport._() : super();
  factory FieldOptions_FeatureSupport.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FieldOptions_FeatureSupport.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FieldOptions.FeatureSupport',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..e<Edition>(
        1, _omitFieldNames ? '' : 'editionIntroduced', $pb.PbFieldType.OE,
        defaultOrMaker: Edition.EDITION_UNKNOWN,
        valueOf: Edition.valueOf,
        enumValues: Edition.values)
    ..e<Edition>(
        2, _omitFieldNames ? '' : 'editionDeprecated', $pb.PbFieldType.OE,
        defaultOrMaker: Edition.EDITION_UNKNOWN,
        valueOf: Edition.valueOf,
        enumValues: Edition.values)
    ..aOS(3, _omitFieldNames ? '' : 'deprecationWarning')
    ..e<Edition>(4, _omitFieldNames ? '' : 'editionRemoved', $pb.PbFieldType.OE,
        defaultOrMaker: Edition.EDITION_UNKNOWN,
        valueOf: Edition.valueOf,
        enumValues: Edition.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FieldOptions_FeatureSupport clone() =>
      FieldOptions_FeatureSupport()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FieldOptions_FeatureSupport copyWith(
          void Function(FieldOptions_FeatureSupport) updates) =>
      super.copyWith(
              (message) => updates(message as FieldOptions_FeatureSupport))
          as FieldOptions_FeatureSupport;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FieldOptions_FeatureSupport create() =>
      FieldOptions_FeatureSupport._();
  FieldOptions_FeatureSupport createEmptyInstance() => create();
  static $pb.PbList<FieldOptions_FeatureSupport> createRepeated() =>
      $pb.PbList<FieldOptions_FeatureSupport>();
  @$core.pragma('dart2js:noInline')
  static FieldOptions_FeatureSupport getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FieldOptions_FeatureSupport>(create);
  static FieldOptions_FeatureSupport? _defaultInstance;

  /// The edition that this feature was first available in.  In editions
  /// earlier than this one, the default assigned to EDITION_LEGACY will be
  /// used, and proto files will not be able to override it.
  @$pb.TagNumber(1)
  Edition get editionIntroduced => $_getN(0);
  @$pb.TagNumber(1)
  set editionIntroduced(Edition v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEditionIntroduced() => $_has(0);
  @$pb.TagNumber(1)
  void clearEditionIntroduced() => clearField(1);

  /// The edition this feature becomes deprecated in.  Using this after this
  /// edition may trigger warnings.
  @$pb.TagNumber(2)
  Edition get editionDeprecated => $_getN(1);
  @$pb.TagNumber(2)
  set editionDeprecated(Edition v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEditionDeprecated() => $_has(1);
  @$pb.TagNumber(2)
  void clearEditionDeprecated() => clearField(2);

  /// The deprecation warning text if this feature is used after the edition it
  /// was marked deprecated in.
  @$pb.TagNumber(3)
  $core.String get deprecationWarning => $_getSZ(2);
  @$pb.TagNumber(3)
  set deprecationWarning($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDeprecationWarning() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeprecationWarning() => clearField(3);

  /// The edition this feature is no longer available in.  In editions after
  /// this one, the last default assigned will be used, and proto files will
  /// not be able to override it.
  @$pb.TagNumber(4)
  Edition get editionRemoved => $_getN(3);
  @$pb.TagNumber(4)
  set editionRemoved(Edition v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasEditionRemoved() => $_has(3);
  @$pb.TagNumber(4)
  void clearEditionRemoved() => clearField(4);
}

class FieldOptions extends $pb.GeneratedMessage {
  factory FieldOptions({
    FieldOptions_CType? ctype,
    $core.bool? packed,
    $core.bool? deprecated,
    $core.bool? lazy,
    FieldOptions_JSType? jstype,
    $core.bool? weak,
    $core.bool? unverifiedLazy,
    $core.bool? debugRedact,
    FieldOptions_OptionRetention? retention,
    $core.Iterable<FieldOptions_OptionTargetType>? targets,
    $core.Iterable<FieldOptions_EditionDefault>? editionDefaults,
    FeatureSet? features,
    FieldOptions_FeatureSupport? featureSupport,
    $core.Iterable<UninterpretedOption>? uninterpretedOption,
  }) {
    final $result = create();
    if (ctype != null) {
      $result.ctype = ctype;
    }
    if (packed != null) {
      $result.packed = packed;
    }
    if (deprecated != null) {
      $result.deprecated = deprecated;
    }
    if (lazy != null) {
      $result.lazy = lazy;
    }
    if (jstype != null) {
      $result.jstype = jstype;
    }
    if (weak != null) {
      $result.weak = weak;
    }
    if (unverifiedLazy != null) {
      $result.unverifiedLazy = unverifiedLazy;
    }
    if (debugRedact != null) {
      $result.debugRedact = debugRedact;
    }
    if (retention != null) {
      $result.retention = retention;
    }
    if (targets != null) {
      $result.targets.addAll(targets);
    }
    if (editionDefaults != null) {
      $result.editionDefaults.addAll(editionDefaults);
    }
    if (features != null) {
      $result.features = features;
    }
    if (featureSupport != null) {
      $result.featureSupport = featureSupport;
    }
    if (uninterpretedOption != null) {
      $result.uninterpretedOption.addAll(uninterpretedOption);
    }
    return $result;
  }
  FieldOptions._() : super();
  factory FieldOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FieldOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FieldOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..e<FieldOptions_CType>(
        1, _omitFieldNames ? '' : 'ctype', $pb.PbFieldType.OE,
        defaultOrMaker: FieldOptions_CType.STRING,
        valueOf: FieldOptions_CType.valueOf,
        enumValues: FieldOptions_CType.values)
    ..aOB(2, _omitFieldNames ? '' : 'packed')
    ..aOB(3, _omitFieldNames ? '' : 'deprecated')
    ..aOB(5, _omitFieldNames ? '' : 'lazy')
    ..e<FieldOptions_JSType>(
        6, _omitFieldNames ? '' : 'jstype', $pb.PbFieldType.OE,
        defaultOrMaker: FieldOptions_JSType.JS_NORMAL,
        valueOf: FieldOptions_JSType.valueOf,
        enumValues: FieldOptions_JSType.values)
    ..aOB(10, _omitFieldNames ? '' : 'weak')
    ..aOB(15, _omitFieldNames ? '' : 'unverifiedLazy')
    ..aOB(16, _omitFieldNames ? '' : 'debugRedact')
    ..e<FieldOptions_OptionRetention>(
        17, _omitFieldNames ? '' : 'retention', $pb.PbFieldType.OE,
        defaultOrMaker: FieldOptions_OptionRetention.RETENTION_UNKNOWN,
        valueOf: FieldOptions_OptionRetention.valueOf,
        enumValues: FieldOptions_OptionRetention.values)
    ..pc<FieldOptions_OptionTargetType>(
        19, _omitFieldNames ? '' : 'targets', $pb.PbFieldType.PE,
        valueOf: FieldOptions_OptionTargetType.valueOf,
        enumValues: FieldOptions_OptionTargetType.values,
        defaultEnumValue: FieldOptions_OptionTargetType.TARGET_TYPE_UNKNOWN)
    ..pc<FieldOptions_EditionDefault>(
        20, _omitFieldNames ? '' : 'editionDefaults', $pb.PbFieldType.PM,
        subBuilder: FieldOptions_EditionDefault.create)
    ..aOM<FeatureSet>(21, _omitFieldNames ? '' : 'features',
        subBuilder: FeatureSet.create)
    ..aOM<FieldOptions_FeatureSupport>(
        22, _omitFieldNames ? '' : 'featureSupport',
        subBuilder: FieldOptions_FeatureSupport.create)
    ..pc<UninterpretedOption>(
        999, _omitFieldNames ? '' : 'uninterpretedOption', $pb.PbFieldType.PM,
        subBuilder: UninterpretedOption.create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FieldOptions clone() => FieldOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FieldOptions copyWith(void Function(FieldOptions) updates) =>
      super.copyWith((message) => updates(message as FieldOptions))
          as FieldOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FieldOptions create() => FieldOptions._();
  FieldOptions createEmptyInstance() => create();
  static $pb.PbList<FieldOptions> createRepeated() =>
      $pb.PbList<FieldOptions>();
  @$core.pragma('dart2js:noInline')
  static FieldOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FieldOptions>(create);
  static FieldOptions? _defaultInstance;

  /// NOTE: ctype is deprecated. Use `features.(pb.cpp).string_type` instead.
  /// The ctype option instructs the C++ code generator to use a different
  /// representation of the field than it normally would.  See the specific
  /// options below.  This option is only implemented to support use of
  /// [ctype=CORD] and [ctype=STRING] (the default) on non-repeated fields of
  /// type "bytes" in the open source release.
  /// TODO: make ctype actually deprecated.
  @$pb.TagNumber(1)
  FieldOptions_CType get ctype => $_getN(0);
  @$pb.TagNumber(1)
  set ctype(FieldOptions_CType v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCtype() => $_has(0);
  @$pb.TagNumber(1)
  void clearCtype() => clearField(1);

  /// The packed option can be enabled for repeated primitive fields to enable
  /// a more efficient representation on the wire. Rather than repeatedly
  /// writing the tag and type for each element, the entire array is encoded as
  /// a single length-delimited blob. In proto3, only explicit setting it to
  /// false will avoid using packed encoding.  This option is prohibited in
  /// Editions, but the `repeated_field_encoding` feature can be used to control
  /// the behavior.
  @$pb.TagNumber(2)
  $core.bool get packed => $_getBF(1);
  @$pb.TagNumber(2)
  set packed($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPacked() => $_has(1);
  @$pb.TagNumber(2)
  void clearPacked() => clearField(2);

  /// Is this field deprecated?
  /// Depending on the target platform, this can emit Deprecated annotations
  /// for accessors, or it will be completely ignored; in the very least, this
  /// is a formalization for deprecating fields.
  @$pb.TagNumber(3)
  $core.bool get deprecated => $_getBF(2);
  @$pb.TagNumber(3)
  set deprecated($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDeprecated() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeprecated() => clearField(3);

  ///  Should this field be parsed lazily?  Lazy applies only to message-type
  ///  fields.  It means that when the outer message is initially parsed, the
  ///  inner message's contents will not be parsed but instead stored in encoded
  ///  form.  The inner message will actually be parsed when it is first accessed.
  ///
  ///  This is only a hint.  Implementations are free to choose whether to use
  ///  eager or lazy parsing regardless of the value of this option.  However,
  ///  setting this option true suggests that the protocol author believes that
  ///  using lazy parsing on this field is worth the additional bookkeeping
  ///  overhead typically needed to implement it.
  ///
  ///  This option does not affect the public interface of any generated code;
  ///  all method signatures remain the same.  Furthermore, thread-safety of the
  ///  interface is not affected by this option; const methods remain safe to
  ///  call from multiple threads concurrently, while non-const methods continue
  ///  to require exclusive access.
  ///
  ///  Note that lazy message fields are still eagerly verified to check
  ///  ill-formed wireformat or missing required fields. Calling IsInitialized()
  ///  on the outer message would fail if the inner message has missing required
  ///  fields. Failed verification would result in parsing failure (except when
  ///  uninitialized messages are acceptable).
  @$pb.TagNumber(5)
  $core.bool get lazy => $_getBF(3);
  @$pb.TagNumber(5)
  set lazy($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasLazy() => $_has(3);
  @$pb.TagNumber(5)
  void clearLazy() => clearField(5);

  ///  The jstype option determines the JavaScript type used for values of the
  ///  field.  The option is permitted only for 64 bit integral and fixed types
  ///  (int64, uint64, sint64, fixed64, sfixed64).  A field with jstype JS_STRING
  ///  is represented as JavaScript string, which avoids loss of precision that
  ///  can happen when a large value is converted to a floating point JavaScript.
  ///  Specifying JS_NUMBER for the jstype causes the generated JavaScript code to
  ///  use the JavaScript "number" type.  The behavior of the default option
  ///  JS_NORMAL is implementation dependent.
  ///
  ///  This option is an enum to permit additional types to be added, e.g.
  ///  goog.math.Integer.
  @$pb.TagNumber(6)
  FieldOptions_JSType get jstype => $_getN(4);
  @$pb.TagNumber(6)
  set jstype(FieldOptions_JSType v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasJstype() => $_has(4);
  @$pb.TagNumber(6)
  void clearJstype() => clearField(6);

  /// For Google-internal migration only. Do not use.
  @$pb.TagNumber(10)
  $core.bool get weak => $_getBF(5);
  @$pb.TagNumber(10)
  set weak($core.bool v) {
    $_setBool(5, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasWeak() => $_has(5);
  @$pb.TagNumber(10)
  void clearWeak() => clearField(10);

  /// unverified_lazy does no correctness checks on the byte stream. This should
  /// only be used where lazy with verification is prohibitive for performance
  /// reasons.
  @$pb.TagNumber(15)
  $core.bool get unverifiedLazy => $_getBF(6);
  @$pb.TagNumber(15)
  set unverifiedLazy($core.bool v) {
    $_setBool(6, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasUnverifiedLazy() => $_has(6);
  @$pb.TagNumber(15)
  void clearUnverifiedLazy() => clearField(15);

  /// Indicate that the field value should not be printed out when using debug
  /// formats, e.g. when the field contains sensitive credentials.
  @$pb.TagNumber(16)
  $core.bool get debugRedact => $_getBF(7);
  @$pb.TagNumber(16)
  set debugRedact($core.bool v) {
    $_setBool(7, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasDebugRedact() => $_has(7);
  @$pb.TagNumber(16)
  void clearDebugRedact() => clearField(16);

  @$pb.TagNumber(17)
  FieldOptions_OptionRetention get retention => $_getN(8);
  @$pb.TagNumber(17)
  set retention(FieldOptions_OptionRetention v) {
    setField(17, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasRetention() => $_has(8);
  @$pb.TagNumber(17)
  void clearRetention() => clearField(17);

  @$pb.TagNumber(19)
  $core.List<FieldOptions_OptionTargetType> get targets => $_getList(9);

  @$pb.TagNumber(20)
  $core.List<FieldOptions_EditionDefault> get editionDefaults => $_getList(10);

  /// Any features defined in the specific edition.
  @$pb.TagNumber(21)
  FeatureSet get features => $_getN(11);
  @$pb.TagNumber(21)
  set features(FeatureSet v) {
    setField(21, v);
  }

  @$pb.TagNumber(21)
  $core.bool hasFeatures() => $_has(11);
  @$pb.TagNumber(21)
  void clearFeatures() => clearField(21);
  @$pb.TagNumber(21)
  FeatureSet ensureFeatures() => $_ensure(11);

  @$pb.TagNumber(22)
  FieldOptions_FeatureSupport get featureSupport => $_getN(12);
  @$pb.TagNumber(22)
  set featureSupport(FieldOptions_FeatureSupport v) {
    setField(22, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasFeatureSupport() => $_has(12);
  @$pb.TagNumber(22)
  void clearFeatureSupport() => clearField(22);
  @$pb.TagNumber(22)
  FieldOptions_FeatureSupport ensureFeatureSupport() => $_ensure(12);

  /// The parser stores options it doesn't recognize here. See above.
  @$pb.TagNumber(999)
  $core.List<UninterpretedOption> get uninterpretedOption => $_getList(13);
}

class OneofOptions extends $pb.GeneratedMessage {
  factory OneofOptions({
    FeatureSet? features,
    $core.Iterable<UninterpretedOption>? uninterpretedOption,
  }) {
    final $result = create();
    if (features != null) {
      $result.features = features;
    }
    if (uninterpretedOption != null) {
      $result.uninterpretedOption.addAll(uninterpretedOption);
    }
    return $result;
  }
  OneofOptions._() : super();
  factory OneofOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OneofOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OneofOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOM<FeatureSet>(1, _omitFieldNames ? '' : 'features',
        subBuilder: FeatureSet.create)
    ..pc<UninterpretedOption>(
        999, _omitFieldNames ? '' : 'uninterpretedOption', $pb.PbFieldType.PM,
        subBuilder: UninterpretedOption.create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OneofOptions clone() => OneofOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OneofOptions copyWith(void Function(OneofOptions) updates) =>
      super.copyWith((message) => updates(message as OneofOptions))
          as OneofOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OneofOptions create() => OneofOptions._();
  OneofOptions createEmptyInstance() => create();
  static $pb.PbList<OneofOptions> createRepeated() =>
      $pb.PbList<OneofOptions>();
  @$core.pragma('dart2js:noInline')
  static OneofOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OneofOptions>(create);
  static OneofOptions? _defaultInstance;

  /// Any features defined in the specific edition.
  @$pb.TagNumber(1)
  FeatureSet get features => $_getN(0);
  @$pb.TagNumber(1)
  set features(FeatureSet v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFeatures() => $_has(0);
  @$pb.TagNumber(1)
  void clearFeatures() => clearField(1);
  @$pb.TagNumber(1)
  FeatureSet ensureFeatures() => $_ensure(0);

  /// The parser stores options it doesn't recognize here. See above.
  @$pb.TagNumber(999)
  $core.List<UninterpretedOption> get uninterpretedOption => $_getList(1);
}

class EnumOptions extends $pb.GeneratedMessage {
  factory EnumOptions({
    $core.bool? allowAlias,
    $core.bool? deprecated,
    @$core.Deprecated('This field is deprecated.')
    $core.bool? deprecatedLegacyJsonFieldConflicts,
    FeatureSet? features,
    $core.Iterable<UninterpretedOption>? uninterpretedOption,
  }) {
    final $result = create();
    if (allowAlias != null) {
      $result.allowAlias = allowAlias;
    }
    if (deprecated != null) {
      $result.deprecated = deprecated;
    }
    if (deprecatedLegacyJsonFieldConflicts != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.deprecatedLegacyJsonFieldConflicts =
          deprecatedLegacyJsonFieldConflicts;
    }
    if (features != null) {
      $result.features = features;
    }
    if (uninterpretedOption != null) {
      $result.uninterpretedOption.addAll(uninterpretedOption);
    }
    return $result;
  }
  EnumOptions._() : super();
  factory EnumOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnumOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnumOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOB(2, _omitFieldNames ? '' : 'allowAlias')
    ..aOB(3, _omitFieldNames ? '' : 'deprecated')
    ..aOB(6, _omitFieldNames ? '' : 'deprecatedLegacyJsonFieldConflicts')
    ..aOM<FeatureSet>(7, _omitFieldNames ? '' : 'features',
        subBuilder: FeatureSet.create)
    ..pc<UninterpretedOption>(
        999, _omitFieldNames ? '' : 'uninterpretedOption', $pb.PbFieldType.PM,
        subBuilder: UninterpretedOption.create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnumOptions clone() => EnumOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnumOptions copyWith(void Function(EnumOptions) updates) =>
      super.copyWith((message) => updates(message as EnumOptions))
          as EnumOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnumOptions create() => EnumOptions._();
  EnumOptions createEmptyInstance() => create();
  static $pb.PbList<EnumOptions> createRepeated() => $pb.PbList<EnumOptions>();
  @$core.pragma('dart2js:noInline')
  static EnumOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnumOptions>(create);
  static EnumOptions? _defaultInstance;

  /// Set this option to true to allow mapping different tag names to the same
  /// value.
  @$pb.TagNumber(2)
  $core.bool get allowAlias => $_getBF(0);
  @$pb.TagNumber(2)
  set allowAlias($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasAllowAlias() => $_has(0);
  @$pb.TagNumber(2)
  void clearAllowAlias() => clearField(2);

  /// Is this enum deprecated?
  /// Depending on the target platform, this can emit Deprecated annotations
  /// for the enum, or it will be completely ignored; in the very least, this
  /// is a formalization for deprecating enums.
  @$pb.TagNumber(3)
  $core.bool get deprecated => $_getBF(1);
  @$pb.TagNumber(3)
  set deprecated($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDeprecated() => $_has(1);
  @$pb.TagNumber(3)
  void clearDeprecated() => clearField(3);

  /// Enable the legacy handling of JSON field name conflicts.  This lowercases
  /// and strips underscored from the fields before comparison in proto3 only.
  /// The new behavior takes `json_name` into account and applies to proto2 as
  /// well.
  /// TODO Remove this legacy behavior once downstream teams have
  /// had time to migrate.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(6)
  $core.bool get deprecatedLegacyJsonFieldConflicts => $_getBF(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(6)
  set deprecatedLegacyJsonFieldConflicts($core.bool v) {
    $_setBool(2, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(6)
  $core.bool hasDeprecatedLegacyJsonFieldConflicts() => $_has(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(6)
  void clearDeprecatedLegacyJsonFieldConflicts() => clearField(6);

  /// Any features defined in the specific edition.
  @$pb.TagNumber(7)
  FeatureSet get features => $_getN(3);
  @$pb.TagNumber(7)
  set features(FeatureSet v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasFeatures() => $_has(3);
  @$pb.TagNumber(7)
  void clearFeatures() => clearField(7);
  @$pb.TagNumber(7)
  FeatureSet ensureFeatures() => $_ensure(3);

  /// The parser stores options it doesn't recognize here. See above.
  @$pb.TagNumber(999)
  $core.List<UninterpretedOption> get uninterpretedOption => $_getList(4);
}

class EnumValueOptions extends $pb.GeneratedMessage {
  factory EnumValueOptions({
    $core.bool? deprecated,
    FeatureSet? features,
    $core.bool? debugRedact,
    FieldOptions_FeatureSupport? featureSupport,
    $core.Iterable<UninterpretedOption>? uninterpretedOption,
  }) {
    final $result = create();
    if (deprecated != null) {
      $result.deprecated = deprecated;
    }
    if (features != null) {
      $result.features = features;
    }
    if (debugRedact != null) {
      $result.debugRedact = debugRedact;
    }
    if (featureSupport != null) {
      $result.featureSupport = featureSupport;
    }
    if (uninterpretedOption != null) {
      $result.uninterpretedOption.addAll(uninterpretedOption);
    }
    return $result;
  }
  EnumValueOptions._() : super();
  factory EnumValueOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnumValueOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnumValueOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'deprecated')
    ..aOM<FeatureSet>(2, _omitFieldNames ? '' : 'features',
        subBuilder: FeatureSet.create)
    ..aOB(3, _omitFieldNames ? '' : 'debugRedact')
    ..aOM<FieldOptions_FeatureSupport>(
        4, _omitFieldNames ? '' : 'featureSupport',
        subBuilder: FieldOptions_FeatureSupport.create)
    ..pc<UninterpretedOption>(
        999, _omitFieldNames ? '' : 'uninterpretedOption', $pb.PbFieldType.PM,
        subBuilder: UninterpretedOption.create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnumValueOptions clone() => EnumValueOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnumValueOptions copyWith(void Function(EnumValueOptions) updates) =>
      super.copyWith((message) => updates(message as EnumValueOptions))
          as EnumValueOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnumValueOptions create() => EnumValueOptions._();
  EnumValueOptions createEmptyInstance() => create();
  static $pb.PbList<EnumValueOptions> createRepeated() =>
      $pb.PbList<EnumValueOptions>();
  @$core.pragma('dart2js:noInline')
  static EnumValueOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnumValueOptions>(create);
  static EnumValueOptions? _defaultInstance;

  /// Is this enum value deprecated?
  /// Depending on the target platform, this can emit Deprecated annotations
  /// for the enum value, or it will be completely ignored; in the very least,
  /// this is a formalization for deprecating enum values.
  @$pb.TagNumber(1)
  $core.bool get deprecated => $_getBF(0);
  @$pb.TagNumber(1)
  set deprecated($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeprecated() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeprecated() => clearField(1);

  /// Any features defined in the specific edition.
  @$pb.TagNumber(2)
  FeatureSet get features => $_getN(1);
  @$pb.TagNumber(2)
  set features(FeatureSet v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFeatures() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeatures() => clearField(2);
  @$pb.TagNumber(2)
  FeatureSet ensureFeatures() => $_ensure(1);

  /// Indicate that fields annotated with this enum value should not be printed
  /// out when using debug formats, e.g. when the field contains sensitive
  /// credentials.
  @$pb.TagNumber(3)
  $core.bool get debugRedact => $_getBF(2);
  @$pb.TagNumber(3)
  set debugRedact($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDebugRedact() => $_has(2);
  @$pb.TagNumber(3)
  void clearDebugRedact() => clearField(3);

  /// Information about the support window of a feature value.
  @$pb.TagNumber(4)
  FieldOptions_FeatureSupport get featureSupport => $_getN(3);
  @$pb.TagNumber(4)
  set featureSupport(FieldOptions_FeatureSupport v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFeatureSupport() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeatureSupport() => clearField(4);
  @$pb.TagNumber(4)
  FieldOptions_FeatureSupport ensureFeatureSupport() => $_ensure(3);

  /// The parser stores options it doesn't recognize here. See above.
  @$pb.TagNumber(999)
  $core.List<UninterpretedOption> get uninterpretedOption => $_getList(4);
}

class ServiceOptions extends $pb.GeneratedMessage {
  factory ServiceOptions({
    $core.bool? deprecated,
    FeatureSet? features,
    $core.Iterable<UninterpretedOption>? uninterpretedOption,
  }) {
    final $result = create();
    if (deprecated != null) {
      $result.deprecated = deprecated;
    }
    if (features != null) {
      $result.features = features;
    }
    if (uninterpretedOption != null) {
      $result.uninterpretedOption.addAll(uninterpretedOption);
    }
    return $result;
  }
  ServiceOptions._() : super();
  factory ServiceOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ServiceOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOB(33, _omitFieldNames ? '' : 'deprecated')
    ..aOM<FeatureSet>(34, _omitFieldNames ? '' : 'features',
        subBuilder: FeatureSet.create)
    ..pc<UninterpretedOption>(
        999, _omitFieldNames ? '' : 'uninterpretedOption', $pb.PbFieldType.PM,
        subBuilder: UninterpretedOption.create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ServiceOptions clone() => ServiceOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ServiceOptions copyWith(void Function(ServiceOptions) updates) =>
      super.copyWith((message) => updates(message as ServiceOptions))
          as ServiceOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceOptions create() => ServiceOptions._();
  ServiceOptions createEmptyInstance() => create();
  static $pb.PbList<ServiceOptions> createRepeated() =>
      $pb.PbList<ServiceOptions>();
  @$core.pragma('dart2js:noInline')
  static ServiceOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceOptions>(create);
  static ServiceOptions? _defaultInstance;

  /// Is this service deprecated?
  /// Depending on the target platform, this can emit Deprecated annotations
  /// for the service, or it will be completely ignored; in the very least,
  /// this is a formalization for deprecating services.
  @$pb.TagNumber(33)
  $core.bool get deprecated => $_getBF(0);
  @$pb.TagNumber(33)
  set deprecated($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(33)
  $core.bool hasDeprecated() => $_has(0);
  @$pb.TagNumber(33)
  void clearDeprecated() => clearField(33);

  /// Any features defined in the specific edition.
  @$pb.TagNumber(34)
  FeatureSet get features => $_getN(1);
  @$pb.TagNumber(34)
  set features(FeatureSet v) {
    setField(34, v);
  }

  @$pb.TagNumber(34)
  $core.bool hasFeatures() => $_has(1);
  @$pb.TagNumber(34)
  void clearFeatures() => clearField(34);
  @$pb.TagNumber(34)
  FeatureSet ensureFeatures() => $_ensure(1);

  /// The parser stores options it doesn't recognize here. See above.
  @$pb.TagNumber(999)
  $core.List<UninterpretedOption> get uninterpretedOption => $_getList(2);
}

class MethodOptions extends $pb.GeneratedMessage {
  factory MethodOptions({
    $core.bool? deprecated,
    MethodOptions_IdempotencyLevel? idempotencyLevel,
    FeatureSet? features,
    $core.Iterable<UninterpretedOption>? uninterpretedOption,
  }) {
    final $result = create();
    if (deprecated != null) {
      $result.deprecated = deprecated;
    }
    if (idempotencyLevel != null) {
      $result.idempotencyLevel = idempotencyLevel;
    }
    if (features != null) {
      $result.features = features;
    }
    if (uninterpretedOption != null) {
      $result.uninterpretedOption.addAll(uninterpretedOption);
    }
    return $result;
  }
  MethodOptions._() : super();
  factory MethodOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MethodOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MethodOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOB(33, _omitFieldNames ? '' : 'deprecated')
    ..e<MethodOptions_IdempotencyLevel>(
        34, _omitFieldNames ? '' : 'idempotencyLevel', $pb.PbFieldType.OE,
        defaultOrMaker: MethodOptions_IdempotencyLevel.IDEMPOTENCY_UNKNOWN,
        valueOf: MethodOptions_IdempotencyLevel.valueOf,
        enumValues: MethodOptions_IdempotencyLevel.values)
    ..aOM<FeatureSet>(35, _omitFieldNames ? '' : 'features',
        subBuilder: FeatureSet.create)
    ..pc<UninterpretedOption>(
        999, _omitFieldNames ? '' : 'uninterpretedOption', $pb.PbFieldType.PM,
        subBuilder: UninterpretedOption.create)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MethodOptions clone() => MethodOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MethodOptions copyWith(void Function(MethodOptions) updates) =>
      super.copyWith((message) => updates(message as MethodOptions))
          as MethodOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MethodOptions create() => MethodOptions._();
  MethodOptions createEmptyInstance() => create();
  static $pb.PbList<MethodOptions> createRepeated() =>
      $pb.PbList<MethodOptions>();
  @$core.pragma('dart2js:noInline')
  static MethodOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MethodOptions>(create);
  static MethodOptions? _defaultInstance;

  /// Is this method deprecated?
  /// Depending on the target platform, this can emit Deprecated annotations
  /// for the method, or it will be completely ignored; in the very least,
  /// this is a formalization for deprecating methods.
  @$pb.TagNumber(33)
  $core.bool get deprecated => $_getBF(0);
  @$pb.TagNumber(33)
  set deprecated($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(33)
  $core.bool hasDeprecated() => $_has(0);
  @$pb.TagNumber(33)
  void clearDeprecated() => clearField(33);

  @$pb.TagNumber(34)
  MethodOptions_IdempotencyLevel get idempotencyLevel => $_getN(1);
  @$pb.TagNumber(34)
  set idempotencyLevel(MethodOptions_IdempotencyLevel v) {
    setField(34, v);
  }

  @$pb.TagNumber(34)
  $core.bool hasIdempotencyLevel() => $_has(1);
  @$pb.TagNumber(34)
  void clearIdempotencyLevel() => clearField(34);

  /// Any features defined in the specific edition.
  @$pb.TagNumber(35)
  FeatureSet get features => $_getN(2);
  @$pb.TagNumber(35)
  set features(FeatureSet v) {
    setField(35, v);
  }

  @$pb.TagNumber(35)
  $core.bool hasFeatures() => $_has(2);
  @$pb.TagNumber(35)
  void clearFeatures() => clearField(35);
  @$pb.TagNumber(35)
  FeatureSet ensureFeatures() => $_ensure(2);

  /// The parser stores options it doesn't recognize here. See above.
  @$pb.TagNumber(999)
  $core.List<UninterpretedOption> get uninterpretedOption => $_getList(3);
}

/// The name of the uninterpreted option.  Each string represents a segment in
/// a dot-separated name.  is_extension is true iff a segment represents an
/// extension (denoted with parentheses in options specs in .proto files).
/// E.g.,{ ["foo", false], ["bar.baz", true], ["moo", false] } represents
/// "foo.(bar.baz).moo".
class UninterpretedOption_NamePart extends $pb.GeneratedMessage {
  factory UninterpretedOption_NamePart({
    $core.String? namePart,
    $core.bool? isExtension,
  }) {
    final $result = create();
    if (namePart != null) {
      $result.namePart = namePart;
    }
    if (isExtension != null) {
      $result.isExtension = isExtension;
    }
    return $result;
  }
  UninterpretedOption_NamePart._() : super();
  factory UninterpretedOption_NamePart.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UninterpretedOption_NamePart.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UninterpretedOption.NamePart',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'namePart')
    ..a<$core.bool>(
        2, _omitFieldNames ? '' : 'isExtension', $pb.PbFieldType.QB);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UninterpretedOption_NamePart clone() =>
      UninterpretedOption_NamePart()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UninterpretedOption_NamePart copyWith(
          void Function(UninterpretedOption_NamePart) updates) =>
      super.copyWith(
              (message) => updates(message as UninterpretedOption_NamePart))
          as UninterpretedOption_NamePart;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UninterpretedOption_NamePart create() =>
      UninterpretedOption_NamePart._();
  UninterpretedOption_NamePart createEmptyInstance() => create();
  static $pb.PbList<UninterpretedOption_NamePart> createRepeated() =>
      $pb.PbList<UninterpretedOption_NamePart>();
  @$core.pragma('dart2js:noInline')
  static UninterpretedOption_NamePart getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UninterpretedOption_NamePart>(create);
  static UninterpretedOption_NamePart? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get namePart => $_getSZ(0);
  @$pb.TagNumber(1)
  set namePart($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNamePart() => $_has(0);
  @$pb.TagNumber(1)
  void clearNamePart() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isExtension => $_getBF(1);
  @$pb.TagNumber(2)
  set isExtension($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIsExtension() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsExtension() => clearField(2);
}

/// A message representing a option the parser does not recognize. This only
/// appears in options protos created by the compiler::Parser class.
/// DescriptorPool resolves these when building Descriptor objects. Therefore,
/// options protos in descriptor objects (e.g. returned by Descriptor::options(),
/// or produced by Descriptor::CopyTo()) will never have UninterpretedOptions
/// in them.
class UninterpretedOption extends $pb.GeneratedMessage {
  factory UninterpretedOption({
    $core.Iterable<UninterpretedOption_NamePart>? name,
    $core.String? identifierValue,
    $fixnum.Int64? positiveIntValue,
    $fixnum.Int64? negativeIntValue,
    $core.double? doubleValue,
    $core.List<$core.int>? stringValue,
    $core.String? aggregateValue,
  }) {
    final $result = create();
    if (name != null) {
      $result.name.addAll(name);
    }
    if (identifierValue != null) {
      $result.identifierValue = identifierValue;
    }
    if (positiveIntValue != null) {
      $result.positiveIntValue = positiveIntValue;
    }
    if (negativeIntValue != null) {
      $result.negativeIntValue = negativeIntValue;
    }
    if (doubleValue != null) {
      $result.doubleValue = doubleValue;
    }
    if (stringValue != null) {
      $result.stringValue = stringValue;
    }
    if (aggregateValue != null) {
      $result.aggregateValue = aggregateValue;
    }
    return $result;
  }
  UninterpretedOption._() : super();
  factory UninterpretedOption.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UninterpretedOption.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UninterpretedOption',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..pc<UninterpretedOption_NamePart>(
        2, _omitFieldNames ? '' : 'name', $pb.PbFieldType.PM,
        subBuilder: UninterpretedOption_NamePart.create)
    ..aOS(3, _omitFieldNames ? '' : 'identifierValue')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'positiveIntValue', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(5, _omitFieldNames ? '' : 'negativeIntValue')
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'doubleValue', $pb.PbFieldType.OD)
    ..a<$core.List<$core.int>>(
        7, _omitFieldNames ? '' : 'stringValue', $pb.PbFieldType.OY)
    ..aOS(8, _omitFieldNames ? '' : 'aggregateValue');

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UninterpretedOption clone() => UninterpretedOption()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UninterpretedOption copyWith(void Function(UninterpretedOption) updates) =>
      super.copyWith((message) => updates(message as UninterpretedOption))
          as UninterpretedOption;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UninterpretedOption create() => UninterpretedOption._();
  UninterpretedOption createEmptyInstance() => create();
  static $pb.PbList<UninterpretedOption> createRepeated() =>
      $pb.PbList<UninterpretedOption>();
  @$core.pragma('dart2js:noInline')
  static UninterpretedOption getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UninterpretedOption>(create);
  static UninterpretedOption? _defaultInstance;

  @$pb.TagNumber(2)
  $core.List<UninterpretedOption_NamePart> get name => $_getList(0);

  /// The value of the uninterpreted option, in whatever type the tokenizer
  /// identified it as during parsing. Exactly one of these should be set.
  @$pb.TagNumber(3)
  $core.String get identifierValue => $_getSZ(1);
  @$pb.TagNumber(3)
  set identifierValue($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasIdentifierValue() => $_has(1);
  @$pb.TagNumber(3)
  void clearIdentifierValue() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get positiveIntValue => $_getI64(2);
  @$pb.TagNumber(4)
  set positiveIntValue($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPositiveIntValue() => $_has(2);
  @$pb.TagNumber(4)
  void clearPositiveIntValue() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get negativeIntValue => $_getI64(3);
  @$pb.TagNumber(5)
  set negativeIntValue($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasNegativeIntValue() => $_has(3);
  @$pb.TagNumber(5)
  void clearNegativeIntValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get doubleValue => $_getN(4);
  @$pb.TagNumber(6)
  set doubleValue($core.double v) {
    $_setDouble(4, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDoubleValue() => $_has(4);
  @$pb.TagNumber(6)
  void clearDoubleValue() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get stringValue => $_getN(5);
  @$pb.TagNumber(7)
  set stringValue($core.List<$core.int> v) {
    $_setBytes(5, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasStringValue() => $_has(5);
  @$pb.TagNumber(7)
  void clearStringValue() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get aggregateValue => $_getSZ(6);
  @$pb.TagNumber(8)
  set aggregateValue($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasAggregateValue() => $_has(6);
  @$pb.TagNumber(8)
  void clearAggregateValue() => clearField(8);
}

/// TODO Enums in C++ gencode (and potentially other languages) are
/// not well scoped.  This means that each of the feature enums below can clash
/// with each other.  The short names we've chosen maximize call-site
/// readability, but leave us very open to this scenario.  A future feature will
/// be designed and implemented to handle this, hopefully before we ever hit a
/// conflict here.
class FeatureSet extends $pb.GeneratedMessage {
  factory FeatureSet({
    FeatureSet_FieldPresence? fieldPresence,
    FeatureSet_EnumType? enumType,
    FeatureSet_RepeatedFieldEncoding? repeatedFieldEncoding,
    FeatureSet_Utf8Validation? utf8Validation,
    FeatureSet_MessageEncoding? messageEncoding,
    FeatureSet_JsonFormat? jsonFormat,
  }) {
    final $result = create();
    if (fieldPresence != null) {
      $result.fieldPresence = fieldPresence;
    }
    if (enumType != null) {
      $result.enumType = enumType;
    }
    if (repeatedFieldEncoding != null) {
      $result.repeatedFieldEncoding = repeatedFieldEncoding;
    }
    if (utf8Validation != null) {
      $result.utf8Validation = utf8Validation;
    }
    if (messageEncoding != null) {
      $result.messageEncoding = messageEncoding;
    }
    if (jsonFormat != null) {
      $result.jsonFormat = jsonFormat;
    }
    return $result;
  }
  FeatureSet._() : super();
  factory FeatureSet.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FeatureSet.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeatureSet',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..e<FeatureSet_FieldPresence>(
        1, _omitFieldNames ? '' : 'fieldPresence', $pb.PbFieldType.OE,
        defaultOrMaker: FeatureSet_FieldPresence.FIELD_PRESENCE_UNKNOWN,
        valueOf: FeatureSet_FieldPresence.valueOf,
        enumValues: FeatureSet_FieldPresence.values)
    ..e<FeatureSet_EnumType>(
        2, _omitFieldNames ? '' : 'enumType', $pb.PbFieldType.OE,
        defaultOrMaker: FeatureSet_EnumType.ENUM_TYPE_UNKNOWN,
        valueOf: FeatureSet_EnumType.valueOf,
        enumValues: FeatureSet_EnumType.values)
    ..e<FeatureSet_RepeatedFieldEncoding>(
        3, _omitFieldNames ? '' : 'repeatedFieldEncoding', $pb.PbFieldType.OE,
        defaultOrMaker:
            FeatureSet_RepeatedFieldEncoding.REPEATED_FIELD_ENCODING_UNKNOWN,
        valueOf: FeatureSet_RepeatedFieldEncoding.valueOf,
        enumValues: FeatureSet_RepeatedFieldEncoding.values)
    ..e<FeatureSet_Utf8Validation>(
        4, _omitFieldNames ? '' : 'utf8Validation', $pb.PbFieldType.OE,
        defaultOrMaker: FeatureSet_Utf8Validation.UTF8_VALIDATION_UNKNOWN,
        valueOf: FeatureSet_Utf8Validation.valueOf,
        enumValues: FeatureSet_Utf8Validation.values)
    ..e<FeatureSet_MessageEncoding>(
        5, _omitFieldNames ? '' : 'messageEncoding', $pb.PbFieldType.OE,
        defaultOrMaker: FeatureSet_MessageEncoding.MESSAGE_ENCODING_UNKNOWN,
        valueOf: FeatureSet_MessageEncoding.valueOf,
        enumValues: FeatureSet_MessageEncoding.values)
    ..e<FeatureSet_JsonFormat>(
        6, _omitFieldNames ? '' : 'jsonFormat', $pb.PbFieldType.OE,
        defaultOrMaker: FeatureSet_JsonFormat.JSON_FORMAT_UNKNOWN,
        valueOf: FeatureSet_JsonFormat.valueOf,
        enumValues: FeatureSet_JsonFormat.values)
    ..hasExtensions = true;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FeatureSet clone() => FeatureSet()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FeatureSet copyWith(void Function(FeatureSet) updates) =>
      super.copyWith((message) => updates(message as FeatureSet)) as FeatureSet;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeatureSet create() => FeatureSet._();
  FeatureSet createEmptyInstance() => create();
  static $pb.PbList<FeatureSet> createRepeated() => $pb.PbList<FeatureSet>();
  @$core.pragma('dart2js:noInline')
  static FeatureSet getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FeatureSet>(create);
  static FeatureSet? _defaultInstance;

  @$pb.TagNumber(1)
  FeatureSet_FieldPresence get fieldPresence => $_getN(0);
  @$pb.TagNumber(1)
  set fieldPresence(FeatureSet_FieldPresence v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFieldPresence() => $_has(0);
  @$pb.TagNumber(1)
  void clearFieldPresence() => clearField(1);

  @$pb.TagNumber(2)
  FeatureSet_EnumType get enumType => $_getN(1);
  @$pb.TagNumber(2)
  set enumType(FeatureSet_EnumType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEnumType() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnumType() => clearField(2);

  @$pb.TagNumber(3)
  FeatureSet_RepeatedFieldEncoding get repeatedFieldEncoding => $_getN(2);
  @$pb.TagNumber(3)
  set repeatedFieldEncoding(FeatureSet_RepeatedFieldEncoding v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRepeatedFieldEncoding() => $_has(2);
  @$pb.TagNumber(3)
  void clearRepeatedFieldEncoding() => clearField(3);

  @$pb.TagNumber(4)
  FeatureSet_Utf8Validation get utf8Validation => $_getN(3);
  @$pb.TagNumber(4)
  set utf8Validation(FeatureSet_Utf8Validation v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasUtf8Validation() => $_has(3);
  @$pb.TagNumber(4)
  void clearUtf8Validation() => clearField(4);

  @$pb.TagNumber(5)
  FeatureSet_MessageEncoding get messageEncoding => $_getN(4);
  @$pb.TagNumber(5)
  set messageEncoding(FeatureSet_MessageEncoding v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasMessageEncoding() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessageEncoding() => clearField(5);

  @$pb.TagNumber(6)
  FeatureSet_JsonFormat get jsonFormat => $_getN(5);
  @$pb.TagNumber(6)
  set jsonFormat(FeatureSet_JsonFormat v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasJsonFormat() => $_has(5);
  @$pb.TagNumber(6)
  void clearJsonFormat() => clearField(6);
}

/// A map from every known edition with a unique set of defaults to its
/// defaults. Not all editions may be contained here.  For a given edition,
/// the defaults at the closest matching edition ordered at or before it should
/// be used.  This field must be in strict ascending order by edition.
class FeatureSetDefaults_FeatureSetEditionDefault extends $pb.GeneratedMessage {
  factory FeatureSetDefaults_FeatureSetEditionDefault({
    Edition? edition,
    FeatureSet? overridableFeatures,
    FeatureSet? fixedFeatures,
  }) {
    final $result = create();
    if (edition != null) {
      $result.edition = edition;
    }
    if (overridableFeatures != null) {
      $result.overridableFeatures = overridableFeatures;
    }
    if (fixedFeatures != null) {
      $result.fixedFeatures = fixedFeatures;
    }
    return $result;
  }
  FeatureSetDefaults_FeatureSetEditionDefault._() : super();
  factory FeatureSetDefaults_FeatureSetEditionDefault.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FeatureSetDefaults_FeatureSetEditionDefault.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeatureSetDefaults.FeatureSetEditionDefault',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..e<Edition>(3, _omitFieldNames ? '' : 'edition', $pb.PbFieldType.OE,
        defaultOrMaker: Edition.EDITION_UNKNOWN,
        valueOf: Edition.valueOf,
        enumValues: Edition.values)
    ..aOM<FeatureSet>(4, _omitFieldNames ? '' : 'overridableFeatures',
        subBuilder: FeatureSet.create)
    ..aOM<FeatureSet>(5, _omitFieldNames ? '' : 'fixedFeatures',
        subBuilder: FeatureSet.create);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FeatureSetDefaults_FeatureSetEditionDefault clone() =>
      FeatureSetDefaults_FeatureSetEditionDefault()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FeatureSetDefaults_FeatureSetEditionDefault copyWith(
          void Function(FeatureSetDefaults_FeatureSetEditionDefault) updates) =>
      super.copyWith((message) =>
              updates(message as FeatureSetDefaults_FeatureSetEditionDefault))
          as FeatureSetDefaults_FeatureSetEditionDefault;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeatureSetDefaults_FeatureSetEditionDefault create() =>
      FeatureSetDefaults_FeatureSetEditionDefault._();
  FeatureSetDefaults_FeatureSetEditionDefault createEmptyInstance() => create();
  static $pb.PbList<FeatureSetDefaults_FeatureSetEditionDefault>
      createRepeated() =>
          $pb.PbList<FeatureSetDefaults_FeatureSetEditionDefault>();
  @$core.pragma('dart2js:noInline')
  static FeatureSetDefaults_FeatureSetEditionDefault getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          FeatureSetDefaults_FeatureSetEditionDefault>(create);
  static FeatureSetDefaults_FeatureSetEditionDefault? _defaultInstance;

  @$pb.TagNumber(3)
  Edition get edition => $_getN(0);
  @$pb.TagNumber(3)
  set edition(Edition v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEdition() => $_has(0);
  @$pb.TagNumber(3)
  void clearEdition() => clearField(3);

  /// Defaults of features that can be overridden in this edition.
  @$pb.TagNumber(4)
  FeatureSet get overridableFeatures => $_getN(1);
  @$pb.TagNumber(4)
  set overridableFeatures(FeatureSet v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasOverridableFeatures() => $_has(1);
  @$pb.TagNumber(4)
  void clearOverridableFeatures() => clearField(4);
  @$pb.TagNumber(4)
  FeatureSet ensureOverridableFeatures() => $_ensure(1);

  /// Defaults of features that can't be overridden in this edition.
  @$pb.TagNumber(5)
  FeatureSet get fixedFeatures => $_getN(2);
  @$pb.TagNumber(5)
  set fixedFeatures(FeatureSet v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasFixedFeatures() => $_has(2);
  @$pb.TagNumber(5)
  void clearFixedFeatures() => clearField(5);
  @$pb.TagNumber(5)
  FeatureSet ensureFixedFeatures() => $_ensure(2);
}

/// A compiled specification for the defaults of a set of features.  These
/// messages are generated from FeatureSet extensions and can be used to seed
/// feature resolution. The resolution with this object becomes a simple search
/// for the closest matching edition, followed by proto merges.
class FeatureSetDefaults extends $pb.GeneratedMessage {
  factory FeatureSetDefaults({
    $core.Iterable<FeatureSetDefaults_FeatureSetEditionDefault>? defaults,
    Edition? minimumEdition,
    Edition? maximumEdition,
  }) {
    final $result = create();
    if (defaults != null) {
      $result.defaults.addAll(defaults);
    }
    if (minimumEdition != null) {
      $result.minimumEdition = minimumEdition;
    }
    if (maximumEdition != null) {
      $result.maximumEdition = maximumEdition;
    }
    return $result;
  }
  FeatureSetDefaults._() : super();
  factory FeatureSetDefaults.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FeatureSetDefaults.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeatureSetDefaults',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..pc<FeatureSetDefaults_FeatureSetEditionDefault>(
        1, _omitFieldNames ? '' : 'defaults', $pb.PbFieldType.PM,
        subBuilder: FeatureSetDefaults_FeatureSetEditionDefault.create)
    ..e<Edition>(4, _omitFieldNames ? '' : 'minimumEdition', $pb.PbFieldType.OE,
        defaultOrMaker: Edition.EDITION_UNKNOWN,
        valueOf: Edition.valueOf,
        enumValues: Edition.values)
    ..e<Edition>(5, _omitFieldNames ? '' : 'maximumEdition', $pb.PbFieldType.OE,
        defaultOrMaker: Edition.EDITION_UNKNOWN,
        valueOf: Edition.valueOf,
        enumValues: Edition.values);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FeatureSetDefaults clone() => FeatureSetDefaults()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FeatureSetDefaults copyWith(void Function(FeatureSetDefaults) updates) =>
      super.copyWith((message) => updates(message as FeatureSetDefaults))
          as FeatureSetDefaults;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeatureSetDefaults create() => FeatureSetDefaults._();
  FeatureSetDefaults createEmptyInstance() => create();
  static $pb.PbList<FeatureSetDefaults> createRepeated() =>
      $pb.PbList<FeatureSetDefaults>();
  @$core.pragma('dart2js:noInline')
  static FeatureSetDefaults getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FeatureSetDefaults>(create);
  static FeatureSetDefaults? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FeatureSetDefaults_FeatureSetEditionDefault> get defaults =>
      $_getList(0);

  /// The minimum supported edition (inclusive) when this was constructed.
  /// Editions before this will not have defaults.
  @$pb.TagNumber(4)
  Edition get minimumEdition => $_getN(1);
  @$pb.TagNumber(4)
  set minimumEdition(Edition v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMinimumEdition() => $_has(1);
  @$pb.TagNumber(4)
  void clearMinimumEdition() => clearField(4);

  /// The maximum known edition (inclusive) when this was constructed. Editions
  /// after this will not have reliable defaults.
  @$pb.TagNumber(5)
  Edition get maximumEdition => $_getN(2);
  @$pb.TagNumber(5)
  set maximumEdition(Edition v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasMaximumEdition() => $_has(2);
  @$pb.TagNumber(5)
  void clearMaximumEdition() => clearField(5);
}

class SourceCodeInfo_Location extends $pb.GeneratedMessage {
  factory SourceCodeInfo_Location({
    $core.Iterable<$core.int>? path,
    $core.Iterable<$core.int>? span,
    $core.String? leadingComments,
    $core.String? trailingComments,
    $core.Iterable<$core.String>? leadingDetachedComments,
  }) {
    final $result = create();
    if (path != null) {
      $result.path.addAll(path);
    }
    if (span != null) {
      $result.span.addAll(span);
    }
    if (leadingComments != null) {
      $result.leadingComments = leadingComments;
    }
    if (trailingComments != null) {
      $result.trailingComments = trailingComments;
    }
    if (leadingDetachedComments != null) {
      $result.leadingDetachedComments.addAll(leadingDetachedComments);
    }
    return $result;
  }
  SourceCodeInfo_Location._() : super();
  factory SourceCodeInfo_Location.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourceCodeInfo_Location.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceCodeInfo.Location',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'path', $pb.PbFieldType.K3)
    ..p<$core.int>(2, _omitFieldNames ? '' : 'span', $pb.PbFieldType.K3)
    ..aOS(3, _omitFieldNames ? '' : 'leadingComments')
    ..aOS(4, _omitFieldNames ? '' : 'trailingComments')
    ..pPS(6, _omitFieldNames ? '' : 'leadingDetachedComments')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourceCodeInfo_Location clone() =>
      SourceCodeInfo_Location()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourceCodeInfo_Location copyWith(
          void Function(SourceCodeInfo_Location) updates) =>
      super.copyWith((message) => updates(message as SourceCodeInfo_Location))
          as SourceCodeInfo_Location;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceCodeInfo_Location create() => SourceCodeInfo_Location._();
  SourceCodeInfo_Location createEmptyInstance() => create();
  static $pb.PbList<SourceCodeInfo_Location> createRepeated() =>
      $pb.PbList<SourceCodeInfo_Location>();
  @$core.pragma('dart2js:noInline')
  static SourceCodeInfo_Location getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceCodeInfo_Location>(create);
  static SourceCodeInfo_Location? _defaultInstance;

  ///  Identifies which part of the FileDescriptorProto was defined at this
  ///  location.
  ///
  ///  Each element is a field number or an index.  They form a path from
  ///  the root FileDescriptorProto to the place where the definition appears.
  ///  For example, this path:
  ///    [ 4, 3, 2, 7, 1 ]
  ///  refers to:
  ///    file.message_type(3)  // 4, 3
  ///        .field(7)         // 2, 7
  ///        .name()           // 1
  ///  This is because FileDescriptorProto.message_type has field number 4:
  ///    repeated DescriptorProto message_type = 4;
  ///  and DescriptorProto.field has field number 2:
  ///    repeated FieldDescriptorProto field = 2;
  ///  and FieldDescriptorProto.name has field number 1:
  ///    optional string name = 1;
  ///
  ///  Thus, the above path gives the location of a field name.  If we removed
  ///  the last element:
  ///    [ 4, 3, 2, 7 ]
  ///  this path refers to the whole field declaration (from the beginning
  ///  of the label to the terminating semicolon).
  @$pb.TagNumber(1)
  $core.List<$core.int> get path => $_getList(0);

  /// Always has exactly three or four elements: start line, start column,
  /// end line (optional, otherwise assumed same as start line), end column.
  /// These are packed into a single field for efficiency.  Note that line
  /// and column numbers are zero-based -- typically you will want to add
  /// 1 to each before displaying to a user.
  @$pb.TagNumber(2)
  $core.List<$core.int> get span => $_getList(1);

  ///  If this SourceCodeInfo represents a complete declaration, these are any
  ///  comments appearing before and after the declaration which appear to be
  ///  attached to the declaration.
  ///
  ///  A series of line comments appearing on consecutive lines, with no other
  ///  tokens appearing on those lines, will be treated as a single comment.
  ///
  ///  leading_detached_comments will keep paragraphs of comments that appear
  ///  before (but not connected to) the current element. Each paragraph,
  ///  separated by empty lines, will be one comment element in the repeated
  ///  field.
  ///
  ///  Only the comment content is provided; comment markers (e.g. //) are
  ///  stripped out.  For block comments, leading whitespace and an asterisk
  ///  will be stripped from the beginning of each line other than the first.
  ///  Newlines are included in the output.
  ///
  ///  Examples:
  ///
  ///    optional int32 foo = 1;  // Comment attached to foo.
  ///    // Comment attached to bar.
  ///    optional int32 bar = 2;
  ///
  ///    optional string baz = 3;
  ///    // Comment attached to baz.
  ///    // Another line attached to baz.
  ///
  ///    // Comment attached to moo.
  ///    //
  ///    // Another line attached to moo.
  ///    optional double moo = 4;
  ///
  ///    // Detached comment for corge. This is not leading or trailing comments
  ///    // to moo or corge because there are blank lines separating it from
  ///    // both.
  ///
  ///    // Detached comment for corge paragraph 2.
  ///
  ///    optional string corge = 5;
  ///    /* Block comment attached
  ///     * to corge.  Leading asterisks
  ///     * will be removed. */
  ///    /* Block comment attached to
  ///     * grault. */
  ///    optional int32 grault = 6;
  ///
  ///    // ignored detached comments.
  @$pb.TagNumber(3)
  $core.String get leadingComments => $_getSZ(2);
  @$pb.TagNumber(3)
  set leadingComments($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLeadingComments() => $_has(2);
  @$pb.TagNumber(3)
  void clearLeadingComments() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get trailingComments => $_getSZ(3);
  @$pb.TagNumber(4)
  set trailingComments($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasTrailingComments() => $_has(3);
  @$pb.TagNumber(4)
  void clearTrailingComments() => clearField(4);

  @$pb.TagNumber(6)
  $core.List<$core.String> get leadingDetachedComments => $_getList(4);
}

/// Encapsulates information about the original source file from which a
/// FileDescriptorProto was generated.
class SourceCodeInfo extends $pb.GeneratedMessage {
  factory SourceCodeInfo({
    $core.Iterable<SourceCodeInfo_Location>? location,
  }) {
    final $result = create();
    if (location != null) {
      $result.location.addAll(location);
    }
    return $result;
  }
  SourceCodeInfo._() : super();
  factory SourceCodeInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourceCodeInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceCodeInfo',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..pc<SourceCodeInfo_Location>(
        1, _omitFieldNames ? '' : 'location', $pb.PbFieldType.PM,
        subBuilder: SourceCodeInfo_Location.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourceCodeInfo clone() => SourceCodeInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourceCodeInfo copyWith(void Function(SourceCodeInfo) updates) =>
      super.copyWith((message) => updates(message as SourceCodeInfo))
          as SourceCodeInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceCodeInfo create() => SourceCodeInfo._();
  SourceCodeInfo createEmptyInstance() => create();
  static $pb.PbList<SourceCodeInfo> createRepeated() =>
      $pb.PbList<SourceCodeInfo>();
  @$core.pragma('dart2js:noInline')
  static SourceCodeInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceCodeInfo>(create);
  static SourceCodeInfo? _defaultInstance;

  ///  A Location identifies a piece of source code in a .proto file which
  ///  corresponds to a particular definition.  This information is intended
  ///  to be useful to IDEs, code indexers, documentation generators, and similar
  ///  tools.
  ///
  ///  For example, say we have a file like:
  ///    message Foo {
  ///      optional string foo = 1;
  ///    }
  ///  Let's look at just the field definition:
  ///    optional string foo = 1;
  ///    ^       ^^     ^^  ^  ^^^
  ///    a       bc     de  f  ghi
  ///  We have the following locations:
  ///    span   path               represents
  ///    [a,i)  [ 4, 0, 2, 0 ]     The whole field definition.
  ///    [a,b)  [ 4, 0, 2, 0, 4 ]  The label (optional).
  ///    [c,d)  [ 4, 0, 2, 0, 5 ]  The type (string).
  ///    [e,f)  [ 4, 0, 2, 0, 1 ]  The name (foo).
  ///    [g,h)  [ 4, 0, 2, 0, 3 ]  The number (1).
  ///
  ///  Notes:
  ///  - A location may refer to a repeated field itself (i.e. not to any
  ///    particular index within it).  This is used whenever a set of elements are
  ///    logically enclosed in a single code segment.  For example, an entire
  ///    extend block (possibly containing multiple extension definitions) will
  ///    have an outer location whose path refers to the "extensions" repeated
  ///    field without an index.
  ///  - Multiple locations may have the same path.  This happens when a single
  ///    logical declaration is spread out across multiple places.  The most
  ///    obvious example is the "extend" block again -- there may be multiple
  ///    extend blocks in the same scope, each of which will have the same path.
  ///  - A location's span is not always a subset of its parent's span.  For
  ///    example, the "extendee" of an extension declaration appears at the
  ///    beginning of the "extend" block and is shared by all extensions within
  ///    the block.
  ///  - Just because a location's span is a subset of some other location's span
  ///    does not mean that it is a descendant.  For example, a "group" defines
  ///    both a type and a field in a single declaration.  Thus, the locations
  ///    corresponding to the type and field and their components will overlap.
  ///  - Code which tries to interpret locations should probably be designed to
  ///    ignore those that it doesn't understand, as more types of locations could
  ///    be recorded in the future.
  @$pb.TagNumber(1)
  $core.List<SourceCodeInfo_Location> get location => $_getList(0);
}

class GeneratedCodeInfo_Annotation extends $pb.GeneratedMessage {
  factory GeneratedCodeInfo_Annotation({
    $core.Iterable<$core.int>? path,
    $core.String? sourceFile,
    $core.int? begin,
    $core.int? end,
    GeneratedCodeInfo_Annotation_Semantic? semantic,
  }) {
    final $result = create();
    if (path != null) {
      $result.path.addAll(path);
    }
    if (sourceFile != null) {
      $result.sourceFile = sourceFile;
    }
    if (begin != null) {
      $result.begin = begin;
    }
    if (end != null) {
      $result.end = end;
    }
    if (semantic != null) {
      $result.semantic = semantic;
    }
    return $result;
  }
  GeneratedCodeInfo_Annotation._() : super();
  factory GeneratedCodeInfo_Annotation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GeneratedCodeInfo_Annotation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GeneratedCodeInfo.Annotation',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'path', $pb.PbFieldType.K3)
    ..aOS(2, _omitFieldNames ? '' : 'sourceFile')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'begin', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'end', $pb.PbFieldType.O3)
    ..e<GeneratedCodeInfo_Annotation_Semantic>(
        5, _omitFieldNames ? '' : 'semantic', $pb.PbFieldType.OE,
        defaultOrMaker: GeneratedCodeInfo_Annotation_Semantic.NONE,
        valueOf: GeneratedCodeInfo_Annotation_Semantic.valueOf,
        enumValues: GeneratedCodeInfo_Annotation_Semantic.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GeneratedCodeInfo_Annotation clone() =>
      GeneratedCodeInfo_Annotation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GeneratedCodeInfo_Annotation copyWith(
          void Function(GeneratedCodeInfo_Annotation) updates) =>
      super.copyWith(
              (message) => updates(message as GeneratedCodeInfo_Annotation))
          as GeneratedCodeInfo_Annotation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeneratedCodeInfo_Annotation create() =>
      GeneratedCodeInfo_Annotation._();
  GeneratedCodeInfo_Annotation createEmptyInstance() => create();
  static $pb.PbList<GeneratedCodeInfo_Annotation> createRepeated() =>
      $pb.PbList<GeneratedCodeInfo_Annotation>();
  @$core.pragma('dart2js:noInline')
  static GeneratedCodeInfo_Annotation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GeneratedCodeInfo_Annotation>(create);
  static GeneratedCodeInfo_Annotation? _defaultInstance;

  /// Identifies the element in the original source .proto file. This field
  /// is formatted the same as SourceCodeInfo.Location.path.
  @$pb.TagNumber(1)
  $core.List<$core.int> get path => $_getList(0);

  /// Identifies the filesystem path to the original source .proto.
  @$pb.TagNumber(2)
  $core.String get sourceFile => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceFile($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSourceFile() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceFile() => clearField(2);

  /// Identifies the starting offset in bytes in the generated code
  /// that relates to the identified object.
  @$pb.TagNumber(3)
  $core.int get begin => $_getIZ(2);
  @$pb.TagNumber(3)
  set begin($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasBegin() => $_has(2);
  @$pb.TagNumber(3)
  void clearBegin() => clearField(3);

  /// Identifies the ending offset in bytes in the generated code that
  /// relates to the identified object. The end offset should be one past
  /// the last relevant byte (so the length of the text = end - begin).
  @$pb.TagNumber(4)
  $core.int get end => $_getIZ(3);
  @$pb.TagNumber(4)
  set end($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasEnd() => $_has(3);
  @$pb.TagNumber(4)
  void clearEnd() => clearField(4);

  @$pb.TagNumber(5)
  GeneratedCodeInfo_Annotation_Semantic get semantic => $_getN(4);
  @$pb.TagNumber(5)
  set semantic(GeneratedCodeInfo_Annotation_Semantic v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSemantic() => $_has(4);
  @$pb.TagNumber(5)
  void clearSemantic() => clearField(5);
}

/// Describes the relationship between generated code and its original source
/// file. A GeneratedCodeInfo message is associated with only one generated
/// source file, but may contain references to different source .proto files.
class GeneratedCodeInfo extends $pb.GeneratedMessage {
  factory GeneratedCodeInfo({
    $core.Iterable<GeneratedCodeInfo_Annotation>? annotation,
  }) {
    final $result = create();
    if (annotation != null) {
      $result.annotation.addAll(annotation);
    }
    return $result;
  }
  GeneratedCodeInfo._() : super();
  factory GeneratedCodeInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GeneratedCodeInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GeneratedCodeInfo',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..pc<GeneratedCodeInfo_Annotation>(
        1, _omitFieldNames ? '' : 'annotation', $pb.PbFieldType.PM,
        subBuilder: GeneratedCodeInfo_Annotation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GeneratedCodeInfo clone() => GeneratedCodeInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GeneratedCodeInfo copyWith(void Function(GeneratedCodeInfo) updates) =>
      super.copyWith((message) => updates(message as GeneratedCodeInfo))
          as GeneratedCodeInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeneratedCodeInfo create() => GeneratedCodeInfo._();
  GeneratedCodeInfo createEmptyInstance() => create();
  static $pb.PbList<GeneratedCodeInfo> createRepeated() =>
      $pb.PbList<GeneratedCodeInfo>();
  @$core.pragma('dart2js:noInline')
  static GeneratedCodeInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GeneratedCodeInfo>(create);
  static GeneratedCodeInfo? _defaultInstance;

  /// An Annotation connects some span of text in generated code to an element
  /// of its generating .proto file.
  @$pb.TagNumber(1)
  $core.List<GeneratedCodeInfo_Annotation> get annotation => $_getList(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
