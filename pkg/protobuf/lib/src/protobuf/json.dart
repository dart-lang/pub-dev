// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

Map<String, dynamic> _writeToJsonMap(_FieldSet fs) {
  convertToMap(fieldValue, fieldType) {
    int baseType = PbFieldType._baseType(fieldType);

    if (_isRepeated(fieldType)) {
      return new List.from(fieldValue.map((e) => convertToMap(e, baseType)));
    }

    switch (baseType) {
      case PbFieldType._BOOL_BIT:
      case PbFieldType._STRING_BIT:
      case PbFieldType._FLOAT_BIT:
      case PbFieldType._DOUBLE_BIT:
      case PbFieldType._INT32_BIT:
      case PbFieldType._SINT32_BIT:
      case PbFieldType._UINT32_BIT:
      case PbFieldType._FIXED32_BIT:
      case PbFieldType._SFIXED32_BIT:
        return fieldValue;
      case PbFieldType._BYTES_BIT:
        // Encode 'bytes' as a base64-encoded string.
        return BASE64.encode(fieldValue as List<int>);
      case PbFieldType._ENUM_BIT:
        return fieldValue.value; // assume |value| < 2^52
      case PbFieldType._INT64_BIT:
      case PbFieldType._SINT64_BIT:
      case PbFieldType._UINT64_BIT:
      case PbFieldType._FIXED64_BIT:
      case PbFieldType._SFIXED64_BIT:
        return fieldValue.toString();
      case PbFieldType._GROUP_BIT:
      case PbFieldType._MESSAGE_BIT:
        return fieldValue.writeToJsonMap();
      default:
        throw 'Unknown type $fieldType';
    }
  }

  var result = <String, dynamic>{};
  for (var fi in fs._infosSortedByTag) {
    var value = fs._values[fi.index];
    if (value == null || (value is List && value.isEmpty)) {
      continue; // It's missing, repeated, or an empty byte array.
    }
    result['${fi.tagNumber}'] = convertToMap(value, fi.type);
  }
  if (fs._hasExtensions) {
    for (int tagNumber in sorted(fs._extensions._tagNumbers)) {
      var value = fs._extensions._values[tagNumber];
      if (value is List && value.isEmpty) {
        continue; // It's repeated or an empty byte array.
      }
      var fi = fs._extensions._getInfoOrNull(tagNumber);
      result['$tagNumber'] = convertToMap(value, fi.type);
    }
  }
  return result;
}

// Merge fields from a previously decoded JSON object.
// (Called recursively on nested messages.)
void _mergeFromJsonMap(
    _FieldSet fs, Map<String, dynamic> json, ExtensionRegistry registry) {
  for (String key in json.keys) {
    var fi = fs._meta.byTagAsString[key];
    if (fi == null) {
      if (registry == null) continue; // Unknown tag; skip
      fi = registry.getExtension(fs._messageName, int.parse(key));
      if (fi == null) continue; // Unknown tag; skip
    }
    if (fi.isRepeated) {
      _appendJsonList(fs, json[key], fi, registry);
    } else {
      _setJsonField(fs, json[key], fi, registry);
    }
  }
}

void _appendJsonList(
    _FieldSet fs, List json, FieldInfo fi, ExtensionRegistry registry) {
  List repeated = fs._ensureRepeatedField(fi);
  for (var value in json) {
    var convertedValue =
        _convertJsonValue(fs, value, fi.tagNumber, fi.type, registry);
    if (convertedValue != null) {
      repeated.add(convertedValue);
    }
  }
}

void _setJsonField(
    _FieldSet fs, json, FieldInfo fi, ExtensionRegistry registry) {
  var value = _convertJsonValue(fs, json, fi.tagNumber, fi.type, registry);
  if (value != null) {
    fs._validateField(fi, value);
    fs._setFieldUnchecked(fi, value);
  }
}

/// Converts [value] from the Json format to the Dart data type
/// suitable for inserting into the corresponding [GeneratedMessage] field.
///
/// Returns the converted value.  This function returns [null] if the caller
/// should ignore the field value, because it is an unknown enum value.
/// This function throws [ArgumentError] if it cannot convert the value.
_convertJsonValue(_FieldSet fs, value, int tagNumber, int fieldType,
    ExtensionRegistry registry) {
  String expectedType; // for exception message
  switch (PbFieldType._baseType(fieldType)) {
    case PbFieldType._BOOL_BIT:
      if (value is bool) {
        return value;
      } else if (value is String) {
        if (value == 'true') {
          return true;
        } else if (value == 'false') {
          return false;
        }
      } else if (value is num) {
        if (value == 1) {
          return true;
        } else if (value == 0) {
          return false;
        }
      }
      expectedType = 'bool (true, false, "true", "false", 1, 0)';
      break;
    case PbFieldType._BYTES_BIT:
      if (value is String) {
        return BASE64.decode(value);
      }
      expectedType = 'Base64 String';
      break;
    case PbFieldType._STRING_BIT:
      if (value is String) {
        return value;
      }
      expectedType = 'String';
      break;
    case PbFieldType._FLOAT_BIT:
    case PbFieldType._DOUBLE_BIT:
      // Allow quoted values, although we don't emit them.
      if (value is double) {
        return value;
      } else if (value is num) {
        return value.toDouble();
      } else if (value is String) {
        return double.parse(value);
      }
      expectedType = 'num or stringified num';
      break;
    case PbFieldType._ENUM_BIT:
      // Allow quoted values, although we don't emit them.
      if (value is String) {
        value = int.parse(value);
      }
      if (value is int) {
        // The following call will return null if the enum value is unknown.
        // In that case, we want the caller to ignore this value, so we return
        // null from this method as well.
        return fs._meta._decodeEnum(tagNumber, registry, value);
      }
      expectedType = 'int or stringified int';
      break;
    case PbFieldType._INT32_BIT:
    case PbFieldType._SINT32_BIT:
    case PbFieldType._UINT32_BIT:
    case PbFieldType._FIXED32_BIT:
    case PbFieldType._SFIXED32_BIT:
      if (value is int) return value;
      if (value is String) return int.parse(value);
      expectedType = 'int or stringified int';
      break;
    case PbFieldType._INT64_BIT:
    case PbFieldType._SINT64_BIT:
    case PbFieldType._UINT64_BIT:
    case PbFieldType._FIXED64_BIT:
    case PbFieldType._SFIXED64_BIT:
      if (value is int) return new Int64(value);
      if (value is String) return Int64.parseRadix(value, 10);
      expectedType = 'int or stringified int';
      break;
    case PbFieldType._GROUP_BIT:
    case PbFieldType._MESSAGE_BIT:
      if (value is Map) {
        GeneratedMessage subMessage =
            fs._meta._makeEmptyMessage(tagNumber, registry);
        _mergeFromJsonMap(
            subMessage._fieldSet, value as Map<String, dynamic>, registry);
        return subMessage;
      }
      expectedType = 'nested message or group';
      break;
    default:
      throw new ArgumentError('Unknown type $fieldType');
  }
  throw new ArgumentError('Expected type $expectedType, got $value');
}
