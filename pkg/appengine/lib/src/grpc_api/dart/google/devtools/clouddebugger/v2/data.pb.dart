///
//  Generated code. Do not modify.
///
library google.devtools.clouddebugger.v2_data;

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/wrappers.pb.dart' as google$protobuf;
import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../source/v1/source_context.pb.dart' as google$devtools$source$v1;

import 'data.pbenum.dart';

export 'data.pbenum.dart';

class FormatMessage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('FormatMessage')
    ..a/*<String>*/(1, 'format', PbFieldType.OS)
    ..p/*<String>*/(2, 'parameters', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  FormatMessage() : super();
  FormatMessage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  FormatMessage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  FormatMessage clone() => new FormatMessage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static FormatMessage create() => new FormatMessage();
  static PbList<FormatMessage> createRepeated() => new PbList<FormatMessage>();
  static FormatMessage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyFormatMessage();
    return _defaultInstance;
  }
  static FormatMessage _defaultInstance;
  static void $checkItem(FormatMessage v) {
    if (v is !FormatMessage) checkItemFailed(v, 'FormatMessage');
  }

  String get format => $_get(0, 1, '');
  void set format(String v) { $_setString(0, 1, v); }
  bool hasFormat() => $_has(0, 1);
  void clearFormat() => clearField(1);

  List<String> get parameters => $_get(1, 2, null);
}

class _ReadonlyFormatMessage extends FormatMessage with ReadonlyMessageMixin {}

class StatusMessage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StatusMessage')
    ..a/*<bool>*/(1, 'isError', PbFieldType.OB)
    ..e/*<StatusMessage_Reference>*/(2, 'refersTo', PbFieldType.OE, StatusMessage_Reference.UNSPECIFIED, StatusMessage_Reference.valueOf)
    ..a/*<FormatMessage>*/(3, 'description', PbFieldType.OM, FormatMessage.getDefault, FormatMessage.create)
    ..hasRequiredFields = false
  ;

  StatusMessage() : super();
  StatusMessage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StatusMessage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StatusMessage clone() => new StatusMessage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StatusMessage create() => new StatusMessage();
  static PbList<StatusMessage> createRepeated() => new PbList<StatusMessage>();
  static StatusMessage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStatusMessage();
    return _defaultInstance;
  }
  static StatusMessage _defaultInstance;
  static void $checkItem(StatusMessage v) {
    if (v is !StatusMessage) checkItemFailed(v, 'StatusMessage');
  }

  bool get isError => $_get(0, 1, false);
  void set isError(bool v) { $_setBool(0, 1, v); }
  bool hasIsError() => $_has(0, 1);
  void clearIsError() => clearField(1);

  StatusMessage_Reference get refersTo => $_get(1, 2, null);
  void set refersTo(StatusMessage_Reference v) { setField(2, v); }
  bool hasRefersTo() => $_has(1, 2);
  void clearRefersTo() => clearField(2);

  FormatMessage get description => $_get(2, 3, null);
  void set description(FormatMessage v) { setField(3, v); }
  bool hasDescription() => $_has(2, 3);
  void clearDescription() => clearField(3);
}

class _ReadonlyStatusMessage extends StatusMessage with ReadonlyMessageMixin {}

class SourceLocation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SourceLocation')
    ..a/*<String>*/(1, 'path', PbFieldType.OS)
    ..a/*<int>*/(2, 'line', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SourceLocation() : super();
  SourceLocation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SourceLocation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SourceLocation clone() => new SourceLocation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SourceLocation create() => new SourceLocation();
  static PbList<SourceLocation> createRepeated() => new PbList<SourceLocation>();
  static SourceLocation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySourceLocation();
    return _defaultInstance;
  }
  static SourceLocation _defaultInstance;
  static void $checkItem(SourceLocation v) {
    if (v is !SourceLocation) checkItemFailed(v, 'SourceLocation');
  }

  String get path => $_get(0, 1, '');
  void set path(String v) { $_setString(0, 1, v); }
  bool hasPath() => $_has(0, 1);
  void clearPath() => clearField(1);

  int get line => $_get(1, 2, 0);
  void set line(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasLine() => $_has(1, 2);
  void clearLine() => clearField(2);
}

class _ReadonlySourceLocation extends SourceLocation with ReadonlyMessageMixin {}

class Variable extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Variable')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..pp/*<Variable>*/(3, 'members', PbFieldType.PM, Variable.$checkItem, Variable.create)
    ..a/*<google$protobuf.Int32Value>*/(4, 'varTableIndex', PbFieldType.OM, google$protobuf.Int32Value.getDefault, google$protobuf.Int32Value.create)
    ..a/*<StatusMessage>*/(5, 'status', PbFieldType.OM, StatusMessage.getDefault, StatusMessage.create)
    ..a/*<String>*/(6, 'type', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Variable() : super();
  Variable.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Variable.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Variable clone() => new Variable()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Variable create() => new Variable();
  static PbList<Variable> createRepeated() => new PbList<Variable>();
  static Variable getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyVariable();
    return _defaultInstance;
  }
  static Variable _defaultInstance;
  static void $checkItem(Variable v) {
    if (v is !Variable) checkItemFailed(v, 'Variable');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);

  List<Variable> get members => $_get(2, 3, null);

  google$protobuf.Int32Value get varTableIndex => $_get(3, 4, null);
  void set varTableIndex(google$protobuf.Int32Value v) { setField(4, v); }
  bool hasVarTableIndex() => $_has(3, 4);
  void clearVarTableIndex() => clearField(4);

  StatusMessage get status => $_get(4, 5, null);
  void set status(StatusMessage v) { setField(5, v); }
  bool hasStatus() => $_has(4, 5);
  void clearStatus() => clearField(5);

  String get type => $_get(5, 6, '');
  void set type(String v) { $_setString(5, 6, v); }
  bool hasType() => $_has(5, 6);
  void clearType() => clearField(6);
}

class _ReadonlyVariable extends Variable with ReadonlyMessageMixin {}

class StackFrame extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StackFrame')
    ..a/*<String>*/(1, 'function', PbFieldType.OS)
    ..a/*<SourceLocation>*/(2, 'location', PbFieldType.OM, SourceLocation.getDefault, SourceLocation.create)
    ..pp/*<Variable>*/(3, 'arguments', PbFieldType.PM, Variable.$checkItem, Variable.create)
    ..pp/*<Variable>*/(4, 'locals', PbFieldType.PM, Variable.$checkItem, Variable.create)
    ..hasRequiredFields = false
  ;

  StackFrame() : super();
  StackFrame.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StackFrame.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StackFrame clone() => new StackFrame()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StackFrame create() => new StackFrame();
  static PbList<StackFrame> createRepeated() => new PbList<StackFrame>();
  static StackFrame getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStackFrame();
    return _defaultInstance;
  }
  static StackFrame _defaultInstance;
  static void $checkItem(StackFrame v) {
    if (v is !StackFrame) checkItemFailed(v, 'StackFrame');
  }

  String get function => $_get(0, 1, '');
  void set function(String v) { $_setString(0, 1, v); }
  bool hasFunction() => $_has(0, 1);
  void clearFunction() => clearField(1);

  SourceLocation get location => $_get(1, 2, null);
  void set location(SourceLocation v) { setField(2, v); }
  bool hasLocation() => $_has(1, 2);
  void clearLocation() => clearField(2);

  List<Variable> get arguments => $_get(2, 3, null);

  List<Variable> get locals => $_get(3, 4, null);
}

class _ReadonlyStackFrame extends StackFrame with ReadonlyMessageMixin {}

class Breakpoint_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Breakpoint_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Breakpoint_LabelsEntry() : super();
  Breakpoint_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Breakpoint_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Breakpoint_LabelsEntry clone() => new Breakpoint_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Breakpoint_LabelsEntry create() => new Breakpoint_LabelsEntry();
  static PbList<Breakpoint_LabelsEntry> createRepeated() => new PbList<Breakpoint_LabelsEntry>();
  static Breakpoint_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBreakpoint_LabelsEntry();
    return _defaultInstance;
  }
  static Breakpoint_LabelsEntry _defaultInstance;
  static void $checkItem(Breakpoint_LabelsEntry v) {
    if (v is !Breakpoint_LabelsEntry) checkItemFailed(v, 'Breakpoint_LabelsEntry');
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

class _ReadonlyBreakpoint_LabelsEntry extends Breakpoint_LabelsEntry with ReadonlyMessageMixin {}

class Breakpoint extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Breakpoint')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<SourceLocation>*/(2, 'location', PbFieldType.OM, SourceLocation.getDefault, SourceLocation.create)
    ..a/*<String>*/(3, 'condition', PbFieldType.OS)
    ..p/*<String>*/(4, 'expressions', PbFieldType.PS)
    ..a/*<bool>*/(5, 'isFinalState', PbFieldType.OB)
    ..pp/*<StackFrame>*/(7, 'stackFrames', PbFieldType.PM, StackFrame.$checkItem, StackFrame.create)
    ..pp/*<Variable>*/(8, 'evaluatedExpressions', PbFieldType.PM, Variable.$checkItem, Variable.create)
    ..pp/*<Variable>*/(9, 'variableTable', PbFieldType.PM, Variable.$checkItem, Variable.create)
    ..a/*<StatusMessage>*/(10, 'status', PbFieldType.OM, StatusMessage.getDefault, StatusMessage.create)
    ..a/*<google$protobuf.Timestamp>*/(11, 'createTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(12, 'finalTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..e/*<Breakpoint_Action>*/(13, 'action', PbFieldType.OE, Breakpoint_Action.CAPTURE, Breakpoint_Action.valueOf)
    ..a/*<String>*/(14, 'logMessageFormat', PbFieldType.OS)
    ..e/*<Breakpoint_LogLevel>*/(15, 'logLevel', PbFieldType.OE, Breakpoint_LogLevel.INFO, Breakpoint_LogLevel.valueOf)
    ..a/*<String>*/(16, 'userEmail', PbFieldType.OS)
    ..pp/*<Breakpoint_LabelsEntry>*/(17, 'labels', PbFieldType.PM, Breakpoint_LabelsEntry.$checkItem, Breakpoint_LabelsEntry.create)
    ..hasRequiredFields = false
  ;

  Breakpoint() : super();
  Breakpoint.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Breakpoint.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Breakpoint clone() => new Breakpoint()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Breakpoint create() => new Breakpoint();
  static PbList<Breakpoint> createRepeated() => new PbList<Breakpoint>();
  static Breakpoint getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBreakpoint();
    return _defaultInstance;
  }
  static Breakpoint _defaultInstance;
  static void $checkItem(Breakpoint v) {
    if (v is !Breakpoint) checkItemFailed(v, 'Breakpoint');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  SourceLocation get location => $_get(1, 2, null);
  void set location(SourceLocation v) { setField(2, v); }
  bool hasLocation() => $_has(1, 2);
  void clearLocation() => clearField(2);

  String get condition => $_get(2, 3, '');
  void set condition(String v) { $_setString(2, 3, v); }
  bool hasCondition() => $_has(2, 3);
  void clearCondition() => clearField(3);

  List<String> get expressions => $_get(3, 4, null);

  bool get isFinalState => $_get(4, 5, false);
  void set isFinalState(bool v) { $_setBool(4, 5, v); }
  bool hasIsFinalState() => $_has(4, 5);
  void clearIsFinalState() => clearField(5);

  List<StackFrame> get stackFrames => $_get(5, 7, null);

  List<Variable> get evaluatedExpressions => $_get(6, 8, null);

  List<Variable> get variableTable => $_get(7, 9, null);

  StatusMessage get status => $_get(8, 10, null);
  void set status(StatusMessage v) { setField(10, v); }
  bool hasStatus() => $_has(8, 10);
  void clearStatus() => clearField(10);

  google$protobuf.Timestamp get createTime => $_get(9, 11, null);
  void set createTime(google$protobuf.Timestamp v) { setField(11, v); }
  bool hasCreateTime() => $_has(9, 11);
  void clearCreateTime() => clearField(11);

  google$protobuf.Timestamp get finalTime => $_get(10, 12, null);
  void set finalTime(google$protobuf.Timestamp v) { setField(12, v); }
  bool hasFinalTime() => $_has(10, 12);
  void clearFinalTime() => clearField(12);

  Breakpoint_Action get action => $_get(11, 13, null);
  void set action(Breakpoint_Action v) { setField(13, v); }
  bool hasAction() => $_has(11, 13);
  void clearAction() => clearField(13);

  String get logMessageFormat => $_get(12, 14, '');
  void set logMessageFormat(String v) { $_setString(12, 14, v); }
  bool hasLogMessageFormat() => $_has(12, 14);
  void clearLogMessageFormat() => clearField(14);

  Breakpoint_LogLevel get logLevel => $_get(13, 15, null);
  void set logLevel(Breakpoint_LogLevel v) { setField(15, v); }
  bool hasLogLevel() => $_has(13, 15);
  void clearLogLevel() => clearField(15);

  String get userEmail => $_get(14, 16, '');
  void set userEmail(String v) { $_setString(14, 16, v); }
  bool hasUserEmail() => $_has(14, 16);
  void clearUserEmail() => clearField(16);

  List<Breakpoint_LabelsEntry> get labels => $_get(15, 17, null);
}

class _ReadonlyBreakpoint extends Breakpoint with ReadonlyMessageMixin {}

class Debuggee_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Debuggee_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Debuggee_LabelsEntry() : super();
  Debuggee_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Debuggee_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Debuggee_LabelsEntry clone() => new Debuggee_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Debuggee_LabelsEntry create() => new Debuggee_LabelsEntry();
  static PbList<Debuggee_LabelsEntry> createRepeated() => new PbList<Debuggee_LabelsEntry>();
  static Debuggee_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDebuggee_LabelsEntry();
    return _defaultInstance;
  }
  static Debuggee_LabelsEntry _defaultInstance;
  static void $checkItem(Debuggee_LabelsEntry v) {
    if (v is !Debuggee_LabelsEntry) checkItemFailed(v, 'Debuggee_LabelsEntry');
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

class _ReadonlyDebuggee_LabelsEntry extends Debuggee_LabelsEntry with ReadonlyMessageMixin {}

class Debuggee extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Debuggee')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<String>*/(2, 'project', PbFieldType.OS)
    ..a/*<String>*/(3, 'uniquifier', PbFieldType.OS)
    ..a/*<String>*/(4, 'description', PbFieldType.OS)
    ..a/*<bool>*/(5, 'isInactive', PbFieldType.OB)
    ..a/*<String>*/(6, 'agentVersion', PbFieldType.OS)
    ..a/*<bool>*/(7, 'isDisabled', PbFieldType.OB)
    ..a/*<StatusMessage>*/(8, 'status', PbFieldType.OM, StatusMessage.getDefault, StatusMessage.create)
    ..pp/*<google$devtools$source$v1.SourceContext>*/(9, 'sourceContexts', PbFieldType.PM, google$devtools$source$v1.SourceContext.$checkItem, google$devtools$source$v1.SourceContext.create)
    ..pp/*<Debuggee_LabelsEntry>*/(11, 'labels', PbFieldType.PM, Debuggee_LabelsEntry.$checkItem, Debuggee_LabelsEntry.create)
    ..pp/*<google$devtools$source$v1.ExtendedSourceContext>*/(13, 'extSourceContexts', PbFieldType.PM, google$devtools$source$v1.ExtendedSourceContext.$checkItem, google$devtools$source$v1.ExtendedSourceContext.create)
    ..hasRequiredFields = false
  ;

  Debuggee() : super();
  Debuggee.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Debuggee.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Debuggee clone() => new Debuggee()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Debuggee create() => new Debuggee();
  static PbList<Debuggee> createRepeated() => new PbList<Debuggee>();
  static Debuggee getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDebuggee();
    return _defaultInstance;
  }
  static Debuggee _defaultInstance;
  static void $checkItem(Debuggee v) {
    if (v is !Debuggee) checkItemFailed(v, 'Debuggee');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  String get project => $_get(1, 2, '');
  void set project(String v) { $_setString(1, 2, v); }
  bool hasProject() => $_has(1, 2);
  void clearProject() => clearField(2);

  String get uniquifier => $_get(2, 3, '');
  void set uniquifier(String v) { $_setString(2, 3, v); }
  bool hasUniquifier() => $_has(2, 3);
  void clearUniquifier() => clearField(3);

  String get description => $_get(3, 4, '');
  void set description(String v) { $_setString(3, 4, v); }
  bool hasDescription() => $_has(3, 4);
  void clearDescription() => clearField(4);

  bool get isInactive => $_get(4, 5, false);
  void set isInactive(bool v) { $_setBool(4, 5, v); }
  bool hasIsInactive() => $_has(4, 5);
  void clearIsInactive() => clearField(5);

  String get agentVersion => $_get(5, 6, '');
  void set agentVersion(String v) { $_setString(5, 6, v); }
  bool hasAgentVersion() => $_has(5, 6);
  void clearAgentVersion() => clearField(6);

  bool get isDisabled => $_get(6, 7, false);
  void set isDisabled(bool v) { $_setBool(6, 7, v); }
  bool hasIsDisabled() => $_has(6, 7);
  void clearIsDisabled() => clearField(7);

  StatusMessage get status => $_get(7, 8, null);
  void set status(StatusMessage v) { setField(8, v); }
  bool hasStatus() => $_has(7, 8);
  void clearStatus() => clearField(8);

  List<google$devtools$source$v1.SourceContext> get sourceContexts => $_get(8, 9, null);

  List<Debuggee_LabelsEntry> get labels => $_get(9, 11, null);

  List<google$devtools$source$v1.ExtendedSourceContext> get extSourceContexts => $_get(10, 13, null);
}

class _ReadonlyDebuggee extends Debuggee with ReadonlyMessageMixin {}

