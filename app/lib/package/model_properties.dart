// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.model_properties;

import 'dart:convert';

import 'package:pana/pana.dart' show SdkConstraintStatus;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart' as pubspek
    show HostedDependency, Pubspec;
import 'package:yaml/yaml.dart';

import '../shared/datastore.dart';
import '../shared/utils.dart' show canonicalizeVersion;

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
  Map<String, dynamic> _json;
  String _canonicalVersion;

  Pubspec._(this._inner, this.jsonString);

  factory Pubspec(String jsonString) =>
      Pubspec._(pubspek.Pubspec.parse(jsonString, lenient: true), jsonString);

  factory Pubspec.fromYaml(String yamlString) => Pubspec._(
      pubspek.Pubspec.parse(yamlString, lenient: true),
      json.encode(_loadYaml(yamlString)));

  factory Pubspec.fromJson(Map<String, dynamic> map) =>
      Pubspec._(pubspek.Pubspec.fromJson(map, lenient: true), json.encode(map));

  Map<String, dynamic> get asJson {
    _load();
    return _json;
  }

  String get name => _inner.name;

  String get nonCanonicalVersion => _inner.version.toString();
  String get canonicalVersion {
    if (_canonicalVersion == null) {
      _canonicalVersion = canonicalizeVersion(nonCanonicalVersion);
      if (_canonicalVersion == null) {
        throw AssertionError(
            'Unable to canonicalize the version: $nonCanonicalVersion');
      }
    }
    return _canonicalVersion;
  }

  Iterable<String> get dependencies => _inner.dependencies.keys;

  bool isHostedDependency(String package) {
    final d = _inner.dependencies[package];
    return d is pubspek.HostedDependency;
  }

  Iterable<String> get devDependencies => _inner.devDependencies.keys;

  String get documentation => _inner.documentation;

  String get homepage => _inner.homepage;

  String get repository => _inner.repository?.toString();

  String get issueTracker => _inner.issueTracker?.toString();

  String get description => _inner.description;

  bool get hasBothAuthorAndAuthors {
    _load();
    return _json['author'] != null && _json['authors'] != null;
  }

  Map<String, dynamic> get executables {
    _load();
    final map = _json['executables'];
    return map is Map<String, dynamic> ? map : null;
  }

  /// Returns the minimal SDK version for the Dart SDK.
  ///
  /// Returns null if the constraint is missing or does not follow the
  /// `>=<version>` pattern.
  MinSdkVersion get minSdkVersion {
    _load();
    return MinSdkVersion.tryParse(_inner.environment['sdk']);
  }

  /// True if the min Dart SDK version constraint is higher than the current SDK.
  bool isPreviewForCurrentSdk(Version currentSdkVersion) {
    final msv = minSdkVersion;
    return msv != null && msv.value.compareTo(currentSdkVersion) > 0;
  }

  String get sdkConstraint {
    _load();
    final environment = _json['environment'];
    if (environment == null || environment is! Map) return null;
    return _asString(environment['sdk']);
  }

  // TODO: migrate uses to SdkConstraintStatus.isDart2Compatible
  bool get supportsOnlyLegacySdk {
    final s =
        SdkConstraintStatus.fromSdkVersion(_inner.environment['sdk'], name);
    return !s.isDart2Compatible;
  }

  /// Whether the pubspec file contains a flutter.plugin entry.
  bool get hasFlutterPlugin {
    _load();
    final flutter = _json['flutter'];
    if (flutter == null || flutter is! Map) return false;
    final plugin = flutter['plugin'];
    return plugin != null && plugin is Map;
  }

  /// Whether the package has a dependency on flutter.
  bool get dependsOnFlutter {
    _load();
    final dependencies = _json['dependencies'];
    if (dependencies == null || dependencies is! Map) return false;
    return (dependencies as Map).containsKey('flutter');
  }

  /// Whether the package has a dependency on flutter and it refers to the SDK.
  bool get dependsOnFlutterSdk {
    _load();
    final dependencies = _json['dependencies'];
    if (dependencies == null || dependencies is! Map) return false;
    final flutter = dependencies['flutter'];
    if (flutter == null || flutter is! Map) return false;
    return flutter['sdk'] == 'flutter';
  }

  /// Whether the package uses Flutter in any way.
  bool get usesFlutter => dependsOnFlutter || hasFlutterPlugin;

  void _load() {
    if (_json == null) {
      if (jsonString != null) {
        _json = _loadYaml(jsonString);
      } else {
        _json = const {};
      }
    }
  }

  String _asString(obj) {
    if (obj == null) return null;
    if (obj is! String) {
      throw Exception('Expected a String value in pubspec.yaml.');
    }
    return obj as String;
  }
}

class MinSdkVersion {
  final Version value;
  final String channel;

  MinSdkVersion(this.value, this.channel);

  static MinSdkVersion tryParse(VersionConstraint constraint) {
    if (constraint == null || constraint is! VersionRange) {
      return null;
    }
    final min = (constraint as VersionRange).min;
    if (min != null && !min.isAny && !min.isEmpty) {
      final str = min.toString();
      String channel;
      if (str.endsWith('.dev')) {
        channel = 'dev';
      } else if (str.endsWith('.beta')) {
        channel = 'beta';
      }
      return MinSdkVersion(min, channel);
    }
    return null;
  }

  int get major => value.major;
  int get minor => value.minor;
}

class PubspecProperty extends StringProperty {
  const PubspecProperty({String propertyName, bool required = false})
      : super(propertyName: propertyName, required: required, indexed: false);

  @override
  bool validate(ModelDB db, Object value) =>
      (!required || value != null) && (value == null || value is Pubspec);

  @override
  String encodeValue(ModelDB db, Object pubspec, {bool forComparison = false}) {
    if (pubspec is Pubspec) {
      return pubspec.jsonString;
    }
    return null;
  }

  @override
  Object decodePrimitiveValue(ModelDB db, Object value) {
    if (value is String) {
      return Pubspec(value);
    }
    return null;
  }
}

class FileObject {
  final String filename;
  final String text;

  FileObject(this.filename, this.text);
}
