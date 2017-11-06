// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

typedef GeneratedMessage CreateBuilderFunc();
typedef MakeDefaultFunc();
typedef ProtobufEnum ValueOfFunc(int value);

/// The base class for all protobuf message types.
///
/// The protoc plugin generates subclasses providing type-specific
/// properties and methods.
///
/// Public properties and methods added here should also be added to
/// GeneratedMessage_reservedNames and should be unlikely to be used in
/// a proto file.
abstract class GeneratedMessage {
  _FieldSet _fieldSet;

  GeneratedMessage() {
    _fieldSet = new _FieldSet(this, info_, eventPlugin);
    if (eventPlugin != null) eventPlugin.attach(this);
  }

  GeneratedMessage.fromBuffer(
      List<int> input, ExtensionRegistry extensionRegistry) {
    _fieldSet = new _FieldSet(this, info_, eventPlugin);
    if (eventPlugin != null) eventPlugin.attach(this);
    mergeFromBuffer(input, extensionRegistry);
  }

  GeneratedMessage.fromJson(String input, ExtensionRegistry extensionRegistry) {
    _fieldSet = new _FieldSet(this, info_, eventPlugin);
    if (eventPlugin != null) eventPlugin.attach(this);
    mergeFromJson(input, extensionRegistry);
  }

  // Overridden by subclasses.
  BuilderInfo get info_;

  /// Subclasses can override this getter to be notified of changes
  /// to protobuf fields.
  EventPlugin get eventPlugin => null;

  /// Creates a deep copy of the fields in this message.
  /// (The generated code uses [mergeFromMessage].)
  GeneratedMessage clone();

  UnknownFieldSet get unknownFields => _fieldSet._ensureUnknownFields();

  bool get _isReadOnly => this is ReadonlyMessageMixin;

  bool hasRequiredFields() => info_.hasRequiredFields;

  /// Returns [:true:] if all required fields in the message and all embedded
  /// messages are set, false otherwise.
  bool isInitialized() => _fieldSet._hasRequiredValues();

  /// Clears all data that was set in this message.
  ///
  /// After calling [clear], [getField] will still return default values for
  /// unset fields.
  void clear() => _fieldSet._clear();

  // TODO(antonm): move to getters.
  int getTagNumber(String fieldName) => info_.tagNumber(fieldName);

  bool operator ==(other) =>
      other is GeneratedMessage ? _fieldSet._equals(other._fieldSet) : false;

  /// Calculates a hash code based on the contents of the protobuf.
  ///
  /// The hash may change when any field changes (recursively).
  /// Therefore, protobufs used as map keys shouldn't be changed.
  int get hashCode => _fieldSet._hashCode;

  /// Returns a String representation of this message.
  ///
  /// This representation is similar to, but not quite, the Protocol Buffer
  /// TextFormat. Each field is printed on its own line. Sub-messages are
  /// indented two spaces farther than their parent messages.
  ///
  /// Note that this format is absolutely subject to change, and should only
  /// ever be used for debugging.
  String toString() => toDebugString();

  /// Returns a String representation of this message.
  ///
  /// This generates the same output as [toString], but can be used by mixins
  /// to compose debug strings with additional information.
  String toDebugString() {
    var out = new StringBuffer();
    _fieldSet.writeString(out, '');
    return out.toString();
  }

  void check() {
    if (!isInitialized()) {
      List<String> invalidFields = <String>[];
      _fieldSet._appendInvalidFields(invalidFields, "");
      String missingFields = (invalidFields..sort()).join(', ');
      throw new StateError('Message missing required fields: $missingFields');
    }
  }

  Uint8List writeToBuffer() {
    CodedBufferWriter out = new CodedBufferWriter();
    writeToCodedBufferWriter(out);
    return out.toBuffer();
  }

  void writeToCodedBufferWriter(CodedBufferWriter output) =>
      _writeToCodedBufferWriter(_fieldSet, output);

  void mergeFromCodedBufferReader(CodedBufferReader input,
          [ExtensionRegistry extensionRegistry = ExtensionRegistry.EMPTY]) =>
      _mergeFromCodedBufferReader(_fieldSet, input, extensionRegistry);

  /// Merges serialized protocol buffer data into this message.
  ///
  /// For each field in [input] that is already present in this message:
  ///
  /// * If it's a repeated field, this appends to the end of our list.
  /// * Else, if it's a scalar, this overwrites our field.
  /// * Else, (it's a non-repeated sub-message), this recursively merges into
  ///   the existing sub-message.
  void mergeFromBuffer(List<int> input,
      [ExtensionRegistry extensionRegistry = ExtensionRegistry.EMPTY]) {
    CodedBufferReader codedInput = new CodedBufferReader(input);
    _mergeFromCodedBufferReader(_fieldSet, codedInput, extensionRegistry);
    codedInput.checkLastTagWas(0);
  }

  // JSON support.

  /// Returns the JSON encoding of this message as a Dart [Map].
  ///
  /// The encoding is described in [GeneratedMessage.writeToJson].
  Map<String, dynamic> writeToJsonMap() => _writeToJsonMap(_fieldSet);

  /// Returns a JSON string that encodes this message.
  ///
  /// Each message (top level or nested) is represented as an object delimited
  /// by curly braces. Within a message, elements are indexed by tag number
  /// (surrounded by quotes). Repeated elements are represented as arrays.
  ///
  /// Boolean values, strings, and floating-point values are represented as
  /// literals. Values with a 32-bit integer datatype are represented as integer
  /// literals; values with a 64-bit integer datatype (regardless of their
  /// actual runtime value) are represented as strings. Enumerated values are
  /// represented as their integer value.
  String writeToJson() => JSON.encode(writeToJsonMap());

  /// Merges field values from [data], a JSON object, encoded as described by
  /// [GeneratedMessage.writeToJson].
  void mergeFromJson(String data,
      [ExtensionRegistry extensionRegistry = ExtensionRegistry.EMPTY]) {
    /// Disable lazy creation of Dart objects for a dart2js speedup.
    /// This is a slight regression on the Dart VM.
    /// TODO(skybrian) we could skip the reviver if we're running
    /// on the Dart VM for a slight speedup.
    final jsonMap =
        JSON.decode(data, reviver: _emptyReviver) as Map<String, dynamic>;
    _mergeFromJsonMap(_fieldSet, jsonMap, extensionRegistry);
  }

  static _emptyReviver(k, v) => v;

  /// Merges field values from a JSON object represented as a Dart map.
  ///
  /// The encoding is described in [GeneratedMessage.writeToJson].
  void mergeFromJsonMap(Map<String, dynamic> json,
      [ExtensionRegistry extensionRegistry = ExtensionRegistry.EMPTY]) {
    _mergeFromJsonMap(_fieldSet, json, extensionRegistry);
  }

  /// Adds an extension field value to a repeated field.
  ///
  /// The backing [List] will be created if necessary.
  /// If the list already exists, the old extension won't be overwritten.
  void addExtension(Extension extension, var value) {
    if (!extension.isRepeated) {
      throw new ArgumentError(
          'Cannot add to a non-repeated field (use setExtension())');
    }
    _fieldSet._ensureExtensions().._ensureRepeatedField(extension).add(value);
  }

  /// Clears an extension field and also removes the extension.
  void clearExtension(Extension extension) {
    if (_fieldSet._hasExtensions) {
      _fieldSet._extensions._clearFieldAndInfo(extension);
    }
  }

  /// Clears the contents of a given field.
  ///
  /// If it's an extension field, the Extension will be kept.
  /// The tagNumber should be a valid tag or extension.
  void clearField(int tagNumber) => _fieldSet._clearField(tagNumber);

  bool extensionsAreInitialized() => _fieldSet._hasRequiredExtensionValues();

  /// Returns the value of [extension].
  ///
  /// If not set, returns the extension's default value.
  getExtension(Extension extension) {
    if (_isReadOnly) return extension.readonlyDefault;
    return _fieldSet._ensureExtensions()._getFieldOrDefault(extension);
  }

  /// Returns the value of the field associated with [tagNumber], or the
  /// default value if it is not set.
  getField(int tagNumber) => _fieldSet._getField(tagNumber);

  /// Creates List implementing a mutable repeated field.
  ///
  /// Mixins may override this method to change the List type. To ensure
  /// that the protobuf can be encoded correctly, the returned List must
  /// validate all items added to it. This can most easily be done
  /// using the FieldInfo.check function.
  List<T> createRepeatedField<T>(int tagNumber, FieldInfo<T> fi) {
    return new PbList<T>(check: fi.check);
  }

  /// Returns the value of a field, ignoring any defaults.
  ///
  /// For unset or cleared fields, returns null.
  /// Also returns null for unknown tag numbers.
  getFieldOrNull(int tagNumber) => _fieldSet._getFieldOrNullByTag(tagNumber);

  /// Returns the default value for the given field.
  ///
  /// For repeated fields, returns an immutable empty list
  /// (unlike [getField]). For all other fields, returns
  /// the same thing that getField() would for a cleared field.
  getDefaultForField(int tagNumber) =>
      _fieldSet._ensureInfo(tagNumber).readonlyDefault;

  /// Returns [:true:] if a value of [extension] is present.
  bool hasExtension(Extension extension) =>
      _fieldSet._hasExtensions &&
      _fieldSet._extensions._getFieldOrNull(extension) != null;

  /// Returns [:true:] if this message has a field associated with [tagNumber].
  bool hasField(int tagNumber) => _fieldSet._hasField(tagNumber);

  /// Merges the contents of the [other] into this message.
  ///
  /// Singular fields that are set in [other] overwrite the corresponding fields
  /// in this message. Repeated fields are appended. Singular sub-messages are
  /// recursively merged.
  void mergeFromMessage(GeneratedMessage other) =>
      _fieldSet._mergeFromMessage(other._fieldSet);

  void mergeUnknownFields(UnknownFieldSet unknownFieldSet) => _fieldSet
      ._ensureUnknownFields()
      .mergeFromUnknownFieldSet(unknownFieldSet);

  /// Sets the value of a non-repeated extension field to [value].
  void setExtension(Extension extension, value) {
    if (value == null) throw new ArgumentError('value is null');
    if (_isRepeated(extension.type)) {
      throw new ArgumentError(_fieldSet._setFieldFailedMessage(
          extension, value, 'repeating field (use get + .add())'));
    }
    _fieldSet._ensureExtensions()._setFieldAndInfo(extension, value);
  }

  /// Sets the value of a field by its [tagNumber].
  ///
  /// Throws an [:ArgumentError:] if [value] does not match the type
  /// associated with [tagNumber].
  ///
  /// Throws an [:ArgumentError:] if [value] is [:null:]. To clear a field of
  /// it's current value, use [clearField] instead.
  void setField(int tagNumber, value) => _fieldSet._setField(tagNumber, value);

  /// For generated code only.
  T $_get<T>(int index, int tagNumber, T defaultValue) =>
      _fieldSet._$get<T>(index, tagNumber, defaultValue);

  /// For generated code only.
  bool $_has(int index, int tagNumber) => _fieldSet._$has(index, tagNumber);

  /// For generated code only.
  void $_setBool(int index, int tagNumber, bool value) =>
      _fieldSet._$set(index, tagNumber, value);

  /// For generated code only.
  void $_setBytes(int index, int tagNumber, List<int> value) =>
      _fieldSet._$set(index, tagNumber, value);

  /// For generated code only.
  void $_setString(int index, int tagNumber, String value) =>
      _fieldSet._$set(index, tagNumber, value);

  /// For generated code only.
  void $_setFloat(int index, int tagNumber, double value) {
    if (value == null || !_isFloat32(value)) {
      _fieldSet._$check(tagNumber, value);
    }
    _fieldSet._$set(index, tagNumber, value);
  }

  /// For generated code only.
  void $_setDouble(int index, int tagNumber, double value) =>
      _fieldSet._$set(index, tagNumber, value);

  /// For generated code only.
  void $_setSignedInt32(int index, int tagNumber, int value) {
    if (value == null || !_isSigned32(value)) {
      _fieldSet._$check(tagNumber, value);
    }
    _fieldSet._$set(index, tagNumber, value);
  }

  /// For generated code only.
  void $_setUnsignedInt32(int index, int tagNumber, int value) {
    if (value == null || !_isUnsigned32(value)) {
      _fieldSet._$check(tagNumber, value);
    }
    _fieldSet._$set(index, tagNumber, value);
  }

  /// For generated code only.
  void $_setInt64(int index, int tagNumber, Int64 value) =>
      _fieldSet._$set(index, tagNumber, value);
}
