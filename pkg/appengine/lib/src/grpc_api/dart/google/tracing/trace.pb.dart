///
//  Generated code. Do not modify.
///
library google.tracing.v1_trace;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../protobuf/timestamp.pb.dart' as google$protobuf;
import '../rpc/status.pb.dart' as google$rpc;

import 'trace.pbenum.dart';

export 'trace.pbenum.dart';

class TraceId extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TraceId')
    ..a/*<String>*/(1, 'hexEncoded', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  TraceId() : super();
  TraceId.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TraceId.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TraceId clone() => new TraceId()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TraceId create() => new TraceId();
  static PbList<TraceId> createRepeated() => new PbList<TraceId>();
  static TraceId getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTraceId();
    return _defaultInstance;
  }
  static TraceId _defaultInstance;
  static void $checkItem(TraceId v) {
    if (v is !TraceId) checkItemFailed(v, 'TraceId');
  }

  String get hexEncoded => $_get(0, 1, '');
  void set hexEncoded(String v) { $_setString(0, 1, v); }
  bool hasHexEncoded() => $_has(0, 1);
  void clearHexEncoded() => clearField(1);
}

class _ReadonlyTraceId extends TraceId with ReadonlyMessageMixin {}

class Module extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Module')
    ..a/*<String>*/(1, 'module', PbFieldType.OS)
    ..a/*<String>*/(2, 'buildId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Module() : super();
  Module.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Module.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Module clone() => new Module()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Module create() => new Module();
  static PbList<Module> createRepeated() => new PbList<Module>();
  static Module getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyModule();
    return _defaultInstance;
  }
  static Module _defaultInstance;
  static void $checkItem(Module v) {
    if (v is !Module) checkItemFailed(v, 'Module');
  }

  String get module => $_get(0, 1, '');
  void set module(String v) { $_setString(0, 1, v); }
  bool hasModule() => $_has(0, 1);
  void clearModule() => clearField(1);

  String get buildId => $_get(1, 2, '');
  void set buildId(String v) { $_setString(1, 2, v); }
  bool hasBuildId() => $_has(1, 2);
  void clearBuildId() => clearField(2);
}

class _ReadonlyModule extends Module with ReadonlyMessageMixin {}

class StackTrace_StackFrame extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StackTrace_StackFrame')
    ..a/*<String>*/(1, 'functionName', PbFieldType.OS)
    ..a/*<String>*/(2, 'origFunctionName', PbFieldType.OS)
    ..a/*<String>*/(3, 'fileName', PbFieldType.OS)
    ..a/*<Int64>*/(4, 'lineNumber', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(5, 'columnNumber', PbFieldType.O6, Int64.ZERO)
    ..a/*<Module>*/(6, 'loadModule', PbFieldType.OM, Module.getDefault, Module.create)
    ..a/*<String>*/(7, 'sourceVersion', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  StackTrace_StackFrame() : super();
  StackTrace_StackFrame.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StackTrace_StackFrame.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StackTrace_StackFrame clone() => new StackTrace_StackFrame()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StackTrace_StackFrame create() => new StackTrace_StackFrame();
  static PbList<StackTrace_StackFrame> createRepeated() => new PbList<StackTrace_StackFrame>();
  static StackTrace_StackFrame getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStackTrace_StackFrame();
    return _defaultInstance;
  }
  static StackTrace_StackFrame _defaultInstance;
  static void $checkItem(StackTrace_StackFrame v) {
    if (v is !StackTrace_StackFrame) checkItemFailed(v, 'StackTrace_StackFrame');
  }

  String get functionName => $_get(0, 1, '');
  void set functionName(String v) { $_setString(0, 1, v); }
  bool hasFunctionName() => $_has(0, 1);
  void clearFunctionName() => clearField(1);

  String get origFunctionName => $_get(1, 2, '');
  void set origFunctionName(String v) { $_setString(1, 2, v); }
  bool hasOrigFunctionName() => $_has(1, 2);
  void clearOrigFunctionName() => clearField(2);

  String get fileName => $_get(2, 3, '');
  void set fileName(String v) { $_setString(2, 3, v); }
  bool hasFileName() => $_has(2, 3);
  void clearFileName() => clearField(3);

  Int64 get lineNumber => $_get(3, 4, null);
  void set lineNumber(Int64 v) { $_setInt64(3, 4, v); }
  bool hasLineNumber() => $_has(3, 4);
  void clearLineNumber() => clearField(4);

  Int64 get columnNumber => $_get(4, 5, null);
  void set columnNumber(Int64 v) { $_setInt64(4, 5, v); }
  bool hasColumnNumber() => $_has(4, 5);
  void clearColumnNumber() => clearField(5);

  Module get loadModule => $_get(5, 6, null);
  void set loadModule(Module v) { setField(6, v); }
  bool hasLoadModule() => $_has(5, 6);
  void clearLoadModule() => clearField(6);

  String get sourceVersion => $_get(6, 7, '');
  void set sourceVersion(String v) { $_setString(6, 7, v); }
  bool hasSourceVersion() => $_has(6, 7);
  void clearSourceVersion() => clearField(7);
}

class _ReadonlyStackTrace_StackFrame extends StackTrace_StackFrame with ReadonlyMessageMixin {}

class StackTrace extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StackTrace')
    ..pp/*<StackTrace_StackFrame>*/(1, 'stackFrame', PbFieldType.PM, StackTrace_StackFrame.$checkItem, StackTrace_StackFrame.create)
    ..a/*<Int64>*/(2, 'stackTraceHashId', PbFieldType.OU6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  StackTrace() : super();
  StackTrace.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StackTrace.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StackTrace clone() => new StackTrace()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StackTrace create() => new StackTrace();
  static PbList<StackTrace> createRepeated() => new PbList<StackTrace>();
  static StackTrace getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStackTrace();
    return _defaultInstance;
  }
  static StackTrace _defaultInstance;
  static void $checkItem(StackTrace v) {
    if (v is !StackTrace) checkItemFailed(v, 'StackTrace');
  }

  List<StackTrace_StackFrame> get stackFrame => $_get(0, 1, null);

  Int64 get stackTraceHashId => $_get(1, 2, null);
  void set stackTraceHashId(Int64 v) { $_setInt64(1, 2, v); }
  bool hasStackTraceHashId() => $_has(1, 2);
  void clearStackTraceHashId() => clearField(2);
}

class _ReadonlyStackTrace extends StackTrace with ReadonlyMessageMixin {}

class LabelValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LabelValue')
    ..a/*<String>*/(1, 'stringValue', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'intValue', PbFieldType.O6, Int64.ZERO)
    ..a/*<bool>*/(3, 'boolValue', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  LabelValue() : super();
  LabelValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LabelValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LabelValue clone() => new LabelValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LabelValue create() => new LabelValue();
  static PbList<LabelValue> createRepeated() => new PbList<LabelValue>();
  static LabelValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLabelValue();
    return _defaultInstance;
  }
  static LabelValue _defaultInstance;
  static void $checkItem(LabelValue v) {
    if (v is !LabelValue) checkItemFailed(v, 'LabelValue');
  }

  String get stringValue => $_get(0, 1, '');
  void set stringValue(String v) { $_setString(0, 1, v); }
  bool hasStringValue() => $_has(0, 1);
  void clearStringValue() => clearField(1);

  Int64 get intValue => $_get(1, 2, null);
  void set intValue(Int64 v) { $_setInt64(1, 2, v); }
  bool hasIntValue() => $_has(1, 2);
  void clearIntValue() => clearField(2);

  bool get boolValue => $_get(2, 3, false);
  void set boolValue(bool v) { $_setBool(2, 3, v); }
  bool hasBoolValue() => $_has(2, 3);
  void clearBoolValue() => clearField(3);
}

class _ReadonlyLabelValue extends LabelValue with ReadonlyMessageMixin {}

class Span_TimeEvent_Annotation_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Span_TimeEvent_Annotation_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<LabelValue>*/(2, 'value', PbFieldType.OM, LabelValue.getDefault, LabelValue.create)
    ..hasRequiredFields = false
  ;

  Span_TimeEvent_Annotation_LabelsEntry() : super();
  Span_TimeEvent_Annotation_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Span_TimeEvent_Annotation_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Span_TimeEvent_Annotation_LabelsEntry clone() => new Span_TimeEvent_Annotation_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Span_TimeEvent_Annotation_LabelsEntry create() => new Span_TimeEvent_Annotation_LabelsEntry();
  static PbList<Span_TimeEvent_Annotation_LabelsEntry> createRepeated() => new PbList<Span_TimeEvent_Annotation_LabelsEntry>();
  static Span_TimeEvent_Annotation_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySpan_TimeEvent_Annotation_LabelsEntry();
    return _defaultInstance;
  }
  static Span_TimeEvent_Annotation_LabelsEntry _defaultInstance;
  static void $checkItem(Span_TimeEvent_Annotation_LabelsEntry v) {
    if (v is !Span_TimeEvent_Annotation_LabelsEntry) checkItemFailed(v, 'Span_TimeEvent_Annotation_LabelsEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  LabelValue get value => $_get(1, 2, null);
  void set value(LabelValue v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlySpan_TimeEvent_Annotation_LabelsEntry extends Span_TimeEvent_Annotation_LabelsEntry with ReadonlyMessageMixin {}

class Span_TimeEvent_Annotation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Span_TimeEvent_Annotation')
    ..a/*<String>*/(1, 'description', PbFieldType.OS)
    ..pp/*<Span_TimeEvent_Annotation_LabelsEntry>*/(2, 'labels', PbFieldType.PM, Span_TimeEvent_Annotation_LabelsEntry.$checkItem, Span_TimeEvent_Annotation_LabelsEntry.create)
    ..hasRequiredFields = false
  ;

  Span_TimeEvent_Annotation() : super();
  Span_TimeEvent_Annotation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Span_TimeEvent_Annotation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Span_TimeEvent_Annotation clone() => new Span_TimeEvent_Annotation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Span_TimeEvent_Annotation create() => new Span_TimeEvent_Annotation();
  static PbList<Span_TimeEvent_Annotation> createRepeated() => new PbList<Span_TimeEvent_Annotation>();
  static Span_TimeEvent_Annotation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySpan_TimeEvent_Annotation();
    return _defaultInstance;
  }
  static Span_TimeEvent_Annotation _defaultInstance;
  static void $checkItem(Span_TimeEvent_Annotation v) {
    if (v is !Span_TimeEvent_Annotation) checkItemFailed(v, 'Span_TimeEvent_Annotation');
  }

  String get description => $_get(0, 1, '');
  void set description(String v) { $_setString(0, 1, v); }
  bool hasDescription() => $_has(0, 1);
  void clearDescription() => clearField(1);

  List<Span_TimeEvent_Annotation_LabelsEntry> get labels => $_get(1, 2, null);
}

class _ReadonlySpan_TimeEvent_Annotation extends Span_TimeEvent_Annotation with ReadonlyMessageMixin {}

class Span_TimeEvent_NetworkEvent extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Span_TimeEvent_NetworkEvent')
    ..a/*<google$protobuf.Timestamp>*/(1, 'kernelTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..e/*<Span_TimeEvent_NetworkEvent_Type>*/(2, 'type', PbFieldType.OE, Span_TimeEvent_NetworkEvent_Type.UNSPECIFIED, Span_TimeEvent_NetworkEvent_Type.valueOf)
    ..a/*<Int64>*/(3, 'messageId', PbFieldType.OU6, Int64.ZERO)
    ..a/*<Int64>*/(4, 'messageSize', PbFieldType.OU6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  Span_TimeEvent_NetworkEvent() : super();
  Span_TimeEvent_NetworkEvent.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Span_TimeEvent_NetworkEvent.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Span_TimeEvent_NetworkEvent clone() => new Span_TimeEvent_NetworkEvent()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Span_TimeEvent_NetworkEvent create() => new Span_TimeEvent_NetworkEvent();
  static PbList<Span_TimeEvent_NetworkEvent> createRepeated() => new PbList<Span_TimeEvent_NetworkEvent>();
  static Span_TimeEvent_NetworkEvent getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySpan_TimeEvent_NetworkEvent();
    return _defaultInstance;
  }
  static Span_TimeEvent_NetworkEvent _defaultInstance;
  static void $checkItem(Span_TimeEvent_NetworkEvent v) {
    if (v is !Span_TimeEvent_NetworkEvent) checkItemFailed(v, 'Span_TimeEvent_NetworkEvent');
  }

  google$protobuf.Timestamp get kernelTime => $_get(0, 1, null);
  void set kernelTime(google$protobuf.Timestamp v) { setField(1, v); }
  bool hasKernelTime() => $_has(0, 1);
  void clearKernelTime() => clearField(1);

  Span_TimeEvent_NetworkEvent_Type get type => $_get(1, 2, null);
  void set type(Span_TimeEvent_NetworkEvent_Type v) { setField(2, v); }
  bool hasType() => $_has(1, 2);
  void clearType() => clearField(2);

  Int64 get messageId => $_get(2, 3, null);
  void set messageId(Int64 v) { $_setInt64(2, 3, v); }
  bool hasMessageId() => $_has(2, 3);
  void clearMessageId() => clearField(3);

  Int64 get messageSize => $_get(3, 4, null);
  void set messageSize(Int64 v) { $_setInt64(3, 4, v); }
  bool hasMessageSize() => $_has(3, 4);
  void clearMessageSize() => clearField(4);
}

class _ReadonlySpan_TimeEvent_NetworkEvent extends Span_TimeEvent_NetworkEvent with ReadonlyMessageMixin {}

class Span_TimeEvent extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Span_TimeEvent')
    ..a/*<google$protobuf.Timestamp>*/(1, 'localTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<Span_TimeEvent_Annotation>*/(2, 'annotation', PbFieldType.OM, Span_TimeEvent_Annotation.getDefault, Span_TimeEvent_Annotation.create)
    ..a/*<Span_TimeEvent_NetworkEvent>*/(3, 'networkEvent', PbFieldType.OM, Span_TimeEvent_NetworkEvent.getDefault, Span_TimeEvent_NetworkEvent.create)
    ..hasRequiredFields = false
  ;

  Span_TimeEvent() : super();
  Span_TimeEvent.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Span_TimeEvent.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Span_TimeEvent clone() => new Span_TimeEvent()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Span_TimeEvent create() => new Span_TimeEvent();
  static PbList<Span_TimeEvent> createRepeated() => new PbList<Span_TimeEvent>();
  static Span_TimeEvent getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySpan_TimeEvent();
    return _defaultInstance;
  }
  static Span_TimeEvent _defaultInstance;
  static void $checkItem(Span_TimeEvent v) {
    if (v is !Span_TimeEvent) checkItemFailed(v, 'Span_TimeEvent');
  }

  google$protobuf.Timestamp get localTime => $_get(0, 1, null);
  void set localTime(google$protobuf.Timestamp v) { setField(1, v); }
  bool hasLocalTime() => $_has(0, 1);
  void clearLocalTime() => clearField(1);

  Span_TimeEvent_Annotation get annotation => $_get(1, 2, null);
  void set annotation(Span_TimeEvent_Annotation v) { setField(2, v); }
  bool hasAnnotation() => $_has(1, 2);
  void clearAnnotation() => clearField(2);

  Span_TimeEvent_NetworkEvent get networkEvent => $_get(2, 3, null);
  void set networkEvent(Span_TimeEvent_NetworkEvent v) { setField(3, v); }
  bool hasNetworkEvent() => $_has(2, 3);
  void clearNetworkEvent() => clearField(3);
}

class _ReadonlySpan_TimeEvent extends Span_TimeEvent with ReadonlyMessageMixin {}

class Span_Link extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Span_Link')
    ..a/*<TraceId>*/(1, 'traceId', PbFieldType.OM, TraceId.getDefault, TraceId.create)
    ..a/*<Int64>*/(2, 'spanId', PbFieldType.OF6, Int64.ZERO)
    ..e/*<Span_Link_Type>*/(3, 'type', PbFieldType.OE, Span_Link_Type.UNSPECIFIED, Span_Link_Type.valueOf)
    ..hasRequiredFields = false
  ;

  Span_Link() : super();
  Span_Link.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Span_Link.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Span_Link clone() => new Span_Link()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Span_Link create() => new Span_Link();
  static PbList<Span_Link> createRepeated() => new PbList<Span_Link>();
  static Span_Link getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySpan_Link();
    return _defaultInstance;
  }
  static Span_Link _defaultInstance;
  static void $checkItem(Span_Link v) {
    if (v is !Span_Link) checkItemFailed(v, 'Span_Link');
  }

  TraceId get traceId => $_get(0, 1, null);
  void set traceId(TraceId v) { setField(1, v); }
  bool hasTraceId() => $_has(0, 1);
  void clearTraceId() => clearField(1);

  Int64 get spanId => $_get(1, 2, null);
  void set spanId(Int64 v) { $_setInt64(1, 2, v); }
  bool hasSpanId() => $_has(1, 2);
  void clearSpanId() => clearField(2);

  Span_Link_Type get type => $_get(2, 3, null);
  void set type(Span_Link_Type v) { setField(3, v); }
  bool hasType() => $_has(2, 3);
  void clearType() => clearField(3);
}

class _ReadonlySpan_Link extends Span_Link with ReadonlyMessageMixin {}

class Span_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Span_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<LabelValue>*/(2, 'value', PbFieldType.OM, LabelValue.getDefault, LabelValue.create)
    ..hasRequiredFields = false
  ;

  Span_LabelsEntry() : super();
  Span_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Span_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Span_LabelsEntry clone() => new Span_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Span_LabelsEntry create() => new Span_LabelsEntry();
  static PbList<Span_LabelsEntry> createRepeated() => new PbList<Span_LabelsEntry>();
  static Span_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySpan_LabelsEntry();
    return _defaultInstance;
  }
  static Span_LabelsEntry _defaultInstance;
  static void $checkItem(Span_LabelsEntry v) {
    if (v is !Span_LabelsEntry) checkItemFailed(v, 'Span_LabelsEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  LabelValue get value => $_get(1, 2, null);
  void set value(LabelValue v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlySpan_LabelsEntry extends Span_LabelsEntry with ReadonlyMessageMixin {}

class Span extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Span')
    ..a/*<Int64>*/(1, 'id', PbFieldType.OF6, Int64.ZERO)
    ..a/*<String>*/(2, 'name', PbFieldType.OS)
    ..a/*<Int64>*/(3, 'parentId', PbFieldType.OF6, Int64.ZERO)
    ..a/*<google$protobuf.Timestamp>*/(4, 'localStartTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(5, 'localEndTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..pp/*<Span_LabelsEntry>*/(6, 'labels', PbFieldType.PM, Span_LabelsEntry.$checkItem, Span_LabelsEntry.create)
    ..a/*<StackTrace>*/(7, 'stackTrace', PbFieldType.OM, StackTrace.getDefault, StackTrace.create)
    ..pp/*<Span_TimeEvent>*/(8, 'timeEvents', PbFieldType.PM, Span_TimeEvent.$checkItem, Span_TimeEvent.create)
    ..pp/*<Span_Link>*/(9, 'links', PbFieldType.PM, Span_Link.$checkItem, Span_Link.create)
    ..a/*<google$rpc.Status>*/(10, 'status', PbFieldType.OM, google$rpc.Status.getDefault, google$rpc.Status.create)
    ..a/*<bool>*/(11, 'hasRemoteParent', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  Span() : super();
  Span.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Span.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Span clone() => new Span()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Span create() => new Span();
  static PbList<Span> createRepeated() => new PbList<Span>();
  static Span getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySpan();
    return _defaultInstance;
  }
  static Span _defaultInstance;
  static void $checkItem(Span v) {
    if (v is !Span) checkItemFailed(v, 'Span');
  }

  Int64 get id => $_get(0, 1, null);
  void set id(Int64 v) { $_setInt64(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  String get name => $_get(1, 2, '');
  void set name(String v) { $_setString(1, 2, v); }
  bool hasName() => $_has(1, 2);
  void clearName() => clearField(2);

  Int64 get parentId => $_get(2, 3, null);
  void set parentId(Int64 v) { $_setInt64(2, 3, v); }
  bool hasParentId() => $_has(2, 3);
  void clearParentId() => clearField(3);

  google$protobuf.Timestamp get localStartTime => $_get(3, 4, null);
  void set localStartTime(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasLocalStartTime() => $_has(3, 4);
  void clearLocalStartTime() => clearField(4);

  google$protobuf.Timestamp get localEndTime => $_get(4, 5, null);
  void set localEndTime(google$protobuf.Timestamp v) { setField(5, v); }
  bool hasLocalEndTime() => $_has(4, 5);
  void clearLocalEndTime() => clearField(5);

  List<Span_LabelsEntry> get labels => $_get(5, 6, null);

  StackTrace get stackTrace => $_get(6, 7, null);
  void set stackTrace(StackTrace v) { setField(7, v); }
  bool hasStackTrace() => $_has(6, 7);
  void clearStackTrace() => clearField(7);

  List<Span_TimeEvent> get timeEvents => $_get(7, 8, null);

  List<Span_Link> get links => $_get(8, 9, null);

  google$rpc.Status get status => $_get(9, 10, null);
  void set status(google$rpc.Status v) { setField(10, v); }
  bool hasStatus() => $_has(9, 10);
  void clearStatus() => clearField(10);

  bool get hasRemoteParent => $_get(10, 11, false);
  void set hasRemoteParent(bool v) { $_setBool(10, 11, v); }
  bool hasHasRemoteParent() => $_has(10, 11);
  void clearHasRemoteParent() => clearField(11);
}

class _ReadonlySpan extends Span with ReadonlyMessageMixin {}

class Trace extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Trace')
    ..a/*<TraceId>*/(1, 'traceId', PbFieldType.OM, TraceId.getDefault, TraceId.create)
    ..pp/*<Span>*/(2, 'spans', PbFieldType.PM, Span.$checkItem, Span.create)
    ..hasRequiredFields = false
  ;

  Trace() : super();
  Trace.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Trace.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Trace clone() => new Trace()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Trace create() => new Trace();
  static PbList<Trace> createRepeated() => new PbList<Trace>();
  static Trace getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTrace();
    return _defaultInstance;
  }
  static Trace _defaultInstance;
  static void $checkItem(Trace v) {
    if (v is !Trace) checkItemFailed(v, 'Trace');
  }

  TraceId get traceId => $_get(0, 1, null);
  void set traceId(TraceId v) { setField(1, v); }
  bool hasTraceId() => $_has(0, 1);
  void clearTraceId() => clearField(1);

  List<Span> get spans => $_get(1, 2, null);
}

class _ReadonlyTrace extends Trace with ReadonlyMessageMixin {}

