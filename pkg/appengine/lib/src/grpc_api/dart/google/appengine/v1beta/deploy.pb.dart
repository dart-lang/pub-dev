//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/deploy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/duration.pb.dart' as $51;

/// Code and application artifacts used to deploy a version to App Engine.
class Deployment extends $pb.GeneratedMessage {
  factory Deployment({
    $core.Map<$core.String, FileInfo>? files,
    ContainerInfo? container,
    ZipInfo? zip,
    BuildInfo? build,
    CloudBuildOptions? cloudBuildOptions,
  }) {
    final $result = create();
    if (files != null) {
      $result.files.addAll(files);
    }
    if (container != null) {
      $result.container = container;
    }
    if (zip != null) {
      $result.zip = zip;
    }
    if (build != null) {
      $result.build = build;
    }
    if (cloudBuildOptions != null) {
      $result.cloudBuildOptions = cloudBuildOptions;
    }
    return $result;
  }
  Deployment._() : super();
  factory Deployment.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Deployment.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deployment',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..m<$core.String, FileInfo>(1, _omitFieldNames ? '' : 'files',
        entryClassName: 'Deployment.FilesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: FileInfo.create,
        valueDefaultOrMaker: FileInfo.getDefault,
        packageName: const $pb.PackageName('google.appengine.v1beta'))
    ..aOM<ContainerInfo>(2, _omitFieldNames ? '' : 'container',
        subBuilder: ContainerInfo.create)
    ..aOM<ZipInfo>(3, _omitFieldNames ? '' : 'zip', subBuilder: ZipInfo.create)
    ..aOM<BuildInfo>(5, _omitFieldNames ? '' : 'build',
        subBuilder: BuildInfo.create)
    ..aOM<CloudBuildOptions>(6, _omitFieldNames ? '' : 'cloudBuildOptions',
        subBuilder: CloudBuildOptions.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Deployment clone() => Deployment()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Deployment copyWith(void Function(Deployment) updates) =>
      super.copyWith((message) => updates(message as Deployment)) as Deployment;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Deployment create() => Deployment._();
  Deployment createEmptyInstance() => create();
  static $pb.PbList<Deployment> createRepeated() => $pb.PbList<Deployment>();
  @$core.pragma('dart2js:noInline')
  static Deployment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Deployment>(create);
  static Deployment? _defaultInstance;

  /// Manifest of the files stored in Google Cloud Storage that are included
  /// as part of this version. All files must be readable using the
  /// credentials supplied with this call.
  @$pb.TagNumber(1)
  $core.Map<$core.String, FileInfo> get files => $_getMap(0);

  /// The Docker image for the container that runs the version.
  /// Only applicable for instances running in the App Engine flexible environment.
  @$pb.TagNumber(2)
  ContainerInfo get container => $_getN(1);
  @$pb.TagNumber(2)
  set container(ContainerInfo v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasContainer() => $_has(1);
  @$pb.TagNumber(2)
  void clearContainer() => clearField(2);
  @$pb.TagNumber(2)
  ContainerInfo ensureContainer() => $_ensure(1);

  /// The zip file for this deployment, if this is a zip deployment.
  @$pb.TagNumber(3)
  ZipInfo get zip => $_getN(2);
  @$pb.TagNumber(3)
  set zip(ZipInfo v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasZip() => $_has(2);
  @$pb.TagNumber(3)
  void clearZip() => clearField(3);
  @$pb.TagNumber(3)
  ZipInfo ensureZip() => $_ensure(2);

  /// Google Cloud Build build information. Only applicable for instances running
  /// in the App Engine flexible environment.
  @$pb.TagNumber(5)
  BuildInfo get build => $_getN(3);
  @$pb.TagNumber(5)
  set build(BuildInfo v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasBuild() => $_has(3);
  @$pb.TagNumber(5)
  void clearBuild() => clearField(5);
  @$pb.TagNumber(5)
  BuildInfo ensureBuild() => $_ensure(3);

  ///  Options for any Google Cloud Build builds created as a part of this
  ///  deployment.
  ///
  ///  These options will only be used if a new build is created, such as when
  ///  deploying to the App Engine flexible environment using files or zip.
  @$pb.TagNumber(6)
  CloudBuildOptions get cloudBuildOptions => $_getN(4);
  @$pb.TagNumber(6)
  set cloudBuildOptions(CloudBuildOptions v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCloudBuildOptions() => $_has(4);
  @$pb.TagNumber(6)
  void clearCloudBuildOptions() => clearField(6);
  @$pb.TagNumber(6)
  CloudBuildOptions ensureCloudBuildOptions() => $_ensure(4);
}

/// Single source file that is part of the version to be deployed. Each source
/// file that is deployed must be specified separately.
class FileInfo extends $pb.GeneratedMessage {
  factory FileInfo({
    $core.String? sourceUrl,
    $core.String? sha1Sum,
    $core.String? mimeType,
  }) {
    final $result = create();
    if (sourceUrl != null) {
      $result.sourceUrl = sourceUrl;
    }
    if (sha1Sum != null) {
      $result.sha1Sum = sha1Sum;
    }
    if (mimeType != null) {
      $result.mimeType = mimeType;
    }
    return $result;
  }
  FileInfo._() : super();
  factory FileInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FileInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sourceUrl')
    ..aOS(2, _omitFieldNames ? '' : 'sha1Sum')
    ..aOS(3, _omitFieldNames ? '' : 'mimeType')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FileInfo clone() => FileInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FileInfo copyWith(void Function(FileInfo) updates) =>
      super.copyWith((message) => updates(message as FileInfo)) as FileInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileInfo create() => FileInfo._();
  FileInfo createEmptyInstance() => create();
  static $pb.PbList<FileInfo> createRepeated() => $pb.PbList<FileInfo>();
  @$core.pragma('dart2js:noInline')
  static FileInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileInfo>(create);
  static FileInfo? _defaultInstance;

  /// URL source to use to fetch this file. Must be a URL to a resource in
  /// Google Cloud Storage in the form
  /// 'http(s)://storage.googleapis.com/\<bucket\>/\<object\>'.
  @$pb.TagNumber(1)
  $core.String get sourceUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set sourceUrl($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSourceUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourceUrl() => clearField(1);

  /// The SHA1 hash of the file, in hex.
  @$pb.TagNumber(2)
  $core.String get sha1Sum => $_getSZ(1);
  @$pb.TagNumber(2)
  set sha1Sum($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSha1Sum() => $_has(1);
  @$pb.TagNumber(2)
  void clearSha1Sum() => clearField(2);

  ///  The MIME type of the file.
  ///
  ///  Defaults to the value from Google Cloud Storage.
  @$pb.TagNumber(3)
  $core.String get mimeType => $_getSZ(2);
  @$pb.TagNumber(3)
  set mimeType($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMimeType() => $_has(2);
  @$pb.TagNumber(3)
  void clearMimeType() => clearField(3);
}

/// Docker image that is used to create a container and start a VM instance for
/// the version that you deploy. Only applicable for instances running in the App
/// Engine flexible environment.
class ContainerInfo extends $pb.GeneratedMessage {
  factory ContainerInfo({
    $core.String? image,
  }) {
    final $result = create();
    if (image != null) {
      $result.image = image;
    }
    return $result;
  }
  ContainerInfo._() : super();
  factory ContainerInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ContainerInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContainerInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'image')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ContainerInfo clone() => ContainerInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ContainerInfo copyWith(void Function(ContainerInfo) updates) =>
      super.copyWith((message) => updates(message as ContainerInfo))
          as ContainerInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContainerInfo create() => ContainerInfo._();
  ContainerInfo createEmptyInstance() => create();
  static $pb.PbList<ContainerInfo> createRepeated() =>
      $pb.PbList<ContainerInfo>();
  @$core.pragma('dart2js:noInline')
  static ContainerInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContainerInfo>(create);
  static ContainerInfo? _defaultInstance;

  /// URI to the hosted container image in Google Container Registry. The URI
  /// must be fully qualified and include a tag or digest.
  /// Examples: "gcr.io/my-project/image:tag" or "gcr.io/my-project/image@digest"
  @$pb.TagNumber(1)
  $core.String get image => $_getSZ(0);
  @$pb.TagNumber(1)
  set image($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasImage() => $_has(0);
  @$pb.TagNumber(1)
  void clearImage() => clearField(1);
}

/// Google Cloud Build information.
class BuildInfo extends $pb.GeneratedMessage {
  factory BuildInfo({
    $core.String? cloudBuildId,
  }) {
    final $result = create();
    if (cloudBuildId != null) {
      $result.cloudBuildId = cloudBuildId;
    }
    return $result;
  }
  BuildInfo._() : super();
  factory BuildInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BuildInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuildInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cloudBuildId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BuildInfo clone() => BuildInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BuildInfo copyWith(void Function(BuildInfo) updates) =>
      super.copyWith((message) => updates(message as BuildInfo)) as BuildInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuildInfo create() => BuildInfo._();
  BuildInfo createEmptyInstance() => create();
  static $pb.PbList<BuildInfo> createRepeated() => $pb.PbList<BuildInfo>();
  @$core.pragma('dart2js:noInline')
  static BuildInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuildInfo>(create);
  static BuildInfo? _defaultInstance;

  /// The Google Cloud Build id.
  /// Example: "f966068f-08b2-42c8-bdfe-74137dff2bf9"
  @$pb.TagNumber(1)
  $core.String get cloudBuildId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cloudBuildId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCloudBuildId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCloudBuildId() => clearField(1);
}

/// Options for the build operations performed as a part of the version
/// deployment. Only applicable for App Engine flexible environment when creating
/// a version using source code directly.
class CloudBuildOptions extends $pb.GeneratedMessage {
  factory CloudBuildOptions({
    $core.String? appYamlPath,
    $51.Duration? cloudBuildTimeout,
  }) {
    final $result = create();
    if (appYamlPath != null) {
      $result.appYamlPath = appYamlPath;
    }
    if (cloudBuildTimeout != null) {
      $result.cloudBuildTimeout = cloudBuildTimeout;
    }
    return $result;
  }
  CloudBuildOptions._() : super();
  factory CloudBuildOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CloudBuildOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloudBuildOptions',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'appYamlPath')
    ..aOM<$51.Duration>(2, _omitFieldNames ? '' : 'cloudBuildTimeout',
        subBuilder: $51.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CloudBuildOptions clone() => CloudBuildOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CloudBuildOptions copyWith(void Function(CloudBuildOptions) updates) =>
      super.copyWith((message) => updates(message as CloudBuildOptions))
          as CloudBuildOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloudBuildOptions create() => CloudBuildOptions._();
  CloudBuildOptions createEmptyInstance() => create();
  static $pb.PbList<CloudBuildOptions> createRepeated() =>
      $pb.PbList<CloudBuildOptions>();
  @$core.pragma('dart2js:noInline')
  static CloudBuildOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloudBuildOptions>(create);
  static CloudBuildOptions? _defaultInstance;

  ///  Path to the yaml file used in deployment, used to determine runtime
  ///  configuration details.
  ///
  ///  Required for flexible environment builds.
  ///
  ///  See https://cloud.google.com/appengine/docs/standard/python/config/appref
  ///  for more details.
  @$pb.TagNumber(1)
  $core.String get appYamlPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set appYamlPath($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAppYamlPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearAppYamlPath() => clearField(1);

  /// The Cloud Build timeout used as part of any dependent builds performed by
  /// version creation. Defaults to 10 minutes.
  @$pb.TagNumber(2)
  $51.Duration get cloudBuildTimeout => $_getN(1);
  @$pb.TagNumber(2)
  set cloudBuildTimeout($51.Duration v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCloudBuildTimeout() => $_has(1);
  @$pb.TagNumber(2)
  void clearCloudBuildTimeout() => clearField(2);
  @$pb.TagNumber(2)
  $51.Duration ensureCloudBuildTimeout() => $_ensure(1);
}

/// The zip file information for a zip deployment.
class ZipInfo extends $pb.GeneratedMessage {
  factory ZipInfo({
    $core.String? sourceUrl,
    $core.int? filesCount,
  }) {
    final $result = create();
    if (sourceUrl != null) {
      $result.sourceUrl = sourceUrl;
    }
    if (filesCount != null) {
      $result.filesCount = filesCount;
    }
    return $result;
  }
  ZipInfo._() : super();
  factory ZipInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ZipInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZipInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(3, _omitFieldNames ? '' : 'sourceUrl')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'filesCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ZipInfo clone() => ZipInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ZipInfo copyWith(void Function(ZipInfo) updates) =>
      super.copyWith((message) => updates(message as ZipInfo)) as ZipInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZipInfo create() => ZipInfo._();
  ZipInfo createEmptyInstance() => create();
  static $pb.PbList<ZipInfo> createRepeated() => $pb.PbList<ZipInfo>();
  @$core.pragma('dart2js:noInline')
  static ZipInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ZipInfo>(create);
  static ZipInfo? _defaultInstance;

  /// URL of the zip file to deploy from. Must be a URL to a resource in
  /// Google Cloud Storage in the form
  /// 'http(s)://storage.googleapis.com/\<bucket\>/\<object\>'.
  @$pb.TagNumber(3)
  $core.String get sourceUrl => $_getSZ(0);
  @$pb.TagNumber(3)
  set sourceUrl($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSourceUrl() => $_has(0);
  @$pb.TagNumber(3)
  void clearSourceUrl() => clearField(3);

  /// An estimate of the number of files in a zip for a zip deployment.
  /// If set, must be greater than or equal to the actual number of files.
  /// Used for optimizing performance; if not provided, deployment may be slow.
  @$pb.TagNumber(4)
  $core.int get filesCount => $_getIZ(1);
  @$pb.TagNumber(4)
  set filesCount($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFilesCount() => $_has(1);
  @$pb.TagNumber(4)
  void clearFilesCount() => clearField(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
