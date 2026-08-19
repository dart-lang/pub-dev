//
//  Generated code. Do not modify.
//  source: google/type/decimal.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  A representation of a decimal value, such as 2.5. Clients may convert values
///  into language-native decimal formats, such as Java's [BigDecimal][] or
///  Python's [decimal.Decimal][].
///
///  [BigDecimal]:
///  https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/math/BigDecimal.html
///  [decimal.Decimal]: https://docs.python.org/3/library/decimal.html
class Decimal extends $pb.GeneratedMessage {
  factory Decimal({
    $core.String? value,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  Decimal._() : super();
  factory Decimal.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Decimal.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Decimal',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.type'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Decimal clone() => Decimal()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Decimal copyWith(void Function(Decimal) updates) =>
      super.copyWith((message) => updates(message as Decimal)) as Decimal;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Decimal create() => Decimal._();
  Decimal createEmptyInstance() => create();
  static $pb.PbList<Decimal> createRepeated() => $pb.PbList<Decimal>();
  @$core.pragma('dart2js:noInline')
  static Decimal getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Decimal>(create);
  static Decimal? _defaultInstance;

  ///  The decimal value, as a string.
  ///
  ///  The string representation consists of an optional sign, `+` (`U+002B`)
  ///  or `-` (`U+002D`), followed by a sequence of zero or more decimal digits
  ///  ("the integer"), optionally followed by a fraction, optionally followed
  ///  by an exponent.
  ///
  ///  The fraction consists of a decimal point followed by zero or more decimal
  ///  digits. The string must contain at least one digit in either the integer
  ///  or the fraction. The number formed by the sign, the integer and the
  ///  fraction is referred to as the significand.
  ///
  ///  The exponent consists of the character `e` (`U+0065`) or `E` (`U+0045`)
  ///  followed by one or more decimal digits.
  ///
  ///  Services **should** normalize decimal values before storing them by:
  ///
  ///    - Removing an explicitly-provided `+` sign (`+2.5` -> `2.5`).
  ///    - Replacing a zero-length integer value with `0` (`.5` -> `0.5`).
  ///    - Coercing the exponent character to lower-case (`2.5E8` -> `2.5e8`).
  ///    - Removing an explicitly-provided zero exponent (`2.5e0` -> `2.5`).
  ///
  ///  Services **may** perform additional normalization based on its own needs
  ///  and the internal decimal implementation selected, such as shifting the
  ///  decimal point and exponent value together (example: `2.5e-1` <-> `0.25`).
  ///  Additionally, services **may** preserve trailing zeroes in the fraction
  ///  to indicate increased precision, but are not required to do so.
  ///
  ///  Note that only the `.` character is supported to divide the integer
  ///  and the fraction; `,` **should not** be supported regardless of locale.
  ///  Additionally, thousand separators **should not** be supported. If a
  ///  service does support them, values **must** be normalized.
  ///
  ///  The ENBF grammar is:
  ///
  ///      DecimalString =
  ///        [Sign] Significand [Exponent];
  ///
  ///      Sign = '+' | '-';
  ///
  ///      Significand =
  ///        Digits ['.'] [Digits] | [Digits] '.' Digits;
  ///
  ///      Exponent = ('e' | 'E') [Sign] Digits;
  ///
  ///      Digits = { '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' };
  ///
  ///  Services **should** clearly document the range of supported values, the
  ///  maximum supported precision (total number of digits), and, if applicable,
  ///  the scale (number of digits after the decimal point), as well as how it
  ///  behaves when receiving out-of-bounds values.
  ///
  ///  Services **may** choose to accept values passed as input even when the
  ///  value has a higher precision or scale than the service supports, and
  ///  **should** round the value to fit the supported scale. Alternatively, the
  ///  service **may** error with `400 Bad Request` (`INVALID_ARGUMENT` in gRPC)
  ///  if precision would be lost.
  ///
  ///  Services **should** error with `400 Bad Request` (`INVALID_ARGUMENT` in
  ///  gRPC) if the service receives a value outside of the supported range.
  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
