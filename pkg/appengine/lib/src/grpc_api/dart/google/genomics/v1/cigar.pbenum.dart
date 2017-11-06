///
//  Generated code. Do not modify.
///
library google.genomics.v1_cigar_pbenum;

import 'package:protobuf/protobuf.dart';

class CigarUnit_Operation extends ProtobufEnum {
  static const CigarUnit_Operation OPERATION_UNSPECIFIED = const CigarUnit_Operation._(0, 'OPERATION_UNSPECIFIED');
  static const CigarUnit_Operation ALIGNMENT_MATCH = const CigarUnit_Operation._(1, 'ALIGNMENT_MATCH');
  static const CigarUnit_Operation INSERT = const CigarUnit_Operation._(2, 'INSERT');
  static const CigarUnit_Operation DELETE = const CigarUnit_Operation._(3, 'DELETE');
  static const CigarUnit_Operation SKIP = const CigarUnit_Operation._(4, 'SKIP');
  static const CigarUnit_Operation CLIP_SOFT = const CigarUnit_Operation._(5, 'CLIP_SOFT');
  static const CigarUnit_Operation CLIP_HARD = const CigarUnit_Operation._(6, 'CLIP_HARD');
  static const CigarUnit_Operation PAD = const CigarUnit_Operation._(7, 'PAD');
  static const CigarUnit_Operation SEQUENCE_MATCH = const CigarUnit_Operation._(8, 'SEQUENCE_MATCH');
  static const CigarUnit_Operation SEQUENCE_MISMATCH = const CigarUnit_Operation._(9, 'SEQUENCE_MISMATCH');

  static const List<CigarUnit_Operation> values = const <CigarUnit_Operation> [
    OPERATION_UNSPECIFIED,
    ALIGNMENT_MATCH,
    INSERT,
    DELETE,
    SKIP,
    CLIP_SOFT,
    CLIP_HARD,
    PAD,
    SEQUENCE_MATCH,
    SEQUENCE_MISMATCH,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static CigarUnit_Operation valueOf(int value) => _byValue[value] as CigarUnit_Operation;
  static void $checkItem(CigarUnit_Operation v) {
    if (v is !CigarUnit_Operation) checkItemFailed(v, 'CigarUnit_Operation');
  }

  const CigarUnit_Operation._(int v, String n) : super(v, n);
}

