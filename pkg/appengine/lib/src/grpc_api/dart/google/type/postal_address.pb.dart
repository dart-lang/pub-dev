///
//  Generated code. Do not modify.
///
library google.type_postal_address;

import 'package:protobuf/protobuf.dart';

class PostalAddress extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PostalAddress')
    ..a/*<int>*/(1, 'revision', PbFieldType.O3)
    ..a/*<String>*/(2, 'regionCode', PbFieldType.OS)
    ..a/*<String>*/(3, 'languageCode', PbFieldType.OS)
    ..a/*<String>*/(4, 'postalCode', PbFieldType.OS)
    ..a/*<String>*/(5, 'sortingCode', PbFieldType.OS)
    ..a/*<String>*/(6, 'administrativeArea', PbFieldType.OS)
    ..a/*<String>*/(7, 'locality', PbFieldType.OS)
    ..a/*<String>*/(8, 'sublocality', PbFieldType.OS)
    ..p/*<String>*/(9, 'addressLines', PbFieldType.PS)
    ..p/*<String>*/(10, 'recipients', PbFieldType.PS)
    ..a/*<String>*/(11, 'organization', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  PostalAddress() : super();
  PostalAddress.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PostalAddress.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PostalAddress clone() => new PostalAddress()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PostalAddress create() => new PostalAddress();
  static PbList<PostalAddress> createRepeated() => new PbList<PostalAddress>();
  static PostalAddress getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPostalAddress();
    return _defaultInstance;
  }
  static PostalAddress _defaultInstance;
  static void $checkItem(PostalAddress v) {
    if (v is !PostalAddress) checkItemFailed(v, 'PostalAddress');
  }

  int get revision => $_get(0, 1, 0);
  void set revision(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasRevision() => $_has(0, 1);
  void clearRevision() => clearField(1);

  String get regionCode => $_get(1, 2, '');
  void set regionCode(String v) { $_setString(1, 2, v); }
  bool hasRegionCode() => $_has(1, 2);
  void clearRegionCode() => clearField(2);

  String get languageCode => $_get(2, 3, '');
  void set languageCode(String v) { $_setString(2, 3, v); }
  bool hasLanguageCode() => $_has(2, 3);
  void clearLanguageCode() => clearField(3);

  String get postalCode => $_get(3, 4, '');
  void set postalCode(String v) { $_setString(3, 4, v); }
  bool hasPostalCode() => $_has(3, 4);
  void clearPostalCode() => clearField(4);

  String get sortingCode => $_get(4, 5, '');
  void set sortingCode(String v) { $_setString(4, 5, v); }
  bool hasSortingCode() => $_has(4, 5);
  void clearSortingCode() => clearField(5);

  String get administrativeArea => $_get(5, 6, '');
  void set administrativeArea(String v) { $_setString(5, 6, v); }
  bool hasAdministrativeArea() => $_has(5, 6);
  void clearAdministrativeArea() => clearField(6);

  String get locality => $_get(6, 7, '');
  void set locality(String v) { $_setString(6, 7, v); }
  bool hasLocality() => $_has(6, 7);
  void clearLocality() => clearField(7);

  String get sublocality => $_get(7, 8, '');
  void set sublocality(String v) { $_setString(7, 8, v); }
  bool hasSublocality() => $_has(7, 8);
  void clearSublocality() => clearField(8);

  List<String> get addressLines => $_get(8, 9, null);

  List<String> get recipients => $_get(9, 10, null);

  String get organization => $_get(10, 11, '');
  void set organization(String v) { $_setString(10, 11, v); }
  bool hasOrganization() => $_has(10, 11);
  void clearOrganization() => clearField(11);
}

class _ReadonlyPostalAddress extends PostalAddress with ReadonlyMessageMixin {}

