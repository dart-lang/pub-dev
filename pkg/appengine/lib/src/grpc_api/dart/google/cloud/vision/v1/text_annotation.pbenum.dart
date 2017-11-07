///
//  Generated code. Do not modify.
///
library google.cloud.vision.v1_text_annotation_pbenum;

import 'package:protobuf/protobuf.dart';

class TextAnnotation_DetectedBreak_BreakType extends ProtobufEnum {
  static const TextAnnotation_DetectedBreak_BreakType UNKNOWN = const TextAnnotation_DetectedBreak_BreakType._(0, 'UNKNOWN');
  static const TextAnnotation_DetectedBreak_BreakType SPACE = const TextAnnotation_DetectedBreak_BreakType._(1, 'SPACE');
  static const TextAnnotation_DetectedBreak_BreakType SURE_SPACE = const TextAnnotation_DetectedBreak_BreakType._(2, 'SURE_SPACE');
  static const TextAnnotation_DetectedBreak_BreakType EOL_SURE_SPACE = const TextAnnotation_DetectedBreak_BreakType._(3, 'EOL_SURE_SPACE');
  static const TextAnnotation_DetectedBreak_BreakType HYPHEN = const TextAnnotation_DetectedBreak_BreakType._(4, 'HYPHEN');
  static const TextAnnotation_DetectedBreak_BreakType LINE_BREAK = const TextAnnotation_DetectedBreak_BreakType._(5, 'LINE_BREAK');

  static const List<TextAnnotation_DetectedBreak_BreakType> values = const <TextAnnotation_DetectedBreak_BreakType> [
    UNKNOWN,
    SPACE,
    SURE_SPACE,
    EOL_SURE_SPACE,
    HYPHEN,
    LINE_BREAK,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static TextAnnotation_DetectedBreak_BreakType valueOf(int value) => _byValue[value] as TextAnnotation_DetectedBreak_BreakType;
  static void $checkItem(TextAnnotation_DetectedBreak_BreakType v) {
    if (v is !TextAnnotation_DetectedBreak_BreakType) checkItemFailed(v, 'TextAnnotation_DetectedBreak_BreakType');
  }

  const TextAnnotation_DetectedBreak_BreakType._(int v, String n) : super(v, n);
}

class Block_BlockType extends ProtobufEnum {
  static const Block_BlockType UNKNOWN = const Block_BlockType._(0, 'UNKNOWN');
  static const Block_BlockType TEXT = const Block_BlockType._(1, 'TEXT');
  static const Block_BlockType TABLE = const Block_BlockType._(2, 'TABLE');
  static const Block_BlockType PICTURE = const Block_BlockType._(3, 'PICTURE');
  static const Block_BlockType RULER = const Block_BlockType._(4, 'RULER');
  static const Block_BlockType BARCODE = const Block_BlockType._(5, 'BARCODE');

  static const List<Block_BlockType> values = const <Block_BlockType> [
    UNKNOWN,
    TEXT,
    TABLE,
    PICTURE,
    RULER,
    BARCODE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Block_BlockType valueOf(int value) => _byValue[value] as Block_BlockType;
  static void $checkItem(Block_BlockType v) {
    if (v is !Block_BlockType) checkItemFailed(v, 'Block_BlockType');
  }

  const Block_BlockType._(int v, String n) : super(v, n);
}

