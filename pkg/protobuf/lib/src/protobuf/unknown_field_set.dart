// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

class UnknownFieldSet {
  final Map<int, UnknownFieldSetField> _fields =
      new Map<int, UnknownFieldSetField>();

  UnknownFieldSet();

  UnknownFieldSet._clone(UnknownFieldSet unknownFieldSet) {
    mergeFromUnknownFieldSet(unknownFieldSet);
  }

  UnknownFieldSet clone() => new UnknownFieldSet._clone(this);

  bool get isEmpty => _fields.isEmpty;
  bool get isNotEmpty => _fields.isNotEmpty;

  Map<int, UnknownFieldSetField> asMap() => new Map.from(_fields);

  void clear() {
    _fields.clear();
  }

  UnknownFieldSetField getField(int tagNumber) => _fields[tagNumber];

  bool hasField(int tagNumber) => _fields.containsKey(tagNumber);

  void addField(int number, UnknownFieldSetField field) {
    _checkFieldNumber(number);
    _fields[number] = field;
  }

  void mergeField(int number, UnknownFieldSetField field) {
    _getField(number)
      ..varints.addAll(field.varints)
      ..fixed32s.addAll(field.fixed32s)
      ..fixed64s.addAll(field.fixed64s)
      ..lengthDelimited.addAll(field.lengthDelimited)
      ..groups.addAll(field.groups);
  }

  bool mergeFieldFromBuffer(int tag, CodedBufferReader input) {
    int number = getTagFieldNumber(tag);
    switch (getTagWireType(tag)) {
      case WIRETYPE_VARINT:
        mergeVarintField(number, input.readInt64());
        return true;
      case WIRETYPE_FIXED64:
        mergeFixed64Field(number, input.readFixed64());
        return true;
      case WIRETYPE_LENGTH_DELIMITED:
        mergeLengthDelimitedField(number, input.readBytes());
        return true;
      case WIRETYPE_START_GROUP:
        UnknownFieldSet subGroup = input.readUnknownFieldSetGroup(number);
        mergeGroupField(number, subGroup);
        return true;
      case WIRETYPE_END_GROUP:
        return false;
      case WIRETYPE_FIXED32:
        mergeFixed32Field(number, input.readFixed32());
        return true;
      default:
        throw new InvalidProtocolBufferException.invalidWireType();
    }
  }

  void mergeFromCodedBufferReader(CodedBufferReader input) {
    while (true) {
      int tag = input.readTag();
      if (tag == 0 || !mergeFieldFromBuffer(tag, input)) {
        break;
      }
    }
  }

  void mergeFromUnknownFieldSet(UnknownFieldSet other) {
    for (int key in other._fields.keys) {
      mergeField(key, other._fields[key]);
    }
  }

  _checkFieldNumber(int number) {
    if (number == 0) {
      throw new ArgumentError('Zero is not a valid field number.');
    }
  }

  void mergeFixed32Field(int number, int value) {
    _getField(number).addFixed32(value);
  }

  void mergeFixed64Field(int number, Int64 value) {
    _getField(number).addFixed64(value);
  }

  void mergeGroupField(int number, UnknownFieldSet value) {
    _getField(number).addGroup(value);
  }

  void mergeLengthDelimitedField(int number, List<int> value) {
    _getField(number).addLengthDelimited(value);
  }

  void mergeVarintField(int number, Int64 value) {
    _getField(number).addVarint(value);
  }

  UnknownFieldSetField _getField(int number) {
    _checkFieldNumber(number);
    return _fields.putIfAbsent(number, () => new UnknownFieldSetField());
  }

  bool operator ==(other) {
    if (other is! UnknownFieldSet) return false;

    UnknownFieldSet o = other;
    return _areMapsEqual(o._fields, _fields);
  }

  int get hashCode {
    int hash = 0;
    _fields.forEach((int number, Object value) {
      hash = ((37 * hash) + number) & 0x3fffffff;
      hash = ((53 * hash) + value.hashCode) & 0x3fffffff;
    });
    return hash;
  }

  String toString() => _toString('');

  String _toString(String indent) {
    var stringBuffer = new StringBuffer();

    for (int tag in sorted(_fields.keys)) {
      var field = _fields[tag];
      for (var value in field.values) {
        if (value is UnknownFieldSet) {
          stringBuffer
            ..write('${indent}${tag}: {\n')
            ..write(value._toString('$indent  '))
            ..write('${indent}}\n');
        } else {
          if (value is ByteData) {
            // TODO(antonm): fix for longs.
            value = value.getUint64(0, Endianness.LITTLE_ENDIAN);
          }
          stringBuffer.write('${indent}${tag}: ${value}\n');
        }
      }
    }

    return stringBuffer.toString();
  }

  void writeToCodedBufferWriter(CodedBufferWriter output) {
    for (int key in _fields.keys) {
      _fields[key].writeTo(key, output);
    }
  }
}

class UnknownFieldSetField {
  final List<List<int>> lengthDelimited = <List<int>>[];
  final List<Int64> varints = <Int64>[];
  final List<int> fixed32s = <int>[];
  final List<Int64> fixed64s = <Int64>[];
  final List<UnknownFieldSet> groups = <UnknownFieldSet>[];

  bool operator ==(other) {
    if (other is! UnknownFieldSetField) return false;

    UnknownFieldSetField o = other;
    if (lengthDelimited.length != o.lengthDelimited.length) return false;
    for (int i = 0; i < lengthDelimited.length; i++) {
      if (!_areListsEqual(o.lengthDelimited[i], lengthDelimited[i])) {
        return false;
      }
    }
    if (!_areListsEqual(o.varints, varints)) return false;
    if (!_areListsEqual(o.fixed32s, fixed32s)) return false;
    if (!_areListsEqual(o.fixed64s, fixed64s)) return false;
    if (!_areListsEqual(o.groups, groups)) return false;

    return true;
  }

  int get hashCode {
    int hash = 0;
    for (final value in lengthDelimited) {
      for (int i = 0; i < value.length; i++) {
        hash = (hash + value[i]) & 0x3fffffff;
        hash = (hash + hash << 10) & 0x3fffffff;
        hash = (hash ^ hash >> 6) & 0x3fffffff;
      }
      hash = (hash + hash << 3) & 0x3fffffff;
      hash = (hash ^ hash >> 11) & 0x3fffffff;
      hash = (hash + hash << 15) & 0x3fffffff;
    }
    for (final value in varints) {
      hash = (hash + 7 * value.hashCode) & 0x3fffffff;
    }
    for (final value in fixed32s) {
      hash = (hash + 37 * value.hashCode) & 0x3fffffff;
    }
    for (final value in fixed64s) {
      hash = (hash + 53 * value.hashCode) & 0x3fffffff;
    }
    for (final value in groups) {
      hash = (hash + value.hashCode) & 0x3fffffff;
    }
    return hash;
  }

  List get values => []
    ..addAll(lengthDelimited)
    ..addAll(varints)
    ..addAll(fixed32s)
    ..addAll(fixed64s)
    ..addAll(groups);

  void writeTo(int fieldNumber, CodedBufferWriter output) {
    write(type, value) {
      output.writeField(fieldNumber, type, value);
    }

    write(PbFieldType._REPEATED_UINT64, varints);
    write(PbFieldType._REPEATED_FIXED32, fixed32s);
    write(PbFieldType._REPEATED_FIXED64, fixed64s);
    write(PbFieldType._REPEATED_BYTES, lengthDelimited);
    write(PbFieldType._REPEATED_GROUP, groups);
  }

  void addGroup(UnknownFieldSet value) {
    groups.add(value);
  }

  void addLengthDelimited(List<int> value) {
    lengthDelimited.add(value);
  }

  void addFixed32(int value) {
    fixed32s.add(value);
  }

  void addFixed64(Int64 value) {
    fixed64s.add(value);
  }

  void addVarint(Int64 value) {
    varints.add(value);
  }

  bool hasRequiredFields() => false;

  bool isInitialized() => true;

  int get length => values.length;
}
