///
//  Generated code. Do not modify.
///
library google.genomics.v1_range;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class Range extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Range')
    ..a/*<String>*/(1, 'referenceName', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'start', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(3, 'end', PbFieldType.O6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  Range() : super();
  Range.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Range.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Range clone() => new Range()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Range create() => new Range();
  static PbList<Range> createRepeated() => new PbList<Range>();
  static Range getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRange();
    return _defaultInstance;
  }
  static Range _defaultInstance;
  static void $checkItem(Range v) {
    if (v is !Range) checkItemFailed(v, 'Range');
  }

  String get referenceName => $_get(0, 1, '');
  void set referenceName(String v) { $_setString(0, 1, v); }
  bool hasReferenceName() => $_has(0, 1);
  void clearReferenceName() => clearField(1);

  Int64 get start => $_get(1, 2, null);
  void set start(Int64 v) { $_setInt64(1, 2, v); }
  bool hasStart() => $_has(1, 2);
  void clearStart() => clearField(2);

  Int64 get end => $_get(2, 3, null);
  void set end(Int64 v) { $_setInt64(2, 3, v); }
  bool hasEnd() => $_has(2, 3);
  void clearEnd() => clearField(3);
}

class _ReadonlyRange extends Range with ReadonlyMessageMixin {}

