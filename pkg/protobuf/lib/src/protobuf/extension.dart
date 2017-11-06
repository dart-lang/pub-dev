// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

/// An object representing an extension field.
class Extension<T> extends FieldInfo<T> {
  final String extendee;

  Extension(this.extendee, String name, int tagNumber, int fieldType,
      [dynamic defaultOrMaker,
      CreateBuilderFunc subBuilder,
      ValueOfFunc valueOf])
      : super(name, tagNumber, null, fieldType, defaultOrMaker, subBuilder,
            valueOf);

  Extension.repeated(
      this.extendee, String name, int tagNumber, int fieldType, CheckFunc check,
      [CreateBuilderFunc subBuilder, ValueOfFunc valueOf])
      : super.repeated(
            name, tagNumber, null, fieldType, check, subBuilder, valueOf);

  int get hashCode => extendee.hashCode * 31 + tagNumber;

  bool operator ==(other) {
    if (other is! Extension) return false;

    Extension o = other;
    return extendee == o.extendee && tagNumber == o.tagNumber;
  }
}
