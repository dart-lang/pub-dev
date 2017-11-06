// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

/// Modifies a GeneratedMessage so that it's read-only.
abstract class ReadonlyMessageMixin {
  BuilderInfo get info_;

  void addExtension(Extension extension, var value) =>
      _readonly("addExtension");

  void clear() => _readonly("clear");

  void clearExtension(Extension extension) => _readonly("clearExtension");

  void clearField(int tagNumber) => _readonly("clearField");

  List<T> createRepeatedField<T>(int tagNumber, FieldInfo<T> fi) {
    _readonly("createRepeatedField");
    return null; // not reached
  }

  void mergeFromBuffer(List<int> input,
          [ExtensionRegistry extensionRegistry = ExtensionRegistry.EMPTY]) =>
      _readonly("mergeFromBuffer");

  void mergeFromCodedBufferReader(CodedBufferReader input,
          [ExtensionRegistry extensionRegistry = ExtensionRegistry.EMPTY]) =>
      _readonly("mergeFromCodedBufferReader");

  void mergeFromJson(String data,
          [ExtensionRegistry extensionRegistry = ExtensionRegistry.EMPTY]) =>
      _readonly("mergeFromJson");

  void mergeFromJsonMap(Map<String, dynamic> json,
          [ExtensionRegistry extensionRegistry = ExtensionRegistry.EMPTY]) =>
      _readonly("mergeFromJsonMap");

  void mergeFromMessage(GeneratedMessage other) =>
      _readonly("mergeFromMessage");

  void mergeUnknownFields(UnknownFieldSet unknownFieldSet) =>
      _readonly("mergeUnknownFields");

  void setExtension(Extension extension, var value) =>
      _readonly("setExtension");

  void setField(int tagNumber, var value, [int fieldType = null]) =>
      _readonly("setField");

  void _readonly(String methodName) {
    String messageType = info_.messageName;
    throw new UnsupportedError(
        "attempted to call $methodName on a read-only message ($messageType)");
  }
}

class _ReadonlyUnknownFieldSet extends UnknownFieldSet {
  static final _empty = new _ReadonlyUnknownFieldSet();

  @override
  void clear() => _readonly("clear");

  @override
  void addField(int number, UnknownFieldSetField field) =>
      _readonly("addField");

  @override
  void mergeField(int number, UnknownFieldSetField field) =>
      _readonly("mergeField");

  @override
  bool mergeFieldFromBuffer(int tag, CodedBufferReader input) {
    _readonly("mergeFieldFromBuffer");
    return false; // not reached
  }

  @override
  void mergeFromCodedBufferReader(CodedBufferReader input) =>
      _readonly("mergeFromCodedBufferReader");

  @override
  void mergeFromUnknownFieldSet(UnknownFieldSet other) =>
      _readonly("mergeFromUnknownFieldSet");

  @override
  UnknownFieldSetField _getField(int number) {
    _readonly("a merge method");
    return null; // not reached
  }

  void _readonly(String methodName) {
    throw new UnsupportedError(
        "attempted to call $methodName on a read-only UnknownFieldSet");
  }
}
