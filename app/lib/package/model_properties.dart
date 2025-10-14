// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pana/pana.dart' show SdkConstraintStatus;
import 'package:pub_package_reader/pub_package_reader.dart'
    show checkStrictVersions;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart'
    as pubspek
    show Dependency, Pubspec;
import 'package:yaml/yaml.dart';

import '../../service/topics/models.dart';
import '../shared/datastore.dart';
import '../shared/utils.dart' show canonicalizeVersion;
import '../shared/versions.dart' as versions;

Map<String, dynamic> _loadYaml(String yamlString) {
  final map = loadYaml(yamlString) as Map;
  // TODO: remove this part after yaml returns a proper map
  if (map is YamlMap) {
    return json.decode(json.encode(map)) as Map<String, dynamic>;
  }
  return map as Map<String, dynamic>;
}

class Pubspec {
  final pubspek.Pubspec _inner;
  final String jsonString;
  String? _canonicalVersion;

  Pubspec._(this._inner, this.jsonString);

  factory Pubspec(String jsonString) =>
      Pubspec._(pubspek.Pubspec.parse(jsonString, lenient: true), jsonString);

  factory Pubspec.fromYaml(String yamlString) => Pubspec._(
    pubspek.Pubspec.parse(yamlString, lenient: true),
    json.encode(_loadYaml(yamlString)),
  );

  factory Pubspec.fromJson(Map<String, dynamic> map) =>
      Pubspec._(pubspek.Pubspec.fromJson(map, lenient: true), json.encode(map));

  late final _json = _loadYaml(jsonString);

  Map<String, dynamic> get asJson => _json;

  String get name => _inner.name;

  String get nonCanonicalVersion => _inner.version.toString();
  String get canonicalVersion {
    if (_canonicalVersion == null) {
      _canonicalVersion = canonicalizeVersion(nonCanonicalVersion);
      if (_canonicalVersion == null) {
        throw AssertionError(
          'Unable to canonicalize the version: $nonCanonicalVersion',
        );
      }
    }
    return _canonicalVersion!;
  }

  Iterable<String> get dependencyNames => _inner.dependencies.keys;
  Map<String, pubspek.Dependency> get dependencies => _inner.dependencies;

  Iterable<String> get devDependencies => _inner.devDependencies.keys;

  String? get documentation => _inner.documentation;

  String? get homepage => _inner.homepage;

  String? get repository => _inner.repository?.toString();

  String? get issueTracker => _inner.issueTracker?.toString();

  String? get description => _inner.description;

  late final canonicalizedTopics = (_inner.topics ?? const <String>[])
      .map((e) => canonicalTopics.aliasToCanonicalMap[e] ?? e)
      .toSet()
      .toList();

  Map<String, dynamic>? get executables {
    final map = _json['executables'];
    return map is Map<String, dynamic> ? map : null;
  }

  /// Whether the pubspec has any version value inside that is not formatter properly.
  bool get hasBadVersionFormat => checkStrictVersions(_inner).isNotEmpty;

  /// Returns the minimal SDK version for the Dart SDK.
  ///
  /// Returns null if the constraint is missing or does not follow the
  /// `>=<version>` pattern.
  MinSdkVersion? get minSdkVersion {
    return MinSdkVersion.tryParse(_inner.environment['sdk']);
  }

  /// Returns the minimal SDK version for the Flutter SDK.
  ///
  /// Returns null if the constraint is missing or does not follow the
  /// `>=<version>` pattern.
  late final _minFlutterSdkVersion = () {
    return MinSdkVersion.tryParse(_inner.environment['flutter']);
  }();

  /// True if the min SDK version constraint is higher than the current SDK.
  bool isPreviewForCurrentSdk({
    required Version dartSdkVersion,
    required Version flutterSdkVersion,
  }) {
    final minDartVersion = minSdkVersion;
    return (minDartVersion != null &&
            minDartVersion.value.compareTo(dartSdkVersion) > 0) ||
        (_minFlutterSdkVersion != null &&
            _minFlutterSdkVersion.value.compareTo(flutterSdkVersion) > 0);
  }

  /// True if either the Dart or the Flutter SDK constraint is higher than the
  /// stable analysis SDK in the current runtime.
  bool usesPreviewAnalysisSdk() {
    if (isPreviewForCurrentSdk(
      dartSdkVersion: versions.semanticToolStableDartSdkVersion,
      flutterSdkVersion: versions.semanticToolStableFlutterSdkVersion,
    )) {
      return true;
    }
    final v = MinSdkVersion.tryParse(_inner.environment['flutter']);
    if (v != null &&
        v.value.compareTo(versions.semanticToolStableFlutterSdkVersion) > 0) {
      return true;
    }
    return false;
  }

  late final _dartSdkConstraint = _inner.environment['sdk'];
  late final _flutterSdkConstraint = _inner.environment['flutter'];
  late final _hasDartSdkConstraint =
      _dartSdkConstraint != null &&
      !_dartSdkConstraint.isAny &&
      !_dartSdkConstraint.isEmpty;

  late final _sdkConstraintStatus = SdkConstraintStatus.fromSdkVersion(
    _dartSdkConstraint,
  );

  bool get supportsOnlyLegacySdk =>
      _flutterSdkConstraint == null &&
      (!_hasDartSdkConstraint ||
          _dartSdkConstraint!
              .intersect(VersionConstraint.parse('>=2.0.0'))
              .isEmpty);

  late final isDart3Incompatible =
      !supportsOnlyLegacySdk && // do not mix is:legacy with is:dart3-incompatible
      _hasDartSdkConstraint &&
      !_dartSdkConstraint!
          .intersect(VersionConstraint.parse('<2.12.0-0'))
          .isEmpty;

  late final _flutterPluginMap = () {
    final flutter = _json['flutter'];
    if (flutter == null || flutter is! Map) {
      return null;
    }
    final plugin = flutter['plugin'];
    if (plugin != null && plugin is Map<String, dynamic>) {
      return plugin;
    } else {
      return null;
    }
  }();

  /// Whether the pubspec file contains a flutter.plugin entry.
  bool get hasFlutterPlugin => _flutterPluginMap != null;

  /// Whether the package has a dependency on flutter.
  bool get dependsOnFlutter {
    final dependencies = _json['dependencies'];
    if (dependencies == null || dependencies is! Map) return false;
    return dependencies.containsKey('flutter');
  }

  /// Whether the package has a dependency on flutter and it refers to the SDK.
  bool get dependsOnFlutterSdk {
    final dependencies = _json['dependencies'];
    if (dependencies == null || dependencies is! Map) return false;
    final flutter = dependencies['flutter'];
    if (flutter == null || flutter is! Map) return false;
    return flutter['sdk'] == 'flutter';
  }

  /// Whether the package uses Flutter in any way.
  bool get usesFlutter => dependsOnFlutter || hasFlutterPlugin;

  bool get hasOptedIntoNullSafety =>
      _sdkConstraintStatus.hasOptedIntoNullSafety;

  late final List<Uri> funding = _inner.funding ?? const <Uri>[];

  /// Whether the pubspec has any topic entry.
  bool get hasTopic => canonicalizedTopics.isNotEmpty;

  /// If package is implementing a federated Flutter plugin, this will be name
  /// of the plugin package, `null` otherwise.
  late final implementsFederatedPluginName = () {
    if (_flutterPluginMap == null) {
      return null;
    }
    final implements = _flutterPluginMap['implements'];
    if (implements != null && implements is String) {
      return implements;
    } else {
      return null;
    }
  }();
}

class MinSdkVersion {
  final Version value;
  final String? channel;

  MinSdkVersion(this.value, this.channel);

  static MinSdkVersion? tryParse(VersionConstraint? constraint) {
    if (constraint == null || constraint is! VersionRange) {
      return null;
    }
    final min = constraint.min;
    if (min != null && !min.isAny && !min.isEmpty) {
      final str = min.toString();
      String? channel;
      if (str.endsWith('.dev')) {
        channel = 'dev';
      } else if (str.endsWith('.beta')) {
        channel = 'beta';
      } else if (min.isPreRelease) {
        channel = 'dev';
      }
      return MinSdkVersion(min, channel);
    }
    return null;
  }

  int get major => value.major;
  int get minor => value.minor;
}

class PubspecProperty extends StringProperty {
  const PubspecProperty({super.propertyName, super.required = false})
    : super(indexed: false);

  @override
  bool validate(ModelDB db, Object? value) =>
      (!required || value != null) && (value == null || value is Pubspec);

  @override
  String? encodeValue(
    ModelDB db,
    Object? pubspec, {
    bool forComparison = false,
  }) {
    if (pubspec is Pubspec) {
      return pubspec.jsonString;
    }
    return null;
  }

  @override
  Object? decodePrimitiveValue(ModelDB db, Object? value) {
    if (value is String) {
      return Pubspec(value);
    }
    return null;
  }
}
