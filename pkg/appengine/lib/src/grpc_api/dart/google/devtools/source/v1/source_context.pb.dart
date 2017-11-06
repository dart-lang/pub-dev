///
//  Generated code. Do not modify.
///
library google.devtools.source.v1_source_context;

import 'package:protobuf/protobuf.dart';

import 'source_context.pbenum.dart';

export 'source_context.pbenum.dart';

class SourceContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SourceContext')
    ..a/*<CloudRepoSourceContext>*/(1, 'cloudRepo', PbFieldType.OM, CloudRepoSourceContext.getDefault, CloudRepoSourceContext.create)
    ..a/*<CloudWorkspaceSourceContext>*/(2, 'cloudWorkspace', PbFieldType.OM, CloudWorkspaceSourceContext.getDefault, CloudWorkspaceSourceContext.create)
    ..a/*<GerritSourceContext>*/(3, 'gerrit', PbFieldType.OM, GerritSourceContext.getDefault, GerritSourceContext.create)
    ..a/*<GitSourceContext>*/(6, 'git', PbFieldType.OM, GitSourceContext.getDefault, GitSourceContext.create)
    ..hasRequiredFields = false
  ;

  SourceContext() : super();
  SourceContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SourceContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SourceContext clone() => new SourceContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SourceContext create() => new SourceContext();
  static PbList<SourceContext> createRepeated() => new PbList<SourceContext>();
  static SourceContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySourceContext();
    return _defaultInstance;
  }
  static SourceContext _defaultInstance;
  static void $checkItem(SourceContext v) {
    if (v is !SourceContext) checkItemFailed(v, 'SourceContext');
  }

  CloudRepoSourceContext get cloudRepo => $_get(0, 1, null);
  void set cloudRepo(CloudRepoSourceContext v) { setField(1, v); }
  bool hasCloudRepo() => $_has(0, 1);
  void clearCloudRepo() => clearField(1);

  CloudWorkspaceSourceContext get cloudWorkspace => $_get(1, 2, null);
  void set cloudWorkspace(CloudWorkspaceSourceContext v) { setField(2, v); }
  bool hasCloudWorkspace() => $_has(1, 2);
  void clearCloudWorkspace() => clearField(2);

  GerritSourceContext get gerrit => $_get(2, 3, null);
  void set gerrit(GerritSourceContext v) { setField(3, v); }
  bool hasGerrit() => $_has(2, 3);
  void clearGerrit() => clearField(3);

  GitSourceContext get git => $_get(3, 6, null);
  void set git(GitSourceContext v) { setField(6, v); }
  bool hasGit() => $_has(3, 6);
  void clearGit() => clearField(6);
}

class _ReadonlySourceContext extends SourceContext with ReadonlyMessageMixin {}

class ExtendedSourceContext_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ExtendedSourceContext_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ExtendedSourceContext_LabelsEntry() : super();
  ExtendedSourceContext_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ExtendedSourceContext_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ExtendedSourceContext_LabelsEntry clone() => new ExtendedSourceContext_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ExtendedSourceContext_LabelsEntry create() => new ExtendedSourceContext_LabelsEntry();
  static PbList<ExtendedSourceContext_LabelsEntry> createRepeated() => new PbList<ExtendedSourceContext_LabelsEntry>();
  static ExtendedSourceContext_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyExtendedSourceContext_LabelsEntry();
    return _defaultInstance;
  }
  static ExtendedSourceContext_LabelsEntry _defaultInstance;
  static void $checkItem(ExtendedSourceContext_LabelsEntry v) {
    if (v is !ExtendedSourceContext_LabelsEntry) checkItemFailed(v, 'ExtendedSourceContext_LabelsEntry');
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

class _ReadonlyExtendedSourceContext_LabelsEntry extends ExtendedSourceContext_LabelsEntry with ReadonlyMessageMixin {}

class ExtendedSourceContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ExtendedSourceContext')
    ..a/*<SourceContext>*/(1, 'context', PbFieldType.OM, SourceContext.getDefault, SourceContext.create)
    ..pp/*<ExtendedSourceContext_LabelsEntry>*/(2, 'labels', PbFieldType.PM, ExtendedSourceContext_LabelsEntry.$checkItem, ExtendedSourceContext_LabelsEntry.create)
    ..hasRequiredFields = false
  ;

  ExtendedSourceContext() : super();
  ExtendedSourceContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ExtendedSourceContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ExtendedSourceContext clone() => new ExtendedSourceContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ExtendedSourceContext create() => new ExtendedSourceContext();
  static PbList<ExtendedSourceContext> createRepeated() => new PbList<ExtendedSourceContext>();
  static ExtendedSourceContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyExtendedSourceContext();
    return _defaultInstance;
  }
  static ExtendedSourceContext _defaultInstance;
  static void $checkItem(ExtendedSourceContext v) {
    if (v is !ExtendedSourceContext) checkItemFailed(v, 'ExtendedSourceContext');
  }

  SourceContext get context => $_get(0, 1, null);
  void set context(SourceContext v) { setField(1, v); }
  bool hasContext() => $_has(0, 1);
  void clearContext() => clearField(1);

  List<ExtendedSourceContext_LabelsEntry> get labels => $_get(1, 2, null);
}

class _ReadonlyExtendedSourceContext extends ExtendedSourceContext with ReadonlyMessageMixin {}

class AliasContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AliasContext')
    ..e/*<AliasContext_Kind>*/(1, 'kind', PbFieldType.OE, AliasContext_Kind.ANY, AliasContext_Kind.valueOf)
    ..a/*<String>*/(2, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AliasContext() : super();
  AliasContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AliasContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AliasContext clone() => new AliasContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AliasContext create() => new AliasContext();
  static PbList<AliasContext> createRepeated() => new PbList<AliasContext>();
  static AliasContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAliasContext();
    return _defaultInstance;
  }
  static AliasContext _defaultInstance;
  static void $checkItem(AliasContext v) {
    if (v is !AliasContext) checkItemFailed(v, 'AliasContext');
  }

  AliasContext_Kind get kind => $_get(0, 1, null);
  void set kind(AliasContext_Kind v) { setField(1, v); }
  bool hasKind() => $_has(0, 1);
  void clearKind() => clearField(1);

  String get name => $_get(1, 2, '');
  void set name(String v) { $_setString(1, 2, v); }
  bool hasName() => $_has(1, 2);
  void clearName() => clearField(2);
}

class _ReadonlyAliasContext extends AliasContext with ReadonlyMessageMixin {}

class CloudRepoSourceContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CloudRepoSourceContext')
    ..a/*<RepoId>*/(1, 'repoId', PbFieldType.OM, RepoId.getDefault, RepoId.create)
    ..a/*<String>*/(2, 'revisionId', PbFieldType.OS)
    ..a/*<String>*/(3, 'aliasName', PbFieldType.OS)
    ..a/*<AliasContext>*/(4, 'aliasContext', PbFieldType.OM, AliasContext.getDefault, AliasContext.create)
    ..hasRequiredFields = false
  ;

  CloudRepoSourceContext() : super();
  CloudRepoSourceContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CloudRepoSourceContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CloudRepoSourceContext clone() => new CloudRepoSourceContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CloudRepoSourceContext create() => new CloudRepoSourceContext();
  static PbList<CloudRepoSourceContext> createRepeated() => new PbList<CloudRepoSourceContext>();
  static CloudRepoSourceContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCloudRepoSourceContext();
    return _defaultInstance;
  }
  static CloudRepoSourceContext _defaultInstance;
  static void $checkItem(CloudRepoSourceContext v) {
    if (v is !CloudRepoSourceContext) checkItemFailed(v, 'CloudRepoSourceContext');
  }

  RepoId get repoId => $_get(0, 1, null);
  void set repoId(RepoId v) { setField(1, v); }
  bool hasRepoId() => $_has(0, 1);
  void clearRepoId() => clearField(1);

  String get revisionId => $_get(1, 2, '');
  void set revisionId(String v) { $_setString(1, 2, v); }
  bool hasRevisionId() => $_has(1, 2);
  void clearRevisionId() => clearField(2);

  String get aliasName => $_get(2, 3, '');
  void set aliasName(String v) { $_setString(2, 3, v); }
  bool hasAliasName() => $_has(2, 3);
  void clearAliasName() => clearField(3);

  AliasContext get aliasContext => $_get(3, 4, null);
  void set aliasContext(AliasContext v) { setField(4, v); }
  bool hasAliasContext() => $_has(3, 4);
  void clearAliasContext() => clearField(4);
}

class _ReadonlyCloudRepoSourceContext extends CloudRepoSourceContext with ReadonlyMessageMixin {}

class CloudWorkspaceSourceContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CloudWorkspaceSourceContext')
    ..a/*<CloudWorkspaceId>*/(1, 'workspaceId', PbFieldType.OM, CloudWorkspaceId.getDefault, CloudWorkspaceId.create)
    ..a/*<String>*/(2, 'snapshotId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CloudWorkspaceSourceContext() : super();
  CloudWorkspaceSourceContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CloudWorkspaceSourceContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CloudWorkspaceSourceContext clone() => new CloudWorkspaceSourceContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CloudWorkspaceSourceContext create() => new CloudWorkspaceSourceContext();
  static PbList<CloudWorkspaceSourceContext> createRepeated() => new PbList<CloudWorkspaceSourceContext>();
  static CloudWorkspaceSourceContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCloudWorkspaceSourceContext();
    return _defaultInstance;
  }
  static CloudWorkspaceSourceContext _defaultInstance;
  static void $checkItem(CloudWorkspaceSourceContext v) {
    if (v is !CloudWorkspaceSourceContext) checkItemFailed(v, 'CloudWorkspaceSourceContext');
  }

  CloudWorkspaceId get workspaceId => $_get(0, 1, null);
  void set workspaceId(CloudWorkspaceId v) { setField(1, v); }
  bool hasWorkspaceId() => $_has(0, 1);
  void clearWorkspaceId() => clearField(1);

  String get snapshotId => $_get(1, 2, '');
  void set snapshotId(String v) { $_setString(1, 2, v); }
  bool hasSnapshotId() => $_has(1, 2);
  void clearSnapshotId() => clearField(2);
}

class _ReadonlyCloudWorkspaceSourceContext extends CloudWorkspaceSourceContext with ReadonlyMessageMixin {}

class GerritSourceContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GerritSourceContext')
    ..a/*<String>*/(1, 'hostUri', PbFieldType.OS)
    ..a/*<String>*/(2, 'gerritProject', PbFieldType.OS)
    ..a/*<String>*/(3, 'revisionId', PbFieldType.OS)
    ..a/*<String>*/(4, 'aliasName', PbFieldType.OS)
    ..a/*<AliasContext>*/(5, 'aliasContext', PbFieldType.OM, AliasContext.getDefault, AliasContext.create)
    ..hasRequiredFields = false
  ;

  GerritSourceContext() : super();
  GerritSourceContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GerritSourceContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GerritSourceContext clone() => new GerritSourceContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GerritSourceContext create() => new GerritSourceContext();
  static PbList<GerritSourceContext> createRepeated() => new PbList<GerritSourceContext>();
  static GerritSourceContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGerritSourceContext();
    return _defaultInstance;
  }
  static GerritSourceContext _defaultInstance;
  static void $checkItem(GerritSourceContext v) {
    if (v is !GerritSourceContext) checkItemFailed(v, 'GerritSourceContext');
  }

  String get hostUri => $_get(0, 1, '');
  void set hostUri(String v) { $_setString(0, 1, v); }
  bool hasHostUri() => $_has(0, 1);
  void clearHostUri() => clearField(1);

  String get gerritProject => $_get(1, 2, '');
  void set gerritProject(String v) { $_setString(1, 2, v); }
  bool hasGerritProject() => $_has(1, 2);
  void clearGerritProject() => clearField(2);

  String get revisionId => $_get(2, 3, '');
  void set revisionId(String v) { $_setString(2, 3, v); }
  bool hasRevisionId() => $_has(2, 3);
  void clearRevisionId() => clearField(3);

  String get aliasName => $_get(3, 4, '');
  void set aliasName(String v) { $_setString(3, 4, v); }
  bool hasAliasName() => $_has(3, 4);
  void clearAliasName() => clearField(4);

  AliasContext get aliasContext => $_get(4, 5, null);
  void set aliasContext(AliasContext v) { setField(5, v); }
  bool hasAliasContext() => $_has(4, 5);
  void clearAliasContext() => clearField(5);
}

class _ReadonlyGerritSourceContext extends GerritSourceContext with ReadonlyMessageMixin {}

class GitSourceContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GitSourceContext')
    ..a/*<String>*/(1, 'url', PbFieldType.OS)
    ..a/*<String>*/(2, 'revisionId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GitSourceContext() : super();
  GitSourceContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GitSourceContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GitSourceContext clone() => new GitSourceContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GitSourceContext create() => new GitSourceContext();
  static PbList<GitSourceContext> createRepeated() => new PbList<GitSourceContext>();
  static GitSourceContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGitSourceContext();
    return _defaultInstance;
  }
  static GitSourceContext _defaultInstance;
  static void $checkItem(GitSourceContext v) {
    if (v is !GitSourceContext) checkItemFailed(v, 'GitSourceContext');
  }

  String get url => $_get(0, 1, '');
  void set url(String v) { $_setString(0, 1, v); }
  bool hasUrl() => $_has(0, 1);
  void clearUrl() => clearField(1);

  String get revisionId => $_get(1, 2, '');
  void set revisionId(String v) { $_setString(1, 2, v); }
  bool hasRevisionId() => $_has(1, 2);
  void clearRevisionId() => clearField(2);
}

class _ReadonlyGitSourceContext extends GitSourceContext with ReadonlyMessageMixin {}

class RepoId extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RepoId')
    ..a/*<ProjectRepoId>*/(1, 'projectRepoId', PbFieldType.OM, ProjectRepoId.getDefault, ProjectRepoId.create)
    ..a/*<String>*/(2, 'uid', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  RepoId() : super();
  RepoId.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RepoId.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RepoId clone() => new RepoId()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RepoId create() => new RepoId();
  static PbList<RepoId> createRepeated() => new PbList<RepoId>();
  static RepoId getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRepoId();
    return _defaultInstance;
  }
  static RepoId _defaultInstance;
  static void $checkItem(RepoId v) {
    if (v is !RepoId) checkItemFailed(v, 'RepoId');
  }

  ProjectRepoId get projectRepoId => $_get(0, 1, null);
  void set projectRepoId(ProjectRepoId v) { setField(1, v); }
  bool hasProjectRepoId() => $_has(0, 1);
  void clearProjectRepoId() => clearField(1);

  String get uid => $_get(1, 2, '');
  void set uid(String v) { $_setString(1, 2, v); }
  bool hasUid() => $_has(1, 2);
  void clearUid() => clearField(2);
}

class _ReadonlyRepoId extends RepoId with ReadonlyMessageMixin {}

class ProjectRepoId extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ProjectRepoId')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'repoName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ProjectRepoId() : super();
  ProjectRepoId.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ProjectRepoId.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ProjectRepoId clone() => new ProjectRepoId()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ProjectRepoId create() => new ProjectRepoId();
  static PbList<ProjectRepoId> createRepeated() => new PbList<ProjectRepoId>();
  static ProjectRepoId getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyProjectRepoId();
    return _defaultInstance;
  }
  static ProjectRepoId _defaultInstance;
  static void $checkItem(ProjectRepoId v) {
    if (v is !ProjectRepoId) checkItemFailed(v, 'ProjectRepoId');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get repoName => $_get(1, 2, '');
  void set repoName(String v) { $_setString(1, 2, v); }
  bool hasRepoName() => $_has(1, 2);
  void clearRepoName() => clearField(2);
}

class _ReadonlyProjectRepoId extends ProjectRepoId with ReadonlyMessageMixin {}

class CloudWorkspaceId extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CloudWorkspaceId')
    ..a/*<RepoId>*/(1, 'repoId', PbFieldType.OM, RepoId.getDefault, RepoId.create)
    ..a/*<String>*/(2, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CloudWorkspaceId() : super();
  CloudWorkspaceId.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CloudWorkspaceId.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CloudWorkspaceId clone() => new CloudWorkspaceId()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CloudWorkspaceId create() => new CloudWorkspaceId();
  static PbList<CloudWorkspaceId> createRepeated() => new PbList<CloudWorkspaceId>();
  static CloudWorkspaceId getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCloudWorkspaceId();
    return _defaultInstance;
  }
  static CloudWorkspaceId _defaultInstance;
  static void $checkItem(CloudWorkspaceId v) {
    if (v is !CloudWorkspaceId) checkItemFailed(v, 'CloudWorkspaceId');
  }

  RepoId get repoId => $_get(0, 1, null);
  void set repoId(RepoId v) { setField(1, v); }
  bool hasRepoId() => $_has(0, 1);
  void clearRepoId() => clearField(1);

  String get name => $_get(1, 2, '');
  void set name(String v) { $_setString(1, 2, v); }
  bool hasName() => $_has(1, 2);
  void clearName() => clearField(2);
}

class _ReadonlyCloudWorkspaceId extends CloudWorkspaceId with ReadonlyMessageMixin {}

