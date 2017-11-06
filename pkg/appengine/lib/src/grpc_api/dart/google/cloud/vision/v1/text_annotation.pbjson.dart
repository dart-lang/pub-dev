///
//  Generated code. Do not modify.
///
library google.cloud.vision.v1_text_annotation_pbjson;

const TextAnnotation$json = const {
  '1': 'TextAnnotation',
  '2': const [
    const {'1': 'pages', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.vision.v1.Page'},
    const {'1': 'text', '3': 2, '4': 1, '5': 9},
  ],
  '3': const [TextAnnotation_DetectedLanguage$json, TextAnnotation_DetectedBreak$json, TextAnnotation_TextProperty$json],
};

const TextAnnotation_DetectedLanguage$json = const {
  '1': 'DetectedLanguage',
  '2': const [
    const {'1': 'language_code', '3': 1, '4': 1, '5': 9},
    const {'1': 'confidence', '3': 2, '4': 1, '5': 2},
  ],
};

const TextAnnotation_DetectedBreak$json = const {
  '1': 'DetectedBreak',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.google.cloud.vision.v1.TextAnnotation.DetectedBreak.BreakType'},
    const {'1': 'is_prefix', '3': 2, '4': 1, '5': 8},
  ],
  '4': const [TextAnnotation_DetectedBreak_BreakType$json],
};

const TextAnnotation_DetectedBreak_BreakType$json = const {
  '1': 'BreakType',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'SPACE', '2': 1},
    const {'1': 'SURE_SPACE', '2': 2},
    const {'1': 'EOL_SURE_SPACE', '2': 3},
    const {'1': 'HYPHEN', '2': 4},
    const {'1': 'LINE_BREAK', '2': 5},
  ],
};

const TextAnnotation_TextProperty$json = const {
  '1': 'TextProperty',
  '2': const [
    const {'1': 'detected_languages', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.vision.v1.TextAnnotation.DetectedLanguage'},
    const {'1': 'detected_break', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.vision.v1.TextAnnotation.DetectedBreak'},
  ],
};

const Page$json = const {
  '1': 'Page',
  '2': const [
    const {'1': 'property', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.vision.v1.TextAnnotation.TextProperty'},
    const {'1': 'width', '3': 2, '4': 1, '5': 5},
    const {'1': 'height', '3': 3, '4': 1, '5': 5},
    const {'1': 'blocks', '3': 4, '4': 3, '5': 11, '6': '.google.cloud.vision.v1.Block'},
  ],
};

const Block$json = const {
  '1': 'Block',
  '2': const [
    const {'1': 'property', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.vision.v1.TextAnnotation.TextProperty'},
    const {'1': 'bounding_box', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.vision.v1.BoundingPoly'},
    const {'1': 'paragraphs', '3': 3, '4': 3, '5': 11, '6': '.google.cloud.vision.v1.Paragraph'},
    const {'1': 'block_type', '3': 4, '4': 1, '5': 14, '6': '.google.cloud.vision.v1.Block.BlockType'},
  ],
  '4': const [Block_BlockType$json],
};

const Block_BlockType$json = const {
  '1': 'BlockType',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'TEXT', '2': 1},
    const {'1': 'TABLE', '2': 2},
    const {'1': 'PICTURE', '2': 3},
    const {'1': 'RULER', '2': 4},
    const {'1': 'BARCODE', '2': 5},
  ],
};

const Paragraph$json = const {
  '1': 'Paragraph',
  '2': const [
    const {'1': 'property', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.vision.v1.TextAnnotation.TextProperty'},
    const {'1': 'bounding_box', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.vision.v1.BoundingPoly'},
    const {'1': 'words', '3': 3, '4': 3, '5': 11, '6': '.google.cloud.vision.v1.Word'},
  ],
};

const Word$json = const {
  '1': 'Word',
  '2': const [
    const {'1': 'property', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.vision.v1.TextAnnotation.TextProperty'},
    const {'1': 'bounding_box', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.vision.v1.BoundingPoly'},
    const {'1': 'symbols', '3': 3, '4': 3, '5': 11, '6': '.google.cloud.vision.v1.Symbol'},
  ],
};

const Symbol$json = const {
  '1': 'Symbol',
  '2': const [
    const {'1': 'property', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.vision.v1.TextAnnotation.TextProperty'},
    const {'1': 'bounding_box', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.vision.v1.BoundingPoly'},
    const {'1': 'text', '3': 3, '4': 1, '5': 9},
  ],
};

