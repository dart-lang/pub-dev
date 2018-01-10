// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.model_properties;

import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:yaml/yaml.dart';

class Pubspec {
  final String jsonString;
  Map _json;

  Pubspec(this.jsonString);

  Pubspec.fromJson(Map json)
      : jsonString = JSON.encode(json),
        _json = json;

  factory Pubspec.fromYaml(String yamlString) =>
      new Pubspec.fromJson(loadYaml(yamlString));

  Map get asJson {
    _load();
    return _json;
  }

  String get name {
    _load();
    return _asString(_json['name']);
  }

  String get version {
    _load();
    return _asString(_json['version']);
  }

  String get author {
    _load();
    return _asString(_json['author']);
  }

  List<String> get authors {
    _load();
    return _asListOfString(_json['authors']);
  }

  List<String> getAllAuthors() {
    final authorsList = authors;
    if (authorsList != null) return authorsList;
    final singleAuthor = author;
    if (singleAuthor != null) return [singleAuthor];
    return const [];
  }

  Iterable<String> get dependencies {
    _load();
    final deps = _json['dependencies'];
    if (deps is Map) {
      return deps.keys.map((key) => key as String);
    }
    return const <String>[];
  }

  Iterable<String> get devDependencies {
    _load();
    final deps = _json['dev_dependencies'];
    if (deps is Map) {
      return deps.keys.map((key) => key as String);
    }
    return const <String>[];
  }

  String get homepage {
    _load();
    return _asString(_json['homepage']);
  }

  String get repository {
    _load();
    return _asString(_json['repository']);
  }

  String get description {
    _load();
    return _asString(_json['description']);
  }

  /// Whether the pubspec file contains a flutter.plugin entry.
  bool get hasFlutterPlugin {
    _load();
    final flutter = _json['flutter'];
    if (flutter == null || flutter is! Map) return false;
    final plugin = flutter['plugin'];
    return plugin != null && plugin is Map;
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

  void _load() {
    if (_json == null) {
      if (jsonString != null) {
        _json = loadYaml(jsonString);
      } else {
        _json = const {};
      }
    }
  }

  List<String> _asListOfString(obj) {
    if (obj == null) return null;
    if (obj is! List) throw 'Expected List<String> value in pubspec.yaml.';
    return obj.map(_asString).toList();
  }

  String _asString(obj) {
    if (obj == null) return null;
    if (obj is! String) throw 'Expected a String value in pubspec.yaml.';
    return obj;
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
