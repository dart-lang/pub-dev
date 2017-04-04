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

  String get homepage {
    _load();
    return _asString(_json['homepage']);
  }

  String get description {
    _load();
    return _asString(_json['description']);
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

/// Similar to [ListProperty] but one which is fully compatible with python's
/// 'db' implementation.
class CompatibleListProperty extends Property {
  final PrimitiveProperty subProperty;

  const CompatibleListProperty(this.subProperty,
      {String propertyName, bool indexed: true})
      : super(propertyName: propertyName, required: true, indexed: indexed);

  @override
  bool validate(ModelDB db, Object value) {
    if (!super.validate(db, value) || value is! List) return false;

    for (var entry in value) {
      if (!subProperty.validate(db, entry)) return false;
    }
    return true;
  }

  @override
  Object encodeValue(ModelDB db, Object value, {bool forComparison: false}) {
    if (forComparison) {
      return subProperty.encodeValue(db, value, forComparison: true);
    }

    // NOTE: As opposed to [ListProperty] we will encode
    //    - `null` as `[]`  (as opposed to `null`)
    //    - `[]` as `[]`  (as opposed to `null`)
    //    - `[a]` as `[a]` (as opposed to `a`)
    if (value == null) return [];
    final List list = value;
    if (list.length == 0) return [];
    if (list.length == 1) return [subProperty.encodeValue(db, list[0])];
    return list.map((value) => subProperty.encodeValue(db, value)).toList();
  }

  @override
  Object decodePrimitiveValue(ModelDB db, Object value) {
    if (value == null) return [];
    if (value is! List) return [subProperty.decodePrimitiveValue(db, value)];
    return (value as List)
        .map((entry) => subProperty.decodePrimitiveValue(db, entry))
        .toList();
  }
}

/// Similar to [StringListProperty] but one which is fully compatible with
/// python's 'db' implementation.
class CompatibleStringListProperty extends CompatibleListProperty {
  const CompatibleStringListProperty({String propertyName, bool indexed: true})
      : super(const StringProperty(required: true),
            propertyName: propertyName, indexed: indexed);
}
