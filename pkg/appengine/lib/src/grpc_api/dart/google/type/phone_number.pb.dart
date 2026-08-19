//
//  Generated code. Do not modify.
//  source: google/type/phone_number.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  An object representing a short code, which is a phone number that is
///  typically much shorter than regular phone numbers and can be used to
///  address messages in MMS and SMS systems, as well as for abbreviated dialing
///  (e.g. "Text 611 to see how many minutes you have remaining on your plan.").
///
///  Short codes are restricted to a region and are not internationally
///  dialable, which means the same short code can exist in different regions,
///  with different usage and pricing, even if those regions share the same
///  country calling code (e.g. US and CA).
class PhoneNumber_ShortCode extends $pb.GeneratedMessage {
  factory PhoneNumber_ShortCode({
    $core.String? regionCode,
    $core.String? number,
  }) {
    final $result = create();
    if (regionCode != null) {
      $result.regionCode = regionCode;
    }
    if (number != null) {
      $result.number = number;
    }
    return $result;
  }
  PhoneNumber_ShortCode._() : super();
  factory PhoneNumber_ShortCode.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PhoneNumber_ShortCode.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PhoneNumber.ShortCode',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.type'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'regionCode')
    ..aOS(2, _omitFieldNames ? '' : 'number')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PhoneNumber_ShortCode clone() =>
      PhoneNumber_ShortCode()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PhoneNumber_ShortCode copyWith(
          void Function(PhoneNumber_ShortCode) updates) =>
      super.copyWith((message) => updates(message as PhoneNumber_ShortCode))
          as PhoneNumber_ShortCode;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhoneNumber_ShortCode create() => PhoneNumber_ShortCode._();
  PhoneNumber_ShortCode createEmptyInstance() => create();
  static $pb.PbList<PhoneNumber_ShortCode> createRepeated() =>
      $pb.PbList<PhoneNumber_ShortCode>();
  @$core.pragma('dart2js:noInline')
  static PhoneNumber_ShortCode getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PhoneNumber_ShortCode>(create);
  static PhoneNumber_ShortCode? _defaultInstance;

  ///  Required. The BCP-47 region code of the location where calls to this
  ///  short code can be made, such as "US" and "BB".
  ///
  ///  Reference(s):
  ///   - http://www.unicode.org/reports/tr35/#unicode_region_subtag
  @$pb.TagNumber(1)
  $core.String get regionCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set regionCode($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRegionCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearRegionCode() => clearField(1);

  /// Required. The short code digits, without a leading plus ('+') or country
  /// calling code, e.g. "611".
  @$pb.TagNumber(2)
  $core.String get number => $_getSZ(1);
  @$pb.TagNumber(2)
  set number($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => clearField(2);
}

enum PhoneNumber_Kind { e164Number, shortCode, notSet }

///  An object representing a phone number, suitable as an API wire format.
///
///  This representation:
///
///   - should not be used for locale-specific formatting of a phone number, such
///     as "+1 (650) 253-0000 ext. 123"
///
///   - is not designed for efficient storage
///   - may not be suitable for dialing - specialized libraries (see references)
///     should be used to parse the number for that purpose
///
///  To do something meaningful with this number, such as format it for various
///  use-cases, convert it to an `i18n.phonenumbers.PhoneNumber` object first.
///
///  For instance, in Java this would be:
///
///     com.google.type.PhoneNumber wireProto =
///         com.google.type.PhoneNumber.newBuilder().build();
///     com.google.i18n.phonenumbers.Phonenumber.PhoneNumber phoneNumber =
///         PhoneNumberUtil.getInstance().parse(wireProto.getE164Number(), "ZZ");
///     if (!wireProto.getExtension().isEmpty()) {
///       phoneNumber.setExtension(wireProto.getExtension());
///     }
///
///   Reference(s):
///    - https://github.com/google/libphonenumber
class PhoneNumber extends $pb.GeneratedMessage {
  factory PhoneNumber({
    $core.String? e164Number,
    PhoneNumber_ShortCode? shortCode,
    $core.String? extension_3,
  }) {
    final $result = create();
    if (e164Number != null) {
      $result.e164Number = e164Number;
    }
    if (shortCode != null) {
      $result.shortCode = shortCode;
    }
    if (extension_3 != null) {
      $result.extension_3 = extension_3;
    }
    return $result;
  }
  PhoneNumber._() : super();
  factory PhoneNumber.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PhoneNumber.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, PhoneNumber_Kind> _PhoneNumber_KindByTag = {
    1: PhoneNumber_Kind.e164Number,
    2: PhoneNumber_Kind.shortCode,
    0: PhoneNumber_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PhoneNumber',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.type'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'e164Number')
    ..aOM<PhoneNumber_ShortCode>(2, _omitFieldNames ? '' : 'shortCode',
        subBuilder: PhoneNumber_ShortCode.create)
    ..aOS(3, _omitFieldNames ? '' : 'extension')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PhoneNumber clone() => PhoneNumber()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PhoneNumber copyWith(void Function(PhoneNumber) updates) =>
      super.copyWith((message) => updates(message as PhoneNumber))
          as PhoneNumber;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhoneNumber create() => PhoneNumber._();
  PhoneNumber createEmptyInstance() => create();
  static $pb.PbList<PhoneNumber> createRepeated() => $pb.PbList<PhoneNumber>();
  @$core.pragma('dart2js:noInline')
  static PhoneNumber getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PhoneNumber>(create);
  static PhoneNumber? _defaultInstance;

  PhoneNumber_Kind whichKind() => _PhoneNumber_KindByTag[$_whichOneof(0)]!;
  void clearKind() => clearField($_whichOneof(0));

  ///  The phone number, represented as a leading plus sign ('+'), followed by a
  ///  phone number that uses a relaxed ITU E.164 format consisting of the
  ///  country calling code (1 to 3 digits) and the subscriber number, with no
  ///  additional spaces or formatting, e.g.:
  ///   - correct: "+15552220123"
  ///   - incorrect: "+1 (555) 222-01234 x123".
  ///
  ///  The ITU E.164 format limits the latter to 12 digits, but in practice not
  ///  all countries respect that, so we relax that restriction here.
  ///  National-only numbers are not allowed.
  ///
  ///  References:
  ///   - https://www.itu.int/rec/T-REC-E.164-201011-I
  ///   - https://en.wikipedia.org/wiki/E.164.
  ///   - https://en.wikipedia.org/wiki/List_of_country_calling_codes
  @$pb.TagNumber(1)
  $core.String get e164Number => $_getSZ(0);
  @$pb.TagNumber(1)
  set e164Number($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasE164Number() => $_has(0);
  @$pb.TagNumber(1)
  void clearE164Number() => clearField(1);

  ///  A short code.
  ///
  ///  Reference(s):
  ///   - https://en.wikipedia.org/wiki/Short_code
  @$pb.TagNumber(2)
  PhoneNumber_ShortCode get shortCode => $_getN(1);
  @$pb.TagNumber(2)
  set shortCode(PhoneNumber_ShortCode v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasShortCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearShortCode() => clearField(2);
  @$pb.TagNumber(2)
  PhoneNumber_ShortCode ensureShortCode() => $_ensure(1);

  ///  The phone number's extension. The extension is not standardized in ITU
  ///  recommendations, except for being defined as a series of numbers with a
  ///  maximum length of 40 digits. Other than digits, some other dialing
  ///  characters such as ',' (indicating a wait) or '#' may be stored here.
  ///
  ///  Note that no regions currently use extensions with short codes, so this
  ///  field is normally only set in conjunction with an E.164 number. It is held
  ///  separately from the E.164 number to allow for short code extensions in the
  ///  future.
  @$pb.TagNumber(3)
  $core.String get extension_3 => $_getSZ(2);
  @$pb.TagNumber(3)
  set extension_3($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasExtension_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtension_3() => clearField(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
