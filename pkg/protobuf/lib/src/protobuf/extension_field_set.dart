// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

class _ExtensionFieldSet {
  final _FieldSet _parent;
  final Map<int, Extension> _info = <int, Extension>{};
  final Map<int, dynamic> _values = <int, dynamic>{};

  _ExtensionFieldSet(this._parent) {
    // Read-only fieldsets shouldn't have extension fields.
    assert(!_parent._isReadOnly);
  }

  Extension _getInfoOrNull(int tagNumber) => _info[tagNumber];

  _getFieldOrDefault(Extension fi) {
    if (fi.isRepeated) return _ensureRepeatedField(fi);
    _validateInfo(fi);
    // TODO(skybrian) seems unnecessary to add info?
    // I think this was originally here for repeated extensions.
    _addInfoUnchecked(fi);
    var value = _getFieldOrNull(fi);
    if (value == null) return fi.makeDefault();
    return value;
  }

  bool _hasField(int tagNumber) {
    var value = _values[tagNumber];
    if (value == null) return false;
    if (value is List) return value.isNotEmpty;
    return true;
  }

  /// Ensures that the list exists and an extension is present.
  ///
  /// If it doesn't exist, creates the list and saves the extension.
  /// Suitable for public API and decoders.
  List<T> _ensureRepeatedField<T>(Extension<T> fi) {
    assert(fi.isRepeated);
    assert(fi.extendee == _parent._messageName);

    var list = _values[fi.tagNumber];
    if (list != null) return list as List<T>;

    // Add info and create list.
    _validateInfo(fi);
    var newList = fi._createRepeatedField(_parent._message);
    _addInfoUnchecked(fi);
    _setFieldUnchecked(fi, newList);
    return newList;
  }

  _getFieldOrNull(Extension extension) => _values[extension.tagNumber];

  void _clearFieldAndInfo(Extension fi) {
    _clearField(fi);
    _info.remove(fi.tagNumber);
  }

  void _clearField(Extension fi) {
    _validateInfo(fi);
    if (_parent._hasObservers) _parent._eventPlugin.beforeClearField(fi);
    _values.remove(fi.tagNumber);
  }

  /// Sets a value for a non-repeated extension that has already been added.
  /// Does error-checking.
  void _setField(int tagNumber, value) {
    var fi = _getInfoOrNull(tagNumber);
    if (fi == null) {
      throw new ArgumentError(
          "tag $tagNumber not defined in $_parent._messageName");
    }
    if (fi.isRepeated) {
      throw new ArgumentError(_parent._setFieldFailedMessage(
          fi, value, 'repeating field (use get + .add())'));
    }
    _parent._validateField(fi, value);
    _setFieldUnchecked(fi, value);
  }

  /// Sets a non-repeated value and extension.
  /// Overwrites any existing extension.
  void _setFieldAndInfo(Extension fi, value) {
    if (fi.isRepeated) {
      throw new ArgumentError(_parent._setFieldFailedMessage(
          fi, value, 'repeating field (use get + .add())'));
    }
    _validateInfo(fi);
    _parent._validateField(fi, value);
    _addInfoUnchecked(fi);
    _setFieldUnchecked(fi, value);
  }

  void _validateInfo(Extension fi) {
    if (fi.extendee != _parent._messageName) {
      throw new ArgumentError(
          'Extension $fi not legal for message ${_parent._messageName}');
    }
  }

  void _addInfoUnchecked(Extension fi) {
    assert(fi.extendee == _parent._messageName);
    _info[fi.tagNumber] = fi;
  }

  void _setFieldUnchecked(Extension fi, value) {
    if (_parent._hasObservers) {
      _parent._eventPlugin.beforeSetField(fi, value);
    }
    _values[fi.tagNumber] = value;
  }

  // Bulk operations

  Iterable<int> get _tagNumbers => _values.keys;
  Iterable<Extension> get _infos => _info.values;

  get _hasValues => _values.isNotEmpty;

  bool _equalValues(_ExtensionFieldSet other) =>
      _areMapsEqual(_values, other._values);

  void _clearValues() => _values.clear();
}
