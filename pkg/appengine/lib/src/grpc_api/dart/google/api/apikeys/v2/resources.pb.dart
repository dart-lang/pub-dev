//
//  Generated code. Do not modify.
//  source: google/api/apikeys/v2/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/timestamp.pb.dart' as $50;

/// The representation of a key managed by the API Keys API.
class Key extends $pb.GeneratedMessage {
  factory Key({
    $core.String? name,
    $core.String? displayName,
    $core.String? keyString,
    $50.Timestamp? createTime,
    $core.String? uid,
    $50.Timestamp? updateTime,
    $50.Timestamp? deleteTime,
    $core.Map<$core.String, $core.String>? annotations,
    Restrictions? restrictions,
    $core.String? etag,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (keyString != null) {
      $result.keyString = keyString;
    }
    if (createTime != null) {
      $result.createTime = createTime;
    }
    if (uid != null) {
      $result.uid = uid;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    if (deleteTime != null) {
      $result.deleteTime = deleteTime;
    }
    if (annotations != null) {
      $result.annotations.addAll(annotations);
    }
    if (restrictions != null) {
      $result.restrictions = restrictions;
    }
    if (etag != null) {
      $result.etag = etag;
    }
    return $result;
  }
  Key._() : super();
  factory Key.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Key.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Key',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.apikeys.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'keyString')
    ..aOM<$50.Timestamp>(4, _omitFieldNames ? '' : 'createTime',
        subBuilder: $50.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'uid')
    ..aOM<$50.Timestamp>(6, _omitFieldNames ? '' : 'updateTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(7, _omitFieldNames ? '' : 'deleteTime',
        subBuilder: $50.Timestamp.create)
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'annotations',
        entryClassName: 'Key.AnnotationsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.apikeys.v2'))
    ..aOM<Restrictions>(9, _omitFieldNames ? '' : 'restrictions',
        subBuilder: Restrictions.create)
    ..aOS(11, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Key clone() => Key()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Key copyWith(void Function(Key) updates) =>
      super.copyWith((message) => updates(message as Key)) as Key;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Key create() => Key._();
  Key createEmptyInstance() => create();
  static $pb.PbList<Key> createRepeated() => $pb.PbList<Key>();
  @$core.pragma('dart2js:noInline')
  static Key getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Key>(create);
  static Key? _defaultInstance;

  ///  Output only. The resource name of the key.
  ///  The `name` has the form:
  ///  `projects/<PROJECT_NUMBER>/locations/global/keys/<KEY_ID>`.
  ///  For example:
  ///  `projects/123456867718/locations/global/keys/b7ff1f9f-8275-410a-94dd-3855ee9b5dd2`
  ///
  ///  NOTE: Key is a global resource; hence the only supported value for
  ///  location is `global`.
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

  /// Human-readable display name of this key that you can modify.
  /// The maximum length is 63 characters.
  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  /// Output only. An encrypted and signed value held by this key.
  /// This field can be accessed only through the `GetKeyString` method.
  @$pb.TagNumber(3)
  $core.String get keyString => $_getSZ(2);
  @$pb.TagNumber(3)
  set keyString($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasKeyString() => $_has(2);
  @$pb.TagNumber(3)
  void clearKeyString() => clearField(3);

  /// Output only. A timestamp identifying the time this key was originally
  /// created.
  @$pb.TagNumber(4)
  $50.Timestamp get createTime => $_getN(3);
  @$pb.TagNumber(4)
  set createTime($50.Timestamp v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCreateTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreateTime() => clearField(4);
  @$pb.TagNumber(4)
  $50.Timestamp ensureCreateTime() => $_ensure(3);

  /// Output only. Unique id in UUID4 format.
  @$pb.TagNumber(5)
  $core.String get uid => $_getSZ(4);
  @$pb.TagNumber(5)
  set uid($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasUid() => $_has(4);
  @$pb.TagNumber(5)
  void clearUid() => clearField(5);

  /// Output only. A timestamp identifying the time this key was last
  /// updated.
  @$pb.TagNumber(6)
  $50.Timestamp get updateTime => $_getN(5);
  @$pb.TagNumber(6)
  set updateTime($50.Timestamp v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasUpdateTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdateTime() => clearField(6);
  @$pb.TagNumber(6)
  $50.Timestamp ensureUpdateTime() => $_ensure(5);

  /// Output only. A timestamp when this key was deleted. If the resource is not
  /// deleted, this must be empty.
  @$pb.TagNumber(7)
  $50.Timestamp get deleteTime => $_getN(6);
  @$pb.TagNumber(7)
  set deleteTime($50.Timestamp v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasDeleteTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeleteTime() => clearField(7);
  @$pb.TagNumber(7)
  $50.Timestamp ensureDeleteTime() => $_ensure(6);

  /// Annotations is an unstructured key-value map stored with a policy that
  /// may be set by external tools to store and retrieve arbitrary metadata.
  /// They are not queryable and should be preserved when modifying objects.
  @$pb.TagNumber(8)
  $core.Map<$core.String, $core.String> get annotations => $_getMap(7);

  /// Key restrictions.
  @$pb.TagNumber(9)
  Restrictions get restrictions => $_getN(8);
  @$pb.TagNumber(9)
  set restrictions(Restrictions v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasRestrictions() => $_has(8);
  @$pb.TagNumber(9)
  void clearRestrictions() => clearField(9);
  @$pb.TagNumber(9)
  Restrictions ensureRestrictions() => $_ensure(8);

  /// Output only. A checksum computed by the server based on the current value
  /// of the Key resource. This may be sent on update and delete requests to
  /// ensure the client has an up-to-date value before proceeding. See
  /// https://google.aip.dev/154.
  @$pb.TagNumber(11)
  $core.String get etag => $_getSZ(9);
  @$pb.TagNumber(11)
  set etag($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasEtag() => $_has(9);
  @$pb.TagNumber(11)
  void clearEtag() => clearField(11);
}

enum Restrictions_ClientRestrictions {
  browserKeyRestrictions,
  serverKeyRestrictions,
  androidKeyRestrictions,
  iosKeyRestrictions,
  notSet
}

/// Describes the restrictions on the key.
class Restrictions extends $pb.GeneratedMessage {
  factory Restrictions({
    BrowserKeyRestrictions? browserKeyRestrictions,
    ServerKeyRestrictions? serverKeyRestrictions,
    AndroidKeyRestrictions? androidKeyRestrictions,
    IosKeyRestrictions? iosKeyRestrictions,
    $core.Iterable<ApiTarget>? apiTargets,
  }) {
    final $result = create();
    if (browserKeyRestrictions != null) {
      $result.browserKeyRestrictions = browserKeyRestrictions;
    }
    if (serverKeyRestrictions != null) {
      $result.serverKeyRestrictions = serverKeyRestrictions;
    }
    if (androidKeyRestrictions != null) {
      $result.androidKeyRestrictions = androidKeyRestrictions;
    }
    if (iosKeyRestrictions != null) {
      $result.iosKeyRestrictions = iosKeyRestrictions;
    }
    if (apiTargets != null) {
      $result.apiTargets.addAll(apiTargets);
    }
    return $result;
  }
  Restrictions._() : super();
  factory Restrictions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Restrictions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Restrictions_ClientRestrictions>
      _Restrictions_ClientRestrictionsByTag = {
    1: Restrictions_ClientRestrictions.browserKeyRestrictions,
    2: Restrictions_ClientRestrictions.serverKeyRestrictions,
    3: Restrictions_ClientRestrictions.androidKeyRestrictions,
    4: Restrictions_ClientRestrictions.iosKeyRestrictions,
    0: Restrictions_ClientRestrictions.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Restrictions',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.apikeys.v2'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<BrowserKeyRestrictions>(
        1, _omitFieldNames ? '' : 'browserKeyRestrictions',
        subBuilder: BrowserKeyRestrictions.create)
    ..aOM<ServerKeyRestrictions>(
        2, _omitFieldNames ? '' : 'serverKeyRestrictions',
        subBuilder: ServerKeyRestrictions.create)
    ..aOM<AndroidKeyRestrictions>(
        3, _omitFieldNames ? '' : 'androidKeyRestrictions',
        subBuilder: AndroidKeyRestrictions.create)
    ..aOM<IosKeyRestrictions>(4, _omitFieldNames ? '' : 'iosKeyRestrictions',
        subBuilder: IosKeyRestrictions.create)
    ..pc<ApiTarget>(5, _omitFieldNames ? '' : 'apiTargets', $pb.PbFieldType.PM,
        subBuilder: ApiTarget.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Restrictions clone() => Restrictions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Restrictions copyWith(void Function(Restrictions) updates) =>
      super.copyWith((message) => updates(message as Restrictions))
          as Restrictions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Restrictions create() => Restrictions._();
  Restrictions createEmptyInstance() => create();
  static $pb.PbList<Restrictions> createRepeated() =>
      $pb.PbList<Restrictions>();
  @$core.pragma('dart2js:noInline')
  static Restrictions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Restrictions>(create);
  static Restrictions? _defaultInstance;

  Restrictions_ClientRestrictions whichClientRestrictions() =>
      _Restrictions_ClientRestrictionsByTag[$_whichOneof(0)]!;
  void clearClientRestrictions() => clearField($_whichOneof(0));

  /// The HTTP referrers (websites) that are allowed to use the key.
  @$pb.TagNumber(1)
  BrowserKeyRestrictions get browserKeyRestrictions => $_getN(0);
  @$pb.TagNumber(1)
  set browserKeyRestrictions(BrowserKeyRestrictions v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBrowserKeyRestrictions() => $_has(0);
  @$pb.TagNumber(1)
  void clearBrowserKeyRestrictions() => clearField(1);
  @$pb.TagNumber(1)
  BrowserKeyRestrictions ensureBrowserKeyRestrictions() => $_ensure(0);

  /// The IP addresses of callers that are allowed to use the key.
  @$pb.TagNumber(2)
  ServerKeyRestrictions get serverKeyRestrictions => $_getN(1);
  @$pb.TagNumber(2)
  set serverKeyRestrictions(ServerKeyRestrictions v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasServerKeyRestrictions() => $_has(1);
  @$pb.TagNumber(2)
  void clearServerKeyRestrictions() => clearField(2);
  @$pb.TagNumber(2)
  ServerKeyRestrictions ensureServerKeyRestrictions() => $_ensure(1);

  /// The Android apps that are allowed to use the key.
  @$pb.TagNumber(3)
  AndroidKeyRestrictions get androidKeyRestrictions => $_getN(2);
  @$pb.TagNumber(3)
  set androidKeyRestrictions(AndroidKeyRestrictions v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAndroidKeyRestrictions() => $_has(2);
  @$pb.TagNumber(3)
  void clearAndroidKeyRestrictions() => clearField(3);
  @$pb.TagNumber(3)
  AndroidKeyRestrictions ensureAndroidKeyRestrictions() => $_ensure(2);

  /// The iOS apps that are allowed to use the key.
  @$pb.TagNumber(4)
  IosKeyRestrictions get iosKeyRestrictions => $_getN(3);
  @$pb.TagNumber(4)
  set iosKeyRestrictions(IosKeyRestrictions v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIosKeyRestrictions() => $_has(3);
  @$pb.TagNumber(4)
  void clearIosKeyRestrictions() => clearField(4);
  @$pb.TagNumber(4)
  IosKeyRestrictions ensureIosKeyRestrictions() => $_ensure(3);

  /// A restriction for a specific service and optionally one or
  /// more specific methods. Requests are allowed if they
  /// match any of these restrictions. If no restrictions are
  /// specified, all targets are allowed.
  @$pb.TagNumber(5)
  $core.List<ApiTarget> get apiTargets => $_getList(4);
}

/// The HTTP referrers (websites) that are allowed to use the key.
class BrowserKeyRestrictions extends $pb.GeneratedMessage {
  factory BrowserKeyRestrictions({
    $core.Iterable<$core.String>? allowedReferrers,
  }) {
    final $result = create();
    if (allowedReferrers != null) {
      $result.allowedReferrers.addAll(allowedReferrers);
    }
    return $result;
  }
  BrowserKeyRestrictions._() : super();
  factory BrowserKeyRestrictions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BrowserKeyRestrictions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BrowserKeyRestrictions',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.apikeys.v2'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'allowedReferrers')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BrowserKeyRestrictions clone() =>
      BrowserKeyRestrictions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BrowserKeyRestrictions copyWith(
          void Function(BrowserKeyRestrictions) updates) =>
      super.copyWith((message) => updates(message as BrowserKeyRestrictions))
          as BrowserKeyRestrictions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BrowserKeyRestrictions create() => BrowserKeyRestrictions._();
  BrowserKeyRestrictions createEmptyInstance() => create();
  static $pb.PbList<BrowserKeyRestrictions> createRepeated() =>
      $pb.PbList<BrowserKeyRestrictions>();
  @$core.pragma('dart2js:noInline')
  static BrowserKeyRestrictions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BrowserKeyRestrictions>(create);
  static BrowserKeyRestrictions? _defaultInstance;

  /// A list of regular expressions for the referrer URLs that are allowed
  /// to make API calls with this key.
  @$pb.TagNumber(1)
  $core.List<$core.String> get allowedReferrers => $_getList(0);
}

/// The IP addresses of callers that are allowed to use the key.
class ServerKeyRestrictions extends $pb.GeneratedMessage {
  factory ServerKeyRestrictions({
    $core.Iterable<$core.String>? allowedIps,
  }) {
    final $result = create();
    if (allowedIps != null) {
      $result.allowedIps.addAll(allowedIps);
    }
    return $result;
  }
  ServerKeyRestrictions._() : super();
  factory ServerKeyRestrictions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ServerKeyRestrictions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServerKeyRestrictions',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.apikeys.v2'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'allowedIps')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ServerKeyRestrictions clone() =>
      ServerKeyRestrictions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ServerKeyRestrictions copyWith(
          void Function(ServerKeyRestrictions) updates) =>
      super.copyWith((message) => updates(message as ServerKeyRestrictions))
          as ServerKeyRestrictions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServerKeyRestrictions create() => ServerKeyRestrictions._();
  ServerKeyRestrictions createEmptyInstance() => create();
  static $pb.PbList<ServerKeyRestrictions> createRepeated() =>
      $pb.PbList<ServerKeyRestrictions>();
  @$core.pragma('dart2js:noInline')
  static ServerKeyRestrictions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServerKeyRestrictions>(create);
  static ServerKeyRestrictions? _defaultInstance;

  /// A list of the caller IP addresses that are allowed to make API calls
  /// with this key.
  @$pb.TagNumber(1)
  $core.List<$core.String> get allowedIps => $_getList(0);
}

/// The Android apps that are allowed to use the key.
class AndroidKeyRestrictions extends $pb.GeneratedMessage {
  factory AndroidKeyRestrictions({
    $core.Iterable<AndroidApplication>? allowedApplications,
  }) {
    final $result = create();
    if (allowedApplications != null) {
      $result.allowedApplications.addAll(allowedApplications);
    }
    return $result;
  }
  AndroidKeyRestrictions._() : super();
  factory AndroidKeyRestrictions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AndroidKeyRestrictions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AndroidKeyRestrictions',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.apikeys.v2'),
      createEmptyInstance: create)
    ..pc<AndroidApplication>(
        1, _omitFieldNames ? '' : 'allowedApplications', $pb.PbFieldType.PM,
        subBuilder: AndroidApplication.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AndroidKeyRestrictions clone() =>
      AndroidKeyRestrictions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AndroidKeyRestrictions copyWith(
          void Function(AndroidKeyRestrictions) updates) =>
      super.copyWith((message) => updates(message as AndroidKeyRestrictions))
          as AndroidKeyRestrictions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AndroidKeyRestrictions create() => AndroidKeyRestrictions._();
  AndroidKeyRestrictions createEmptyInstance() => create();
  static $pb.PbList<AndroidKeyRestrictions> createRepeated() =>
      $pb.PbList<AndroidKeyRestrictions>();
  @$core.pragma('dart2js:noInline')
  static AndroidKeyRestrictions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AndroidKeyRestrictions>(create);
  static AndroidKeyRestrictions? _defaultInstance;

  /// A list of Android applications that are allowed to make API calls with
  /// this key.
  @$pb.TagNumber(1)
  $core.List<AndroidApplication> get allowedApplications => $_getList(0);
}

/// Identifier of an Android application for key use.
class AndroidApplication extends $pb.GeneratedMessage {
  factory AndroidApplication({
    $core.String? sha1Fingerprint,
    $core.String? packageName,
  }) {
    final $result = create();
    if (sha1Fingerprint != null) {
      $result.sha1Fingerprint = sha1Fingerprint;
    }
    if (packageName != null) {
      $result.packageName = packageName;
    }
    return $result;
  }
  AndroidApplication._() : super();
  factory AndroidApplication.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AndroidApplication.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AndroidApplication',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.apikeys.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sha1Fingerprint')
    ..aOS(2, _omitFieldNames ? '' : 'packageName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AndroidApplication clone() => AndroidApplication()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AndroidApplication copyWith(void Function(AndroidApplication) updates) =>
      super.copyWith((message) => updates(message as AndroidApplication))
          as AndroidApplication;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AndroidApplication create() => AndroidApplication._();
  AndroidApplication createEmptyInstance() => create();
  static $pb.PbList<AndroidApplication> createRepeated() =>
      $pb.PbList<AndroidApplication>();
  @$core.pragma('dart2js:noInline')
  static AndroidApplication getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AndroidApplication>(create);
  static AndroidApplication? _defaultInstance;

  /// The SHA1 fingerprint of the application. For example, both sha1 formats are
  /// acceptable : DA:39:A3:EE:5E:6B:4B:0D:32:55:BF:EF:95:60:18:90:AF:D8:07:09 or
  /// DA39A3EE5E6B4B0D3255BFEF95601890AFD80709.
  /// Output format is the latter.
  @$pb.TagNumber(1)
  $core.String get sha1Fingerprint => $_getSZ(0);
  @$pb.TagNumber(1)
  set sha1Fingerprint($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSha1Fingerprint() => $_has(0);
  @$pb.TagNumber(1)
  void clearSha1Fingerprint() => clearField(1);

  /// The package name of the application.
  @$pb.TagNumber(2)
  $core.String get packageName => $_getSZ(1);
  @$pb.TagNumber(2)
  set packageName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPackageName() => $_has(1);
  @$pb.TagNumber(2)
  void clearPackageName() => clearField(2);
}

/// The iOS apps that are allowed to use the key.
class IosKeyRestrictions extends $pb.GeneratedMessage {
  factory IosKeyRestrictions({
    $core.Iterable<$core.String>? allowedBundleIds,
  }) {
    final $result = create();
    if (allowedBundleIds != null) {
      $result.allowedBundleIds.addAll(allowedBundleIds);
    }
    return $result;
  }
  IosKeyRestrictions._() : super();
  factory IosKeyRestrictions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory IosKeyRestrictions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IosKeyRestrictions',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.apikeys.v2'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'allowedBundleIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  IosKeyRestrictions clone() => IosKeyRestrictions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  IosKeyRestrictions copyWith(void Function(IosKeyRestrictions) updates) =>
      super.copyWith((message) => updates(message as IosKeyRestrictions))
          as IosKeyRestrictions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IosKeyRestrictions create() => IosKeyRestrictions._();
  IosKeyRestrictions createEmptyInstance() => create();
  static $pb.PbList<IosKeyRestrictions> createRepeated() =>
      $pb.PbList<IosKeyRestrictions>();
  @$core.pragma('dart2js:noInline')
  static IosKeyRestrictions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IosKeyRestrictions>(create);
  static IosKeyRestrictions? _defaultInstance;

  /// A list of bundle IDs that are allowed when making API calls with this key.
  @$pb.TagNumber(1)
  $core.List<$core.String> get allowedBundleIds => $_getList(0);
}

/// A restriction for a specific service and optionally one or multiple
/// specific methods. Both fields are case insensitive.
class ApiTarget extends $pb.GeneratedMessage {
  factory ApiTarget({
    $core.String? service,
    $core.Iterable<$core.String>? methods,
  }) {
    final $result = create();
    if (service != null) {
      $result.service = service;
    }
    if (methods != null) {
      $result.methods.addAll(methods);
    }
    return $result;
  }
  ApiTarget._() : super();
  factory ApiTarget.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ApiTarget.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApiTarget',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.apikeys.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'service')
    ..pPS(2, _omitFieldNames ? '' : 'methods')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ApiTarget clone() => ApiTarget()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ApiTarget copyWith(void Function(ApiTarget) updates) =>
      super.copyWith((message) => updates(message as ApiTarget)) as ApiTarget;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApiTarget create() => ApiTarget._();
  ApiTarget createEmptyInstance() => create();
  static $pb.PbList<ApiTarget> createRepeated() => $pb.PbList<ApiTarget>();
  @$core.pragma('dart2js:noInline')
  static ApiTarget getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApiTarget>(create);
  static ApiTarget? _defaultInstance;

  /// The service for this restriction. It should be the canonical
  /// service name, for example: `translate.googleapis.com`.
  /// You can use [`gcloud services list`](/sdk/gcloud/reference/services/list)
  /// to get a list of services that are enabled in the project.
  @$pb.TagNumber(1)
  $core.String get service => $_getSZ(0);
  @$pb.TagNumber(1)
  set service($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasService() => $_has(0);
  @$pb.TagNumber(1)
  void clearService() => clearField(1);

  /// Optional. List of one or more methods that can be called.
  /// If empty, all methods for the service are allowed. A wildcard
  /// (*) can be used as the last symbol.
  /// Valid examples:
  ///   `google.cloud.translate.v2.TranslateService.GetSupportedLanguage`
  ///   `TranslateText`
  ///   `Get*`
  ///   `translate.googleapis.com.Get*`
  @$pb.TagNumber(2)
  $core.List<$core.String> get methods => $_getList(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
