///
//  Generated code. Do not modify.
///
library google.devtools.source.v1_source_context_pbenum;

import 'package:protobuf/protobuf.dart';

class AliasContext_Kind extends ProtobufEnum {
  static const AliasContext_Kind ANY = const AliasContext_Kind._(0, 'ANY');
  static const AliasContext_Kind FIXED = const AliasContext_Kind._(1, 'FIXED');
  static const AliasContext_Kind MOVABLE = const AliasContext_Kind._(2, 'MOVABLE');
  static const AliasContext_Kind OTHER = const AliasContext_Kind._(4, 'OTHER');

  static const List<AliasContext_Kind> values = const <AliasContext_Kind> [
    ANY,
    FIXED,
    MOVABLE,
    OTHER,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static AliasContext_Kind valueOf(int value) => _byValue[value] as AliasContext_Kind;
  static void $checkItem(AliasContext_Kind v) {
    if (v is !AliasContext_Kind) checkItemFailed(v, 'AliasContext_Kind');
  }

  const AliasContext_Kind._(int v, String n) : super(v, n);
}

