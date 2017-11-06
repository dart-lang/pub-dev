// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

/// A base class for all Protocol Buffer enum types.
///
/// All Protocol Buffer [:enum:] classes inherit from ProtobufEnum. For
/// example, given the following enum defined in a .proto file:
///
///     message MyMessage {
///       enum Color {
///         RED = 0;
///         GREEN = 1;
///         BLUE = 2;
///       };
///       // ...
///     }
///
/// the generated Dart file will include a [:MyMessage_Color:] class that
/// [:extends ProtobufEnum:]. It will also include a [:const MyMessage_Color:]
/// for each of the three values defined. Here are some examples:
///
///     MyMessage_Color.RED  // => a MyMessage_Color instance
///     MyMessage_Color.GREEN.value  // => 1
///     MyMessage_Color.GREEN.name   // => "GREEN"
class ProtobufEnum {
  /// This enum's integer value, as specified in the .proto file.
  final int value;

  /// This enum's name, as specified in the .proto file.
  final String name;

  /// Returns a new constant ProtobufEnum using [value] and [name].
  const ProtobufEnum(this.value, this.name);

  /// Returns a Map for all of the [ProtobufEnum]s in [byIndex], mapping each
  /// [ProtobufEnum]'s [value] to the [ProtobufEnum].

  // Cannot type return type as Map<int, ProtobufEnum> as it will be
  // assigned to Map<int, subtype of ProtobufEnum>.
  static Map<int, dynamic> initByValue(List<ProtobufEnum> byIndex) {
    var byValue = new Map<int, dynamic>();
    for (ProtobufEnum v in byIndex) {
      byValue[v.value] = v;
    }
    return byValue;
  }

  int get hashCode => value;

  /// Returns this enum's [name].
  String toString() => name;
}
