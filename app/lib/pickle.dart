// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.pickle;

import 'dart:convert';

class PickleClass {
  final String moduleName;
  final String className;

  PickleClass(this.moduleName, this.className);

  String toString() => 'Class(module: $moduleName, class: $className)';
}

class PickleObject {
  final PickleClass klass;
  final Object argument;
  Map properties;

  PickleObject(this.klass, this.argument);

  String toString() {
    return 'PickleObject(class: $klass, argument: $argument, '
           'properties: $properties)';
  }
}

/// Decodes the pickled `bytes` and returns a PickleObject.
///
/// Only a very limited subset of the python pickle format is supported. More
/// specifically it has been only tested pickled objects which look like:
///     test.py
///     class File(object):
///        def __init__(self, filename, content):
///          self.filename = filename
///          self.content = content
///
/// The returned `PickleObject` will look like
///     [PickleObject]
///       - klass:
///         [PickleClass]
///           - moduleName = 'test'
///           - className = 'File'
///       - properties:
///         - filename = '...'
///         - content = '...'
// TODO: Make sure we can read all the pickled objects form the old python
// datastore.
PickleObject dePickle(List<int> bytes) {
  var bytesIndex = 0;
  var gstack = [];
  var memory = {};

  List sliceToMark() {
    var values = [];
    var value = gstack.removeLast();
    while (value != #mark) {
      values.add(value);
      value = gstack.removeLast();
    }
    return values;
  }

  String readString(List<int> bytes, int size) {
    var string = UTF8.decode(bytes.sublist(bytesIndex, bytesIndex + size));
    bytesIndex += size;
    return string;
  }

  String readStringUntilNewline(List<int> bytes) {
    var r = [];
    var byte = bytes[bytesIndex++];
    while (byte != 0x0A) {
      r.add(byte);
      byte = bytes[bytesIndex++];
    }
    return UTF8.decode(r);
  }

  int readInteger(List<int> bytes, int length) {
    var val = 0;
    for (int i = 0; i < length; i++) {
      val += bytes[bytesIndex++] << (i * 8);
    }
    return val;
  }

  while (true) {
    if (bytesIndex >= bytes.length) throw 'unexpected end of pickle stream';

    var opcode = bytes[bytesIndex++];
    switch (opcode) {
      case 40: // '('
        gstack.add(#mark);
        break;
      case 41: // ')'
        gstack.add([]);
        break;
      case 125: // '}'
        gstack.add({});
        break;
      case 78: // 'N'
        gstack.add(null);
        break;
      case 85:
        var size = bytes[bytesIndex++];
        gstack.add(readString(bytes, size));
        break;
      case 88: // 'X' - binunicode
        var size = readInteger(bytes, 4);
        gstack.add(readString(bytes, size));
        break;
      case 98: // 'b'
        Map arg = gstack.removeLast();
        PickleObject obj = gstack.last;
        obj.properties = arg;
        break;
      case 99: // 'c'
        var modname = readStringUntilNewline(bytes);
        var clsname = readStringUntilNewline(bytes);
        gstack.add(new PickleClass(modname, clsname));
        break;
      case 117: // 'u'
        var sublist = sliceToMark();
        while (!sublist.isEmpty) {
          var key = sublist.removeLast();
          var value = sublist.removeLast();
          gstack.last[key] = value;
        }
        break;
      case 128: // :PROTO
        bytesIndex++;
        break;
      case 129:
        var arg = gstack.removeLast();
        var cls = gstack.removeLast();
        gstack.add(new PickleObject(cls, arg));
        break;
      case 113: // 'q'
        memory[bytes[bytesIndex++]] = gstack.last;
        break;
      case 46: // '.'
        return gstack.last;

      /*
          case 'R': break;
          case 'I': break;
          case 'J': break;
          case 'K': break;
          case 'M': break;
          case 'd': break;
          case 'i': break;
          case 'o': break;
          case 'P': break;
          case 'Q': break;
          case 's': break;
          case 'p': break;
          case 'V': break;
          case 'r': break;
          case 'g': break;
          case 'h': break;
          case 'j': break;
          case '1': break;
          case '2': break;
          case '0': break;
          case 'F': break;
          case 'G': break;
          case ']': break;
          case 'a': break;
          case 'e': break;
          case 'l': break;
          case 't': break;
          case 'T': break;
          case 'L': break;
          case 'S': break;
          case '.': break;
          case 136: break;
          case 137: break;
          case 133: break;
          case 134: break;
          case 135: break;
          case 130: break;
          case 131: break;
          case 132: break;
          case 138: break;
          case 139: break;
     */
      default:
        throw 'Unsupported opcode ${opcode}';
        break;
    }
  }
}
