// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

class CodedBufferWriter {
  final List<TypedData> _output = <TypedData>[];
  int _runningSizeInBytes = 0;
  int get lengthInBytes => _runningSizeInBytes;

  static final _WRITE_FUNCTION_MAP = _makeWriteFunctionMap();

  static ByteData _toVarint32(int value) {
    // Varint encoding always fits into 5 bytes.
    Uint8List result = new Uint8List(5);
    int i = 0;
    while (value >= 0x80) {
      result[i++] = 0x80 | (value & 0x7f);
      value >>= 7;
    }
    result[i++] = value;

    return new ByteData.view(result.buffer, 0, i);
  }

  static ByteData _toVarint64(Int64 value) {
    // Varint encoding always fits into 10 bytes.
    Uint8List result = new Uint8List(10);
    int i = 0;
    ByteData bytes =
        new ByteData.view(new Uint8List.fromList(value.toBytes()).buffer, 0, 8);
    int lo = bytes.getUint32(0, Endianness.LITTLE_ENDIAN);
    int hi = bytes.getUint32(4, Endianness.LITTLE_ENDIAN);
    while (hi > 0 || lo >= 0x80) {
      result[i++] = 0x80 | (lo & 0x7f);
      lo = (lo >> 7) | ((hi & 0x7f) << 25);
      hi >>= 7;
    }
    result[i++] = lo;

    return new ByteData.view(result.buffer, 0, i);
  }

  static ByteData _int32ToBytes(int value) => _toVarint32(value & 0xffffffff);

  static _makeWriteFunctionMap() {
    writeBytesNoTag(output, List<int> value) {
      output.writeInt32NoTag(value.length);
      output.writeRawBytes(
          new Uint8List(value.length)..setRange(0, value.length, value));
    }

    makeWriter(convertor) => ((output, value) {
          output.writeRawBytes(convertor(value));
        });

    int _encodeZigZag32(int value) => (value << 1) ^ (value >> 31);

    Int64 _encodeZigZag64(Int64 value) => (value << 1) ^ (value >> 63);

    ByteData makeByteData32(int value) =>
        new ByteData(4)..setUint32(0, value, Endianness.LITTLE_ENDIAN);

    ByteData makeByteData64(Int64 value) {
      var data = new Uint8List.fromList(value.toBytes());
      return new ByteData.view(data.buffer, 0, 8);
    }

    return new Map<int, dynamic>()
      ..[PbFieldType._BOOL_BIT] =
          makeWriter((value) => _int32ToBytes(value ? 1 : 0))
      ..[PbFieldType._BYTES_BIT] = writeBytesNoTag
      ..[PbFieldType._STRING_BIT] = (output, value) {
        writeBytesNoTag(output, _UTF8.encode(value));
      }
      ..[PbFieldType._DOUBLE_BIT] = makeWriter((double value) {
        if (value.isNaN)
          return new ByteData(8)
            ..setUint32(0, 0x00000000, Endianness.LITTLE_ENDIAN)
            ..setUint32(4, 0x7ff80000, Endianness.LITTLE_ENDIAN);
        return new ByteData(8)..setFloat64(0, value, Endianness.LITTLE_ENDIAN);
      })
      ..[PbFieldType._FLOAT_BIT] = makeWriter((double value) {
        const double MIN_FLOAT_DENORM = 1.401298464324817E-45;
        const double MAX_FLOAT = 3.4028234663852886E38;
        // TODO(antonm): reevaluate once semantics of odd values
        // writes is clear.
        if (value.isNaN) return makeByteData32(0x7fc00000);
        if (value.abs() < MIN_FLOAT_DENORM) {
          return makeByteData32(value.isNegative ? 0x80000000 : 0x00000000);
        }
        if (value.isInfinite || value.abs() > MAX_FLOAT) {
          return makeByteData32(value.isNegative ? 0xff800000 : 0x7f800000);
        }
        return new ByteData(4)..setFloat32(0, value, Endianness.LITTLE_ENDIAN);
      })
      ..[PbFieldType._ENUM_BIT] =
          makeWriter((value) => _int32ToBytes(value.value))
      ..[PbFieldType._GROUP_BIT] = (output, value) {
        value.writeToCodedBufferWriter(output);
      }
      ..[PbFieldType._INT32_BIT] = makeWriter(_int32ToBytes)
      ..[PbFieldType._INT64_BIT] = makeWriter((value) => _toVarint64(value))
      ..[PbFieldType._SINT32_BIT] =
          makeWriter((int value) => _int32ToBytes(_encodeZigZag32(value)))
      ..[PbFieldType._SINT64_BIT] =
          makeWriter((Int64 value) => _toVarint64(_encodeZigZag64(value)))
      ..[PbFieldType._UINT32_BIT] = makeWriter(_toVarint32)
      ..[PbFieldType._UINT64_BIT] = makeWriter(_toVarint64)
      ..[PbFieldType._FIXED32_BIT] = makeWriter(makeByteData32)
      ..[PbFieldType._FIXED64_BIT] = makeWriter(makeByteData64)
      ..[PbFieldType._SFIXED32_BIT] = makeWriter(makeByteData32)
      ..[PbFieldType._SFIXED64_BIT] = makeWriter(makeByteData64)
      ..[PbFieldType._MESSAGE_BIT] = (output, value) {
        output._withDeferredSizeCalculation(() {
          value.writeToCodedBufferWriter(output);
        });
      };
  }

  static final _OPEN_TAG_MAP = _makeOpenTagMap();

  static _makeOpenTagMap() {
    return new Map<int, int>()
      ..[PbFieldType._BOOL_BIT] = WIRETYPE_VARINT
      ..[PbFieldType._BYTES_BIT] = WIRETYPE_LENGTH_DELIMITED
      ..[PbFieldType._STRING_BIT] = WIRETYPE_LENGTH_DELIMITED
      ..[PbFieldType._DOUBLE_BIT] = WIRETYPE_FIXED64
      ..[PbFieldType._FLOAT_BIT] = WIRETYPE_FIXED32
      ..[PbFieldType._ENUM_BIT] = WIRETYPE_VARINT
      ..[PbFieldType._GROUP_BIT] = WIRETYPE_START_GROUP
      ..[PbFieldType._INT32_BIT] = WIRETYPE_VARINT
      ..[PbFieldType._INT64_BIT] = WIRETYPE_VARINT
      ..[PbFieldType._SINT32_BIT] = WIRETYPE_VARINT
      ..[PbFieldType._SINT64_BIT] = WIRETYPE_VARINT
      ..[PbFieldType._UINT32_BIT] = WIRETYPE_VARINT
      ..[PbFieldType._UINT64_BIT] = WIRETYPE_VARINT
      ..[PbFieldType._FIXED32_BIT] = WIRETYPE_FIXED32
      ..[PbFieldType._FIXED64_BIT] = WIRETYPE_FIXED64
      ..[PbFieldType._SFIXED32_BIT] = WIRETYPE_FIXED32
      ..[PbFieldType._SFIXED64_BIT] = WIRETYPE_FIXED64
      ..[PbFieldType._MESSAGE_BIT] = WIRETYPE_LENGTH_DELIMITED;
  }

  void _withDeferredSizeCalculation(continuation) {
    // Reserve a place for size data.
    int index = _output.length;
    _output.add(null);
    int currentRunningSizeInBytes = _runningSizeInBytes;
    continuation();
    int writtenSizeInBytes = _runningSizeInBytes - currentRunningSizeInBytes;
    TypedData sizeMarker = _int32ToBytes(writtenSizeInBytes);
    _output[index] = sizeMarker;
    _runningSizeInBytes += sizeMarker.lengthInBytes;
  }

  void writeField(int fieldNumber, int fieldType, fieldValue) {
    var valueType = fieldType & ~0x07;
    var writeFunction = _WRITE_FUNCTION_MAP[valueType];

    writeTag(int wireFormat) {
      writeInt32NoTag(makeTag(fieldNumber, wireFormat));
    }

    if ((fieldType & PbFieldType._PACKED_BIT) != 0) {
      if (!fieldValue.isEmpty) {
        writeTag(WIRETYPE_LENGTH_DELIMITED);
        _withDeferredSizeCalculation(() {
          for (var value in fieldValue) {
            writeFunction(this, value);
          }
        });
      }
      return;
    }

    writeValue(value) {
      writeTag(_OPEN_TAG_MAP[valueType]);
      writeFunction(this, value);
      if (valueType == PbFieldType._GROUP_BIT) {
        writeTag(WIRETYPE_END_GROUP);
      }
    }

    if ((fieldType & PbFieldType._REPEATED_BIT) != 0) {
      fieldValue.forEach(writeValue);
      return;
    }

    writeValue(fieldValue);
  }

  void writeInt32NoTag(int value) {
    writeRawBytes(_int32ToBytes(value));
  }

  void writeRawBytes(TypedData value) {
    _output.add(value);
    _runningSizeInBytes += value.lengthInBytes;
  }

  Uint8List toBuffer() {
    Uint8List result = new Uint8List(_runningSizeInBytes);
    writeTo(result);
    return result;
  }

  /// Serializes everything written to this writer so far to [buffer], starting
  /// from [offset] in [buffer]. Returns `true` on success.
  bool writeTo(List<int> buffer, [int offset = 0]) {
    if (buffer.length - offset < _runningSizeInBytes) {
      return false;
    }
    int position = offset;
    for (var typedData in _output) {
      Uint8List asBytes = new Uint8List.view(
          typedData.buffer, typedData.offsetInBytes, typedData.lengthInBytes);
      buffer.setRange(position, position + typedData.lengthInBytes, asBytes);
      position += typedData.lengthInBytes;
    }
    return true;
  }
}
