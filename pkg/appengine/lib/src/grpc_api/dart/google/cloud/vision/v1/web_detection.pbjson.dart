///
//  Generated code. Do not modify.
///
library google.cloud.vision.v1_web_detection_pbjson;

const WebDetection$json = const {
  '1': 'WebDetection',
  '2': const [
    const {'1': 'web_entities', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.vision.v1.WebDetection.WebEntity'},
    const {'1': 'full_matching_images', '3': 2, '4': 3, '5': 11, '6': '.google.cloud.vision.v1.WebDetection.WebImage'},
    const {'1': 'partial_matching_images', '3': 3, '4': 3, '5': 11, '6': '.google.cloud.vision.v1.WebDetection.WebImage'},
    const {'1': 'pages_with_matching_images', '3': 4, '4': 3, '5': 11, '6': '.google.cloud.vision.v1.WebDetection.WebPage'},
  ],
  '3': const [WebDetection_WebEntity$json, WebDetection_WebImage$json, WebDetection_WebPage$json],
};

const WebDetection_WebEntity$json = const {
  '1': 'WebEntity',
  '2': const [
    const {'1': 'entity_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'score', '3': 2, '4': 1, '5': 2},
    const {'1': 'description', '3': 3, '4': 1, '5': 9},
  ],
};

const WebDetection_WebImage$json = const {
  '1': 'WebImage',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9},
    const {'1': 'score', '3': 2, '4': 1, '5': 2},
  ],
};

const WebDetection_WebPage$json = const {
  '1': 'WebPage',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9},
    const {'1': 'score', '3': 2, '4': 1, '5': 2},
  ],
};

