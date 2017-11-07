///
//  Generated code. Do not modify.
///
library google.cloud.vision.v1_image_annotator_pbenum;

import 'package:protobuf/protobuf.dart';

class Likelihood extends ProtobufEnum {
  static const Likelihood UNKNOWN = const Likelihood._(0, 'UNKNOWN');
  static const Likelihood VERY_UNLIKELY = const Likelihood._(1, 'VERY_UNLIKELY');
  static const Likelihood UNLIKELY = const Likelihood._(2, 'UNLIKELY');
  static const Likelihood POSSIBLE = const Likelihood._(3, 'POSSIBLE');
  static const Likelihood LIKELY = const Likelihood._(4, 'LIKELY');
  static const Likelihood VERY_LIKELY = const Likelihood._(5, 'VERY_LIKELY');

  static const List<Likelihood> values = const <Likelihood> [
    UNKNOWN,
    VERY_UNLIKELY,
    UNLIKELY,
    POSSIBLE,
    LIKELY,
    VERY_LIKELY,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Likelihood valueOf(int value) => _byValue[value] as Likelihood;
  static void $checkItem(Likelihood v) {
    if (v is !Likelihood) checkItemFailed(v, 'Likelihood');
  }

  const Likelihood._(int v, String n) : super(v, n);
}

class Feature_Type extends ProtobufEnum {
  static const Feature_Type TYPE_UNSPECIFIED = const Feature_Type._(0, 'TYPE_UNSPECIFIED');
  static const Feature_Type FACE_DETECTION = const Feature_Type._(1, 'FACE_DETECTION');
  static const Feature_Type LANDMARK_DETECTION = const Feature_Type._(2, 'LANDMARK_DETECTION');
  static const Feature_Type LOGO_DETECTION = const Feature_Type._(3, 'LOGO_DETECTION');
  static const Feature_Type LABEL_DETECTION = const Feature_Type._(4, 'LABEL_DETECTION');
  static const Feature_Type TEXT_DETECTION = const Feature_Type._(5, 'TEXT_DETECTION');
  static const Feature_Type SAFE_SEARCH_DETECTION = const Feature_Type._(6, 'SAFE_SEARCH_DETECTION');
  static const Feature_Type IMAGE_PROPERTIES = const Feature_Type._(7, 'IMAGE_PROPERTIES');

  static const List<Feature_Type> values = const <Feature_Type> [
    TYPE_UNSPECIFIED,
    FACE_DETECTION,
    LANDMARK_DETECTION,
    LOGO_DETECTION,
    LABEL_DETECTION,
    TEXT_DETECTION,
    SAFE_SEARCH_DETECTION,
    IMAGE_PROPERTIES,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Feature_Type valueOf(int value) => _byValue[value] as Feature_Type;
  static void $checkItem(Feature_Type v) {
    if (v is !Feature_Type) checkItemFailed(v, 'Feature_Type');
  }

  const Feature_Type._(int v, String n) : super(v, n);
}

class FaceAnnotation_Landmark_Type extends ProtobufEnum {
  static const FaceAnnotation_Landmark_Type UNKNOWN_LANDMARK = const FaceAnnotation_Landmark_Type._(0, 'UNKNOWN_LANDMARK');
  static const FaceAnnotation_Landmark_Type LEFT_EYE = const FaceAnnotation_Landmark_Type._(1, 'LEFT_EYE');
  static const FaceAnnotation_Landmark_Type RIGHT_EYE = const FaceAnnotation_Landmark_Type._(2, 'RIGHT_EYE');
  static const FaceAnnotation_Landmark_Type LEFT_OF_LEFT_EYEBROW = const FaceAnnotation_Landmark_Type._(3, 'LEFT_OF_LEFT_EYEBROW');
  static const FaceAnnotation_Landmark_Type RIGHT_OF_LEFT_EYEBROW = const FaceAnnotation_Landmark_Type._(4, 'RIGHT_OF_LEFT_EYEBROW');
  static const FaceAnnotation_Landmark_Type LEFT_OF_RIGHT_EYEBROW = const FaceAnnotation_Landmark_Type._(5, 'LEFT_OF_RIGHT_EYEBROW');
  static const FaceAnnotation_Landmark_Type RIGHT_OF_RIGHT_EYEBROW = const FaceAnnotation_Landmark_Type._(6, 'RIGHT_OF_RIGHT_EYEBROW');
  static const FaceAnnotation_Landmark_Type MIDPOINT_BETWEEN_EYES = const FaceAnnotation_Landmark_Type._(7, 'MIDPOINT_BETWEEN_EYES');
  static const FaceAnnotation_Landmark_Type NOSE_TIP = const FaceAnnotation_Landmark_Type._(8, 'NOSE_TIP');
  static const FaceAnnotation_Landmark_Type UPPER_LIP = const FaceAnnotation_Landmark_Type._(9, 'UPPER_LIP');
  static const FaceAnnotation_Landmark_Type LOWER_LIP = const FaceAnnotation_Landmark_Type._(10, 'LOWER_LIP');
  static const FaceAnnotation_Landmark_Type MOUTH_LEFT = const FaceAnnotation_Landmark_Type._(11, 'MOUTH_LEFT');
  static const FaceAnnotation_Landmark_Type MOUTH_RIGHT = const FaceAnnotation_Landmark_Type._(12, 'MOUTH_RIGHT');
  static const FaceAnnotation_Landmark_Type MOUTH_CENTER = const FaceAnnotation_Landmark_Type._(13, 'MOUTH_CENTER');
  static const FaceAnnotation_Landmark_Type NOSE_BOTTOM_RIGHT = const FaceAnnotation_Landmark_Type._(14, 'NOSE_BOTTOM_RIGHT');
  static const FaceAnnotation_Landmark_Type NOSE_BOTTOM_LEFT = const FaceAnnotation_Landmark_Type._(15, 'NOSE_BOTTOM_LEFT');
  static const FaceAnnotation_Landmark_Type NOSE_BOTTOM_CENTER = const FaceAnnotation_Landmark_Type._(16, 'NOSE_BOTTOM_CENTER');
  static const FaceAnnotation_Landmark_Type LEFT_EYE_TOP_BOUNDARY = const FaceAnnotation_Landmark_Type._(17, 'LEFT_EYE_TOP_BOUNDARY');
  static const FaceAnnotation_Landmark_Type LEFT_EYE_RIGHT_CORNER = const FaceAnnotation_Landmark_Type._(18, 'LEFT_EYE_RIGHT_CORNER');
  static const FaceAnnotation_Landmark_Type LEFT_EYE_BOTTOM_BOUNDARY = const FaceAnnotation_Landmark_Type._(19, 'LEFT_EYE_BOTTOM_BOUNDARY');
  static const FaceAnnotation_Landmark_Type LEFT_EYE_LEFT_CORNER = const FaceAnnotation_Landmark_Type._(20, 'LEFT_EYE_LEFT_CORNER');
  static const FaceAnnotation_Landmark_Type RIGHT_EYE_TOP_BOUNDARY = const FaceAnnotation_Landmark_Type._(21, 'RIGHT_EYE_TOP_BOUNDARY');
  static const FaceAnnotation_Landmark_Type RIGHT_EYE_RIGHT_CORNER = const FaceAnnotation_Landmark_Type._(22, 'RIGHT_EYE_RIGHT_CORNER');
  static const FaceAnnotation_Landmark_Type RIGHT_EYE_BOTTOM_BOUNDARY = const FaceAnnotation_Landmark_Type._(23, 'RIGHT_EYE_BOTTOM_BOUNDARY');
  static const FaceAnnotation_Landmark_Type RIGHT_EYE_LEFT_CORNER = const FaceAnnotation_Landmark_Type._(24, 'RIGHT_EYE_LEFT_CORNER');
  static const FaceAnnotation_Landmark_Type LEFT_EYEBROW_UPPER_MIDPOINT = const FaceAnnotation_Landmark_Type._(25, 'LEFT_EYEBROW_UPPER_MIDPOINT');
  static const FaceAnnotation_Landmark_Type RIGHT_EYEBROW_UPPER_MIDPOINT = const FaceAnnotation_Landmark_Type._(26, 'RIGHT_EYEBROW_UPPER_MIDPOINT');
  static const FaceAnnotation_Landmark_Type LEFT_EAR_TRAGION = const FaceAnnotation_Landmark_Type._(27, 'LEFT_EAR_TRAGION');
  static const FaceAnnotation_Landmark_Type RIGHT_EAR_TRAGION = const FaceAnnotation_Landmark_Type._(28, 'RIGHT_EAR_TRAGION');
  static const FaceAnnotation_Landmark_Type LEFT_EYE_PUPIL = const FaceAnnotation_Landmark_Type._(29, 'LEFT_EYE_PUPIL');
  static const FaceAnnotation_Landmark_Type RIGHT_EYE_PUPIL = const FaceAnnotation_Landmark_Type._(30, 'RIGHT_EYE_PUPIL');
  static const FaceAnnotation_Landmark_Type FOREHEAD_GLABELLA = const FaceAnnotation_Landmark_Type._(31, 'FOREHEAD_GLABELLA');
  static const FaceAnnotation_Landmark_Type CHIN_GNATHION = const FaceAnnotation_Landmark_Type._(32, 'CHIN_GNATHION');
  static const FaceAnnotation_Landmark_Type CHIN_LEFT_GONION = const FaceAnnotation_Landmark_Type._(33, 'CHIN_LEFT_GONION');
  static const FaceAnnotation_Landmark_Type CHIN_RIGHT_GONION = const FaceAnnotation_Landmark_Type._(34, 'CHIN_RIGHT_GONION');

  static const List<FaceAnnotation_Landmark_Type> values = const <FaceAnnotation_Landmark_Type> [
    UNKNOWN_LANDMARK,
    LEFT_EYE,
    RIGHT_EYE,
    LEFT_OF_LEFT_EYEBROW,
    RIGHT_OF_LEFT_EYEBROW,
    LEFT_OF_RIGHT_EYEBROW,
    RIGHT_OF_RIGHT_EYEBROW,
    MIDPOINT_BETWEEN_EYES,
    NOSE_TIP,
    UPPER_LIP,
    LOWER_LIP,
    MOUTH_LEFT,
    MOUTH_RIGHT,
    MOUTH_CENTER,
    NOSE_BOTTOM_RIGHT,
    NOSE_BOTTOM_LEFT,
    NOSE_BOTTOM_CENTER,
    LEFT_EYE_TOP_BOUNDARY,
    LEFT_EYE_RIGHT_CORNER,
    LEFT_EYE_BOTTOM_BOUNDARY,
    LEFT_EYE_LEFT_CORNER,
    RIGHT_EYE_TOP_BOUNDARY,
    RIGHT_EYE_RIGHT_CORNER,
    RIGHT_EYE_BOTTOM_BOUNDARY,
    RIGHT_EYE_LEFT_CORNER,
    LEFT_EYEBROW_UPPER_MIDPOINT,
    RIGHT_EYEBROW_UPPER_MIDPOINT,
    LEFT_EAR_TRAGION,
    RIGHT_EAR_TRAGION,
    LEFT_EYE_PUPIL,
    RIGHT_EYE_PUPIL,
    FOREHEAD_GLABELLA,
    CHIN_GNATHION,
    CHIN_LEFT_GONION,
    CHIN_RIGHT_GONION,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static FaceAnnotation_Landmark_Type valueOf(int value) => _byValue[value] as FaceAnnotation_Landmark_Type;
  static void $checkItem(FaceAnnotation_Landmark_Type v) {
    if (v is !FaceAnnotation_Landmark_Type) checkItemFailed(v, 'FaceAnnotation_Landmark_Type');
  }

  const FaceAnnotation_Landmark_Type._(int v, String n) : super(v, n);
}

