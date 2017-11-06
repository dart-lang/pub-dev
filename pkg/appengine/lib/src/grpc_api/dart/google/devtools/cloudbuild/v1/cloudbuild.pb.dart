///
//  Generated code. Do not modify.
///
library google.devtools.cloudbuild.v1_cloudbuild;

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../../protobuf/duration.pb.dart' as google$protobuf;
import '../../../longrunning/operations.pb.dart' as google$longrunning;
import '../../../protobuf/empty.pb.dart' as google$protobuf;

import 'cloudbuild.pbenum.dart';

export 'cloudbuild.pbenum.dart';

class StorageSource extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StorageSource')
    ..a/*<String>*/(1, 'bucket', PbFieldType.OS)
    ..a/*<String>*/(2, 'object', PbFieldType.OS)
    ..a/*<Int64>*/(3, 'generation', PbFieldType.O6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  StorageSource() : super();
  StorageSource.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StorageSource.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StorageSource clone() => new StorageSource()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StorageSource create() => new StorageSource();
  static PbList<StorageSource> createRepeated() => new PbList<StorageSource>();
  static StorageSource getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStorageSource();
    return _defaultInstance;
  }
  static StorageSource _defaultInstance;
  static void $checkItem(StorageSource v) {
    if (v is !StorageSource) checkItemFailed(v, 'StorageSource');
  }

  String get bucket => $_get(0, 1, '');
  void set bucket(String v) { $_setString(0, 1, v); }
  bool hasBucket() => $_has(0, 1);
  void clearBucket() => clearField(1);

  String get object => $_get(1, 2, '');
  void set object(String v) { $_setString(1, 2, v); }
  bool hasObject() => $_has(1, 2);
  void clearObject() => clearField(2);

  Int64 get generation => $_get(2, 3, null);
  void set generation(Int64 v) { $_setInt64(2, 3, v); }
  bool hasGeneration() => $_has(2, 3);
  void clearGeneration() => clearField(3);
}

class _ReadonlyStorageSource extends StorageSource with ReadonlyMessageMixin {}

class RepoSource extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RepoSource')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'repoName', PbFieldType.OS)
    ..a/*<String>*/(3, 'branchName', PbFieldType.OS)
    ..a/*<String>*/(4, 'tagName', PbFieldType.OS)
    ..a/*<String>*/(5, 'commitSha', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  RepoSource() : super();
  RepoSource.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RepoSource.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RepoSource clone() => new RepoSource()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RepoSource create() => new RepoSource();
  static PbList<RepoSource> createRepeated() => new PbList<RepoSource>();
  static RepoSource getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRepoSource();
    return _defaultInstance;
  }
  static RepoSource _defaultInstance;
  static void $checkItem(RepoSource v) {
    if (v is !RepoSource) checkItemFailed(v, 'RepoSource');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get repoName => $_get(1, 2, '');
  void set repoName(String v) { $_setString(1, 2, v); }
  bool hasRepoName() => $_has(1, 2);
  void clearRepoName() => clearField(2);

  String get branchName => $_get(2, 3, '');
  void set branchName(String v) { $_setString(2, 3, v); }
  bool hasBranchName() => $_has(2, 3);
  void clearBranchName() => clearField(3);

  String get tagName => $_get(3, 4, '');
  void set tagName(String v) { $_setString(3, 4, v); }
  bool hasTagName() => $_has(3, 4);
  void clearTagName() => clearField(4);

  String get commitSha => $_get(4, 5, '');
  void set commitSha(String v) { $_setString(4, 5, v); }
  bool hasCommitSha() => $_has(4, 5);
  void clearCommitSha() => clearField(5);
}

class _ReadonlyRepoSource extends RepoSource with ReadonlyMessageMixin {}

class Source extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Source')
    ..a/*<StorageSource>*/(2, 'storageSource', PbFieldType.OM, StorageSource.getDefault, StorageSource.create)
    ..a/*<RepoSource>*/(3, 'repoSource', PbFieldType.OM, RepoSource.getDefault, RepoSource.create)
    ..hasRequiredFields = false
  ;

  Source() : super();
  Source.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Source.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Source clone() => new Source()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Source create() => new Source();
  static PbList<Source> createRepeated() => new PbList<Source>();
  static Source getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySource();
    return _defaultInstance;
  }
  static Source _defaultInstance;
  static void $checkItem(Source v) {
    if (v is !Source) checkItemFailed(v, 'Source');
  }

  StorageSource get storageSource => $_get(0, 2, null);
  void set storageSource(StorageSource v) { setField(2, v); }
  bool hasStorageSource() => $_has(0, 2);
  void clearStorageSource() => clearField(2);

  RepoSource get repoSource => $_get(1, 3, null);
  void set repoSource(RepoSource v) { setField(3, v); }
  bool hasRepoSource() => $_has(1, 3);
  void clearRepoSource() => clearField(3);
}

class _ReadonlySource extends Source with ReadonlyMessageMixin {}

class BuiltImage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BuiltImage')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(3, 'digest', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  BuiltImage() : super();
  BuiltImage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BuiltImage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BuiltImage clone() => new BuiltImage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BuiltImage create() => new BuiltImage();
  static PbList<BuiltImage> createRepeated() => new PbList<BuiltImage>();
  static BuiltImage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBuiltImage();
    return _defaultInstance;
  }
  static BuiltImage _defaultInstance;
  static void $checkItem(BuiltImage v) {
    if (v is !BuiltImage) checkItemFailed(v, 'BuiltImage');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get digest => $_get(1, 3, '');
  void set digest(String v) { $_setString(1, 3, v); }
  bool hasDigest() => $_has(1, 3);
  void clearDigest() => clearField(3);
}

class _ReadonlyBuiltImage extends BuiltImage with ReadonlyMessageMixin {}

class BuildStep extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BuildStep')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..p/*<String>*/(2, 'env', PbFieldType.PS)
    ..p/*<String>*/(3, 'args', PbFieldType.PS)
    ..a/*<String>*/(4, 'dir', PbFieldType.OS)
    ..a/*<String>*/(5, 'id', PbFieldType.OS)
    ..p/*<String>*/(6, 'waitFor', PbFieldType.PS)
    ..a/*<String>*/(7, 'entrypoint', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  BuildStep() : super();
  BuildStep.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BuildStep.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BuildStep clone() => new BuildStep()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BuildStep create() => new BuildStep();
  static PbList<BuildStep> createRepeated() => new PbList<BuildStep>();
  static BuildStep getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBuildStep();
    return _defaultInstance;
  }
  static BuildStep _defaultInstance;
  static void $checkItem(BuildStep v) {
    if (v is !BuildStep) checkItemFailed(v, 'BuildStep');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<String> get env => $_get(1, 2, null);

  List<String> get args => $_get(2, 3, null);

  String get dir => $_get(3, 4, '');
  void set dir(String v) { $_setString(3, 4, v); }
  bool hasDir() => $_has(3, 4);
  void clearDir() => clearField(4);

  String get id => $_get(4, 5, '');
  void set id(String v) { $_setString(4, 5, v); }
  bool hasId() => $_has(4, 5);
  void clearId() => clearField(5);

  List<String> get waitFor => $_get(5, 6, null);

  String get entrypoint => $_get(6, 7, '');
  void set entrypoint(String v) { $_setString(6, 7, v); }
  bool hasEntrypoint() => $_has(6, 7);
  void clearEntrypoint() => clearField(7);
}

class _ReadonlyBuildStep extends BuildStep with ReadonlyMessageMixin {}

class Results extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Results')
    ..pp/*<BuiltImage>*/(2, 'images', PbFieldType.PM, BuiltImage.$checkItem, BuiltImage.create)
    ..p/*<String>*/(3, 'buildStepImages', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  Results() : super();
  Results.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Results.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Results clone() => new Results()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Results create() => new Results();
  static PbList<Results> createRepeated() => new PbList<Results>();
  static Results getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyResults();
    return _defaultInstance;
  }
  static Results _defaultInstance;
  static void $checkItem(Results v) {
    if (v is !Results) checkItemFailed(v, 'Results');
  }

  List<BuiltImage> get images => $_get(0, 2, null);

  List<String> get buildStepImages => $_get(1, 3, null);
}

class _ReadonlyResults extends Results with ReadonlyMessageMixin {}

class Build_SubstitutionsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Build_SubstitutionsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Build_SubstitutionsEntry() : super();
  Build_SubstitutionsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Build_SubstitutionsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Build_SubstitutionsEntry clone() => new Build_SubstitutionsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Build_SubstitutionsEntry create() => new Build_SubstitutionsEntry();
  static PbList<Build_SubstitutionsEntry> createRepeated() => new PbList<Build_SubstitutionsEntry>();
  static Build_SubstitutionsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBuild_SubstitutionsEntry();
    return _defaultInstance;
  }
  static Build_SubstitutionsEntry _defaultInstance;
  static void $checkItem(Build_SubstitutionsEntry v) {
    if (v is !Build_SubstitutionsEntry) checkItemFailed(v, 'Build_SubstitutionsEntry');
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

class _ReadonlyBuild_SubstitutionsEntry extends Build_SubstitutionsEntry with ReadonlyMessageMixin {}

class Build extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Build')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..e/*<Build_Status>*/(2, 'status', PbFieldType.OE, Build_Status.STATUS_UNKNOWN, Build_Status.valueOf)
    ..a/*<Source>*/(3, 'source', PbFieldType.OM, Source.getDefault, Source.create)
    ..a/*<google$protobuf.Timestamp>*/(6, 'createTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(7, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(8, 'finishTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<Results>*/(10, 'results', PbFieldType.OM, Results.getDefault, Results.create)
    ..pp/*<BuildStep>*/(11, 'steps', PbFieldType.PM, BuildStep.$checkItem, BuildStep.create)
    ..a/*<google$protobuf.Duration>*/(12, 'timeout', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..p/*<String>*/(13, 'images', PbFieldType.PS)
    ..a/*<String>*/(16, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(19, 'logsBucket', PbFieldType.OS)
    ..a/*<SourceProvenance>*/(21, 'sourceProvenance', PbFieldType.OM, SourceProvenance.getDefault, SourceProvenance.create)
    ..a/*<String>*/(22, 'buildTriggerId', PbFieldType.OS)
    ..a/*<BuildOptions>*/(23, 'options', PbFieldType.OM, BuildOptions.getDefault, BuildOptions.create)
    ..a/*<String>*/(24, 'statusDetail', PbFieldType.OS)
    ..a/*<String>*/(25, 'logUrl', PbFieldType.OS)
    ..pp/*<Build_SubstitutionsEntry>*/(29, 'substitutions', PbFieldType.PM, Build_SubstitutionsEntry.$checkItem, Build_SubstitutionsEntry.create)
    ..hasRequiredFields = false
  ;

  Build() : super();
  Build.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Build.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Build clone() => new Build()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Build create() => new Build();
  static PbList<Build> createRepeated() => new PbList<Build>();
  static Build getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBuild();
    return _defaultInstance;
  }
  static Build _defaultInstance;
  static void $checkItem(Build v) {
    if (v is !Build) checkItemFailed(v, 'Build');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  Build_Status get status => $_get(1, 2, null);
  void set status(Build_Status v) { setField(2, v); }
  bool hasStatus() => $_has(1, 2);
  void clearStatus() => clearField(2);

  Source get source => $_get(2, 3, null);
  void set source(Source v) { setField(3, v); }
  bool hasSource() => $_has(2, 3);
  void clearSource() => clearField(3);

  google$protobuf.Timestamp get createTime => $_get(3, 6, null);
  void set createTime(google$protobuf.Timestamp v) { setField(6, v); }
  bool hasCreateTime() => $_has(3, 6);
  void clearCreateTime() => clearField(6);

  google$protobuf.Timestamp get startTime => $_get(4, 7, null);
  void set startTime(google$protobuf.Timestamp v) { setField(7, v); }
  bool hasStartTime() => $_has(4, 7);
  void clearStartTime() => clearField(7);

  google$protobuf.Timestamp get finishTime => $_get(5, 8, null);
  void set finishTime(google$protobuf.Timestamp v) { setField(8, v); }
  bool hasFinishTime() => $_has(5, 8);
  void clearFinishTime() => clearField(8);

  Results get results => $_get(6, 10, null);
  void set results(Results v) { setField(10, v); }
  bool hasResults() => $_has(6, 10);
  void clearResults() => clearField(10);

  List<BuildStep> get steps => $_get(7, 11, null);

  google$protobuf.Duration get timeout => $_get(8, 12, null);
  void set timeout(google$protobuf.Duration v) { setField(12, v); }
  bool hasTimeout() => $_has(8, 12);
  void clearTimeout() => clearField(12);

  List<String> get images => $_get(9, 13, null);

  String get projectId => $_get(10, 16, '');
  void set projectId(String v) { $_setString(10, 16, v); }
  bool hasProjectId() => $_has(10, 16);
  void clearProjectId() => clearField(16);

  String get logsBucket => $_get(11, 19, '');
  void set logsBucket(String v) { $_setString(11, 19, v); }
  bool hasLogsBucket() => $_has(11, 19);
  void clearLogsBucket() => clearField(19);

  SourceProvenance get sourceProvenance => $_get(12, 21, null);
  void set sourceProvenance(SourceProvenance v) { setField(21, v); }
  bool hasSourceProvenance() => $_has(12, 21);
  void clearSourceProvenance() => clearField(21);

  String get buildTriggerId => $_get(13, 22, '');
  void set buildTriggerId(String v) { $_setString(13, 22, v); }
  bool hasBuildTriggerId() => $_has(13, 22);
  void clearBuildTriggerId() => clearField(22);

  BuildOptions get options => $_get(14, 23, null);
  void set options(BuildOptions v) { setField(23, v); }
  bool hasOptions() => $_has(14, 23);
  void clearOptions() => clearField(23);

  String get statusDetail => $_get(15, 24, '');
  void set statusDetail(String v) { $_setString(15, 24, v); }
  bool hasStatusDetail() => $_has(15, 24);
  void clearStatusDetail() => clearField(24);

  String get logUrl => $_get(16, 25, '');
  void set logUrl(String v) { $_setString(16, 25, v); }
  bool hasLogUrl() => $_has(16, 25);
  void clearLogUrl() => clearField(25);

  List<Build_SubstitutionsEntry> get substitutions => $_get(17, 29, null);
}

class _ReadonlyBuild extends Build with ReadonlyMessageMixin {}

class BuildOperationMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BuildOperationMetadata')
    ..a/*<Build>*/(1, 'build', PbFieldType.OM, Build.getDefault, Build.create)
    ..hasRequiredFields = false
  ;

  BuildOperationMetadata() : super();
  BuildOperationMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BuildOperationMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BuildOperationMetadata clone() => new BuildOperationMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BuildOperationMetadata create() => new BuildOperationMetadata();
  static PbList<BuildOperationMetadata> createRepeated() => new PbList<BuildOperationMetadata>();
  static BuildOperationMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBuildOperationMetadata();
    return _defaultInstance;
  }
  static BuildOperationMetadata _defaultInstance;
  static void $checkItem(BuildOperationMetadata v) {
    if (v is !BuildOperationMetadata) checkItemFailed(v, 'BuildOperationMetadata');
  }

  Build get build => $_get(0, 1, null);
  void set build(Build v) { setField(1, v); }
  bool hasBuild() => $_has(0, 1);
  void clearBuild() => clearField(1);
}

class _ReadonlyBuildOperationMetadata extends BuildOperationMetadata with ReadonlyMessageMixin {}

class SourceProvenance_FileHashesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SourceProvenance_FileHashesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<FileHashes>*/(2, 'value', PbFieldType.OM, FileHashes.getDefault, FileHashes.create)
    ..hasRequiredFields = false
  ;

  SourceProvenance_FileHashesEntry() : super();
  SourceProvenance_FileHashesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SourceProvenance_FileHashesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SourceProvenance_FileHashesEntry clone() => new SourceProvenance_FileHashesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SourceProvenance_FileHashesEntry create() => new SourceProvenance_FileHashesEntry();
  static PbList<SourceProvenance_FileHashesEntry> createRepeated() => new PbList<SourceProvenance_FileHashesEntry>();
  static SourceProvenance_FileHashesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySourceProvenance_FileHashesEntry();
    return _defaultInstance;
  }
  static SourceProvenance_FileHashesEntry _defaultInstance;
  static void $checkItem(SourceProvenance_FileHashesEntry v) {
    if (v is !SourceProvenance_FileHashesEntry) checkItemFailed(v, 'SourceProvenance_FileHashesEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  FileHashes get value => $_get(1, 2, null);
  void set value(FileHashes v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlySourceProvenance_FileHashesEntry extends SourceProvenance_FileHashesEntry with ReadonlyMessageMixin {}

class SourceProvenance extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SourceProvenance')
    ..a/*<StorageSource>*/(3, 'resolvedStorageSource', PbFieldType.OM, StorageSource.getDefault, StorageSource.create)
    ..pp/*<SourceProvenance_FileHashesEntry>*/(4, 'fileHashes', PbFieldType.PM, SourceProvenance_FileHashesEntry.$checkItem, SourceProvenance_FileHashesEntry.create)
    ..a/*<RepoSource>*/(6, 'resolvedRepoSource', PbFieldType.OM, RepoSource.getDefault, RepoSource.create)
    ..hasRequiredFields = false
  ;

  SourceProvenance() : super();
  SourceProvenance.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SourceProvenance.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SourceProvenance clone() => new SourceProvenance()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SourceProvenance create() => new SourceProvenance();
  static PbList<SourceProvenance> createRepeated() => new PbList<SourceProvenance>();
  static SourceProvenance getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySourceProvenance();
    return _defaultInstance;
  }
  static SourceProvenance _defaultInstance;
  static void $checkItem(SourceProvenance v) {
    if (v is !SourceProvenance) checkItemFailed(v, 'SourceProvenance');
  }

  StorageSource get resolvedStorageSource => $_get(0, 3, null);
  void set resolvedStorageSource(StorageSource v) { setField(3, v); }
  bool hasResolvedStorageSource() => $_has(0, 3);
  void clearResolvedStorageSource() => clearField(3);

  List<SourceProvenance_FileHashesEntry> get fileHashes => $_get(1, 4, null);

  RepoSource get resolvedRepoSource => $_get(2, 6, null);
  void set resolvedRepoSource(RepoSource v) { setField(6, v); }
  bool hasResolvedRepoSource() => $_has(2, 6);
  void clearResolvedRepoSource() => clearField(6);
}

class _ReadonlySourceProvenance extends SourceProvenance with ReadonlyMessageMixin {}

class FileHashes extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('FileHashes')
    ..pp/*<Hash>*/(1, 'fileHash', PbFieldType.PM, Hash.$checkItem, Hash.create)
    ..hasRequiredFields = false
  ;

  FileHashes() : super();
  FileHashes.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  FileHashes.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  FileHashes clone() => new FileHashes()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static FileHashes create() => new FileHashes();
  static PbList<FileHashes> createRepeated() => new PbList<FileHashes>();
  static FileHashes getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyFileHashes();
    return _defaultInstance;
  }
  static FileHashes _defaultInstance;
  static void $checkItem(FileHashes v) {
    if (v is !FileHashes) checkItemFailed(v, 'FileHashes');
  }

  List<Hash> get fileHash => $_get(0, 1, null);
}

class _ReadonlyFileHashes extends FileHashes with ReadonlyMessageMixin {}

class Hash extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Hash')
    ..e/*<Hash_HashType>*/(1, 'type', PbFieldType.OE, Hash_HashType.NONE, Hash_HashType.valueOf)
    ..a/*<List<int>>*/(2, 'value', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Hash() : super();
  Hash.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Hash.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Hash clone() => new Hash()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Hash create() => new Hash();
  static PbList<Hash> createRepeated() => new PbList<Hash>();
  static Hash getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHash();
    return _defaultInstance;
  }
  static Hash _defaultInstance;
  static void $checkItem(Hash v) {
    if (v is !Hash) checkItemFailed(v, 'Hash');
  }

  Hash_HashType get type => $_get(0, 1, null);
  void set type(Hash_HashType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  List<int> get value => $_get(1, 2, null);
  void set value(List<int> v) { $_setBytes(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyHash extends Hash with ReadonlyMessageMixin {}

class CreateBuildRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateBuildRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<Build>*/(2, 'build', PbFieldType.OM, Build.getDefault, Build.create)
    ..hasRequiredFields = false
  ;

  CreateBuildRequest() : super();
  CreateBuildRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateBuildRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateBuildRequest clone() => new CreateBuildRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateBuildRequest create() => new CreateBuildRequest();
  static PbList<CreateBuildRequest> createRepeated() => new PbList<CreateBuildRequest>();
  static CreateBuildRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateBuildRequest();
    return _defaultInstance;
  }
  static CreateBuildRequest _defaultInstance;
  static void $checkItem(CreateBuildRequest v) {
    if (v is !CreateBuildRequest) checkItemFailed(v, 'CreateBuildRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  Build get build => $_get(1, 2, null);
  void set build(Build v) { setField(2, v); }
  bool hasBuild() => $_has(1, 2);
  void clearBuild() => clearField(2);
}

class _ReadonlyCreateBuildRequest extends CreateBuildRequest with ReadonlyMessageMixin {}

class GetBuildRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetBuildRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'id', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetBuildRequest() : super();
  GetBuildRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetBuildRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetBuildRequest clone() => new GetBuildRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetBuildRequest create() => new GetBuildRequest();
  static PbList<GetBuildRequest> createRepeated() => new PbList<GetBuildRequest>();
  static GetBuildRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetBuildRequest();
    return _defaultInstance;
  }
  static GetBuildRequest _defaultInstance;
  static void $checkItem(GetBuildRequest v) {
    if (v is !GetBuildRequest) checkItemFailed(v, 'GetBuildRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get id => $_get(1, 2, '');
  void set id(String v) { $_setString(1, 2, v); }
  bool hasId() => $_has(1, 2);
  void clearId() => clearField(2);
}

class _ReadonlyGetBuildRequest extends GetBuildRequest with ReadonlyMessageMixin {}

class ListBuildsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBuildsRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..a/*<String>*/(8, 'filter', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListBuildsRequest() : super();
  ListBuildsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBuildsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBuildsRequest clone() => new ListBuildsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBuildsRequest create() => new ListBuildsRequest();
  static PbList<ListBuildsRequest> createRepeated() => new PbList<ListBuildsRequest>();
  static ListBuildsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBuildsRequest();
    return _defaultInstance;
  }
  static ListBuildsRequest _defaultInstance;
  static void $checkItem(ListBuildsRequest v) {
    if (v is !ListBuildsRequest) checkItemFailed(v, 'ListBuildsRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);

  String get filter => $_get(3, 8, '');
  void set filter(String v) { $_setString(3, 8, v); }
  bool hasFilter() => $_has(3, 8);
  void clearFilter() => clearField(8);
}

class _ReadonlyListBuildsRequest extends ListBuildsRequest with ReadonlyMessageMixin {}

class ListBuildsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBuildsResponse')
    ..pp/*<Build>*/(1, 'builds', PbFieldType.PM, Build.$checkItem, Build.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListBuildsResponse() : super();
  ListBuildsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBuildsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBuildsResponse clone() => new ListBuildsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBuildsResponse create() => new ListBuildsResponse();
  static PbList<ListBuildsResponse> createRepeated() => new PbList<ListBuildsResponse>();
  static ListBuildsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBuildsResponse();
    return _defaultInstance;
  }
  static ListBuildsResponse _defaultInstance;
  static void $checkItem(ListBuildsResponse v) {
    if (v is !ListBuildsResponse) checkItemFailed(v, 'ListBuildsResponse');
  }

  List<Build> get builds => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListBuildsResponse extends ListBuildsResponse with ReadonlyMessageMixin {}

class CancelBuildRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CancelBuildRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'id', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CancelBuildRequest() : super();
  CancelBuildRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CancelBuildRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CancelBuildRequest clone() => new CancelBuildRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CancelBuildRequest create() => new CancelBuildRequest();
  static PbList<CancelBuildRequest> createRepeated() => new PbList<CancelBuildRequest>();
  static CancelBuildRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCancelBuildRequest();
    return _defaultInstance;
  }
  static CancelBuildRequest _defaultInstance;
  static void $checkItem(CancelBuildRequest v) {
    if (v is !CancelBuildRequest) checkItemFailed(v, 'CancelBuildRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get id => $_get(1, 2, '');
  void set id(String v) { $_setString(1, 2, v); }
  bool hasId() => $_has(1, 2);
  void clearId() => clearField(2);
}

class _ReadonlyCancelBuildRequest extends CancelBuildRequest with ReadonlyMessageMixin {}

class BuildTrigger_SubstitutionsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BuildTrigger_SubstitutionsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  BuildTrigger_SubstitutionsEntry() : super();
  BuildTrigger_SubstitutionsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BuildTrigger_SubstitutionsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BuildTrigger_SubstitutionsEntry clone() => new BuildTrigger_SubstitutionsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BuildTrigger_SubstitutionsEntry create() => new BuildTrigger_SubstitutionsEntry();
  static PbList<BuildTrigger_SubstitutionsEntry> createRepeated() => new PbList<BuildTrigger_SubstitutionsEntry>();
  static BuildTrigger_SubstitutionsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBuildTrigger_SubstitutionsEntry();
    return _defaultInstance;
  }
  static BuildTrigger_SubstitutionsEntry _defaultInstance;
  static void $checkItem(BuildTrigger_SubstitutionsEntry v) {
    if (v is !BuildTrigger_SubstitutionsEntry) checkItemFailed(v, 'BuildTrigger_SubstitutionsEntry');
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

class _ReadonlyBuildTrigger_SubstitutionsEntry extends BuildTrigger_SubstitutionsEntry with ReadonlyMessageMixin {}

class BuildTrigger extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BuildTrigger')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<Build>*/(4, 'build', PbFieldType.OM, Build.getDefault, Build.create)
    ..a/*<google$protobuf.Timestamp>*/(5, 'createTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<RepoSource>*/(7, 'triggerTemplate', PbFieldType.OM, RepoSource.getDefault, RepoSource.create)
    ..a/*<String>*/(8, 'filename', PbFieldType.OS)
    ..a/*<bool>*/(9, 'disabled', PbFieldType.OB)
    ..a/*<String>*/(10, 'description', PbFieldType.OS)
    ..pp/*<BuildTrigger_SubstitutionsEntry>*/(11, 'substitutions', PbFieldType.PM, BuildTrigger_SubstitutionsEntry.$checkItem, BuildTrigger_SubstitutionsEntry.create)
    ..hasRequiredFields = false
  ;

  BuildTrigger() : super();
  BuildTrigger.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BuildTrigger.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BuildTrigger clone() => new BuildTrigger()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BuildTrigger create() => new BuildTrigger();
  static PbList<BuildTrigger> createRepeated() => new PbList<BuildTrigger>();
  static BuildTrigger getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBuildTrigger();
    return _defaultInstance;
  }
  static BuildTrigger _defaultInstance;
  static void $checkItem(BuildTrigger v) {
    if (v is !BuildTrigger) checkItemFailed(v, 'BuildTrigger');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  Build get build => $_get(1, 4, null);
  void set build(Build v) { setField(4, v); }
  bool hasBuild() => $_has(1, 4);
  void clearBuild() => clearField(4);

  google$protobuf.Timestamp get createTime => $_get(2, 5, null);
  void set createTime(google$protobuf.Timestamp v) { setField(5, v); }
  bool hasCreateTime() => $_has(2, 5);
  void clearCreateTime() => clearField(5);

  RepoSource get triggerTemplate => $_get(3, 7, null);
  void set triggerTemplate(RepoSource v) { setField(7, v); }
  bool hasTriggerTemplate() => $_has(3, 7);
  void clearTriggerTemplate() => clearField(7);

  String get filename => $_get(4, 8, '');
  void set filename(String v) { $_setString(4, 8, v); }
  bool hasFilename() => $_has(4, 8);
  void clearFilename() => clearField(8);

  bool get disabled => $_get(5, 9, false);
  void set disabled(bool v) { $_setBool(5, 9, v); }
  bool hasDisabled() => $_has(5, 9);
  void clearDisabled() => clearField(9);

  String get description => $_get(6, 10, '');
  void set description(String v) { $_setString(6, 10, v); }
  bool hasDescription() => $_has(6, 10);
  void clearDescription() => clearField(10);

  List<BuildTrigger_SubstitutionsEntry> get substitutions => $_get(7, 11, null);
}

class _ReadonlyBuildTrigger extends BuildTrigger with ReadonlyMessageMixin {}

class CreateBuildTriggerRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateBuildTriggerRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<BuildTrigger>*/(2, 'trigger', PbFieldType.OM, BuildTrigger.getDefault, BuildTrigger.create)
    ..hasRequiredFields = false
  ;

  CreateBuildTriggerRequest() : super();
  CreateBuildTriggerRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateBuildTriggerRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateBuildTriggerRequest clone() => new CreateBuildTriggerRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateBuildTriggerRequest create() => new CreateBuildTriggerRequest();
  static PbList<CreateBuildTriggerRequest> createRepeated() => new PbList<CreateBuildTriggerRequest>();
  static CreateBuildTriggerRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateBuildTriggerRequest();
    return _defaultInstance;
  }
  static CreateBuildTriggerRequest _defaultInstance;
  static void $checkItem(CreateBuildTriggerRequest v) {
    if (v is !CreateBuildTriggerRequest) checkItemFailed(v, 'CreateBuildTriggerRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  BuildTrigger get trigger => $_get(1, 2, null);
  void set trigger(BuildTrigger v) { setField(2, v); }
  bool hasTrigger() => $_has(1, 2);
  void clearTrigger() => clearField(2);
}

class _ReadonlyCreateBuildTriggerRequest extends CreateBuildTriggerRequest with ReadonlyMessageMixin {}

class GetBuildTriggerRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetBuildTriggerRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'triggerId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetBuildTriggerRequest() : super();
  GetBuildTriggerRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetBuildTriggerRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetBuildTriggerRequest clone() => new GetBuildTriggerRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetBuildTriggerRequest create() => new GetBuildTriggerRequest();
  static PbList<GetBuildTriggerRequest> createRepeated() => new PbList<GetBuildTriggerRequest>();
  static GetBuildTriggerRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetBuildTriggerRequest();
    return _defaultInstance;
  }
  static GetBuildTriggerRequest _defaultInstance;
  static void $checkItem(GetBuildTriggerRequest v) {
    if (v is !GetBuildTriggerRequest) checkItemFailed(v, 'GetBuildTriggerRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get triggerId => $_get(1, 2, '');
  void set triggerId(String v) { $_setString(1, 2, v); }
  bool hasTriggerId() => $_has(1, 2);
  void clearTriggerId() => clearField(2);
}

class _ReadonlyGetBuildTriggerRequest extends GetBuildTriggerRequest with ReadonlyMessageMixin {}

class ListBuildTriggersRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBuildTriggersRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListBuildTriggersRequest() : super();
  ListBuildTriggersRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBuildTriggersRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBuildTriggersRequest clone() => new ListBuildTriggersRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBuildTriggersRequest create() => new ListBuildTriggersRequest();
  static PbList<ListBuildTriggersRequest> createRepeated() => new PbList<ListBuildTriggersRequest>();
  static ListBuildTriggersRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBuildTriggersRequest();
    return _defaultInstance;
  }
  static ListBuildTriggersRequest _defaultInstance;
  static void $checkItem(ListBuildTriggersRequest v) {
    if (v is !ListBuildTriggersRequest) checkItemFailed(v, 'ListBuildTriggersRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);
}

class _ReadonlyListBuildTriggersRequest extends ListBuildTriggersRequest with ReadonlyMessageMixin {}

class ListBuildTriggersResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBuildTriggersResponse')
    ..pp/*<BuildTrigger>*/(1, 'triggers', PbFieldType.PM, BuildTrigger.$checkItem, BuildTrigger.create)
    ..hasRequiredFields = false
  ;

  ListBuildTriggersResponse() : super();
  ListBuildTriggersResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBuildTriggersResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBuildTriggersResponse clone() => new ListBuildTriggersResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBuildTriggersResponse create() => new ListBuildTriggersResponse();
  static PbList<ListBuildTriggersResponse> createRepeated() => new PbList<ListBuildTriggersResponse>();
  static ListBuildTriggersResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBuildTriggersResponse();
    return _defaultInstance;
  }
  static ListBuildTriggersResponse _defaultInstance;
  static void $checkItem(ListBuildTriggersResponse v) {
    if (v is !ListBuildTriggersResponse) checkItemFailed(v, 'ListBuildTriggersResponse');
  }

  List<BuildTrigger> get triggers => $_get(0, 1, null);
}

class _ReadonlyListBuildTriggersResponse extends ListBuildTriggersResponse with ReadonlyMessageMixin {}

class DeleteBuildTriggerRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteBuildTriggerRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'triggerId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteBuildTriggerRequest() : super();
  DeleteBuildTriggerRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteBuildTriggerRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteBuildTriggerRequest clone() => new DeleteBuildTriggerRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteBuildTriggerRequest create() => new DeleteBuildTriggerRequest();
  static PbList<DeleteBuildTriggerRequest> createRepeated() => new PbList<DeleteBuildTriggerRequest>();
  static DeleteBuildTriggerRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteBuildTriggerRequest();
    return _defaultInstance;
  }
  static DeleteBuildTriggerRequest _defaultInstance;
  static void $checkItem(DeleteBuildTriggerRequest v) {
    if (v is !DeleteBuildTriggerRequest) checkItemFailed(v, 'DeleteBuildTriggerRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get triggerId => $_get(1, 2, '');
  void set triggerId(String v) { $_setString(1, 2, v); }
  bool hasTriggerId() => $_has(1, 2);
  void clearTriggerId() => clearField(2);
}

class _ReadonlyDeleteBuildTriggerRequest extends DeleteBuildTriggerRequest with ReadonlyMessageMixin {}

class UpdateBuildTriggerRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateBuildTriggerRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'triggerId', PbFieldType.OS)
    ..a/*<BuildTrigger>*/(3, 'trigger', PbFieldType.OM, BuildTrigger.getDefault, BuildTrigger.create)
    ..hasRequiredFields = false
  ;

  UpdateBuildTriggerRequest() : super();
  UpdateBuildTriggerRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateBuildTriggerRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateBuildTriggerRequest clone() => new UpdateBuildTriggerRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateBuildTriggerRequest create() => new UpdateBuildTriggerRequest();
  static PbList<UpdateBuildTriggerRequest> createRepeated() => new PbList<UpdateBuildTriggerRequest>();
  static UpdateBuildTriggerRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateBuildTriggerRequest();
    return _defaultInstance;
  }
  static UpdateBuildTriggerRequest _defaultInstance;
  static void $checkItem(UpdateBuildTriggerRequest v) {
    if (v is !UpdateBuildTriggerRequest) checkItemFailed(v, 'UpdateBuildTriggerRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get triggerId => $_get(1, 2, '');
  void set triggerId(String v) { $_setString(1, 2, v); }
  bool hasTriggerId() => $_has(1, 2);
  void clearTriggerId() => clearField(2);

  BuildTrigger get trigger => $_get(2, 3, null);
  void set trigger(BuildTrigger v) { setField(3, v); }
  bool hasTrigger() => $_has(2, 3);
  void clearTrigger() => clearField(3);
}

class _ReadonlyUpdateBuildTriggerRequest extends UpdateBuildTriggerRequest with ReadonlyMessageMixin {}

class BuildOptions extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BuildOptions')
    ..pp/*<Hash_HashType>*/(1, 'sourceProvenanceHash', PbFieldType.PE, Hash_HashType.$checkItem, null, Hash_HashType.valueOf)
    ..e/*<BuildOptions_VerifyOption>*/(2, 'requestedVerifyOption', PbFieldType.OE, BuildOptions_VerifyOption.NOT_VERIFIED, BuildOptions_VerifyOption.valueOf)
    ..hasRequiredFields = false
  ;

  BuildOptions() : super();
  BuildOptions.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BuildOptions.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BuildOptions clone() => new BuildOptions()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BuildOptions create() => new BuildOptions();
  static PbList<BuildOptions> createRepeated() => new PbList<BuildOptions>();
  static BuildOptions getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBuildOptions();
    return _defaultInstance;
  }
  static BuildOptions _defaultInstance;
  static void $checkItem(BuildOptions v) {
    if (v is !BuildOptions) checkItemFailed(v, 'BuildOptions');
  }

  List<Hash_HashType> get sourceProvenanceHash => $_get(0, 1, null);

  BuildOptions_VerifyOption get requestedVerifyOption => $_get(1, 2, null);
  void set requestedVerifyOption(BuildOptions_VerifyOption v) { setField(2, v); }
  bool hasRequestedVerifyOption() => $_has(1, 2);
  void clearRequestedVerifyOption() => clearField(2);
}

class _ReadonlyBuildOptions extends BuildOptions with ReadonlyMessageMixin {}

class CloudBuildApi {
  RpcClient _client;
  CloudBuildApi(this._client);

  Future<google$longrunning.Operation> createBuild(ClientContext ctx, CreateBuildRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'CloudBuild', 'CreateBuild', request, emptyResponse);
  }
  Future<Build> getBuild(ClientContext ctx, GetBuildRequest request) {
    var emptyResponse = new Build();
    return _client.invoke(ctx, 'CloudBuild', 'GetBuild', request, emptyResponse);
  }
  Future<ListBuildsResponse> listBuilds(ClientContext ctx, ListBuildsRequest request) {
    var emptyResponse = new ListBuildsResponse();
    return _client.invoke(ctx, 'CloudBuild', 'ListBuilds', request, emptyResponse);
  }
  Future<Build> cancelBuild(ClientContext ctx, CancelBuildRequest request) {
    var emptyResponse = new Build();
    return _client.invoke(ctx, 'CloudBuild', 'CancelBuild', request, emptyResponse);
  }
  Future<BuildTrigger> createBuildTrigger(ClientContext ctx, CreateBuildTriggerRequest request) {
    var emptyResponse = new BuildTrigger();
    return _client.invoke(ctx, 'CloudBuild', 'CreateBuildTrigger', request, emptyResponse);
  }
  Future<BuildTrigger> getBuildTrigger(ClientContext ctx, GetBuildTriggerRequest request) {
    var emptyResponse = new BuildTrigger();
    return _client.invoke(ctx, 'CloudBuild', 'GetBuildTrigger', request, emptyResponse);
  }
  Future<ListBuildTriggersResponse> listBuildTriggers(ClientContext ctx, ListBuildTriggersRequest request) {
    var emptyResponse = new ListBuildTriggersResponse();
    return _client.invoke(ctx, 'CloudBuild', 'ListBuildTriggers', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteBuildTrigger(ClientContext ctx, DeleteBuildTriggerRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'CloudBuild', 'DeleteBuildTrigger', request, emptyResponse);
  }
  Future<BuildTrigger> updateBuildTrigger(ClientContext ctx, UpdateBuildTriggerRequest request) {
    var emptyResponse = new BuildTrigger();
    return _client.invoke(ctx, 'CloudBuild', 'UpdateBuildTrigger', request, emptyResponse);
  }
}

