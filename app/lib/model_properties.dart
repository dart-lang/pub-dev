// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.model_properties;

import 'package:gcloud/db.dart';
import 'package:yaml/yaml.dart';

import 'pickle.dart' as pickle;

class Pubspec {
  final String yamlString;
  Map _json;

  Pubspec(this.yamlString);

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
      if (yamlString != null) {
        _json = loadYaml(yamlString);
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
    return pubspec.yamlString;
  }

  Object decodePrimitiveValue(ModelDB db, String value) {
    if (value == null) return null;
    return new Pubspec(value);
  }
}

class FileObject {
  final pickle.PickleObject _obj;

  FileObject(this._obj);

  String get filename => _obj.properties['filename'];

  String get text => _obj.properties['text'];
}

class FileProperty extends BlobProperty {
  const FileProperty({String propertyName, bool required: false})
      : super(propertyName: propertyName, required: required);

  bool validate(ModelDB db, Object value) {
    return (!required || value != null) &&
        (value == null || value is FileObject);
  }

  String encodeValue(ModelDB db, FileObject pickle) {
    if (pickle == null) return null;
    throw 'not supported yet';
  }

  Object decodePrimitiveValue(ModelDB db, value) {
    if (value == null) return null;
    var pickleObj = pickle.dePickle(super.decodePrimitiveValue(db, value));
    if (pickleObj == null) return null;
    return new FileObject(pickleObj);
  }
}
