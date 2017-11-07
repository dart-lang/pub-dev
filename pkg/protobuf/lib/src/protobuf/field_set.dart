// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

/// All the data in a GeneratedMessage.
///
/// These fields and methods are in a separate class to avoid
/// polymorphic access due to inheritance. This turns out to
/// be faster when compiled to JavaScript.
class _FieldSet {
  final GeneratedMessage _message;
  final BuilderInfo _meta;
  final EventPlugin _eventPlugin;

  /// The value of each non-extension field in a fixed-length array.
  /// The index of a field can be found in [FieldInfo.index].
  /// A null entry indicates that the field has no value.
  final List _values;

  /// Contains all the extension fields, or null if there aren't any.
  _ExtensionFieldSet _extensions;

  /// Contains all the unknown fields, or null if there aren't any.
  UnknownFieldSet _unknownFields;

  _FieldSet(this._message, BuilderInfo meta, this._eventPlugin)
      : this._meta = meta,
        _values = _makeValueList(meta.fieldInfo);

  static _makeValueList(Map<int, FieldInfo> infos) {
    if (infos.isEmpty) return const [];
    return new List(infos.length);
  }

  // Metadata about multiple fields

  String get _messageName => _meta.messageName;
  bool get _isReadOnly => _message._isReadOnly;
  bool get _hasRequiredFields => _meta.hasRequiredFields;

  /// The FieldInfo for each non-extension field.
  Iterable<FieldInfo> get _infos => _meta.fieldInfo.values;

  /// The FieldInfo for each non-extension field in tag order.
  Iterable<FieldInfo> get _infosSortedByTag => _meta.sortedByTag;

  /// Returns true if we should send events to the plugin.
  bool get _hasObservers => _eventPlugin != null && _eventPlugin.hasObservers;

  bool get _hasExtensions => _extensions != null;
  bool get hasUnknownFields => _unknownFields != null;

  _ExtensionFieldSet _ensureExtensions() {
    assert(!_isReadOnly);
    if (!_hasExtensions) _extensions = new _ExtensionFieldSet(this);
    return _extensions;
  }

  UnknownFieldSet _ensureUnknownFields() {
    if (_isReadOnly) return _ReadonlyUnknownFieldSet._empty;
    if (_unknownFields == null) _unknownFields = new UnknownFieldSet();
    return _unknownFields;
  }

  // Metadata about single fields

  /// Returns FieldInfo for a non-extension field, or null if not found.
  FieldInfo _nonExtensionInfo(int tagNumber) => _meta.fieldInfo[tagNumber];

  /// Returns the FieldInfo for a regular or extension field.
  /// throws ArgumentException if no info is found.
  FieldInfo _ensureInfo(int tagNumber) {
    var fi = _getFieldInfoOrNull(tagNumber);
    if (fi != null) return fi;
    throw new ArgumentError("tag $tagNumber not defined in $_messageName");
  }

  /// Returns the FieldInfo for a regular or extension field.
  FieldInfo _getFieldInfoOrNull(int tagNumber) {
    var fi = _nonExtensionInfo(tagNumber);
    if (fi != null) return fi;
    if (!_hasExtensions) return null;
    return _extensions._getInfoOrNull(tagNumber);
  }

  // Single-field operations

  /// Gets a field with full error-checking.
  ///
  /// Works for both extended and non-extended fields.
  /// Creates repeated fields (unless read-only).
  /// Suitable for public API.
  _getField(int tagNumber) {
    var fi = _nonExtensionInfo(tagNumber);
    if (fi != null) {
      var value = _values[fi.index];
      if (value != null) return value;
      return _getDefault(fi);
    }
    if (_hasExtensions) {
      var fi = _extensions._getInfoOrNull(tagNumber);
      if (fi != null) {
        return _extensions._getFieldOrDefault(fi);
      }
    }
    throw new ArgumentError("tag $tagNumber not defined in $_messageName");
  }

  _getDefault(FieldInfo fi) {
    if (!fi.isRepeated) return fi.makeDefault();
    if (_isReadOnly) return const [];

    // TODO(skybrian) we could avoid this by generating another
    // method for repeated fields:
    //   msg.mutableFoo().add(123);
    var value = fi._createRepeatedField(_message);
    _setNonExtensionFieldUnchecked(fi, value);
    return value;
  }

  _getFieldOrNullByTag(int tagNumber) {
    var fi = _getFieldInfoOrNull(tagNumber);
    if (fi == null) return null;
    return _getFieldOrNull(fi);
  }

  /// Returns the field's value or null if not set.
  ///
  /// Works for both extended and non-extend fields.
  /// Works for both repeated and non-repeated fields.
  _getFieldOrNull(FieldInfo fi) {
    if (fi.index != null) return _values[fi.index];
    if (!_hasExtensions) return null;
    return _extensions._getFieldOrNull(fi);
  }

  bool _hasField(int tagNumber) {
    var fi = _nonExtensionInfo(tagNumber);
    if (fi != null) return _$has(fi.index, tagNumber);
    if (!_hasExtensions) return false;
    return _extensions._hasField(tagNumber);
  }

  void _clearField(int tagNumber) {
    var fi = _nonExtensionInfo(tagNumber);
    if (fi != null) {
      // clear a non-extension field
      if (_hasObservers) _eventPlugin.beforeClearField(fi);
      _values[fi.index] = null;
      return;
    }

    if (_hasExtensions) {
      var fi = _extensions._getInfoOrNull(tagNumber);
      if (fi != null) {
        _extensions._clearField(fi);
        return;
      }
    }

    // neither a regular field nor an extension.
    // TODO(skybrian) throw?
  }

  /// Sets a non-repeated field with error-checking.
  ///
  /// Works for both extended and non-extended fields.
  /// Suitable for public API.
  void _setField(int tagNumber, value) {
    if (value == null) throw new ArgumentError('value is null');

    var fi = _nonExtensionInfo(tagNumber);
    if (fi == null) {
      if (!_hasExtensions) {
        throw new ArgumentError("tag $tagNumber not defined in $_messageName");
      }
      _extensions._setField(tagNumber, value);
      return;
    }

    if (fi.isRepeated) {
      throw new ArgumentError(_setFieldFailedMessage(
          fi, value, 'repeating field (use get + .add())'));
    }
    _validateField(fi, value);
    _setNonExtensionFieldUnchecked(fi, value);
  }

  /// Sets a non-repeated field without validating it.
  ///
  /// Works for both extended and non-extended fields.
  /// Suitable for decoders that do their own validation.
  void _setFieldUnchecked(FieldInfo fi, value) {
    assert(fi != null);
    assert(!fi.isRepeated);
    if (fi.index == null) {
      _ensureExtensions()
        .._addInfoUnchecked(fi)
        .._setFieldUnchecked(fi, value);
    } else {
      _setNonExtensionFieldUnchecked(fi, value);
    }
  }

  /// Returns the list to use for adding to a repeated field.
  ///
  /// Works for both extended and non-extended fields.
  /// Creates and stores the repeated field if it doesn't exist.
  /// If it's an extension and the list doesn't exist, validates and stores it.
  /// Suitable for decoders.
  List<T> _ensureRepeatedField<T>(FieldInfo<T> fi) {
    assert(!_isReadOnly);
    assert(fi.isRepeated);
    if (fi.index == null) {
      return _ensureExtensions()._ensureRepeatedField(fi);
    }
    var value = _getFieldOrNull(fi);
    if (value != null) return value as List<T>;

    var newValue = fi._createRepeatedField(_message);
    _setNonExtensionFieldUnchecked(fi, newValue);
    return newValue;
  }

  /// Sets a non-extended field and fires events.
  void _setNonExtensionFieldUnchecked(FieldInfo fi, value) {
    if (_hasObservers) {
      _eventPlugin.beforeSetField(fi, value);
    }
    _values[fi.index] = value;
  }

  // Generated method implementations

  /// The implementation of a generated getter.
  T _$get<T>(int index, int tagNumber, T defaultValue) {
    assert(_nonExtensionInfo(tagNumber).index == index);
    var value = _values[index];
    if (value != null) return value as T;
    if (defaultValue != null) return defaultValue;
    return _getDefault(_nonExtensionInfo(tagNumber)) as T;
  }

  /// The implementation of a generated has method.
  bool _$has(int index, int tagNumber) {
    assert(_nonExtensionInfo(tagNumber).index == index);
    var value = _values[index];
    if (value == null) return false;
    if (value is List) return value.isNotEmpty;
    return true;
  }

  /// The implementation of a generated setter.
  ///
  /// In production, does no validation other than a null check.
  /// Only handles non-repeated, non-extension fields.
  /// Also, doesn't handle enums or messages which need per-type validation.
  void _$set(int index, int tagNumber, value) {
    assert(_nonExtensionInfo(tagNumber).index == index);
    assert(!_nonExtensionInfo(tagNumber).isRepeated);
    assert(_$check(tagNumber, value));
    if (_isReadOnly) {
      throw new UnsupportedError(
          "attempted to call a setter on a read-only message ($_messageName)");
    }
    if (value == null) {
      _$check(tagNumber, value); // throw exception for null value
    }
    if (_hasObservers) {
      _eventPlugin.beforeSetField(_nonExtensionInfo(tagNumber), value);
    }
    _values[index] = value;
  }

  bool _$check(int tagNumber, var newValue) {
    _validateField(_nonExtensionInfo(tagNumber), newValue);
    return true; // Allows use in an assertion.
  }

  // Bulk operations reading or writing multiple fields

  void _clear() {
    if (_unknownFields != null) {
      _unknownFields.clear();
    }

    if (_hasObservers) {
      for (var fi in _infos) {
        if (_values[fi.index] != null) {
          _eventPlugin.beforeClearField(fi);
        }
      }
      if (_hasExtensions) {
        for (int key in _extensions._tagNumbers) {
          var fi = _extensions._getInfoOrNull(key);
          _eventPlugin.beforeClearField(fi);
        }
      }
    }
    if (_values.isNotEmpty) _values.fillRange(0, _values.length, null);
    if (_hasExtensions) _extensions._clearValues();
  }

  bool _equals(_FieldSet o) {
    if (_meta != o._meta) return false;
    for (var i = 0; i < _values.length; i++) {
      if (!_equalFieldValues(_values[i], o._values[i])) return false;
    }

    if (!_hasExtensions || !_extensions._hasValues) {
      // Check if other extensions are logically empty.
      // (Don't create them unnecessarily.)
      if (o._hasExtensions && o._extensions._hasValues) {
        return false;
      }
    } else {
      if (!_extensions._equalValues(o._extensions)) return false;
    }

    if (_unknownFields == null || _unknownFields.isEmpty) {
      // Check if other unknown fields is logically empty.
      // (Don't create them unnecessarily.)
      if (o._unknownFields != null && o._unknownFields.isNotEmpty) return false;
    } else {
      // Check if the other unknown fields has the same fields.
      if (_unknownFields != o._unknownFields) return false;
    }

    return true;
  }

  bool _equalFieldValues(left, right) {
    if (left != null && right != null) return _deepEquals(left, right);

    var val = left ?? right;

    // Two uninitialized fields are equal.
    if (val == null) return true;

    // One field is null. We are comparing an initialized field
    // with its default value.

    // An empty repeated field is the same as uninitialized.
    // This is because accessing a repeated field automatically creates it.
    // We don't want reading a field to change equality comparisons.
    if (val is List && val.isEmpty) return true;

    // For now, initialized and uninitialized fields are different.
    // TODO(skybrian) consider other cases; should we compare with the
    // default value or not?
    return false;
  }

  /// Calculates a hash code based on the contents of the protobuf.
  ///
  /// The hash may change when any field changes (recursively).
  /// Therefore, protobufs used as map keys shouldn't be changed.
  int get _hashCode {
    int hash;

    void hashEnumList(PbList enums) {
      for (ProtobufEnum enm in enums) {
        hash = (31 * hash + enm.value) & 0x3fffffff;
      }
    }

    // Hashes the value of one field (recursively).
    void hashField(FieldInfo fi, value) {
      if (value is List && value.isEmpty) {
        return; // It's either repeated or an empty byte array.
      }
      hash = ((37 * hash) + fi.tagNumber) & 0x3fffffff;
      if (!_isEnum(fi.type)) {
        // TODO(sgjesse): Remove 'as Object' here when issue 14951 is fixed.
        hash = ((53 * hash) + (value as Object).hashCode) & 0x3fffffff;
      } else if (fi.isRepeated) {
        hashEnumList(value);
      } else {
        ProtobufEnum enm = value;
        hash = ((53 * hash) + enm.value) & 0x3fffffff;
      }
    }

    void hashEachField() {
      for (var fi in _infosSortedByTag) {
        var v = _values[fi.index];
        if (v != null) hashField(fi, v);
      }
      if (!_hasExtensions) return;
      for (int tagNumber in sorted(_extensions._tagNumbers)) {
        var fi = _extensions._getInfoOrNull(tagNumber);
        hashField(fi, _extensions._getFieldOrNull(fi));
      }
    }

    // Generate hash.
    hash = 41;
    // Hash with descriptor.
    hash = ((19 * hash) + _meta.hashCode) & 0x3fffffff;
    // Hash with fields.
    hashEachField();
    // Hash with unknown fields.
    if (hasUnknownFields) {
      hash = ((29 * hash) + _unknownFields.hashCode) & 0x3fffffff;
    }
    return hash;
  }

  void writeString(StringBuffer out, String indent) {
    void renderValue(key, value) {
      if (value is GeneratedMessage) {
        out.write('$indent$key: {\n');
        value._fieldSet.writeString(out, '$indent  ');
        out.write('$indent}\n');
      } else {
        out.write('$indent$key: $value\n');
      }
    }

    for (FieldInfo fi in _infosSortedByTag) {
      var fieldValue = _values[fi.index];
      if (fieldValue == null) continue;
      if (fieldValue is ByteData) {
        // TODO(skybrian): possibly unused. Delete?
        final value = fieldValue.getUint64(0, Endianness.LITTLE_ENDIAN);
        renderValue(fi.name, value);
      } else if (fieldValue is List) {
        for (var value in fieldValue) {
          renderValue(fi.name, value);
        }
      } else {
        renderValue(fi.name, fieldValue);
      }
    }
    // TODO(skybrian) write extension fields? So far we haven't.
    if (hasUnknownFields) {
      out.write(_unknownFields.toString());
    } else {
      out.write(new UnknownFieldSet().toString());
    }
  }

  /// Merges the contents of the [other] into this message.
  ///
  /// Singular fields that are set in [other] overwrite the corresponding fields
  /// in this message. Repeated fields are appended. Singular sub-messages are
  /// recursively merged.
  void _mergeFromMessage(_FieldSet other) {
    // TODO(https://github.com/dart-lang/protobuf/issues/60): Recognize
    // when [this] and [other] are the same protobuf (e.g. from cloning). In
    // this case, we can merge the non-extension fields without field lookups or
    // validation checks.

    for (FieldInfo fi in other._infosSortedByTag) {
      var value = other._values[fi.index];
      if (value != null) _mergeField(fi, value);
    }
    if (other._hasExtensions) {
      var others = other._extensions;
      for (int tagNumber in others._tagNumbers) {
        var extension = others._getInfoOrNull(tagNumber);
        var value = others._getFieldOrNull(extension);
        _mergeField(extension, value);
      }
    }

    if (other.hasUnknownFields) {
      _ensureUnknownFields().mergeFromUnknownFieldSet(other._unknownFields);
    }
  }

  void _mergeField(FieldInfo otherFi, fieldValue) {
    int tagNumber = otherFi.tagNumber;

    // Determine the FieldInfo to use.
    // Don't allow regular fields to be overwritten by extensions.
    var fi = _nonExtensionInfo(tagNumber);
    if (fi == null && otherFi is Extension) {
      // This will overwrite any existing extension field info.
      fi = otherFi;
    }

    bool mustClone = _isGroupOrMessage(otherFi.type);

    if (fi.isRepeated) {
      if (mustClone) {
        // Copy the mapped values to a List to avoid redundant cloning (since
        // PbList.addAll iterates over its argument twice).
        _ensureRepeatedField(fi)
            .addAll(new List.from(fieldValue.map(_cloneMessage)));
      } else {
        _ensureRepeatedField(fi).addAll(fieldValue);
      }
      return;
    }

    if (mustClone) {
      fieldValue = _cloneMessage(fieldValue);
    }
    if (fi.index == null) {
      _ensureExtensions()._setFieldAndInfo(fi, fieldValue);
    } else {
      _validateField(fi, fieldValue);
      _setNonExtensionFieldUnchecked(fi, fieldValue);
    }
  }

  // This function is declared as a static method rather than an in-place
  // closure since dart2js does not currently hoist closures with no captured
  // variables (See http://dartbug.com/26932), and dart2js will inline this
  // version at the direct call site.
  static GeneratedMessage _cloneMessage(GeneratedMessage message) =>
      message.clone();

  // Error-checking

  /// Checks the value for a field that's about to be set.
  void _validateField(FieldInfo fi, var newValue) {
    var message = _getFieldError(fi.type, newValue);
    if (message != null) {
      throw new ArgumentError(_setFieldFailedMessage(fi, newValue, message));
    }
  }

  String _setFieldFailedMessage(FieldInfo fi, var value, String detail) {
    return 'Illegal to set field ${fi.name} (${fi.tagNumber}) of $_messageName'
        ' to value ($value): $detail';
  }

  bool _hasRequiredValues() {
    if (!_hasRequiredFields) return true;
    for (var fi in _infos) {
      var value = _values[fi.index];
      if (!fi._hasRequiredValues(value)) return false;
    }
    return _hasRequiredExtensionValues();
  }

  bool _hasRequiredExtensionValues() {
    if (!_hasExtensions) return true;
    for (var fi in _extensions._infos) {
      var value = _extensions._getFieldOrNull(fi);
      if (!fi._hasRequiredValues(value)) return false;
    }
    return true; // No problems found.
  }

  /// Adds the path to each uninitialized field to the list.
  void _appendInvalidFields(List<String> problems, String prefix) {
    if (!_hasRequiredFields) return;
    for (var fi in _infos) {
      var value = _values[fi.index];
      fi._appendInvalidFields(problems, value, prefix);
    }
    // TODO(skybrian): search extensions as well
    // https://github.com/dart-lang/protobuf/issues/46
  }
}
