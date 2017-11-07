///
//  Generated code. Do not modify.
///
library google.genomics.v1_cigar;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import 'cigar.pbenum.dart';

export 'cigar.pbenum.dart';

class CigarUnit extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CigarUnit')
    ..e/*<CigarUnit_Operation>*/(1, 'operation', PbFieldType.OE, CigarUnit_Operation.OPERATION_UNSPECIFIED, CigarUnit_Operation.valueOf)
    ..a/*<Int64>*/(2, 'operationLength', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(3, 'referenceSequence', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CigarUnit() : super();
  CigarUnit.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CigarUnit.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CigarUnit clone() => new CigarUnit()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CigarUnit create() => new CigarUnit();
  static PbList<CigarUnit> createRepeated() => new PbList<CigarUnit>();
  static CigarUnit getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCigarUnit();
    return _defaultInstance;
  }
  static CigarUnit _defaultInstance;
  static void $checkItem(CigarUnit v) {
    if (v is !CigarUnit) checkItemFailed(v, 'CigarUnit');
  }

  CigarUnit_Operation get operation => $_get(0, 1, null);
  void set operation(CigarUnit_Operation v) { setField(1, v); }
  bool hasOperation() => $_has(0, 1);
  void clearOperation() => clearField(1);

  Int64 get operationLength => $_get(1, 2, null);
  void set operationLength(Int64 v) { $_setInt64(1, 2, v); }
  bool hasOperationLength() => $_has(1, 2);
  void clearOperationLength() => clearField(2);

  String get referenceSequence => $_get(2, 3, '');
  void set referenceSequence(String v) { $_setString(2, 3, v); }
  bool hasReferenceSequence() => $_has(2, 3);
  void clearReferenceSequence() => clearField(3);
}

class _ReadonlyCigarUnit extends CigarUnit with ReadonlyMessageMixin {}

