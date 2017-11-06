///
//  Generated code. Do not modify.
///
library protobuf_test_messages.proto3_test_messages_proto3;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import 'wrappers.pb.dart' as google$protobuf;
import 'duration.pb.dart' as google$protobuf;
import 'timestamp.pb.dart' as google$protobuf;
import 'field_mask.pb.dart' as google$protobuf;
import 'struct.pb.dart' as google$protobuf;
import 'any.pb.dart' as google$protobuf;

import 'test_messages_proto3.pbenum.dart';

export 'test_messages_proto3.pbenum.dart';

class TestAllTypes_NestedMessage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_NestedMessage')
    ..a/*<int>*/(1, 'a', PbFieldType.O3)
    ..a/*<TestAllTypes>*/(2, 'corecursive', PbFieldType.OM, TestAllTypes.getDefault, TestAllTypes.create)
    ..hasRequiredFields = false
  ;

  TestAllTypes_NestedMessage() : super();
  TestAllTypes_NestedMessage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_NestedMessage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_NestedMessage clone() => new TestAllTypes_NestedMessage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_NestedMessage create() => new TestAllTypes_NestedMessage();
  static PbList<TestAllTypes_NestedMessage> createRepeated() => new PbList<TestAllTypes_NestedMessage>();
  static TestAllTypes_NestedMessage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_NestedMessage();
    return _defaultInstance;
  }
  static TestAllTypes_NestedMessage _defaultInstance;
  static void $checkItem(TestAllTypes_NestedMessage v) {
    if (v is !TestAllTypes_NestedMessage) checkItemFailed(v, 'TestAllTypes_NestedMessage');
  }

  int get a => $_get(0, 1, 0);
  void set a(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasA() => $_has(0, 1);
  void clearA() => clearField(1);

  TestAllTypes get corecursive => $_get(1, 2, null);
  void set corecursive(TestAllTypes v) { setField(2, v); }
  bool hasCorecursive() => $_has(1, 2);
  void clearCorecursive() => clearField(2);
}

class _ReadonlyTestAllTypes_NestedMessage extends TestAllTypes_NestedMessage with ReadonlyMessageMixin {}

class TestAllTypes_MapInt32Int32Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapInt32Int32Entry')
    ..a/*<int>*/(1, 'key', PbFieldType.O3)
    ..a/*<int>*/(2, 'value', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapInt32Int32Entry() : super();
  TestAllTypes_MapInt32Int32Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapInt32Int32Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapInt32Int32Entry clone() => new TestAllTypes_MapInt32Int32Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapInt32Int32Entry create() => new TestAllTypes_MapInt32Int32Entry();
  static PbList<TestAllTypes_MapInt32Int32Entry> createRepeated() => new PbList<TestAllTypes_MapInt32Int32Entry>();
  static TestAllTypes_MapInt32Int32Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapInt32Int32Entry();
    return _defaultInstance;
  }
  static TestAllTypes_MapInt32Int32Entry _defaultInstance;
  static void $checkItem(TestAllTypes_MapInt32Int32Entry v) {
    if (v is !TestAllTypes_MapInt32Int32Entry) checkItemFailed(v, 'TestAllTypes_MapInt32Int32Entry');
  }

  int get key => $_get(0, 1, 0);
  void set key(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  int get value => $_get(1, 2, 0);
  void set value(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapInt32Int32Entry extends TestAllTypes_MapInt32Int32Entry with ReadonlyMessageMixin {}

class TestAllTypes_MapInt64Int64Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapInt64Int64Entry')
    ..a/*<Int64>*/(1, 'key', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(2, 'value', PbFieldType.O6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapInt64Int64Entry() : super();
  TestAllTypes_MapInt64Int64Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapInt64Int64Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapInt64Int64Entry clone() => new TestAllTypes_MapInt64Int64Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapInt64Int64Entry create() => new TestAllTypes_MapInt64Int64Entry();
  static PbList<TestAllTypes_MapInt64Int64Entry> createRepeated() => new PbList<TestAllTypes_MapInt64Int64Entry>();
  static TestAllTypes_MapInt64Int64Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapInt64Int64Entry();
    return _defaultInstance;
  }
  static TestAllTypes_MapInt64Int64Entry _defaultInstance;
  static void $checkItem(TestAllTypes_MapInt64Int64Entry v) {
    if (v is !TestAllTypes_MapInt64Int64Entry) checkItemFailed(v, 'TestAllTypes_MapInt64Int64Entry');
  }

  Int64 get key => $_get(0, 1, null);
  void set key(Int64 v) { $_setInt64(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Int64 get value => $_get(1, 2, null);
  void set value(Int64 v) { $_setInt64(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapInt64Int64Entry extends TestAllTypes_MapInt64Int64Entry with ReadonlyMessageMixin {}

class TestAllTypes_MapUint32Uint32Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapUint32Uint32Entry')
    ..a/*<int>*/(1, 'key', PbFieldType.OU3)
    ..a/*<int>*/(2, 'value', PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapUint32Uint32Entry() : super();
  TestAllTypes_MapUint32Uint32Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapUint32Uint32Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapUint32Uint32Entry clone() => new TestAllTypes_MapUint32Uint32Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapUint32Uint32Entry create() => new TestAllTypes_MapUint32Uint32Entry();
  static PbList<TestAllTypes_MapUint32Uint32Entry> createRepeated() => new PbList<TestAllTypes_MapUint32Uint32Entry>();
  static TestAllTypes_MapUint32Uint32Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapUint32Uint32Entry();
    return _defaultInstance;
  }
  static TestAllTypes_MapUint32Uint32Entry _defaultInstance;
  static void $checkItem(TestAllTypes_MapUint32Uint32Entry v) {
    if (v is !TestAllTypes_MapUint32Uint32Entry) checkItemFailed(v, 'TestAllTypes_MapUint32Uint32Entry');
  }

  int get key => $_get(0, 1, 0);
  void set key(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  int get value => $_get(1, 2, 0);
  void set value(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapUint32Uint32Entry extends TestAllTypes_MapUint32Uint32Entry with ReadonlyMessageMixin {}

class TestAllTypes_MapUint64Uint64Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapUint64Uint64Entry')
    ..a/*<Int64>*/(1, 'key', PbFieldType.OU6, Int64.ZERO)
    ..a/*<Int64>*/(2, 'value', PbFieldType.OU6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapUint64Uint64Entry() : super();
  TestAllTypes_MapUint64Uint64Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapUint64Uint64Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapUint64Uint64Entry clone() => new TestAllTypes_MapUint64Uint64Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapUint64Uint64Entry create() => new TestAllTypes_MapUint64Uint64Entry();
  static PbList<TestAllTypes_MapUint64Uint64Entry> createRepeated() => new PbList<TestAllTypes_MapUint64Uint64Entry>();
  static TestAllTypes_MapUint64Uint64Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapUint64Uint64Entry();
    return _defaultInstance;
  }
  static TestAllTypes_MapUint64Uint64Entry _defaultInstance;
  static void $checkItem(TestAllTypes_MapUint64Uint64Entry v) {
    if (v is !TestAllTypes_MapUint64Uint64Entry) checkItemFailed(v, 'TestAllTypes_MapUint64Uint64Entry');
  }

  Int64 get key => $_get(0, 1, null);
  void set key(Int64 v) { $_setInt64(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Int64 get value => $_get(1, 2, null);
  void set value(Int64 v) { $_setInt64(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapUint64Uint64Entry extends TestAllTypes_MapUint64Uint64Entry with ReadonlyMessageMixin {}

class TestAllTypes_MapSint32Sint32Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapSint32Sint32Entry')
    ..a/*<int>*/(1, 'key', PbFieldType.OS3)
    ..a/*<int>*/(2, 'value', PbFieldType.OS3)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapSint32Sint32Entry() : super();
  TestAllTypes_MapSint32Sint32Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapSint32Sint32Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapSint32Sint32Entry clone() => new TestAllTypes_MapSint32Sint32Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapSint32Sint32Entry create() => new TestAllTypes_MapSint32Sint32Entry();
  static PbList<TestAllTypes_MapSint32Sint32Entry> createRepeated() => new PbList<TestAllTypes_MapSint32Sint32Entry>();
  static TestAllTypes_MapSint32Sint32Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapSint32Sint32Entry();
    return _defaultInstance;
  }
  static TestAllTypes_MapSint32Sint32Entry _defaultInstance;
  static void $checkItem(TestAllTypes_MapSint32Sint32Entry v) {
    if (v is !TestAllTypes_MapSint32Sint32Entry) checkItemFailed(v, 'TestAllTypes_MapSint32Sint32Entry');
  }

  int get key => $_get(0, 1, 0);
  void set key(int v) { $_setSignedInt32(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  int get value => $_get(1, 2, 0);
  void set value(int v) { $_setSignedInt32(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapSint32Sint32Entry extends TestAllTypes_MapSint32Sint32Entry with ReadonlyMessageMixin {}

class TestAllTypes_MapSint64Sint64Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapSint64Sint64Entry')
    ..a/*<Int64>*/(1, 'key', PbFieldType.OS6, Int64.ZERO)
    ..a/*<Int64>*/(2, 'value', PbFieldType.OS6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapSint64Sint64Entry() : super();
  TestAllTypes_MapSint64Sint64Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapSint64Sint64Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapSint64Sint64Entry clone() => new TestAllTypes_MapSint64Sint64Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapSint64Sint64Entry create() => new TestAllTypes_MapSint64Sint64Entry();
  static PbList<TestAllTypes_MapSint64Sint64Entry> createRepeated() => new PbList<TestAllTypes_MapSint64Sint64Entry>();
  static TestAllTypes_MapSint64Sint64Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapSint64Sint64Entry();
    return _defaultInstance;
  }
  static TestAllTypes_MapSint64Sint64Entry _defaultInstance;
  static void $checkItem(TestAllTypes_MapSint64Sint64Entry v) {
    if (v is !TestAllTypes_MapSint64Sint64Entry) checkItemFailed(v, 'TestAllTypes_MapSint64Sint64Entry');
  }

  Int64 get key => $_get(0, 1, null);
  void set key(Int64 v) { $_setInt64(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Int64 get value => $_get(1, 2, null);
  void set value(Int64 v) { $_setInt64(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapSint64Sint64Entry extends TestAllTypes_MapSint64Sint64Entry with ReadonlyMessageMixin {}

class TestAllTypes_MapFixed32Fixed32Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapFixed32Fixed32Entry')
    ..a/*<int>*/(1, 'key', PbFieldType.OF3)
    ..a/*<int>*/(2, 'value', PbFieldType.OF3)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapFixed32Fixed32Entry() : super();
  TestAllTypes_MapFixed32Fixed32Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapFixed32Fixed32Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapFixed32Fixed32Entry clone() => new TestAllTypes_MapFixed32Fixed32Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapFixed32Fixed32Entry create() => new TestAllTypes_MapFixed32Fixed32Entry();
  static PbList<TestAllTypes_MapFixed32Fixed32Entry> createRepeated() => new PbList<TestAllTypes_MapFixed32Fixed32Entry>();
  static TestAllTypes_MapFixed32Fixed32Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapFixed32Fixed32Entry();
    return _defaultInstance;
  }
  static TestAllTypes_MapFixed32Fixed32Entry _defaultInstance;
  static void $checkItem(TestAllTypes_MapFixed32Fixed32Entry v) {
    if (v is !TestAllTypes_MapFixed32Fixed32Entry) checkItemFailed(v, 'TestAllTypes_MapFixed32Fixed32Entry');
  }

  int get key => $_get(0, 1, 0);
  void set key(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  int get value => $_get(1, 2, 0);
  void set value(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapFixed32Fixed32Entry extends TestAllTypes_MapFixed32Fixed32Entry with ReadonlyMessageMixin {}

class TestAllTypes_MapFixed64Fixed64Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapFixed64Fixed64Entry')
    ..a/*<Int64>*/(1, 'key', PbFieldType.OF6, Int64.ZERO)
    ..a/*<Int64>*/(2, 'value', PbFieldType.OF6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapFixed64Fixed64Entry() : super();
  TestAllTypes_MapFixed64Fixed64Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapFixed64Fixed64Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapFixed64Fixed64Entry clone() => new TestAllTypes_MapFixed64Fixed64Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapFixed64Fixed64Entry create() => new TestAllTypes_MapFixed64Fixed64Entry();
  static PbList<TestAllTypes_MapFixed64Fixed64Entry> createRepeated() => new PbList<TestAllTypes_MapFixed64Fixed64Entry>();
  static TestAllTypes_MapFixed64Fixed64Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapFixed64Fixed64Entry();
    return _defaultInstance;
  }
  static TestAllTypes_MapFixed64Fixed64Entry _defaultInstance;
  static void $checkItem(TestAllTypes_MapFixed64Fixed64Entry v) {
    if (v is !TestAllTypes_MapFixed64Fixed64Entry) checkItemFailed(v, 'TestAllTypes_MapFixed64Fixed64Entry');
  }

  Int64 get key => $_get(0, 1, null);
  void set key(Int64 v) { $_setInt64(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Int64 get value => $_get(1, 2, null);
  void set value(Int64 v) { $_setInt64(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapFixed64Fixed64Entry extends TestAllTypes_MapFixed64Fixed64Entry with ReadonlyMessageMixin {}

class TestAllTypes_MapSfixed32Sfixed32Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapSfixed32Sfixed32Entry')
    ..a/*<int>*/(1, 'key', PbFieldType.OSF3)
    ..a/*<int>*/(2, 'value', PbFieldType.OSF3)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapSfixed32Sfixed32Entry() : super();
  TestAllTypes_MapSfixed32Sfixed32Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapSfixed32Sfixed32Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapSfixed32Sfixed32Entry clone() => new TestAllTypes_MapSfixed32Sfixed32Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapSfixed32Sfixed32Entry create() => new TestAllTypes_MapSfixed32Sfixed32Entry();
  static PbList<TestAllTypes_MapSfixed32Sfixed32Entry> createRepeated() => new PbList<TestAllTypes_MapSfixed32Sfixed32Entry>();
  static TestAllTypes_MapSfixed32Sfixed32Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapSfixed32Sfixed32Entry();
    return _defaultInstance;
  }
  static TestAllTypes_MapSfixed32Sfixed32Entry _defaultInstance;
  static void $checkItem(TestAllTypes_MapSfixed32Sfixed32Entry v) {
    if (v is !TestAllTypes_MapSfixed32Sfixed32Entry) checkItemFailed(v, 'TestAllTypes_MapSfixed32Sfixed32Entry');
  }

  int get key => $_get(0, 1, 0);
  void set key(int v) { $_setSignedInt32(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  int get value => $_get(1, 2, 0);
  void set value(int v) { $_setSignedInt32(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapSfixed32Sfixed32Entry extends TestAllTypes_MapSfixed32Sfixed32Entry with ReadonlyMessageMixin {}

class TestAllTypes_MapSfixed64Sfixed64Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapSfixed64Sfixed64Entry')
    ..a/*<Int64>*/(1, 'key', PbFieldType.OSF6, Int64.ZERO)
    ..a/*<Int64>*/(2, 'value', PbFieldType.OSF6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapSfixed64Sfixed64Entry() : super();
  TestAllTypes_MapSfixed64Sfixed64Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapSfixed64Sfixed64Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapSfixed64Sfixed64Entry clone() => new TestAllTypes_MapSfixed64Sfixed64Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapSfixed64Sfixed64Entry create() => new TestAllTypes_MapSfixed64Sfixed64Entry();
  static PbList<TestAllTypes_MapSfixed64Sfixed64Entry> createRepeated() => new PbList<TestAllTypes_MapSfixed64Sfixed64Entry>();
  static TestAllTypes_MapSfixed64Sfixed64Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapSfixed64Sfixed64Entry();
    return _defaultInstance;
  }
  static TestAllTypes_MapSfixed64Sfixed64Entry _defaultInstance;
  static void $checkItem(TestAllTypes_MapSfixed64Sfixed64Entry v) {
    if (v is !TestAllTypes_MapSfixed64Sfixed64Entry) checkItemFailed(v, 'TestAllTypes_MapSfixed64Sfixed64Entry');
  }

  Int64 get key => $_get(0, 1, null);
  void set key(Int64 v) { $_setInt64(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Int64 get value => $_get(1, 2, null);
  void set value(Int64 v) { $_setInt64(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapSfixed64Sfixed64Entry extends TestAllTypes_MapSfixed64Sfixed64Entry with ReadonlyMessageMixin {}

class TestAllTypes_MapInt32FloatEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapInt32FloatEntry')
    ..a/*<int>*/(1, 'key', PbFieldType.O3)
    ..a/*<double>*/(2, 'value', PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapInt32FloatEntry() : super();
  TestAllTypes_MapInt32FloatEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapInt32FloatEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapInt32FloatEntry clone() => new TestAllTypes_MapInt32FloatEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapInt32FloatEntry create() => new TestAllTypes_MapInt32FloatEntry();
  static PbList<TestAllTypes_MapInt32FloatEntry> createRepeated() => new PbList<TestAllTypes_MapInt32FloatEntry>();
  static TestAllTypes_MapInt32FloatEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapInt32FloatEntry();
    return _defaultInstance;
  }
  static TestAllTypes_MapInt32FloatEntry _defaultInstance;
  static void $checkItem(TestAllTypes_MapInt32FloatEntry v) {
    if (v is !TestAllTypes_MapInt32FloatEntry) checkItemFailed(v, 'TestAllTypes_MapInt32FloatEntry');
  }

  int get key => $_get(0, 1, 0);
  void set key(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  double get value => $_get(1, 2, null);
  void set value(double v) { $_setFloat(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapInt32FloatEntry extends TestAllTypes_MapInt32FloatEntry with ReadonlyMessageMixin {}

class TestAllTypes_MapInt32DoubleEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapInt32DoubleEntry')
    ..a/*<int>*/(1, 'key', PbFieldType.O3)
    ..a/*<double>*/(2, 'value', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapInt32DoubleEntry() : super();
  TestAllTypes_MapInt32DoubleEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapInt32DoubleEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapInt32DoubleEntry clone() => new TestAllTypes_MapInt32DoubleEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapInt32DoubleEntry create() => new TestAllTypes_MapInt32DoubleEntry();
  static PbList<TestAllTypes_MapInt32DoubleEntry> createRepeated() => new PbList<TestAllTypes_MapInt32DoubleEntry>();
  static TestAllTypes_MapInt32DoubleEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapInt32DoubleEntry();
    return _defaultInstance;
  }
  static TestAllTypes_MapInt32DoubleEntry _defaultInstance;
  static void $checkItem(TestAllTypes_MapInt32DoubleEntry v) {
    if (v is !TestAllTypes_MapInt32DoubleEntry) checkItemFailed(v, 'TestAllTypes_MapInt32DoubleEntry');
  }

  int get key => $_get(0, 1, 0);
  void set key(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  double get value => $_get(1, 2, null);
  void set value(double v) { $_setDouble(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapInt32DoubleEntry extends TestAllTypes_MapInt32DoubleEntry with ReadonlyMessageMixin {}

class TestAllTypes_MapBoolBoolEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapBoolBoolEntry')
    ..a/*<bool>*/(1, 'key', PbFieldType.OB)
    ..a/*<bool>*/(2, 'value', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapBoolBoolEntry() : super();
  TestAllTypes_MapBoolBoolEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapBoolBoolEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapBoolBoolEntry clone() => new TestAllTypes_MapBoolBoolEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapBoolBoolEntry create() => new TestAllTypes_MapBoolBoolEntry();
  static PbList<TestAllTypes_MapBoolBoolEntry> createRepeated() => new PbList<TestAllTypes_MapBoolBoolEntry>();
  static TestAllTypes_MapBoolBoolEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapBoolBoolEntry();
    return _defaultInstance;
  }
  static TestAllTypes_MapBoolBoolEntry _defaultInstance;
  static void $checkItem(TestAllTypes_MapBoolBoolEntry v) {
    if (v is !TestAllTypes_MapBoolBoolEntry) checkItemFailed(v, 'TestAllTypes_MapBoolBoolEntry');
  }

  bool get key => $_get(0, 1, false);
  void set key(bool v) { $_setBool(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  bool get value => $_get(1, 2, false);
  void set value(bool v) { $_setBool(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapBoolBoolEntry extends TestAllTypes_MapBoolBoolEntry with ReadonlyMessageMixin {}

class TestAllTypes_MapStringStringEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapStringStringEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapStringStringEntry() : super();
  TestAllTypes_MapStringStringEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapStringStringEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapStringStringEntry clone() => new TestAllTypes_MapStringStringEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapStringStringEntry create() => new TestAllTypes_MapStringStringEntry();
  static PbList<TestAllTypes_MapStringStringEntry> createRepeated() => new PbList<TestAllTypes_MapStringStringEntry>();
  static TestAllTypes_MapStringStringEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapStringStringEntry();
    return _defaultInstance;
  }
  static TestAllTypes_MapStringStringEntry _defaultInstance;
  static void $checkItem(TestAllTypes_MapStringStringEntry v) {
    if (v is !TestAllTypes_MapStringStringEntry) checkItemFailed(v, 'TestAllTypes_MapStringStringEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapStringStringEntry extends TestAllTypes_MapStringStringEntry with ReadonlyMessageMixin {}

class TestAllTypes_MapStringBytesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapStringBytesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'value', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapStringBytesEntry() : super();
  TestAllTypes_MapStringBytesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapStringBytesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapStringBytesEntry clone() => new TestAllTypes_MapStringBytesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapStringBytesEntry create() => new TestAllTypes_MapStringBytesEntry();
  static PbList<TestAllTypes_MapStringBytesEntry> createRepeated() => new PbList<TestAllTypes_MapStringBytesEntry>();
  static TestAllTypes_MapStringBytesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapStringBytesEntry();
    return _defaultInstance;
  }
  static TestAllTypes_MapStringBytesEntry _defaultInstance;
  static void $checkItem(TestAllTypes_MapStringBytesEntry v) {
    if (v is !TestAllTypes_MapStringBytesEntry) checkItemFailed(v, 'TestAllTypes_MapStringBytesEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  List<int> get value => $_get(1, 2, null);
  void set value(List<int> v) { $_setBytes(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapStringBytesEntry extends TestAllTypes_MapStringBytesEntry with ReadonlyMessageMixin {}

class TestAllTypes_MapStringNestedMessageEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapStringNestedMessageEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<TestAllTypes_NestedMessage>*/(2, 'value', PbFieldType.OM, TestAllTypes_NestedMessage.getDefault, TestAllTypes_NestedMessage.create)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapStringNestedMessageEntry() : super();
  TestAllTypes_MapStringNestedMessageEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapStringNestedMessageEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapStringNestedMessageEntry clone() => new TestAllTypes_MapStringNestedMessageEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapStringNestedMessageEntry create() => new TestAllTypes_MapStringNestedMessageEntry();
  static PbList<TestAllTypes_MapStringNestedMessageEntry> createRepeated() => new PbList<TestAllTypes_MapStringNestedMessageEntry>();
  static TestAllTypes_MapStringNestedMessageEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapStringNestedMessageEntry();
    return _defaultInstance;
  }
  static TestAllTypes_MapStringNestedMessageEntry _defaultInstance;
  static void $checkItem(TestAllTypes_MapStringNestedMessageEntry v) {
    if (v is !TestAllTypes_MapStringNestedMessageEntry) checkItemFailed(v, 'TestAllTypes_MapStringNestedMessageEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  TestAllTypes_NestedMessage get value => $_get(1, 2, null);
  void set value(TestAllTypes_NestedMessage v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapStringNestedMessageEntry extends TestAllTypes_MapStringNestedMessageEntry with ReadonlyMessageMixin {}

class TestAllTypes_MapStringForeignMessageEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapStringForeignMessageEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<ForeignMessage>*/(2, 'value', PbFieldType.OM, ForeignMessage.getDefault, ForeignMessage.create)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapStringForeignMessageEntry() : super();
  TestAllTypes_MapStringForeignMessageEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapStringForeignMessageEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapStringForeignMessageEntry clone() => new TestAllTypes_MapStringForeignMessageEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapStringForeignMessageEntry create() => new TestAllTypes_MapStringForeignMessageEntry();
  static PbList<TestAllTypes_MapStringForeignMessageEntry> createRepeated() => new PbList<TestAllTypes_MapStringForeignMessageEntry>();
  static TestAllTypes_MapStringForeignMessageEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapStringForeignMessageEntry();
    return _defaultInstance;
  }
  static TestAllTypes_MapStringForeignMessageEntry _defaultInstance;
  static void $checkItem(TestAllTypes_MapStringForeignMessageEntry v) {
    if (v is !TestAllTypes_MapStringForeignMessageEntry) checkItemFailed(v, 'TestAllTypes_MapStringForeignMessageEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  ForeignMessage get value => $_get(1, 2, null);
  void set value(ForeignMessage v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapStringForeignMessageEntry extends TestAllTypes_MapStringForeignMessageEntry with ReadonlyMessageMixin {}

class TestAllTypes_MapStringNestedEnumEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapStringNestedEnumEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..e/*<TestAllTypes_NestedEnum>*/(2, 'value', PbFieldType.OE, TestAllTypes_NestedEnum.FOO, TestAllTypes_NestedEnum.valueOf)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapStringNestedEnumEntry() : super();
  TestAllTypes_MapStringNestedEnumEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapStringNestedEnumEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapStringNestedEnumEntry clone() => new TestAllTypes_MapStringNestedEnumEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapStringNestedEnumEntry create() => new TestAllTypes_MapStringNestedEnumEntry();
  static PbList<TestAllTypes_MapStringNestedEnumEntry> createRepeated() => new PbList<TestAllTypes_MapStringNestedEnumEntry>();
  static TestAllTypes_MapStringNestedEnumEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapStringNestedEnumEntry();
    return _defaultInstance;
  }
  static TestAllTypes_MapStringNestedEnumEntry _defaultInstance;
  static void $checkItem(TestAllTypes_MapStringNestedEnumEntry v) {
    if (v is !TestAllTypes_MapStringNestedEnumEntry) checkItemFailed(v, 'TestAllTypes_MapStringNestedEnumEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  TestAllTypes_NestedEnum get value => $_get(1, 2, null);
  void set value(TestAllTypes_NestedEnum v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapStringNestedEnumEntry extends TestAllTypes_MapStringNestedEnumEntry with ReadonlyMessageMixin {}

class TestAllTypes_MapStringForeignEnumEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes_MapStringForeignEnumEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..e/*<ForeignEnum>*/(2, 'value', PbFieldType.OE, ForeignEnum.FOREIGN_FOO, ForeignEnum.valueOf)
    ..hasRequiredFields = false
  ;

  TestAllTypes_MapStringForeignEnumEntry() : super();
  TestAllTypes_MapStringForeignEnumEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes_MapStringForeignEnumEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes_MapStringForeignEnumEntry clone() => new TestAllTypes_MapStringForeignEnumEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes_MapStringForeignEnumEntry create() => new TestAllTypes_MapStringForeignEnumEntry();
  static PbList<TestAllTypes_MapStringForeignEnumEntry> createRepeated() => new PbList<TestAllTypes_MapStringForeignEnumEntry>();
  static TestAllTypes_MapStringForeignEnumEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes_MapStringForeignEnumEntry();
    return _defaultInstance;
  }
  static TestAllTypes_MapStringForeignEnumEntry _defaultInstance;
  static void $checkItem(TestAllTypes_MapStringForeignEnumEntry v) {
    if (v is !TestAllTypes_MapStringForeignEnumEntry) checkItemFailed(v, 'TestAllTypes_MapStringForeignEnumEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  ForeignEnum get value => $_get(1, 2, null);
  void set value(ForeignEnum v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTestAllTypes_MapStringForeignEnumEntry extends TestAllTypes_MapStringForeignEnumEntry with ReadonlyMessageMixin {}

class TestAllTypes extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestAllTypes')
    ..a/*<int>*/(1, 'optionalInt32', PbFieldType.O3)
    ..a/*<Int64>*/(2, 'optionalInt64', PbFieldType.O6, Int64.ZERO)
    ..a/*<int>*/(3, 'optionalUint32', PbFieldType.OU3)
    ..a/*<Int64>*/(4, 'optionalUint64', PbFieldType.OU6, Int64.ZERO)
    ..a/*<int>*/(5, 'optionalSint32', PbFieldType.OS3)
    ..a/*<Int64>*/(6, 'optionalSint64', PbFieldType.OS6, Int64.ZERO)
    ..a/*<int>*/(7, 'optionalFixed32', PbFieldType.OF3)
    ..a/*<Int64>*/(8, 'optionalFixed64', PbFieldType.OF6, Int64.ZERO)
    ..a/*<int>*/(9, 'optionalSfixed32', PbFieldType.OSF3)
    ..a/*<Int64>*/(10, 'optionalSfixed64', PbFieldType.OSF6, Int64.ZERO)
    ..a/*<double>*/(11, 'optionalFloat', PbFieldType.OF)
    ..a/*<double>*/(12, 'optionalDouble', PbFieldType.OD)
    ..a/*<bool>*/(13, 'optionalBool', PbFieldType.OB)
    ..a/*<String>*/(14, 'optionalString', PbFieldType.OS)
    ..a/*<List<int>>*/(15, 'optionalBytes', PbFieldType.OY)
    ..a/*<TestAllTypes_NestedMessage>*/(18, 'optionalNestedMessage', PbFieldType.OM, TestAllTypes_NestedMessage.getDefault, TestAllTypes_NestedMessage.create)
    ..a/*<ForeignMessage>*/(19, 'optionalForeignMessage', PbFieldType.OM, ForeignMessage.getDefault, ForeignMessage.create)
    ..e/*<TestAllTypes_NestedEnum>*/(21, 'optionalNestedEnum', PbFieldType.OE, TestAllTypes_NestedEnum.FOO, TestAllTypes_NestedEnum.valueOf)
    ..e/*<ForeignEnum>*/(22, 'optionalForeignEnum', PbFieldType.OE, ForeignEnum.FOREIGN_FOO, ForeignEnum.valueOf)
    ..a/*<String>*/(24, 'optionalStringPiece', PbFieldType.OS)
    ..a/*<String>*/(25, 'optionalCord', PbFieldType.OS)
    ..a/*<TestAllTypes>*/(27, 'recursiveMessage', PbFieldType.OM, TestAllTypes.getDefault, TestAllTypes.create)
    ..p/*<int>*/(31, 'repeatedInt32', PbFieldType.P3)
    ..p/*<Int64>*/(32, 'repeatedInt64', PbFieldType.P6)
    ..p/*<int>*/(33, 'repeatedUint32', PbFieldType.PU3)
    ..p/*<Int64>*/(34, 'repeatedUint64', PbFieldType.PU6)
    ..p/*<int>*/(35, 'repeatedSint32', PbFieldType.PS3)
    ..p/*<Int64>*/(36, 'repeatedSint64', PbFieldType.PS6)
    ..p/*<int>*/(37, 'repeatedFixed32', PbFieldType.PF3)
    ..p/*<Int64>*/(38, 'repeatedFixed64', PbFieldType.PF6)
    ..p/*<int>*/(39, 'repeatedSfixed32', PbFieldType.PSF3)
    ..p/*<Int64>*/(40, 'repeatedSfixed64', PbFieldType.PSF6)
    ..p/*<double>*/(41, 'repeatedFloat', PbFieldType.PF)
    ..p/*<double>*/(42, 'repeatedDouble', PbFieldType.PD)
    ..p/*<bool>*/(43, 'repeatedBool', PbFieldType.PB)
    ..p/*<String>*/(44, 'repeatedString', PbFieldType.PS)
    ..p/*<List<int>>*/(45, 'repeatedBytes', PbFieldType.PY)
    ..pp/*<TestAllTypes_NestedMessage>*/(48, 'repeatedNestedMessage', PbFieldType.PM, TestAllTypes_NestedMessage.$checkItem, TestAllTypes_NestedMessage.create)
    ..pp/*<ForeignMessage>*/(49, 'repeatedForeignMessage', PbFieldType.PM, ForeignMessage.$checkItem, ForeignMessage.create)
    ..pp/*<TestAllTypes_NestedEnum>*/(51, 'repeatedNestedEnum', PbFieldType.PE, TestAllTypes_NestedEnum.$checkItem, null, TestAllTypes_NestedEnum.valueOf)
    ..pp/*<ForeignEnum>*/(52, 'repeatedForeignEnum', PbFieldType.PE, ForeignEnum.$checkItem, null, ForeignEnum.valueOf)
    ..p/*<String>*/(54, 'repeatedStringPiece', PbFieldType.PS)
    ..p/*<String>*/(55, 'repeatedCord', PbFieldType.PS)
    ..pp/*<TestAllTypes_MapInt32Int32Entry>*/(56, 'mapInt32Int32', PbFieldType.PM, TestAllTypes_MapInt32Int32Entry.$checkItem, TestAllTypes_MapInt32Int32Entry.create)
    ..pp/*<TestAllTypes_MapInt64Int64Entry>*/(57, 'mapInt64Int64', PbFieldType.PM, TestAllTypes_MapInt64Int64Entry.$checkItem, TestAllTypes_MapInt64Int64Entry.create)
    ..pp/*<TestAllTypes_MapUint32Uint32Entry>*/(58, 'mapUint32Uint32', PbFieldType.PM, TestAllTypes_MapUint32Uint32Entry.$checkItem, TestAllTypes_MapUint32Uint32Entry.create)
    ..pp/*<TestAllTypes_MapUint64Uint64Entry>*/(59, 'mapUint64Uint64', PbFieldType.PM, TestAllTypes_MapUint64Uint64Entry.$checkItem, TestAllTypes_MapUint64Uint64Entry.create)
    ..pp/*<TestAllTypes_MapSint32Sint32Entry>*/(60, 'mapSint32Sint32', PbFieldType.PM, TestAllTypes_MapSint32Sint32Entry.$checkItem, TestAllTypes_MapSint32Sint32Entry.create)
    ..pp/*<TestAllTypes_MapSint64Sint64Entry>*/(61, 'mapSint64Sint64', PbFieldType.PM, TestAllTypes_MapSint64Sint64Entry.$checkItem, TestAllTypes_MapSint64Sint64Entry.create)
    ..pp/*<TestAllTypes_MapFixed32Fixed32Entry>*/(62, 'mapFixed32Fixed32', PbFieldType.PM, TestAllTypes_MapFixed32Fixed32Entry.$checkItem, TestAllTypes_MapFixed32Fixed32Entry.create)
    ..pp/*<TestAllTypes_MapFixed64Fixed64Entry>*/(63, 'mapFixed64Fixed64', PbFieldType.PM, TestAllTypes_MapFixed64Fixed64Entry.$checkItem, TestAllTypes_MapFixed64Fixed64Entry.create)
    ..pp/*<TestAllTypes_MapSfixed32Sfixed32Entry>*/(64, 'mapSfixed32Sfixed32', PbFieldType.PM, TestAllTypes_MapSfixed32Sfixed32Entry.$checkItem, TestAllTypes_MapSfixed32Sfixed32Entry.create)
    ..pp/*<TestAllTypes_MapSfixed64Sfixed64Entry>*/(65, 'mapSfixed64Sfixed64', PbFieldType.PM, TestAllTypes_MapSfixed64Sfixed64Entry.$checkItem, TestAllTypes_MapSfixed64Sfixed64Entry.create)
    ..pp/*<TestAllTypes_MapInt32FloatEntry>*/(66, 'mapInt32Float', PbFieldType.PM, TestAllTypes_MapInt32FloatEntry.$checkItem, TestAllTypes_MapInt32FloatEntry.create)
    ..pp/*<TestAllTypes_MapInt32DoubleEntry>*/(67, 'mapInt32Double', PbFieldType.PM, TestAllTypes_MapInt32DoubleEntry.$checkItem, TestAllTypes_MapInt32DoubleEntry.create)
    ..pp/*<TestAllTypes_MapBoolBoolEntry>*/(68, 'mapBoolBool', PbFieldType.PM, TestAllTypes_MapBoolBoolEntry.$checkItem, TestAllTypes_MapBoolBoolEntry.create)
    ..pp/*<TestAllTypes_MapStringStringEntry>*/(69, 'mapStringString', PbFieldType.PM, TestAllTypes_MapStringStringEntry.$checkItem, TestAllTypes_MapStringStringEntry.create)
    ..pp/*<TestAllTypes_MapStringBytesEntry>*/(70, 'mapStringBytes', PbFieldType.PM, TestAllTypes_MapStringBytesEntry.$checkItem, TestAllTypes_MapStringBytesEntry.create)
    ..pp/*<TestAllTypes_MapStringNestedMessageEntry>*/(71, 'mapStringNestedMessage', PbFieldType.PM, TestAllTypes_MapStringNestedMessageEntry.$checkItem, TestAllTypes_MapStringNestedMessageEntry.create)
    ..pp/*<TestAllTypes_MapStringForeignMessageEntry>*/(72, 'mapStringForeignMessage', PbFieldType.PM, TestAllTypes_MapStringForeignMessageEntry.$checkItem, TestAllTypes_MapStringForeignMessageEntry.create)
    ..pp/*<TestAllTypes_MapStringNestedEnumEntry>*/(73, 'mapStringNestedEnum', PbFieldType.PM, TestAllTypes_MapStringNestedEnumEntry.$checkItem, TestAllTypes_MapStringNestedEnumEntry.create)
    ..pp/*<TestAllTypes_MapStringForeignEnumEntry>*/(74, 'mapStringForeignEnum', PbFieldType.PM, TestAllTypes_MapStringForeignEnumEntry.$checkItem, TestAllTypes_MapStringForeignEnumEntry.create)
    ..a/*<int>*/(111, 'oneofUint32', PbFieldType.OU3)
    ..a/*<TestAllTypes_NestedMessage>*/(112, 'oneofNestedMessage', PbFieldType.OM, TestAllTypes_NestedMessage.getDefault, TestAllTypes_NestedMessage.create)
    ..a/*<String>*/(113, 'oneofString', PbFieldType.OS)
    ..a/*<List<int>>*/(114, 'oneofBytes', PbFieldType.OY)
    ..a/*<bool>*/(115, 'oneofBool', PbFieldType.OB)
    ..a/*<Int64>*/(116, 'oneofUint64', PbFieldType.OU6, Int64.ZERO)
    ..a/*<double>*/(117, 'oneofFloat', PbFieldType.OF)
    ..a/*<double>*/(118, 'oneofDouble', PbFieldType.OD)
    ..e/*<TestAllTypes_NestedEnum>*/(119, 'oneofEnum', PbFieldType.OE, TestAllTypes_NestedEnum.FOO, TestAllTypes_NestedEnum.valueOf)
    ..a/*<google$protobuf.BoolValue>*/(201, 'optionalBoolWrapper', PbFieldType.OM, google$protobuf.BoolValue.getDefault, google$protobuf.BoolValue.create)
    ..a/*<google$protobuf.Int32Value>*/(202, 'optionalInt32Wrapper', PbFieldType.OM, google$protobuf.Int32Value.getDefault, google$protobuf.Int32Value.create)
    ..a/*<google$protobuf.Int64Value>*/(203, 'optionalInt64Wrapper', PbFieldType.OM, google$protobuf.Int64Value.getDefault, google$protobuf.Int64Value.create)
    ..a/*<google$protobuf.UInt32Value>*/(204, 'optionalUint32Wrapper', PbFieldType.OM, google$protobuf.UInt32Value.getDefault, google$protobuf.UInt32Value.create)
    ..a/*<google$protobuf.UInt64Value>*/(205, 'optionalUint64Wrapper', PbFieldType.OM, google$protobuf.UInt64Value.getDefault, google$protobuf.UInt64Value.create)
    ..a/*<google$protobuf.FloatValue>*/(206, 'optionalFloatWrapper', PbFieldType.OM, google$protobuf.FloatValue.getDefault, google$protobuf.FloatValue.create)
    ..a/*<google$protobuf.DoubleValue>*/(207, 'optionalDoubleWrapper', PbFieldType.OM, google$protobuf.DoubleValue.getDefault, google$protobuf.DoubleValue.create)
    ..a/*<google$protobuf.StringValue>*/(208, 'optionalStringWrapper', PbFieldType.OM, google$protobuf.StringValue.getDefault, google$protobuf.StringValue.create)
    ..a/*<google$protobuf.BytesValue>*/(209, 'optionalBytesWrapper', PbFieldType.OM, google$protobuf.BytesValue.getDefault, google$protobuf.BytesValue.create)
    ..pp/*<google$protobuf.BoolValue>*/(211, 'repeatedBoolWrapper', PbFieldType.PM, google$protobuf.BoolValue.$checkItem, google$protobuf.BoolValue.create)
    ..pp/*<google$protobuf.Int32Value>*/(212, 'repeatedInt32Wrapper', PbFieldType.PM, google$protobuf.Int32Value.$checkItem, google$protobuf.Int32Value.create)
    ..pp/*<google$protobuf.Int64Value>*/(213, 'repeatedInt64Wrapper', PbFieldType.PM, google$protobuf.Int64Value.$checkItem, google$protobuf.Int64Value.create)
    ..pp/*<google$protobuf.UInt32Value>*/(214, 'repeatedUint32Wrapper', PbFieldType.PM, google$protobuf.UInt32Value.$checkItem, google$protobuf.UInt32Value.create)
    ..pp/*<google$protobuf.UInt64Value>*/(215, 'repeatedUint64Wrapper', PbFieldType.PM, google$protobuf.UInt64Value.$checkItem, google$protobuf.UInt64Value.create)
    ..pp/*<google$protobuf.FloatValue>*/(216, 'repeatedFloatWrapper', PbFieldType.PM, google$protobuf.FloatValue.$checkItem, google$protobuf.FloatValue.create)
    ..pp/*<google$protobuf.DoubleValue>*/(217, 'repeatedDoubleWrapper', PbFieldType.PM, google$protobuf.DoubleValue.$checkItem, google$protobuf.DoubleValue.create)
    ..pp/*<google$protobuf.StringValue>*/(218, 'repeatedStringWrapper', PbFieldType.PM, google$protobuf.StringValue.$checkItem, google$protobuf.StringValue.create)
    ..pp/*<google$protobuf.BytesValue>*/(219, 'repeatedBytesWrapper', PbFieldType.PM, google$protobuf.BytesValue.$checkItem, google$protobuf.BytesValue.create)
    ..a/*<google$protobuf.Duration>*/(301, 'optionalDuration', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<google$protobuf.Timestamp>*/(302, 'optionalTimestamp', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.FieldMask>*/(303, 'optionalFieldMask', PbFieldType.OM, google$protobuf.FieldMask.getDefault, google$protobuf.FieldMask.create)
    ..a/*<google$protobuf.Struct>*/(304, 'optionalStruct', PbFieldType.OM, google$protobuf.Struct.getDefault, google$protobuf.Struct.create)
    ..a/*<google$protobuf.Any>*/(305, 'optionalAny', PbFieldType.OM, google$protobuf.Any.getDefault, google$protobuf.Any.create)
    ..a/*<google$protobuf.Value>*/(306, 'optionalValue', PbFieldType.OM, google$protobuf.Value.getDefault, google$protobuf.Value.create)
    ..pp/*<google$protobuf.Duration>*/(311, 'repeatedDuration', PbFieldType.PM, google$protobuf.Duration.$checkItem, google$protobuf.Duration.create)
    ..pp/*<google$protobuf.Timestamp>*/(312, 'repeatedTimestamp', PbFieldType.PM, google$protobuf.Timestamp.$checkItem, google$protobuf.Timestamp.create)
    ..pp/*<google$protobuf.FieldMask>*/(313, 'repeatedFieldmask', PbFieldType.PM, google$protobuf.FieldMask.$checkItem, google$protobuf.FieldMask.create)
    ..pp/*<google$protobuf.Any>*/(315, 'repeatedAny', PbFieldType.PM, google$protobuf.Any.$checkItem, google$protobuf.Any.create)
    ..pp/*<google$protobuf.Value>*/(316, 'repeatedValue', PbFieldType.PM, google$protobuf.Value.$checkItem, google$protobuf.Value.create)
    ..pp/*<google$protobuf.Struct>*/(324, 'repeatedStruct', PbFieldType.PM, google$protobuf.Struct.$checkItem, google$protobuf.Struct.create)
    ..a/*<int>*/(401, 'fieldname1', PbFieldType.O3)
    ..a/*<int>*/(402, 'fieldName2', PbFieldType.O3)
    ..a/*<int>*/(403, 'fieldName3', PbFieldType.O3)
    ..a/*<int>*/(404, 'fieldName4', PbFieldType.O3)
    ..a/*<int>*/(405, 'field0name5', PbFieldType.O3)
    ..a/*<int>*/(406, 'field0Name6', PbFieldType.O3)
    ..a/*<int>*/(407, 'fieldName7', PbFieldType.O3)
    ..a/*<int>*/(408, 'fieldName8', PbFieldType.O3)
    ..a/*<int>*/(409, 'fieldName9', PbFieldType.O3)
    ..a/*<int>*/(410, 'fieldName10', PbFieldType.O3)
    ..a/*<int>*/(411, 'fIELDNAME11', PbFieldType.O3)
    ..a/*<int>*/(412, 'fIELDName12', PbFieldType.O3)
    ..a/*<int>*/(413, 'fieldName13', PbFieldType.O3)
    ..a/*<int>*/(414, 'fieldName14', PbFieldType.O3)
    ..a/*<int>*/(415, 'fieldName15', PbFieldType.O3)
    ..a/*<int>*/(416, 'fieldName16', PbFieldType.O3)
    ..a/*<int>*/(417, 'fieldName17', PbFieldType.O3)
    ..a/*<int>*/(418, 'fieldName18', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  TestAllTypes() : super();
  TestAllTypes.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestAllTypes.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestAllTypes clone() => new TestAllTypes()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestAllTypes create() => new TestAllTypes();
  static PbList<TestAllTypes> createRepeated() => new PbList<TestAllTypes>();
  static TestAllTypes getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestAllTypes();
    return _defaultInstance;
  }
  static TestAllTypes _defaultInstance;
  static void $checkItem(TestAllTypes v) {
    if (v is !TestAllTypes) checkItemFailed(v, 'TestAllTypes');
  }

  int get optionalInt32 => $_get(0, 1, 0);
  void set optionalInt32(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasOptionalInt32() => $_has(0, 1);
  void clearOptionalInt32() => clearField(1);

  Int64 get optionalInt64 => $_get(1, 2, null);
  void set optionalInt64(Int64 v) { $_setInt64(1, 2, v); }
  bool hasOptionalInt64() => $_has(1, 2);
  void clearOptionalInt64() => clearField(2);

  int get optionalUint32 => $_get(2, 3, 0);
  void set optionalUint32(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasOptionalUint32() => $_has(2, 3);
  void clearOptionalUint32() => clearField(3);

  Int64 get optionalUint64 => $_get(3, 4, null);
  void set optionalUint64(Int64 v) { $_setInt64(3, 4, v); }
  bool hasOptionalUint64() => $_has(3, 4);
  void clearOptionalUint64() => clearField(4);

  int get optionalSint32 => $_get(4, 5, 0);
  void set optionalSint32(int v) { $_setSignedInt32(4, 5, v); }
  bool hasOptionalSint32() => $_has(4, 5);
  void clearOptionalSint32() => clearField(5);

  Int64 get optionalSint64 => $_get(5, 6, null);
  void set optionalSint64(Int64 v) { $_setInt64(5, 6, v); }
  bool hasOptionalSint64() => $_has(5, 6);
  void clearOptionalSint64() => clearField(6);

  int get optionalFixed32 => $_get(6, 7, 0);
  void set optionalFixed32(int v) { $_setUnsignedInt32(6, 7, v); }
  bool hasOptionalFixed32() => $_has(6, 7);
  void clearOptionalFixed32() => clearField(7);

  Int64 get optionalFixed64 => $_get(7, 8, null);
  void set optionalFixed64(Int64 v) { $_setInt64(7, 8, v); }
  bool hasOptionalFixed64() => $_has(7, 8);
  void clearOptionalFixed64() => clearField(8);

  int get optionalSfixed32 => $_get(8, 9, 0);
  void set optionalSfixed32(int v) { $_setSignedInt32(8, 9, v); }
  bool hasOptionalSfixed32() => $_has(8, 9);
  void clearOptionalSfixed32() => clearField(9);

  Int64 get optionalSfixed64 => $_get(9, 10, null);
  void set optionalSfixed64(Int64 v) { $_setInt64(9, 10, v); }
  bool hasOptionalSfixed64() => $_has(9, 10);
  void clearOptionalSfixed64() => clearField(10);

  double get optionalFloat => $_get(10, 11, null);
  void set optionalFloat(double v) { $_setFloat(10, 11, v); }
  bool hasOptionalFloat() => $_has(10, 11);
  void clearOptionalFloat() => clearField(11);

  double get optionalDouble => $_get(11, 12, null);
  void set optionalDouble(double v) { $_setDouble(11, 12, v); }
  bool hasOptionalDouble() => $_has(11, 12);
  void clearOptionalDouble() => clearField(12);

  bool get optionalBool => $_get(12, 13, false);
  void set optionalBool(bool v) { $_setBool(12, 13, v); }
  bool hasOptionalBool() => $_has(12, 13);
  void clearOptionalBool() => clearField(13);

  String get optionalString => $_get(13, 14, '');
  void set optionalString(String v) { $_setString(13, 14, v); }
  bool hasOptionalString() => $_has(13, 14);
  void clearOptionalString() => clearField(14);

  List<int> get optionalBytes => $_get(14, 15, null);
  void set optionalBytes(List<int> v) { $_setBytes(14, 15, v); }
  bool hasOptionalBytes() => $_has(14, 15);
  void clearOptionalBytes() => clearField(15);

  TestAllTypes_NestedMessage get optionalNestedMessage => $_get(15, 18, null);
  void set optionalNestedMessage(TestAllTypes_NestedMessage v) { setField(18, v); }
  bool hasOptionalNestedMessage() => $_has(15, 18);
  void clearOptionalNestedMessage() => clearField(18);

  ForeignMessage get optionalForeignMessage => $_get(16, 19, null);
  void set optionalForeignMessage(ForeignMessage v) { setField(19, v); }
  bool hasOptionalForeignMessage() => $_has(16, 19);
  void clearOptionalForeignMessage() => clearField(19);

  TestAllTypes_NestedEnum get optionalNestedEnum => $_get(17, 21, null);
  void set optionalNestedEnum(TestAllTypes_NestedEnum v) { setField(21, v); }
  bool hasOptionalNestedEnum() => $_has(17, 21);
  void clearOptionalNestedEnum() => clearField(21);

  ForeignEnum get optionalForeignEnum => $_get(18, 22, null);
  void set optionalForeignEnum(ForeignEnum v) { setField(22, v); }
  bool hasOptionalForeignEnum() => $_has(18, 22);
  void clearOptionalForeignEnum() => clearField(22);

  String get optionalStringPiece => $_get(19, 24, '');
  void set optionalStringPiece(String v) { $_setString(19, 24, v); }
  bool hasOptionalStringPiece() => $_has(19, 24);
  void clearOptionalStringPiece() => clearField(24);

  String get optionalCord => $_get(20, 25, '');
  void set optionalCord(String v) { $_setString(20, 25, v); }
  bool hasOptionalCord() => $_has(20, 25);
  void clearOptionalCord() => clearField(25);

  TestAllTypes get recursiveMessage => $_get(21, 27, null);
  void set recursiveMessage(TestAllTypes v) { setField(27, v); }
  bool hasRecursiveMessage() => $_has(21, 27);
  void clearRecursiveMessage() => clearField(27);

  List<int> get repeatedInt32 => $_get(22, 31, null);

  List<Int64> get repeatedInt64 => $_get(23, 32, null);

  List<int> get repeatedUint32 => $_get(24, 33, null);

  List<Int64> get repeatedUint64 => $_get(25, 34, null);

  List<int> get repeatedSint32 => $_get(26, 35, null);

  List<Int64> get repeatedSint64 => $_get(27, 36, null);

  List<int> get repeatedFixed32 => $_get(28, 37, null);

  List<Int64> get repeatedFixed64 => $_get(29, 38, null);

  List<int> get repeatedSfixed32 => $_get(30, 39, null);

  List<Int64> get repeatedSfixed64 => $_get(31, 40, null);

  List<double> get repeatedFloat => $_get(32, 41, null);

  List<double> get repeatedDouble => $_get(33, 42, null);

  List<bool> get repeatedBool => $_get(34, 43, null);

  List<String> get repeatedString => $_get(35, 44, null);

  List<List<int>> get repeatedBytes => $_get(36, 45, null);

  List<TestAllTypes_NestedMessage> get repeatedNestedMessage => $_get(37, 48, null);

  List<ForeignMessage> get repeatedForeignMessage => $_get(38, 49, null);

  List<TestAllTypes_NestedEnum> get repeatedNestedEnum => $_get(39, 51, null);

  List<ForeignEnum> get repeatedForeignEnum => $_get(40, 52, null);

  List<String> get repeatedStringPiece => $_get(41, 54, null);

  List<String> get repeatedCord => $_get(42, 55, null);

  List<TestAllTypes_MapInt32Int32Entry> get mapInt32Int32 => $_get(43, 56, null);

  List<TestAllTypes_MapInt64Int64Entry> get mapInt64Int64 => $_get(44, 57, null);

  List<TestAllTypes_MapUint32Uint32Entry> get mapUint32Uint32 => $_get(45, 58, null);

  List<TestAllTypes_MapUint64Uint64Entry> get mapUint64Uint64 => $_get(46, 59, null);

  List<TestAllTypes_MapSint32Sint32Entry> get mapSint32Sint32 => $_get(47, 60, null);

  List<TestAllTypes_MapSint64Sint64Entry> get mapSint64Sint64 => $_get(48, 61, null);

  List<TestAllTypes_MapFixed32Fixed32Entry> get mapFixed32Fixed32 => $_get(49, 62, null);

  List<TestAllTypes_MapFixed64Fixed64Entry> get mapFixed64Fixed64 => $_get(50, 63, null);

  List<TestAllTypes_MapSfixed32Sfixed32Entry> get mapSfixed32Sfixed32 => $_get(51, 64, null);

  List<TestAllTypes_MapSfixed64Sfixed64Entry> get mapSfixed64Sfixed64 => $_get(52, 65, null);

  List<TestAllTypes_MapInt32FloatEntry> get mapInt32Float => $_get(53, 66, null);

  List<TestAllTypes_MapInt32DoubleEntry> get mapInt32Double => $_get(54, 67, null);

  List<TestAllTypes_MapBoolBoolEntry> get mapBoolBool => $_get(55, 68, null);

  List<TestAllTypes_MapStringStringEntry> get mapStringString => $_get(56, 69, null);

  List<TestAllTypes_MapStringBytesEntry> get mapStringBytes => $_get(57, 70, null);

  List<TestAllTypes_MapStringNestedMessageEntry> get mapStringNestedMessage => $_get(58, 71, null);

  List<TestAllTypes_MapStringForeignMessageEntry> get mapStringForeignMessage => $_get(59, 72, null);

  List<TestAllTypes_MapStringNestedEnumEntry> get mapStringNestedEnum => $_get(60, 73, null);

  List<TestAllTypes_MapStringForeignEnumEntry> get mapStringForeignEnum => $_get(61, 74, null);

  int get oneofUint32 => $_get(62, 111, 0);
  void set oneofUint32(int v) { $_setUnsignedInt32(62, 111, v); }
  bool hasOneofUint32() => $_has(62, 111);
  void clearOneofUint32() => clearField(111);

  TestAllTypes_NestedMessage get oneofNestedMessage => $_get(63, 112, null);
  void set oneofNestedMessage(TestAllTypes_NestedMessage v) { setField(112, v); }
  bool hasOneofNestedMessage() => $_has(63, 112);
  void clearOneofNestedMessage() => clearField(112);

  String get oneofString => $_get(64, 113, '');
  void set oneofString(String v) { $_setString(64, 113, v); }
  bool hasOneofString() => $_has(64, 113);
  void clearOneofString() => clearField(113);

  List<int> get oneofBytes => $_get(65, 114, null);
  void set oneofBytes(List<int> v) { $_setBytes(65, 114, v); }
  bool hasOneofBytes() => $_has(65, 114);
  void clearOneofBytes() => clearField(114);

  bool get oneofBool => $_get(66, 115, false);
  void set oneofBool(bool v) { $_setBool(66, 115, v); }
  bool hasOneofBool() => $_has(66, 115);
  void clearOneofBool() => clearField(115);

  Int64 get oneofUint64 => $_get(67, 116, null);
  void set oneofUint64(Int64 v) { $_setInt64(67, 116, v); }
  bool hasOneofUint64() => $_has(67, 116);
  void clearOneofUint64() => clearField(116);

  double get oneofFloat => $_get(68, 117, null);
  void set oneofFloat(double v) { $_setFloat(68, 117, v); }
  bool hasOneofFloat() => $_has(68, 117);
  void clearOneofFloat() => clearField(117);

  double get oneofDouble => $_get(69, 118, null);
  void set oneofDouble(double v) { $_setDouble(69, 118, v); }
  bool hasOneofDouble() => $_has(69, 118);
  void clearOneofDouble() => clearField(118);

  TestAllTypes_NestedEnum get oneofEnum => $_get(70, 119, null);
  void set oneofEnum(TestAllTypes_NestedEnum v) { setField(119, v); }
  bool hasOneofEnum() => $_has(70, 119);
  void clearOneofEnum() => clearField(119);

  google$protobuf.BoolValue get optionalBoolWrapper => $_get(71, 201, null);
  void set optionalBoolWrapper(google$protobuf.BoolValue v) { setField(201, v); }
  bool hasOptionalBoolWrapper() => $_has(71, 201);
  void clearOptionalBoolWrapper() => clearField(201);

  google$protobuf.Int32Value get optionalInt32Wrapper => $_get(72, 202, null);
  void set optionalInt32Wrapper(google$protobuf.Int32Value v) { setField(202, v); }
  bool hasOptionalInt32Wrapper() => $_has(72, 202);
  void clearOptionalInt32Wrapper() => clearField(202);

  google$protobuf.Int64Value get optionalInt64Wrapper => $_get(73, 203, null);
  void set optionalInt64Wrapper(google$protobuf.Int64Value v) { setField(203, v); }
  bool hasOptionalInt64Wrapper() => $_has(73, 203);
  void clearOptionalInt64Wrapper() => clearField(203);

  google$protobuf.UInt32Value get optionalUint32Wrapper => $_get(74, 204, null);
  void set optionalUint32Wrapper(google$protobuf.UInt32Value v) { setField(204, v); }
  bool hasOptionalUint32Wrapper() => $_has(74, 204);
  void clearOptionalUint32Wrapper() => clearField(204);

  google$protobuf.UInt64Value get optionalUint64Wrapper => $_get(75, 205, null);
  void set optionalUint64Wrapper(google$protobuf.UInt64Value v) { setField(205, v); }
  bool hasOptionalUint64Wrapper() => $_has(75, 205);
  void clearOptionalUint64Wrapper() => clearField(205);

  google$protobuf.FloatValue get optionalFloatWrapper => $_get(76, 206, null);
  void set optionalFloatWrapper(google$protobuf.FloatValue v) { setField(206, v); }
  bool hasOptionalFloatWrapper() => $_has(76, 206);
  void clearOptionalFloatWrapper() => clearField(206);

  google$protobuf.DoubleValue get optionalDoubleWrapper => $_get(77, 207, null);
  void set optionalDoubleWrapper(google$protobuf.DoubleValue v) { setField(207, v); }
  bool hasOptionalDoubleWrapper() => $_has(77, 207);
  void clearOptionalDoubleWrapper() => clearField(207);

  google$protobuf.StringValue get optionalStringWrapper => $_get(78, 208, null);
  void set optionalStringWrapper(google$protobuf.StringValue v) { setField(208, v); }
  bool hasOptionalStringWrapper() => $_has(78, 208);
  void clearOptionalStringWrapper() => clearField(208);

  google$protobuf.BytesValue get optionalBytesWrapper => $_get(79, 209, null);
  void set optionalBytesWrapper(google$protobuf.BytesValue v) { setField(209, v); }
  bool hasOptionalBytesWrapper() => $_has(79, 209);
  void clearOptionalBytesWrapper() => clearField(209);

  List<google$protobuf.BoolValue> get repeatedBoolWrapper => $_get(80, 211, null);

  List<google$protobuf.Int32Value> get repeatedInt32Wrapper => $_get(81, 212, null);

  List<google$protobuf.Int64Value> get repeatedInt64Wrapper => $_get(82, 213, null);

  List<google$protobuf.UInt32Value> get repeatedUint32Wrapper => $_get(83, 214, null);

  List<google$protobuf.UInt64Value> get repeatedUint64Wrapper => $_get(84, 215, null);

  List<google$protobuf.FloatValue> get repeatedFloatWrapper => $_get(85, 216, null);

  List<google$protobuf.DoubleValue> get repeatedDoubleWrapper => $_get(86, 217, null);

  List<google$protobuf.StringValue> get repeatedStringWrapper => $_get(87, 218, null);

  List<google$protobuf.BytesValue> get repeatedBytesWrapper => $_get(88, 219, null);

  google$protobuf.Duration get optionalDuration => $_get(89, 301, null);
  void set optionalDuration(google$protobuf.Duration v) { setField(301, v); }
  bool hasOptionalDuration() => $_has(89, 301);
  void clearOptionalDuration() => clearField(301);

  google$protobuf.Timestamp get optionalTimestamp => $_get(90, 302, null);
  void set optionalTimestamp(google$protobuf.Timestamp v) { setField(302, v); }
  bool hasOptionalTimestamp() => $_has(90, 302);
  void clearOptionalTimestamp() => clearField(302);

  google$protobuf.FieldMask get optionalFieldMask => $_get(91, 303, null);
  void set optionalFieldMask(google$protobuf.FieldMask v) { setField(303, v); }
  bool hasOptionalFieldMask() => $_has(91, 303);
  void clearOptionalFieldMask() => clearField(303);

  google$protobuf.Struct get optionalStruct => $_get(92, 304, null);
  void set optionalStruct(google$protobuf.Struct v) { setField(304, v); }
  bool hasOptionalStruct() => $_has(92, 304);
  void clearOptionalStruct() => clearField(304);

  google$protobuf.Any get optionalAny => $_get(93, 305, null);
  void set optionalAny(google$protobuf.Any v) { setField(305, v); }
  bool hasOptionalAny() => $_has(93, 305);
  void clearOptionalAny() => clearField(305);

  google$protobuf.Value get optionalValue => $_get(94, 306, null);
  void set optionalValue(google$protobuf.Value v) { setField(306, v); }
  bool hasOptionalValue() => $_has(94, 306);
  void clearOptionalValue() => clearField(306);

  List<google$protobuf.Duration> get repeatedDuration => $_get(95, 311, null);

  List<google$protobuf.Timestamp> get repeatedTimestamp => $_get(96, 312, null);

  List<google$protobuf.FieldMask> get repeatedFieldmask => $_get(97, 313, null);

  List<google$protobuf.Any> get repeatedAny => $_get(98, 315, null);

  List<google$protobuf.Value> get repeatedValue => $_get(99, 316, null);

  List<google$protobuf.Struct> get repeatedStruct => $_get(100, 324, null);

  int get fieldname1 => $_get(101, 401, 0);
  void set fieldname1(int v) { $_setUnsignedInt32(101, 401, v); }
  bool hasFieldname1() => $_has(101, 401);
  void clearFieldname1() => clearField(401);

  int get fieldName2 => $_get(102, 402, 0);
  void set fieldName2(int v) { $_setUnsignedInt32(102, 402, v); }
  bool hasFieldName2() => $_has(102, 402);
  void clearFieldName2() => clearField(402);

  int get fieldName3 => $_get(103, 403, 0);
  void set fieldName3(int v) { $_setUnsignedInt32(103, 403, v); }
  bool hasFieldName3() => $_has(103, 403);
  void clearFieldName3() => clearField(403);

  int get fieldName4 => $_get(104, 404, 0);
  void set fieldName4(int v) { $_setUnsignedInt32(104, 404, v); }
  bool hasFieldName4() => $_has(104, 404);
  void clearFieldName4() => clearField(404);

  int get field0name5 => $_get(105, 405, 0);
  void set field0name5(int v) { $_setUnsignedInt32(105, 405, v); }
  bool hasField0name5() => $_has(105, 405);
  void clearField0name5() => clearField(405);

  int get field0Name6 => $_get(106, 406, 0);
  void set field0Name6(int v) { $_setUnsignedInt32(106, 406, v); }
  bool hasField0Name6() => $_has(106, 406);
  void clearField0Name6() => clearField(406);

  int get fieldName7 => $_get(107, 407, 0);
  void set fieldName7(int v) { $_setUnsignedInt32(107, 407, v); }
  bool hasFieldName7() => $_has(107, 407);
  void clearFieldName7() => clearField(407);

  int get fieldName8 => $_get(108, 408, 0);
  void set fieldName8(int v) { $_setUnsignedInt32(108, 408, v); }
  bool hasFieldName8() => $_has(108, 408);
  void clearFieldName8() => clearField(408);

  int get fieldName9 => $_get(109, 409, 0);
  void set fieldName9(int v) { $_setUnsignedInt32(109, 409, v); }
  bool hasFieldName9() => $_has(109, 409);
  void clearFieldName9() => clearField(409);

  int get fieldName10 => $_get(110, 410, 0);
  void set fieldName10(int v) { $_setUnsignedInt32(110, 410, v); }
  bool hasFieldName10() => $_has(110, 410);
  void clearFieldName10() => clearField(410);

  int get fIELDNAME11 => $_get(111, 411, 0);
  void set fIELDNAME11(int v) { $_setUnsignedInt32(111, 411, v); }
  bool hasFIELDNAME11() => $_has(111, 411);
  void clearFIELDNAME11() => clearField(411);

  int get fIELDName12 => $_get(112, 412, 0);
  void set fIELDName12(int v) { $_setUnsignedInt32(112, 412, v); }
  bool hasFIELDName12() => $_has(112, 412);
  void clearFIELDName12() => clearField(412);

  int get fieldName13 => $_get(113, 413, 0);
  void set fieldName13(int v) { $_setUnsignedInt32(113, 413, v); }
  bool hasFieldName13() => $_has(113, 413);
  void clearFieldName13() => clearField(413);

  int get fieldName14 => $_get(114, 414, 0);
  void set fieldName14(int v) { $_setUnsignedInt32(114, 414, v); }
  bool hasFieldName14() => $_has(114, 414);
  void clearFieldName14() => clearField(414);

  int get fieldName15 => $_get(115, 415, 0);
  void set fieldName15(int v) { $_setUnsignedInt32(115, 415, v); }
  bool hasFieldName15() => $_has(115, 415);
  void clearFieldName15() => clearField(415);

  int get fieldName16 => $_get(116, 416, 0);
  void set fieldName16(int v) { $_setUnsignedInt32(116, 416, v); }
  bool hasFieldName16() => $_has(116, 416);
  void clearFieldName16() => clearField(416);

  int get fieldName17 => $_get(117, 417, 0);
  void set fieldName17(int v) { $_setUnsignedInt32(117, 417, v); }
  bool hasFieldName17() => $_has(117, 417);
  void clearFieldName17() => clearField(417);

  int get fieldName18 => $_get(118, 418, 0);
  void set fieldName18(int v) { $_setUnsignedInt32(118, 418, v); }
  bool hasFieldName18() => $_has(118, 418);
  void clearFieldName18() => clearField(418);
}

class _ReadonlyTestAllTypes extends TestAllTypes with ReadonlyMessageMixin {}

class ForeignMessage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ForeignMessage')
    ..a/*<int>*/(1, 'c', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ForeignMessage() : super();
  ForeignMessage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ForeignMessage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ForeignMessage clone() => new ForeignMessage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ForeignMessage create() => new ForeignMessage();
  static PbList<ForeignMessage> createRepeated() => new PbList<ForeignMessage>();
  static ForeignMessage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyForeignMessage();
    return _defaultInstance;
  }
  static ForeignMessage _defaultInstance;
  static void $checkItem(ForeignMessage v) {
    if (v is !ForeignMessage) checkItemFailed(v, 'ForeignMessage');
  }

  int get c => $_get(0, 1, 0);
  void set c(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasC() => $_has(0, 1);
  void clearC() => clearField(1);
}

class _ReadonlyForeignMessage extends ForeignMessage with ReadonlyMessageMixin {}

