//
//  Generated code. Do not modify.
//  source: google/api/client.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/duration.pb.dart' as $51;
import 'client.pbenum.dart';
import 'launch_stage.pbenum.dart' as $56;

export 'client.pbenum.dart';

/// Required information for every language.
class CommonLanguageSettings extends $pb.GeneratedMessage {
  factory CommonLanguageSettings({
    @$core.Deprecated('This field is deprecated.')
    $core.String? referenceDocsUri,
    $core.Iterable<ClientLibraryDestination>? destinations,
  }) {
    final $result = create();
    if (referenceDocsUri != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.referenceDocsUri = referenceDocsUri;
    }
    if (destinations != null) {
      $result.destinations.addAll(destinations);
    }
    return $result;
  }
  CommonLanguageSettings._() : super();
  factory CommonLanguageSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CommonLanguageSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommonLanguageSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'referenceDocsUri')
    ..pc<ClientLibraryDestination>(
        2, _omitFieldNames ? '' : 'destinations', $pb.PbFieldType.KE,
        valueOf: ClientLibraryDestination.valueOf,
        enumValues: ClientLibraryDestination.values,
        defaultEnumValue:
            ClientLibraryDestination.CLIENT_LIBRARY_DESTINATION_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CommonLanguageSettings clone() =>
      CommonLanguageSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CommonLanguageSettings copyWith(
          void Function(CommonLanguageSettings) updates) =>
      super.copyWith((message) => updates(message as CommonLanguageSettings))
          as CommonLanguageSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommonLanguageSettings create() => CommonLanguageSettings._();
  CommonLanguageSettings createEmptyInstance() => create();
  static $pb.PbList<CommonLanguageSettings> createRepeated() =>
      $pb.PbList<CommonLanguageSettings>();
  @$core.pragma('dart2js:noInline')
  static CommonLanguageSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommonLanguageSettings>(create);
  static CommonLanguageSettings? _defaultInstance;

  /// Link to automatically generated reference documentation.  Example:
  /// https://cloud.google.com/nodejs/docs/reference/asset/latest
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.String get referenceDocsUri => $_getSZ(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set referenceDocsUri($core.String v) {
    $_setString(0, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasReferenceDocsUri() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearReferenceDocsUri() => clearField(1);

  /// The destination where API teams want this client library to be published.
  @$pb.TagNumber(2)
  $core.List<ClientLibraryDestination> get destinations => $_getList(1);
}

/// Details about how and where to publish client libraries.
class ClientLibrarySettings extends $pb.GeneratedMessage {
  factory ClientLibrarySettings({
    $core.String? version,
    $56.LaunchStage? launchStage,
    $core.bool? restNumericEnums,
    JavaSettings? javaSettings,
    CppSettings? cppSettings,
    PhpSettings? phpSettings,
    PythonSettings? pythonSettings,
    NodeSettings? nodeSettings,
    DotnetSettings? dotnetSettings,
    RubySettings? rubySettings,
    GoSettings? goSettings,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    if (launchStage != null) {
      $result.launchStage = launchStage;
    }
    if (restNumericEnums != null) {
      $result.restNumericEnums = restNumericEnums;
    }
    if (javaSettings != null) {
      $result.javaSettings = javaSettings;
    }
    if (cppSettings != null) {
      $result.cppSettings = cppSettings;
    }
    if (phpSettings != null) {
      $result.phpSettings = phpSettings;
    }
    if (pythonSettings != null) {
      $result.pythonSettings = pythonSettings;
    }
    if (nodeSettings != null) {
      $result.nodeSettings = nodeSettings;
    }
    if (dotnetSettings != null) {
      $result.dotnetSettings = dotnetSettings;
    }
    if (rubySettings != null) {
      $result.rubySettings = rubySettings;
    }
    if (goSettings != null) {
      $result.goSettings = goSettings;
    }
    return $result;
  }
  ClientLibrarySettings._() : super();
  factory ClientLibrarySettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ClientLibrarySettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClientLibrarySettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..e<$56.LaunchStage>(
        2, _omitFieldNames ? '' : 'launchStage', $pb.PbFieldType.OE,
        defaultOrMaker: $56.LaunchStage.LAUNCH_STAGE_UNSPECIFIED,
        valueOf: $56.LaunchStage.valueOf,
        enumValues: $56.LaunchStage.values)
    ..aOB(3, _omitFieldNames ? '' : 'restNumericEnums')
    ..aOM<JavaSettings>(21, _omitFieldNames ? '' : 'javaSettings',
        subBuilder: JavaSettings.create)
    ..aOM<CppSettings>(22, _omitFieldNames ? '' : 'cppSettings',
        subBuilder: CppSettings.create)
    ..aOM<PhpSettings>(23, _omitFieldNames ? '' : 'phpSettings',
        subBuilder: PhpSettings.create)
    ..aOM<PythonSettings>(24, _omitFieldNames ? '' : 'pythonSettings',
        subBuilder: PythonSettings.create)
    ..aOM<NodeSettings>(25, _omitFieldNames ? '' : 'nodeSettings',
        subBuilder: NodeSettings.create)
    ..aOM<DotnetSettings>(26, _omitFieldNames ? '' : 'dotnetSettings',
        subBuilder: DotnetSettings.create)
    ..aOM<RubySettings>(27, _omitFieldNames ? '' : 'rubySettings',
        subBuilder: RubySettings.create)
    ..aOM<GoSettings>(28, _omitFieldNames ? '' : 'goSettings',
        subBuilder: GoSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ClientLibrarySettings clone() =>
      ClientLibrarySettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ClientLibrarySettings copyWith(
          void Function(ClientLibrarySettings) updates) =>
      super.copyWith((message) => updates(message as ClientLibrarySettings))
          as ClientLibrarySettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientLibrarySettings create() => ClientLibrarySettings._();
  ClientLibrarySettings createEmptyInstance() => create();
  static $pb.PbList<ClientLibrarySettings> createRepeated() =>
      $pb.PbList<ClientLibrarySettings>();
  @$core.pragma('dart2js:noInline')
  static ClientLibrarySettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClientLibrarySettings>(create);
  static ClientLibrarySettings? _defaultInstance;

  /// Version of the API to apply these settings to. This is the full protobuf
  /// package for the API, ending in the version element.
  /// Examples: "google.cloud.speech.v1" and "google.spanner.admin.database.v1".
  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);

  /// Launch stage of this version of the API.
  @$pb.TagNumber(2)
  $56.LaunchStage get launchStage => $_getN(1);
  @$pb.TagNumber(2)
  set launchStage($56.LaunchStage v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLaunchStage() => $_has(1);
  @$pb.TagNumber(2)
  void clearLaunchStage() => clearField(2);

  /// When using transport=rest, the client request will encode enums as
  /// numbers rather than strings.
  @$pb.TagNumber(3)
  $core.bool get restNumericEnums => $_getBF(2);
  @$pb.TagNumber(3)
  set restNumericEnums($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRestNumericEnums() => $_has(2);
  @$pb.TagNumber(3)
  void clearRestNumericEnums() => clearField(3);

  /// Settings for legacy Java features, supported in the Service YAML.
  @$pb.TagNumber(21)
  JavaSettings get javaSettings => $_getN(3);
  @$pb.TagNumber(21)
  set javaSettings(JavaSettings v) {
    setField(21, v);
  }

  @$pb.TagNumber(21)
  $core.bool hasJavaSettings() => $_has(3);
  @$pb.TagNumber(21)
  void clearJavaSettings() => clearField(21);
  @$pb.TagNumber(21)
  JavaSettings ensureJavaSettings() => $_ensure(3);

  /// Settings for C++ client libraries.
  @$pb.TagNumber(22)
  CppSettings get cppSettings => $_getN(4);
  @$pb.TagNumber(22)
  set cppSettings(CppSettings v) {
    setField(22, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasCppSettings() => $_has(4);
  @$pb.TagNumber(22)
  void clearCppSettings() => clearField(22);
  @$pb.TagNumber(22)
  CppSettings ensureCppSettings() => $_ensure(4);

  /// Settings for PHP client libraries.
  @$pb.TagNumber(23)
  PhpSettings get phpSettings => $_getN(5);
  @$pb.TagNumber(23)
  set phpSettings(PhpSettings v) {
    setField(23, v);
  }

  @$pb.TagNumber(23)
  $core.bool hasPhpSettings() => $_has(5);
  @$pb.TagNumber(23)
  void clearPhpSettings() => clearField(23);
  @$pb.TagNumber(23)
  PhpSettings ensurePhpSettings() => $_ensure(5);

  /// Settings for Python client libraries.
  @$pb.TagNumber(24)
  PythonSettings get pythonSettings => $_getN(6);
  @$pb.TagNumber(24)
  set pythonSettings(PythonSettings v) {
    setField(24, v);
  }

  @$pb.TagNumber(24)
  $core.bool hasPythonSettings() => $_has(6);
  @$pb.TagNumber(24)
  void clearPythonSettings() => clearField(24);
  @$pb.TagNumber(24)
  PythonSettings ensurePythonSettings() => $_ensure(6);

  /// Settings for Node client libraries.
  @$pb.TagNumber(25)
  NodeSettings get nodeSettings => $_getN(7);
  @$pb.TagNumber(25)
  set nodeSettings(NodeSettings v) {
    setField(25, v);
  }

  @$pb.TagNumber(25)
  $core.bool hasNodeSettings() => $_has(7);
  @$pb.TagNumber(25)
  void clearNodeSettings() => clearField(25);
  @$pb.TagNumber(25)
  NodeSettings ensureNodeSettings() => $_ensure(7);

  /// Settings for .NET client libraries.
  @$pb.TagNumber(26)
  DotnetSettings get dotnetSettings => $_getN(8);
  @$pb.TagNumber(26)
  set dotnetSettings(DotnetSettings v) {
    setField(26, v);
  }

  @$pb.TagNumber(26)
  $core.bool hasDotnetSettings() => $_has(8);
  @$pb.TagNumber(26)
  void clearDotnetSettings() => clearField(26);
  @$pb.TagNumber(26)
  DotnetSettings ensureDotnetSettings() => $_ensure(8);

  /// Settings for Ruby client libraries.
  @$pb.TagNumber(27)
  RubySettings get rubySettings => $_getN(9);
  @$pb.TagNumber(27)
  set rubySettings(RubySettings v) {
    setField(27, v);
  }

  @$pb.TagNumber(27)
  $core.bool hasRubySettings() => $_has(9);
  @$pb.TagNumber(27)
  void clearRubySettings() => clearField(27);
  @$pb.TagNumber(27)
  RubySettings ensureRubySettings() => $_ensure(9);

  /// Settings for Go client libraries.
  @$pb.TagNumber(28)
  GoSettings get goSettings => $_getN(10);
  @$pb.TagNumber(28)
  set goSettings(GoSettings v) {
    setField(28, v);
  }

  @$pb.TagNumber(28)
  $core.bool hasGoSettings() => $_has(10);
  @$pb.TagNumber(28)
  void clearGoSettings() => clearField(28);
  @$pb.TagNumber(28)
  GoSettings ensureGoSettings() => $_ensure(10);
}

/// This message configures the settings for publishing [Google Cloud Client
/// libraries](https://cloud.google.com/apis/docs/cloud-client-libraries)
/// generated from the service config.
class Publishing extends $pb.GeneratedMessage {
  factory Publishing({
    $core.Iterable<MethodSettings>? methodSettings,
    $core.String? newIssueUri,
    $core.String? documentationUri,
    $core.String? apiShortName,
    $core.String? githubLabel,
    $core.Iterable<$core.String>? codeownerGithubTeams,
    $core.String? docTagPrefix,
    ClientLibraryOrganization? organization,
    $core.Iterable<ClientLibrarySettings>? librarySettings,
    $core.String? protoReferenceDocumentationUri,
    $core.String? restReferenceDocumentationUri,
  }) {
    final $result = create();
    if (methodSettings != null) {
      $result.methodSettings.addAll(methodSettings);
    }
    if (newIssueUri != null) {
      $result.newIssueUri = newIssueUri;
    }
    if (documentationUri != null) {
      $result.documentationUri = documentationUri;
    }
    if (apiShortName != null) {
      $result.apiShortName = apiShortName;
    }
    if (githubLabel != null) {
      $result.githubLabel = githubLabel;
    }
    if (codeownerGithubTeams != null) {
      $result.codeownerGithubTeams.addAll(codeownerGithubTeams);
    }
    if (docTagPrefix != null) {
      $result.docTagPrefix = docTagPrefix;
    }
    if (organization != null) {
      $result.organization = organization;
    }
    if (librarySettings != null) {
      $result.librarySettings.addAll(librarySettings);
    }
    if (protoReferenceDocumentationUri != null) {
      $result.protoReferenceDocumentationUri = protoReferenceDocumentationUri;
    }
    if (restReferenceDocumentationUri != null) {
      $result.restReferenceDocumentationUri = restReferenceDocumentationUri;
    }
    return $result;
  }
  Publishing._() : super();
  factory Publishing.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Publishing.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Publishing',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<MethodSettings>(
        2, _omitFieldNames ? '' : 'methodSettings', $pb.PbFieldType.PM,
        subBuilder: MethodSettings.create)
    ..aOS(101, _omitFieldNames ? '' : 'newIssueUri')
    ..aOS(102, _omitFieldNames ? '' : 'documentationUri')
    ..aOS(103, _omitFieldNames ? '' : 'apiShortName')
    ..aOS(104, _omitFieldNames ? '' : 'githubLabel')
    ..pPS(105, _omitFieldNames ? '' : 'codeownerGithubTeams')
    ..aOS(106, _omitFieldNames ? '' : 'docTagPrefix')
    ..e<ClientLibraryOrganization>(
        107, _omitFieldNames ? '' : 'organization', $pb.PbFieldType.OE,
        defaultOrMaker:
            ClientLibraryOrganization.CLIENT_LIBRARY_ORGANIZATION_UNSPECIFIED,
        valueOf: ClientLibraryOrganization.valueOf,
        enumValues: ClientLibraryOrganization.values)
    ..pc<ClientLibrarySettings>(
        109, _omitFieldNames ? '' : 'librarySettings', $pb.PbFieldType.PM,
        subBuilder: ClientLibrarySettings.create)
    ..aOS(110, _omitFieldNames ? '' : 'protoReferenceDocumentationUri')
    ..aOS(111, _omitFieldNames ? '' : 'restReferenceDocumentationUri')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Publishing clone() => Publishing()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Publishing copyWith(void Function(Publishing) updates) =>
      super.copyWith((message) => updates(message as Publishing)) as Publishing;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Publishing create() => Publishing._();
  Publishing createEmptyInstance() => create();
  static $pb.PbList<Publishing> createRepeated() => $pb.PbList<Publishing>();
  @$core.pragma('dart2js:noInline')
  static Publishing getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Publishing>(create);
  static Publishing? _defaultInstance;

  /// A list of API method settings, e.g. the behavior for methods that use the
  /// long-running operation pattern.
  @$pb.TagNumber(2)
  $core.List<MethodSettings> get methodSettings => $_getList(0);

  /// Link to a *public* URI where users can report issues.  Example:
  /// https://issuetracker.google.com/issues/new?component=190865&template=1161103
  @$pb.TagNumber(101)
  $core.String get newIssueUri => $_getSZ(1);
  @$pb.TagNumber(101)
  set newIssueUri($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(101)
  $core.bool hasNewIssueUri() => $_has(1);
  @$pb.TagNumber(101)
  void clearNewIssueUri() => clearField(101);

  /// Link to product home page.  Example:
  /// https://cloud.google.com/asset-inventory/docs/overview
  @$pb.TagNumber(102)
  $core.String get documentationUri => $_getSZ(2);
  @$pb.TagNumber(102)
  set documentationUri($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(102)
  $core.bool hasDocumentationUri() => $_has(2);
  @$pb.TagNumber(102)
  void clearDocumentationUri() => clearField(102);

  /// Used as a tracking tag when collecting data about the APIs developer
  /// relations artifacts like docs, packages delivered to package managers,
  /// etc.  Example: "speech".
  @$pb.TagNumber(103)
  $core.String get apiShortName => $_getSZ(3);
  @$pb.TagNumber(103)
  set apiShortName($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(103)
  $core.bool hasApiShortName() => $_has(3);
  @$pb.TagNumber(103)
  void clearApiShortName() => clearField(103);

  /// GitHub label to apply to issues and pull requests opened for this API.
  @$pb.TagNumber(104)
  $core.String get githubLabel => $_getSZ(4);
  @$pb.TagNumber(104)
  set githubLabel($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(104)
  $core.bool hasGithubLabel() => $_has(4);
  @$pb.TagNumber(104)
  void clearGithubLabel() => clearField(104);

  /// GitHub teams to be added to CODEOWNERS in the directory in GitHub
  /// containing source code for the client libraries for this API.
  @$pb.TagNumber(105)
  $core.List<$core.String> get codeownerGithubTeams => $_getList(5);

  /// A prefix used in sample code when demarking regions to be included in
  /// documentation.
  @$pb.TagNumber(106)
  $core.String get docTagPrefix => $_getSZ(6);
  @$pb.TagNumber(106)
  set docTagPrefix($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(106)
  $core.bool hasDocTagPrefix() => $_has(6);
  @$pb.TagNumber(106)
  void clearDocTagPrefix() => clearField(106);

  /// For whom the client library is being published.
  @$pb.TagNumber(107)
  ClientLibraryOrganization get organization => $_getN(7);
  @$pb.TagNumber(107)
  set organization(ClientLibraryOrganization v) {
    setField(107, v);
  }

  @$pb.TagNumber(107)
  $core.bool hasOrganization() => $_has(7);
  @$pb.TagNumber(107)
  void clearOrganization() => clearField(107);

  /// Client library settings.  If the same version string appears multiple
  /// times in this list, then the last one wins.  Settings from earlier
  /// settings with the same version string are discarded.
  @$pb.TagNumber(109)
  $core.List<ClientLibrarySettings> get librarySettings => $_getList(8);

  /// Optional link to proto reference documentation.  Example:
  /// https://cloud.google.com/pubsub/lite/docs/reference/rpc
  @$pb.TagNumber(110)
  $core.String get protoReferenceDocumentationUri => $_getSZ(9);
  @$pb.TagNumber(110)
  set protoReferenceDocumentationUri($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(110)
  $core.bool hasProtoReferenceDocumentationUri() => $_has(9);
  @$pb.TagNumber(110)
  void clearProtoReferenceDocumentationUri() => clearField(110);

  /// Optional link to REST reference documentation.  Example:
  /// https://cloud.google.com/pubsub/lite/docs/reference/rest
  @$pb.TagNumber(111)
  $core.String get restReferenceDocumentationUri => $_getSZ(10);
  @$pb.TagNumber(111)
  set restReferenceDocumentationUri($core.String v) {
    $_setString(10, v);
  }

  @$pb.TagNumber(111)
  $core.bool hasRestReferenceDocumentationUri() => $_has(10);
  @$pb.TagNumber(111)
  void clearRestReferenceDocumentationUri() => clearField(111);
}

/// Settings for Java client libraries.
class JavaSettings extends $pb.GeneratedMessage {
  factory JavaSettings({
    $core.String? libraryPackage,
    $core.Map<$core.String, $core.String>? serviceClassNames,
    CommonLanguageSettings? common,
  }) {
    final $result = create();
    if (libraryPackage != null) {
      $result.libraryPackage = libraryPackage;
    }
    if (serviceClassNames != null) {
      $result.serviceClassNames.addAll(serviceClassNames);
    }
    if (common != null) {
      $result.common = common;
    }
    return $result;
  }
  JavaSettings._() : super();
  factory JavaSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JavaSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JavaSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'libraryPackage')
    ..m<$core.String, $core.String>(
        2, _omitFieldNames ? '' : 'serviceClassNames',
        entryClassName: 'JavaSettings.ServiceClassNamesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..aOM<CommonLanguageSettings>(3, _omitFieldNames ? '' : 'common',
        subBuilder: CommonLanguageSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JavaSettings clone() => JavaSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JavaSettings copyWith(void Function(JavaSettings) updates) =>
      super.copyWith((message) => updates(message as JavaSettings))
          as JavaSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JavaSettings create() => JavaSettings._();
  JavaSettings createEmptyInstance() => create();
  static $pb.PbList<JavaSettings> createRepeated() =>
      $pb.PbList<JavaSettings>();
  @$core.pragma('dart2js:noInline')
  static JavaSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JavaSettings>(create);
  static JavaSettings? _defaultInstance;

  ///  The package name to use in Java. Clobbers the java_package option
  ///  set in the protobuf. This should be used **only** by APIs
  ///  who have already set the language_settings.java.package_name" field
  ///  in gapic.yaml. API teams should use the protobuf java_package option
  ///  where possible.
  ///
  ///  Example of a YAML configuration::
  ///
  ///   publishing:
  ///     java_settings:
  ///       library_package: com.google.cloud.pubsub.v1
  @$pb.TagNumber(1)
  $core.String get libraryPackage => $_getSZ(0);
  @$pb.TagNumber(1)
  set libraryPackage($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLibraryPackage() => $_has(0);
  @$pb.TagNumber(1)
  void clearLibraryPackage() => clearField(1);

  ///  Configure the Java class name to use instead of the service's for its
  ///  corresponding generated GAPIC client. Keys are fully-qualified
  ///  service names as they appear in the protobuf (including the full
  ///  the language_settings.java.interface_names" field in gapic.yaml. API
  ///  teams should otherwise use the service name as it appears in the
  ///  protobuf.
  ///
  ///  Example of a YAML configuration::
  ///
  ///   publishing:
  ///     java_settings:
  ///       service_class_names:
  ///         - google.pubsub.v1.Publisher: TopicAdmin
  ///         - google.pubsub.v1.Subscriber: SubscriptionAdmin
  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get serviceClassNames => $_getMap(1);

  /// Some settings.
  @$pb.TagNumber(3)
  CommonLanguageSettings get common => $_getN(2);
  @$pb.TagNumber(3)
  set common(CommonLanguageSettings v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCommon() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommon() => clearField(3);
  @$pb.TagNumber(3)
  CommonLanguageSettings ensureCommon() => $_ensure(2);
}

/// Settings for C++ client libraries.
class CppSettings extends $pb.GeneratedMessage {
  factory CppSettings({
    CommonLanguageSettings? common,
  }) {
    final $result = create();
    if (common != null) {
      $result.common = common;
    }
    return $result;
  }
  CppSettings._() : super();
  factory CppSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CppSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CppSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOM<CommonLanguageSettings>(1, _omitFieldNames ? '' : 'common',
        subBuilder: CommonLanguageSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CppSettings clone() => CppSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CppSettings copyWith(void Function(CppSettings) updates) =>
      super.copyWith((message) => updates(message as CppSettings))
          as CppSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CppSettings create() => CppSettings._();
  CppSettings createEmptyInstance() => create();
  static $pb.PbList<CppSettings> createRepeated() => $pb.PbList<CppSettings>();
  @$core.pragma('dart2js:noInline')
  static CppSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CppSettings>(create);
  static CppSettings? _defaultInstance;

  /// Some settings.
  @$pb.TagNumber(1)
  CommonLanguageSettings get common => $_getN(0);
  @$pb.TagNumber(1)
  set common(CommonLanguageSettings v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => clearField(1);
  @$pb.TagNumber(1)
  CommonLanguageSettings ensureCommon() => $_ensure(0);
}

/// Settings for Php client libraries.
class PhpSettings extends $pb.GeneratedMessage {
  factory PhpSettings({
    CommonLanguageSettings? common,
  }) {
    final $result = create();
    if (common != null) {
      $result.common = common;
    }
    return $result;
  }
  PhpSettings._() : super();
  factory PhpSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PhpSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PhpSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOM<CommonLanguageSettings>(1, _omitFieldNames ? '' : 'common',
        subBuilder: CommonLanguageSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PhpSettings clone() => PhpSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PhpSettings copyWith(void Function(PhpSettings) updates) =>
      super.copyWith((message) => updates(message as PhpSettings))
          as PhpSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhpSettings create() => PhpSettings._();
  PhpSettings createEmptyInstance() => create();
  static $pb.PbList<PhpSettings> createRepeated() => $pb.PbList<PhpSettings>();
  @$core.pragma('dart2js:noInline')
  static PhpSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PhpSettings>(create);
  static PhpSettings? _defaultInstance;

  /// Some settings.
  @$pb.TagNumber(1)
  CommonLanguageSettings get common => $_getN(0);
  @$pb.TagNumber(1)
  set common(CommonLanguageSettings v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => clearField(1);
  @$pb.TagNumber(1)
  CommonLanguageSettings ensureCommon() => $_ensure(0);
}

/// Experimental features to be included during client library generation.
/// These fields will be deprecated once the feature graduates and is enabled
/// by default.
class PythonSettings_ExperimentalFeatures extends $pb.GeneratedMessage {
  factory PythonSettings_ExperimentalFeatures({
    $core.bool? restAsyncIoEnabled,
  }) {
    final $result = create();
    if (restAsyncIoEnabled != null) {
      $result.restAsyncIoEnabled = restAsyncIoEnabled;
    }
    return $result;
  }
  PythonSettings_ExperimentalFeatures._() : super();
  factory PythonSettings_ExperimentalFeatures.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PythonSettings_ExperimentalFeatures.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PythonSettings.ExperimentalFeatures',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'restAsyncIoEnabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PythonSettings_ExperimentalFeatures clone() =>
      PythonSettings_ExperimentalFeatures()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PythonSettings_ExperimentalFeatures copyWith(
          void Function(PythonSettings_ExperimentalFeatures) updates) =>
      super.copyWith((message) =>
              updates(message as PythonSettings_ExperimentalFeatures))
          as PythonSettings_ExperimentalFeatures;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PythonSettings_ExperimentalFeatures create() =>
      PythonSettings_ExperimentalFeatures._();
  PythonSettings_ExperimentalFeatures createEmptyInstance() => create();
  static $pb.PbList<PythonSettings_ExperimentalFeatures> createRepeated() =>
      $pb.PbList<PythonSettings_ExperimentalFeatures>();
  @$core.pragma('dart2js:noInline')
  static PythonSettings_ExperimentalFeatures getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          PythonSettings_ExperimentalFeatures>(create);
  static PythonSettings_ExperimentalFeatures? _defaultInstance;

  /// Enables generation of asynchronous REST clients if `rest` transport is
  /// enabled. By default, asynchronous REST clients will not be generated.
  /// This feature will be enabled by default 1 month after launching the
  /// feature in preview packages.
  @$pb.TagNumber(1)
  $core.bool get restAsyncIoEnabled => $_getBF(0);
  @$pb.TagNumber(1)
  set restAsyncIoEnabled($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRestAsyncIoEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearRestAsyncIoEnabled() => clearField(1);
}

/// Settings for Python client libraries.
class PythonSettings extends $pb.GeneratedMessage {
  factory PythonSettings({
    CommonLanguageSettings? common,
    PythonSettings_ExperimentalFeatures? experimentalFeatures,
  }) {
    final $result = create();
    if (common != null) {
      $result.common = common;
    }
    if (experimentalFeatures != null) {
      $result.experimentalFeatures = experimentalFeatures;
    }
    return $result;
  }
  PythonSettings._() : super();
  factory PythonSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PythonSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PythonSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOM<CommonLanguageSettings>(1, _omitFieldNames ? '' : 'common',
        subBuilder: CommonLanguageSettings.create)
    ..aOM<PythonSettings_ExperimentalFeatures>(
        2, _omitFieldNames ? '' : 'experimentalFeatures',
        subBuilder: PythonSettings_ExperimentalFeatures.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PythonSettings clone() => PythonSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PythonSettings copyWith(void Function(PythonSettings) updates) =>
      super.copyWith((message) => updates(message as PythonSettings))
          as PythonSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PythonSettings create() => PythonSettings._();
  PythonSettings createEmptyInstance() => create();
  static $pb.PbList<PythonSettings> createRepeated() =>
      $pb.PbList<PythonSettings>();
  @$core.pragma('dart2js:noInline')
  static PythonSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PythonSettings>(create);
  static PythonSettings? _defaultInstance;

  /// Some settings.
  @$pb.TagNumber(1)
  CommonLanguageSettings get common => $_getN(0);
  @$pb.TagNumber(1)
  set common(CommonLanguageSettings v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => clearField(1);
  @$pb.TagNumber(1)
  CommonLanguageSettings ensureCommon() => $_ensure(0);

  /// Experimental features to be included during client library generation.
  @$pb.TagNumber(2)
  PythonSettings_ExperimentalFeatures get experimentalFeatures => $_getN(1);
  @$pb.TagNumber(2)
  set experimentalFeatures(PythonSettings_ExperimentalFeatures v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasExperimentalFeatures() => $_has(1);
  @$pb.TagNumber(2)
  void clearExperimentalFeatures() => clearField(2);
  @$pb.TagNumber(2)
  PythonSettings_ExperimentalFeatures ensureExperimentalFeatures() =>
      $_ensure(1);
}

/// Settings for Node client libraries.
class NodeSettings extends $pb.GeneratedMessage {
  factory NodeSettings({
    CommonLanguageSettings? common,
  }) {
    final $result = create();
    if (common != null) {
      $result.common = common;
    }
    return $result;
  }
  NodeSettings._() : super();
  factory NodeSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NodeSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NodeSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOM<CommonLanguageSettings>(1, _omitFieldNames ? '' : 'common',
        subBuilder: CommonLanguageSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NodeSettings clone() => NodeSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NodeSettings copyWith(void Function(NodeSettings) updates) =>
      super.copyWith((message) => updates(message as NodeSettings))
          as NodeSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSettings create() => NodeSettings._();
  NodeSettings createEmptyInstance() => create();
  static $pb.PbList<NodeSettings> createRepeated() =>
      $pb.PbList<NodeSettings>();
  @$core.pragma('dart2js:noInline')
  static NodeSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NodeSettings>(create);
  static NodeSettings? _defaultInstance;

  /// Some settings.
  @$pb.TagNumber(1)
  CommonLanguageSettings get common => $_getN(0);
  @$pb.TagNumber(1)
  set common(CommonLanguageSettings v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => clearField(1);
  @$pb.TagNumber(1)
  CommonLanguageSettings ensureCommon() => $_ensure(0);
}

/// Settings for Dotnet client libraries.
class DotnetSettings extends $pb.GeneratedMessage {
  factory DotnetSettings({
    CommonLanguageSettings? common,
    $core.Map<$core.String, $core.String>? renamedServices,
    $core.Map<$core.String, $core.String>? renamedResources,
    $core.Iterable<$core.String>? ignoredResources,
    $core.Iterable<$core.String>? forcedNamespaceAliases,
    $core.Iterable<$core.String>? handwrittenSignatures,
  }) {
    final $result = create();
    if (common != null) {
      $result.common = common;
    }
    if (renamedServices != null) {
      $result.renamedServices.addAll(renamedServices);
    }
    if (renamedResources != null) {
      $result.renamedResources.addAll(renamedResources);
    }
    if (ignoredResources != null) {
      $result.ignoredResources.addAll(ignoredResources);
    }
    if (forcedNamespaceAliases != null) {
      $result.forcedNamespaceAliases.addAll(forcedNamespaceAliases);
    }
    if (handwrittenSignatures != null) {
      $result.handwrittenSignatures.addAll(handwrittenSignatures);
    }
    return $result;
  }
  DotnetSettings._() : super();
  factory DotnetSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DotnetSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DotnetSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOM<CommonLanguageSettings>(1, _omitFieldNames ? '' : 'common',
        subBuilder: CommonLanguageSettings.create)
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'renamedServices',
        entryClassName: 'DotnetSettings.RenamedServicesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..m<$core.String, $core.String>(
        3, _omitFieldNames ? '' : 'renamedResources',
        entryClassName: 'DotnetSettings.RenamedResourcesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..pPS(4, _omitFieldNames ? '' : 'ignoredResources')
    ..pPS(5, _omitFieldNames ? '' : 'forcedNamespaceAliases')
    ..pPS(6, _omitFieldNames ? '' : 'handwrittenSignatures')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DotnetSettings clone() => DotnetSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DotnetSettings copyWith(void Function(DotnetSettings) updates) =>
      super.copyWith((message) => updates(message as DotnetSettings))
          as DotnetSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DotnetSettings create() => DotnetSettings._();
  DotnetSettings createEmptyInstance() => create();
  static $pb.PbList<DotnetSettings> createRepeated() =>
      $pb.PbList<DotnetSettings>();
  @$core.pragma('dart2js:noInline')
  static DotnetSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DotnetSettings>(create);
  static DotnetSettings? _defaultInstance;

  /// Some settings.
  @$pb.TagNumber(1)
  CommonLanguageSettings get common => $_getN(0);
  @$pb.TagNumber(1)
  set common(CommonLanguageSettings v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => clearField(1);
  @$pb.TagNumber(1)
  CommonLanguageSettings ensureCommon() => $_ensure(0);

  /// Map from original service names to renamed versions.
  /// This is used when the default generated types
  /// would cause a naming conflict. (Neither name is
  /// fully-qualified.)
  /// Example: Subscriber to SubscriberServiceApi.
  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get renamedServices => $_getMap(1);

  /// Map from full resource types to the effective short name
  /// for the resource. This is used when otherwise resource
  /// named from different services would cause naming collisions.
  /// Example entry:
  /// "datalabeling.googleapis.com/Dataset": "DataLabelingDataset"
  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get renamedResources => $_getMap(2);

  /// List of full resource types to ignore during generation.
  /// This is typically used for API-specific Location resources,
  /// which should be handled by the generator as if they were actually
  /// the common Location resources.
  /// Example entry: "documentai.googleapis.com/Location"
  @$pb.TagNumber(4)
  $core.List<$core.String> get ignoredResources => $_getList(3);

  /// Namespaces which must be aliased in snippets due to
  /// a known (but non-generator-predictable) naming collision
  @$pb.TagNumber(5)
  $core.List<$core.String> get forcedNamespaceAliases => $_getList(4);

  /// Method signatures (in the form "service.method(signature)")
  /// which are provided separately, so shouldn't be generated.
  /// Snippets *calling* these methods are still generated, however.
  @$pb.TagNumber(6)
  $core.List<$core.String> get handwrittenSignatures => $_getList(5);
}

/// Settings for Ruby client libraries.
class RubySettings extends $pb.GeneratedMessage {
  factory RubySettings({
    CommonLanguageSettings? common,
  }) {
    final $result = create();
    if (common != null) {
      $result.common = common;
    }
    return $result;
  }
  RubySettings._() : super();
  factory RubySettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RubySettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RubySettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOM<CommonLanguageSettings>(1, _omitFieldNames ? '' : 'common',
        subBuilder: CommonLanguageSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RubySettings clone() => RubySettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RubySettings copyWith(void Function(RubySettings) updates) =>
      super.copyWith((message) => updates(message as RubySettings))
          as RubySettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RubySettings create() => RubySettings._();
  RubySettings createEmptyInstance() => create();
  static $pb.PbList<RubySettings> createRepeated() =>
      $pb.PbList<RubySettings>();
  @$core.pragma('dart2js:noInline')
  static RubySettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RubySettings>(create);
  static RubySettings? _defaultInstance;

  /// Some settings.
  @$pb.TagNumber(1)
  CommonLanguageSettings get common => $_getN(0);
  @$pb.TagNumber(1)
  set common(CommonLanguageSettings v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => clearField(1);
  @$pb.TagNumber(1)
  CommonLanguageSettings ensureCommon() => $_ensure(0);
}

/// Settings for Go client libraries.
class GoSettings extends $pb.GeneratedMessage {
  factory GoSettings({
    CommonLanguageSettings? common,
  }) {
    final $result = create();
    if (common != null) {
      $result.common = common;
    }
    return $result;
  }
  GoSettings._() : super();
  factory GoSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GoSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GoSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOM<CommonLanguageSettings>(1, _omitFieldNames ? '' : 'common',
        subBuilder: CommonLanguageSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GoSettings clone() => GoSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GoSettings copyWith(void Function(GoSettings) updates) =>
      super.copyWith((message) => updates(message as GoSettings)) as GoSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GoSettings create() => GoSettings._();
  GoSettings createEmptyInstance() => create();
  static $pb.PbList<GoSettings> createRepeated() => $pb.PbList<GoSettings>();
  @$core.pragma('dart2js:noInline')
  static GoSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GoSettings>(create);
  static GoSettings? _defaultInstance;

  /// Some settings.
  @$pb.TagNumber(1)
  CommonLanguageSettings get common => $_getN(0);
  @$pb.TagNumber(1)
  set common(CommonLanguageSettings v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommon() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommon() => clearField(1);
  @$pb.TagNumber(1)
  CommonLanguageSettings ensureCommon() => $_ensure(0);
}

/// Describes settings to use when generating API methods that use the
/// long-running operation pattern.
/// All default values below are from those used in the client library
/// generators (e.g.
/// [Java](https://github.com/googleapis/gapic-generator-java/blob/04c2faa191a9b5a10b92392fe8482279c4404803/src/main/java/com/google/api/generator/gapic/composer/common/RetrySettingsComposer.java)).
class MethodSettings_LongRunning extends $pb.GeneratedMessage {
  factory MethodSettings_LongRunning({
    $51.Duration? initialPollDelay,
    $core.double? pollDelayMultiplier,
    $51.Duration? maxPollDelay,
    $51.Duration? totalPollTimeout,
  }) {
    final $result = create();
    if (initialPollDelay != null) {
      $result.initialPollDelay = initialPollDelay;
    }
    if (pollDelayMultiplier != null) {
      $result.pollDelayMultiplier = pollDelayMultiplier;
    }
    if (maxPollDelay != null) {
      $result.maxPollDelay = maxPollDelay;
    }
    if (totalPollTimeout != null) {
      $result.totalPollTimeout = totalPollTimeout;
    }
    return $result;
  }
  MethodSettings_LongRunning._() : super();
  factory MethodSettings_LongRunning.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MethodSettings_LongRunning.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MethodSettings.LongRunning',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOM<$51.Duration>(1, _omitFieldNames ? '' : 'initialPollDelay',
        subBuilder: $51.Duration.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'pollDelayMultiplier', $pb.PbFieldType.OF)
    ..aOM<$51.Duration>(3, _omitFieldNames ? '' : 'maxPollDelay',
        subBuilder: $51.Duration.create)
    ..aOM<$51.Duration>(4, _omitFieldNames ? '' : 'totalPollTimeout',
        subBuilder: $51.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MethodSettings_LongRunning clone() =>
      MethodSettings_LongRunning()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MethodSettings_LongRunning copyWith(
          void Function(MethodSettings_LongRunning) updates) =>
      super.copyWith(
              (message) => updates(message as MethodSettings_LongRunning))
          as MethodSettings_LongRunning;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MethodSettings_LongRunning create() => MethodSettings_LongRunning._();
  MethodSettings_LongRunning createEmptyInstance() => create();
  static $pb.PbList<MethodSettings_LongRunning> createRepeated() =>
      $pb.PbList<MethodSettings_LongRunning>();
  @$core.pragma('dart2js:noInline')
  static MethodSettings_LongRunning getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MethodSettings_LongRunning>(create);
  static MethodSettings_LongRunning? _defaultInstance;

  /// Initial delay after which the first poll request will be made.
  /// Default value: 5 seconds.
  @$pb.TagNumber(1)
  $51.Duration get initialPollDelay => $_getN(0);
  @$pb.TagNumber(1)
  set initialPollDelay($51.Duration v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasInitialPollDelay() => $_has(0);
  @$pb.TagNumber(1)
  void clearInitialPollDelay() => clearField(1);
  @$pb.TagNumber(1)
  $51.Duration ensureInitialPollDelay() => $_ensure(0);

  /// Multiplier to gradually increase delay between subsequent polls until it
  /// reaches max_poll_delay.
  /// Default value: 1.5.
  @$pb.TagNumber(2)
  $core.double get pollDelayMultiplier => $_getN(1);
  @$pb.TagNumber(2)
  set pollDelayMultiplier($core.double v) {
    $_setFloat(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPollDelayMultiplier() => $_has(1);
  @$pb.TagNumber(2)
  void clearPollDelayMultiplier() => clearField(2);

  /// Maximum time between two subsequent poll requests.
  /// Default value: 45 seconds.
  @$pb.TagNumber(3)
  $51.Duration get maxPollDelay => $_getN(2);
  @$pb.TagNumber(3)
  set maxPollDelay($51.Duration v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMaxPollDelay() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxPollDelay() => clearField(3);
  @$pb.TagNumber(3)
  $51.Duration ensureMaxPollDelay() => $_ensure(2);

  /// Total polling timeout.
  /// Default value: 5 minutes.
  @$pb.TagNumber(4)
  $51.Duration get totalPollTimeout => $_getN(3);
  @$pb.TagNumber(4)
  set totalPollTimeout($51.Duration v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasTotalPollTimeout() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPollTimeout() => clearField(4);
  @$pb.TagNumber(4)
  $51.Duration ensureTotalPollTimeout() => $_ensure(3);
}

/// Describes the generator configuration for a method.
class MethodSettings extends $pb.GeneratedMessage {
  factory MethodSettings({
    $core.String? selector,
    MethodSettings_LongRunning? longRunning,
    $core.Iterable<$core.String>? autoPopulatedFields,
  }) {
    final $result = create();
    if (selector != null) {
      $result.selector = selector;
    }
    if (longRunning != null) {
      $result.longRunning = longRunning;
    }
    if (autoPopulatedFields != null) {
      $result.autoPopulatedFields.addAll(autoPopulatedFields);
    }
    return $result;
  }
  MethodSettings._() : super();
  factory MethodSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MethodSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MethodSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'selector')
    ..aOM<MethodSettings_LongRunning>(2, _omitFieldNames ? '' : 'longRunning',
        subBuilder: MethodSettings_LongRunning.create)
    ..pPS(3, _omitFieldNames ? '' : 'autoPopulatedFields')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MethodSettings clone() => MethodSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MethodSettings copyWith(void Function(MethodSettings) updates) =>
      super.copyWith((message) => updates(message as MethodSettings))
          as MethodSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MethodSettings create() => MethodSettings._();
  MethodSettings createEmptyInstance() => create();
  static $pb.PbList<MethodSettings> createRepeated() =>
      $pb.PbList<MethodSettings>();
  @$core.pragma('dart2js:noInline')
  static MethodSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MethodSettings>(create);
  static MethodSettings? _defaultInstance;

  ///  The fully qualified name of the method, for which the options below apply.
  ///  This is used to find the method to apply the options.
  ///
  ///  Example:
  ///
  ///     publishing:
  ///       method_settings:
  ///       - selector: google.storage.control.v2.StorageControl.CreateFolder
  ///         # method settings for CreateFolder...
  @$pb.TagNumber(1)
  $core.String get selector => $_getSZ(0);
  @$pb.TagNumber(1)
  set selector($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSelector() => $_has(0);
  @$pb.TagNumber(1)
  void clearSelector() => clearField(1);

  ///  Describes settings to use for long-running operations when generating
  ///  API methods for RPCs. Complements RPCs that use the annotations in
  ///  google/longrunning/operations.proto.
  ///
  ///  Example of a YAML configuration::
  ///
  ///     publishing:
  ///       method_settings:
  ///       - selector: google.cloud.speech.v2.Speech.BatchRecognize
  ///         long_running:
  ///           initial_poll_delay: 60s # 1 minute
  ///           poll_delay_multiplier: 1.5
  ///           max_poll_delay: 360s # 6 minutes
  ///           total_poll_timeout: 54000s # 90 minutes
  @$pb.TagNumber(2)
  MethodSettings_LongRunning get longRunning => $_getN(1);
  @$pb.TagNumber(2)
  set longRunning(MethodSettings_LongRunning v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLongRunning() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongRunning() => clearField(2);
  @$pb.TagNumber(2)
  MethodSettings_LongRunning ensureLongRunning() => $_ensure(1);

  ///  List of top-level fields of the request message, that should be
  ///  automatically populated by the client libraries based on their
  ///  (google.api.field_info).format. Currently supported format: UUID4.
  ///
  ///  Example of a YAML configuration:
  ///
  ///     publishing:
  ///       method_settings:
  ///       - selector: google.example.v1.ExampleService.CreateExample
  ///         auto_populated_fields:
  ///         - request_id
  @$pb.TagNumber(3)
  $core.List<$core.String> get autoPopulatedFields => $_getList(2);
}

class Client {
  static final methodSignature = $pb.Extension<$core.String>.repeated(
      _omitMessageNames ? '' : 'google.protobuf.MethodOptions',
      _omitFieldNames ? '' : 'methodSignature',
      1051,
      $pb.PbFieldType.PS,
      check: $pb.getCheckFunction($pb.PbFieldType.PS));
  static final defaultHost = $pb.Extension<$core.String>(
      _omitMessageNames ? '' : 'google.protobuf.ServiceOptions',
      _omitFieldNames ? '' : 'defaultHost',
      1049,
      $pb.PbFieldType.OS);
  static final oauthScopes = $pb.Extension<$core.String>(
      _omitMessageNames ? '' : 'google.protobuf.ServiceOptions',
      _omitFieldNames ? '' : 'oauthScopes',
      1050,
      $pb.PbFieldType.OS);
  static final apiVersion = $pb.Extension<$core.String>(
      _omitMessageNames ? '' : 'google.protobuf.ServiceOptions',
      _omitFieldNames ? '' : 'apiVersion',
      525000001,
      $pb.PbFieldType.OS);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(methodSignature);
    registry.add(defaultHost);
    registry.add(oauthScopes);
    registry.add(apiVersion);
  }
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
