///
//  Generated code. Do not modify.
///
library google.genomics.v1_readgroup;

import 'package:protobuf/protobuf.dart';

import '../../protobuf/struct.pb.dart' as google$protobuf;

class ReadGroup_Experiment extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadGroup_Experiment')
    ..a/*<String>*/(1, 'libraryId', PbFieldType.OS)
    ..a/*<String>*/(2, 'platformUnit', PbFieldType.OS)
    ..a/*<String>*/(3, 'sequencingCenter', PbFieldType.OS)
    ..a/*<String>*/(4, 'instrumentModel', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ReadGroup_Experiment() : super();
  ReadGroup_Experiment.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadGroup_Experiment.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadGroup_Experiment clone() => new ReadGroup_Experiment()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadGroup_Experiment create() => new ReadGroup_Experiment();
  static PbList<ReadGroup_Experiment> createRepeated() => new PbList<ReadGroup_Experiment>();
  static ReadGroup_Experiment getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadGroup_Experiment();
    return _defaultInstance;
  }
  static ReadGroup_Experiment _defaultInstance;
  static void $checkItem(ReadGroup_Experiment v) {
    if (v is !ReadGroup_Experiment) checkItemFailed(v, 'ReadGroup_Experiment');
  }

  String get libraryId => $_get(0, 1, '');
  void set libraryId(String v) { $_setString(0, 1, v); }
  bool hasLibraryId() => $_has(0, 1);
  void clearLibraryId() => clearField(1);

  String get platformUnit => $_get(1, 2, '');
  void set platformUnit(String v) { $_setString(1, 2, v); }
  bool hasPlatformUnit() => $_has(1, 2);
  void clearPlatformUnit() => clearField(2);

  String get sequencingCenter => $_get(2, 3, '');
  void set sequencingCenter(String v) { $_setString(2, 3, v); }
  bool hasSequencingCenter() => $_has(2, 3);
  void clearSequencingCenter() => clearField(3);

  String get instrumentModel => $_get(3, 4, '');
  void set instrumentModel(String v) { $_setString(3, 4, v); }
  bool hasInstrumentModel() => $_has(3, 4);
  void clearInstrumentModel() => clearField(4);
}

class _ReadonlyReadGroup_Experiment extends ReadGroup_Experiment with ReadonlyMessageMixin {}

class ReadGroup_Program extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadGroup_Program')
    ..a/*<String>*/(1, 'commandLine', PbFieldType.OS)
    ..a/*<String>*/(2, 'id', PbFieldType.OS)
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..a/*<String>*/(4, 'prevProgramId', PbFieldType.OS)
    ..a/*<String>*/(5, 'version', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ReadGroup_Program() : super();
  ReadGroup_Program.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadGroup_Program.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadGroup_Program clone() => new ReadGroup_Program()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadGroup_Program create() => new ReadGroup_Program();
  static PbList<ReadGroup_Program> createRepeated() => new PbList<ReadGroup_Program>();
  static ReadGroup_Program getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadGroup_Program();
    return _defaultInstance;
  }
  static ReadGroup_Program _defaultInstance;
  static void $checkItem(ReadGroup_Program v) {
    if (v is !ReadGroup_Program) checkItemFailed(v, 'ReadGroup_Program');
  }

  String get commandLine => $_get(0, 1, '');
  void set commandLine(String v) { $_setString(0, 1, v); }
  bool hasCommandLine() => $_has(0, 1);
  void clearCommandLine() => clearField(1);

  String get id => $_get(1, 2, '');
  void set id(String v) { $_setString(1, 2, v); }
  bool hasId() => $_has(1, 2);
  void clearId() => clearField(2);

  String get name => $_get(2, 3, '');
  void set name(String v) { $_setString(2, 3, v); }
  bool hasName() => $_has(2, 3);
  void clearName() => clearField(3);

  String get prevProgramId => $_get(3, 4, '');
  void set prevProgramId(String v) { $_setString(3, 4, v); }
  bool hasPrevProgramId() => $_has(3, 4);
  void clearPrevProgramId() => clearField(4);

  String get version => $_get(4, 5, '');
  void set version(String v) { $_setString(4, 5, v); }
  bool hasVersion() => $_has(4, 5);
  void clearVersion() => clearField(5);
}

class _ReadonlyReadGroup_Program extends ReadGroup_Program with ReadonlyMessageMixin {}

class ReadGroup_InfoEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadGroup_InfoEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<google$protobuf.ListValue>*/(2, 'value', PbFieldType.OM, google$protobuf.ListValue.getDefault, google$protobuf.ListValue.create)
    ..hasRequiredFields = false
  ;

  ReadGroup_InfoEntry() : super();
  ReadGroup_InfoEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadGroup_InfoEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadGroup_InfoEntry clone() => new ReadGroup_InfoEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadGroup_InfoEntry create() => new ReadGroup_InfoEntry();
  static PbList<ReadGroup_InfoEntry> createRepeated() => new PbList<ReadGroup_InfoEntry>();
  static ReadGroup_InfoEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadGroup_InfoEntry();
    return _defaultInstance;
  }
  static ReadGroup_InfoEntry _defaultInstance;
  static void $checkItem(ReadGroup_InfoEntry v) {
    if (v is !ReadGroup_InfoEntry) checkItemFailed(v, 'ReadGroup_InfoEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  google$protobuf.ListValue get value => $_get(1, 2, null);
  void set value(google$protobuf.ListValue v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyReadGroup_InfoEntry extends ReadGroup_InfoEntry with ReadonlyMessageMixin {}

class ReadGroup extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadGroup')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<String>*/(2, 'datasetId', PbFieldType.OS)
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..a/*<String>*/(4, 'description', PbFieldType.OS)
    ..a/*<String>*/(5, 'sampleId', PbFieldType.OS)
    ..a/*<ReadGroup_Experiment>*/(6, 'experiment', PbFieldType.OM, ReadGroup_Experiment.getDefault, ReadGroup_Experiment.create)
    ..a/*<int>*/(7, 'predictedInsertSize', PbFieldType.O3)
    ..pp/*<ReadGroup_Program>*/(10, 'programs', PbFieldType.PM, ReadGroup_Program.$checkItem, ReadGroup_Program.create)
    ..a/*<String>*/(11, 'referenceSetId', PbFieldType.OS)
    ..pp/*<ReadGroup_InfoEntry>*/(12, 'info', PbFieldType.PM, ReadGroup_InfoEntry.$checkItem, ReadGroup_InfoEntry.create)
    ..hasRequiredFields = false
  ;

  ReadGroup() : super();
  ReadGroup.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadGroup.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadGroup clone() => new ReadGroup()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadGroup create() => new ReadGroup();
  static PbList<ReadGroup> createRepeated() => new PbList<ReadGroup>();
  static ReadGroup getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadGroup();
    return _defaultInstance;
  }
  static ReadGroup _defaultInstance;
  static void $checkItem(ReadGroup v) {
    if (v is !ReadGroup) checkItemFailed(v, 'ReadGroup');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  String get datasetId => $_get(1, 2, '');
  void set datasetId(String v) { $_setString(1, 2, v); }
  bool hasDatasetId() => $_has(1, 2);
  void clearDatasetId() => clearField(2);

  String get name => $_get(2, 3, '');
  void set name(String v) { $_setString(2, 3, v); }
  bool hasName() => $_has(2, 3);
  void clearName() => clearField(3);

  String get description => $_get(3, 4, '');
  void set description(String v) { $_setString(3, 4, v); }
  bool hasDescription() => $_has(3, 4);
  void clearDescription() => clearField(4);

  String get sampleId => $_get(4, 5, '');
  void set sampleId(String v) { $_setString(4, 5, v); }
  bool hasSampleId() => $_has(4, 5);
  void clearSampleId() => clearField(5);

  ReadGroup_Experiment get experiment => $_get(5, 6, null);
  void set experiment(ReadGroup_Experiment v) { setField(6, v); }
  bool hasExperiment() => $_has(5, 6);
  void clearExperiment() => clearField(6);

  int get predictedInsertSize => $_get(6, 7, 0);
  void set predictedInsertSize(int v) { $_setUnsignedInt32(6, 7, v); }
  bool hasPredictedInsertSize() => $_has(6, 7);
  void clearPredictedInsertSize() => clearField(7);

  List<ReadGroup_Program> get programs => $_get(7, 10, null);

  String get referenceSetId => $_get(8, 11, '');
  void set referenceSetId(String v) { $_setString(8, 11, v); }
  bool hasReferenceSetId() => $_has(8, 11);
  void clearReferenceSetId() => clearField(11);

  List<ReadGroup_InfoEntry> get info => $_get(9, 12, null);
}

class _ReadonlyReadGroup extends ReadGroup with ReadonlyMessageMixin {}

