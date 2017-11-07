// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

void _writeToCodedBufferWriter(_FieldSet fs, CodedBufferWriter out) {
  // Sorting by tag number isn't required, but it sometimes enables
  // performance optimizations for the receiver. See:
  // https://developers.google.com/protocol-buffers/docs/encoding?hl=en#order

  for (var fi in fs._infosSortedByTag) {
    var value = fs._values[fi.index];
    if (value == null) continue;
    out.writeField(fi.tagNumber, fi.type, value);
  }

  if (fs._hasExtensions) {
    for (var tagNumber in sorted(fs._extensions._tagNumbers)) {
      var fi = fs._extensions._getInfoOrNull(tagNumber);
      out.writeField(tagNumber, fi.type, fs._extensions._getFieldOrNull(fi));
    }
  }
  if (fs.hasUnknownFields) {
    fs._unknownFields.writeToCodedBufferWriter(out);
  }
}

void _mergeFromCodedBufferReader(
    _FieldSet fs, CodedBufferReader input, ExtensionRegistry registry) {
  assert(registry != null);

  void readPackableToList(int wireType, FieldInfo fi, Function readToList) {
    List list = fs._ensureRepeatedField(fi);

    if (wireType == WIRETYPE_LENGTH_DELIMITED) {
      // Packed.
      input._withLimit(input.readInt32(), () {
        while (!input.isAtEnd()) {
          readToList(list);
        }
      });
    } else {
      // Not packed.
      readToList(list);
    }
  }

  void readPackable(int wireType, FieldInfo fi, Function readFunc) {
    void readToList(List list) => list.add(readFunc());
    readPackableToList(wireType, fi, readToList);
  }

  while (true) {
    int tag = input.readTag();
    if (tag == 0) return;
    int wireType = tag & 0x7;
    int tagNumber = tag >> 3;

    FieldInfo fi = fs._nonExtensionInfo(tagNumber);
    if (fi == null) {
      fi = registry.getExtension(fs._messageName, tagNumber);
    }

    if (fi == null || !_wireTypeMatches(fi.type, wireType)) {
      if (!fs._ensureUnknownFields().mergeFieldFromBuffer(tag, input)) {
        return;
      }
      continue;
    }

    // Ignore required/optional packed/unpacked.
    int fieldType = fi.type;
    fieldType &= ~(PbFieldType._PACKED_BIT | PbFieldType._REQUIRED_BIT);
    switch (fieldType) {
      case PbFieldType._OPTIONAL_BOOL:
        fs._setFieldUnchecked(fi, input.readBool());
        break;
      case PbFieldType._OPTIONAL_BYTES:
        fs._setFieldUnchecked(fi, input.readBytes());
        break;
      case PbFieldType._OPTIONAL_STRING:
        fs._setFieldUnchecked(fi, input.readString());
        break;
      case PbFieldType._OPTIONAL_FLOAT:
        fs._setFieldUnchecked(fi, input.readFloat());
        break;
      case PbFieldType._OPTIONAL_DOUBLE:
        fs._setFieldUnchecked(fi, input.readDouble());
        break;
      case PbFieldType._OPTIONAL_ENUM:
        int rawValue = input.readEnum();
        var value = fs._meta._decodeEnum(tagNumber, registry, rawValue);
        if (value == null) {
          var unknown = fs._ensureUnknownFields();
          unknown.mergeVarintField(tagNumber, new Int64(rawValue));
        } else {
          fs._setFieldUnchecked(fi, value);
        }
        break;
      case PbFieldType._OPTIONAL_GROUP:
        GeneratedMessage subMessage =
            fs._meta._makeEmptyMessage(tagNumber, registry);
        var oldValue = fs._getFieldOrNull(fi);
        if (oldValue != null) {
          subMessage.mergeFromMessage(oldValue);
        }
        input.readGroup(tagNumber, subMessage, registry);
        fs._setFieldUnchecked(fi, subMessage);
        break;
      case PbFieldType._OPTIONAL_INT32:
        fs._setFieldUnchecked(fi, input.readInt32());
        break;
      case PbFieldType._OPTIONAL_INT64:
        fs._setFieldUnchecked(fi, input.readInt64());
        break;
      case PbFieldType._OPTIONAL_SINT32:
        fs._setFieldUnchecked(fi, input.readSint32());
        break;
      case PbFieldType._OPTIONAL_SINT64:
        fs._setFieldUnchecked(fi, input.readSint64());
        break;
      case PbFieldType._OPTIONAL_UINT32:
        fs._setFieldUnchecked(fi, input.readUint32());
        break;
      case PbFieldType._OPTIONAL_UINT64:
        fs._setFieldUnchecked(fi, input.readUint64());
        break;
      case PbFieldType._OPTIONAL_FIXED32:
        fs._setFieldUnchecked(fi, input.readFixed32());
        break;
      case PbFieldType._OPTIONAL_FIXED64:
        fs._setFieldUnchecked(fi, input.readFixed64());
        break;
      case PbFieldType._OPTIONAL_SFIXED32:
        fs._setFieldUnchecked(fi, input.readSfixed32());
        break;
      case PbFieldType._OPTIONAL_SFIXED64:
        fs._setFieldUnchecked(fi, input.readSfixed64());
        break;
      case PbFieldType._OPTIONAL_MESSAGE:
        GeneratedMessage subMessage =
            fs._meta._makeEmptyMessage(tagNumber, registry);
        var oldValue = fs._getFieldOrNull(fi);
        if (oldValue != null) {
          subMessage.mergeFromMessage(oldValue);
        }
        input.readMessage(subMessage, registry);
        fs._setFieldUnchecked(fi, subMessage);
        break;
      case PbFieldType._REPEATED_BOOL:
        readPackable(wireType, fi, input.readBool);
        break;
      case PbFieldType._REPEATED_BYTES:
        fs._ensureRepeatedField(fi).add(input.readBytes());
        break;
      case PbFieldType._REPEATED_STRING:
        fs._ensureRepeatedField(fi).add(input.readString());
        break;
      case PbFieldType._REPEATED_FLOAT:
        readPackable(wireType, fi, input.readFloat);
        break;
      case PbFieldType._REPEATED_DOUBLE:
        readPackable(wireType, fi, input.readDouble);
        break;
      case PbFieldType._REPEATED_ENUM:
        readPackableToList(wireType, fi, (List list) {
          int rawValue = input.readEnum();
          var value = fs._meta._decodeEnum(tagNumber, registry, rawValue);
          if (value == null) {
            var unknown = fs._ensureUnknownFields();
            unknown.mergeVarintField(tagNumber, new Int64(rawValue));
          } else {
            list.add(value);
          }
        });
        break;
      case PbFieldType._REPEATED_GROUP:
        GeneratedMessage subMessage =
            fs._meta._makeEmptyMessage(tagNumber, registry);
        input.readGroup(tagNumber, subMessage, registry);
        fs._ensureRepeatedField(fi).add(subMessage);
        break;
      case PbFieldType._REPEATED_INT32:
        readPackable(wireType, fi, input.readInt32);
        break;
      case PbFieldType._REPEATED_INT64:
        readPackable(wireType, fi, input.readInt64);
        break;
      case PbFieldType._REPEATED_SINT32:
        readPackable(wireType, fi, input.readSint32);
        break;
      case PbFieldType._REPEATED_SINT64:
        readPackable(wireType, fi, input.readSint64);
        break;
      case PbFieldType._REPEATED_UINT32:
        readPackable(wireType, fi, input.readUint32);
        break;
      case PbFieldType._REPEATED_UINT64:
        readPackable(wireType, fi, input.readUint64);
        break;
      case PbFieldType._REPEATED_FIXED32:
        readPackable(wireType, fi, input.readFixed32);
        break;
      case PbFieldType._REPEATED_FIXED64:
        readPackable(wireType, fi, input.readFixed64);
        break;
      case PbFieldType._REPEATED_SFIXED32:
        readPackable(wireType, fi, input.readSfixed32);
        break;
      case PbFieldType._REPEATED_SFIXED64:
        readPackable(wireType, fi, input.readSfixed64);
        break;
      case PbFieldType._REPEATED_MESSAGE:
        GeneratedMessage subMessage =
            fs._meta._makeEmptyMessage(tagNumber, registry);
        input.readMessage(subMessage, registry);
        fs._ensureRepeatedField(fi).add(subMessage);
        break;
      default:
        throw 'Unknown field type $fieldType';
    }
  }
}
