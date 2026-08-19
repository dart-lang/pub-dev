//
//  Generated code. Do not modify.
//  source: google/type/quaternion.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  A quaternion is defined as the quotient of two directed lines in a
///  three-dimensional space or equivalently as the quotient of two Euclidean
///  vectors (https://en.wikipedia.org/wiki/Quaternion).
///
///  Quaternions are often used in calculations involving three-dimensional
///  rotations (https://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation),
///  as they provide greater mathematical robustness by avoiding the gimbal lock
///  problems that can be encountered when using Euler angles
///  (https://en.wikipedia.org/wiki/Gimbal_lock).
///
///  Quaternions are generally represented in this form:
///
///      w + xi + yj + zk
///
///  where x, y, z, and w are real numbers, and i, j, and k are three imaginary
///  numbers.
///
///  Our naming choice `(x, y, z, w)` comes from the desire to avoid confusion for
///  those interested in the geometric properties of the quaternion in the 3D
///  Cartesian space. Other texts often use alternative names or subscripts, such
///  as `(a, b, c, d)`, `(1, i, j, k)`, or `(0, 1, 2, 3)`, which are perhaps
///  better suited for mathematical interpretations.
///
///  To avoid any confusion, as well as to maintain compatibility with a large
///  number of software libraries, the quaternions represented using the protocol
///  buffer below *must* follow the Hamilton convention, which defines `ij = k`
///  (i.e. a right-handed algebra), and therefore:
///
///      i^2 = j^2 = k^2 = ijk = −1
///      ij = −ji = k
///      jk = −kj = i
///      ki = −ik = j
///
///  Please DO NOT use this to represent quaternions that follow the JPL
///  convention, or any of the other quaternion flavors out there.
///
///  Definitions:
///
///    - Quaternion norm (or magnitude): `sqrt(x^2 + y^2 + z^2 + w^2)`.
///    - Unit (or normalized) quaternion: a quaternion whose norm is 1.
///    - Pure quaternion: a quaternion whose scalar component (`w`) is 0.
///    - Rotation quaternion: a unit quaternion used to represent rotation.
///    - Orientation quaternion: a unit quaternion used to represent orientation.
///
///  A quaternion can be normalized by dividing it by its norm. The resulting
///  quaternion maintains the same direction, but has a norm of 1, i.e. it moves
///  on the unit sphere. This is generally necessary for rotation and orientation
///  quaternions, to avoid rounding errors:
///  https://en.wikipedia.org/wiki/Rotation_formalisms_in_three_dimensions
///
///  Note that `(x, y, z, w)` and `(-x, -y, -z, -w)` represent the same rotation,
///  but normalization would be even more useful, e.g. for comparison purposes, if
///  it would produce a unique representation. It is thus recommended that `w` be
///  kept positive, which can be achieved by changing all the signs when `w` is
///  negative.
class Quaternion extends $pb.GeneratedMessage {
  factory Quaternion({
    $core.double? x,
    $core.double? y,
    $core.double? z,
    $core.double? w,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (z != null) {
      $result.z = z;
    }
    if (w != null) {
      $result.w = w;
    }
    return $result;
  }
  Quaternion._() : super();
  factory Quaternion.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Quaternion.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Quaternion',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.type'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'z', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'w', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Quaternion clone() => Quaternion()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Quaternion copyWith(void Function(Quaternion) updates) =>
      super.copyWith((message) => updates(message as Quaternion)) as Quaternion;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Quaternion create() => Quaternion._();
  Quaternion createEmptyInstance() => create();
  static $pb.PbList<Quaternion> createRepeated() => $pb.PbList<Quaternion>();
  @$core.pragma('dart2js:noInline')
  static Quaternion getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Quaternion>(create);
  static Quaternion? _defaultInstance;

  /// The x component.
  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) {
    $_setDouble(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  /// The y component.
  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);

  /// The z component.
  @$pb.TagNumber(3)
  $core.double get z => $_getN(2);
  @$pb.TagNumber(3)
  set z($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasZ() => $_has(2);
  @$pb.TagNumber(3)
  void clearZ() => clearField(3);

  /// The scalar component.
  @$pb.TagNumber(4)
  $core.double get w => $_getN(3);
  @$pb.TagNumber(4)
  set w($core.double v) {
    $_setDouble(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasW() => $_has(3);
  @$pb.TagNumber(4)
  void clearW() => clearField(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
