// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.model_properties;

import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:pubspec_parse/pubspec_parse.dart' as pubspek show Pubspec;
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

final _dart2OrLater = new VersionConstraint.parse('>=2.0.0');

Map<String, dynamic> _loadYaml(String yamlString) {
  final Map map = loadYaml(yamlString);
  // TODO: remove this part after yaml returns a proper map
  if (map is YamlMap) {
    return json.decode(json.encode(map)) as Map<String, dynamic>;
  }
  return map as Map<String, dynamic>;
}

class Pubspec {
  final pubspek.Pubspec _inner;
  final String jsonString;
  Map _json;

  Pubspec._(this._inner, this.jsonString);

  factory Pubspec(String jsonString) =>
      new Pubspec._(new pubspek.Pubspec.parse(jsonString), jsonString);

  factory Pubspec.fromYaml(String yamlString) => new Pubspec._(
      new pubspek.Pubspec.parse(yamlString),
      json.encode(_loadYaml(yamlString)));

  Map get asJson {
    _load();
    return _json;
  }

  String get name => _inner.name;

  String get version => _inner.version.toString();

  List<String> get authors => _inner.authors ?? const [];

  Iterable<String> get dependencies => _inner.dependencies.keys;

  Iterable<String> get devDependencies => _inner.devDependencies.keys;

  String get documentation => _inner.documentation;

  String get homepage => _inner.homepage;

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

  String get sdkConstraint {
    _load();
    final environment = _json['environment'];
    if (environment == null || environment is! Map) return null;
    return _asString(environment['sdk']);
  }

  bool get supportsOnlyLegacySdk {
    final sdkVersionConstraint = _inner.environment['sdk'];
    return sdkVersionConstraint != null &&
        !sdkVersionConstraint.allowsAny(_dart2OrLater);
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
      throw new Exception('Expected a String value in pubspec.yaml.');
    }
    return obj as String;
  }
}

class PubspecProperty extends StringProperty {
  const PubspecProperty({String propertyName, bool required: false})
      : super(propertyName: propertyName, required: required, indexed: false);

  @override
  bool validate(ModelDB db, Object value) =>
      (!required || value != null) && (value == null || value is Pubspec);

  @override
  String encodeValue(ModelDB db, Object pubspec, {bool forComparison: false}) {
    if (pubspec is Pubspec) {
      return pubspec.jsonString;
    }
    return null;
  }

  @override
  Object decodePrimitiveValue(ModelDB db, Object value) {
    if (value is String) {
      return new Pubspec(value);
    }
    return null;
  }
}

class FileObject {
  final String filename;
  final String text;

  FileObject(this.filename, this.text);
}

final _authorsRegExp = new RegExp(r'^\s*(.+)\s+<(.+)>\s*$');

class Author {
  final String name;
  final String email;

  Author(this.name, this.email);

  factory Author.parse(String value) {
    String name = value;
    String email;

    final match = _authorsRegExp.matchAsPrefix(value);
    if (match != null) {
      name = match.group(1);
      email = match.group(2);
    } else if (value.contains('@')) {
      final List<String> parts = value.split(' ');
      for (int i = 0; i < parts.length; i++) {
        if (parts[i].contains('@') &&
            parts[i].contains('.') &&
            parts[i].length > 4) {
          email = parts[i];
          parts.removeAt(i);
          name = parts.join(' ');
          if (name.isEmpty) {
            name = email;
          }
          break;
        }
      }
    }
    return new Author(name, email);
  }
}
