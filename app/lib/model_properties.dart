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

  Pubspec.fromJson(Map json) : jsonString = JSON.encode(json), _json = json;

  factory Pubspec.fromYaml(String yamlString)
      => new Pubspec.fromJson(loadYaml(yamlString));

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

  String get homepage {
    _load();
    return _asString(_json['homepage']);
  }

  String get description {
    _load();
    return _asString(_json['description']);
  }

  _load() {
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
    if (obj is! List)  throw 'Expected List<String> value in pubspec.yaml.';
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

  bool validate(ModelDB db, Object value)
      => (!required || value != null) && (value == null || value is Pubspec);

  String encodeValue(ModelDB db, Pubspec pubspec) {
    if (pubspec == null) return null;
    return pubspec.jsonString;
  }

  Object decodePrimitiveValue(ModelDB db, String value) {
    if (value == null) return null;
    return new Pubspec(value);
  }
}

class FileObject {
  final String filename;
  final String text;

  FileObject(this.filename, this.text);
}
