// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

/// An object representing a protobuf message field.
class FieldInfo<T> {
  final String name;
  final int tagNumber;
  final int index; // index of the field's value. Null for extensions.
  final int type;

  // Constructs the default value of a field.
  // (Only used for repeated fields where check is null.)
  final MakeDefaultFunc makeDefault;

  // Creates an empty message or group when decoding a message.
  // Not used for other types.
  // see GeneratedMessage._getEmptyMessage
  final CreateBuilderFunc subBuilder;

  // Looks up the enum value given its integer code.
  // (Not used for other types.)
  // see GeneratedMessage._getValueOfFunc
  final ValueOfFunc valueOf;

  // Verifies an item being added to a repeated field
  // (Not used for non-repeated fields.)
  final CheckFunc check;

  FieldInfo(this.name, this.tagNumber, this.index, int type,
      [dynamic defaultOrMaker, this.subBuilder, this.valueOf])
      : this.type = type,
        this.makeDefault = findMakeDefault(type, defaultOrMaker),
        this.check = null {
    assert(type != 0);
    assert(!_isGroupOrMessage(type) || subBuilder != null);
    assert(!_isEnum(type) || valueOf != null);
  }

  FieldInfo.repeated(this.name, this.tagNumber, this.index, int type,
      CheckFunc check, this.subBuilder,
      [this.valueOf])
      : this.type = type,
        this.check = check,
        this.makeDefault = (() => new PbList<T>(check: check)) {
    assert(name != null);
    assert(tagNumber != null);
    assert(_isRepeated(type));
    assert(check != null);
    assert(!_isEnum(type) || valueOf != null);
  }

  static MakeDefaultFunc findMakeDefault(int type, dynamic defaultOrMaker) {
    if (defaultOrMaker == null) return PbFieldType._defaultForType(type);
    if (defaultOrMaker is MakeDefaultFunc) return defaultOrMaker;
    return () => defaultOrMaker;
  }

  bool get isRequired => _isRequired(type);
  bool get isRepeated => _isRepeated(type);

  /// Returns a read-only default value for a field.
  /// (Unlike getField, doesn't create a repeated field.)
  get readonlyDefault {
    if (isRepeated) return const [];
    return makeDefault();
  }

  /// Returns true if the field's value is okay to transmit.
  /// That is, it doesn't contain any required fields that aren't initialized.
  bool _hasRequiredValues(value) {
    if (value == null) return !isRequired; // missing is okay if optional
    if (!_isGroupOrMessage(type)) return true; // primitive and present

    if (!isRepeated) {
      // A required message: recurse.
      GeneratedMessage message = value;
      return message._fieldSet._hasRequiredValues();
    }

    List list = value;
    if (list.isEmpty) return true;

    // For message types that (recursively) contain no required fields,
    // short-circuit the loop.
    if (!list[0]._fieldSet._hasRequiredFields) return true;

    // Recurse on each item in the list.
    return list.every((GeneratedMessage m) => m._fieldSet._hasRequiredValues());
  }

  /// Appends the dotted path to each required field that's missing a value.
  void _appendInvalidFields(List<String> problems, value, String prefix) {
    if (value == null) {
      if (isRequired) problems.add('$prefix$name');
    } else if (!_isGroupOrMessage(type)) {
      // primitive and present
    } else if (!isRepeated) {
      // Required message/group: recurse.
      GeneratedMessage message = value;
      message._fieldSet._appendInvalidFields(problems, '$prefix$name.');
    } else {
      final list = value as List<GeneratedMessage>;
      if (list.isEmpty) return;

      // For message types that (recursively) contain no required fields,
      // short-circuit the loop.
      if (!list[0]._fieldSet._hasRequiredFields) return;

      // Recurse on each item in the list.
      int position = 0;
      for (GeneratedMessage message in list) {
        message._fieldSet
            ._appendInvalidFields(problems, '$prefix$name[$position].');
        position++;
      }
    }
  }

  /// Creates a repeated field to be attached to the given message.
  ///
  /// Delegates actual list creation to the message, so that it can
  /// be overridden by a mixin.
  List<T> _createRepeatedField(GeneratedMessage m) {
    assert(isRepeated);
    return m.createRepeatedField<T>(tagNumber, this);
  }

  String toString() => name;
}
