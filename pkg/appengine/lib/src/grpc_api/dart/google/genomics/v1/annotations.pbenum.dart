///
//  Generated code. Do not modify.
///
library google.genomics.v1_annotations_pbenum;

import 'package:protobuf/protobuf.dart';

class AnnotationType extends ProtobufEnum {
  static const AnnotationType ANNOTATION_TYPE_UNSPECIFIED = const AnnotationType._(0, 'ANNOTATION_TYPE_UNSPECIFIED');
  static const AnnotationType GENERIC = const AnnotationType._(1, 'GENERIC');
  static const AnnotationType VARIANT = const AnnotationType._(2, 'VARIANT');
  static const AnnotationType GENE = const AnnotationType._(3, 'GENE');
  static const AnnotationType TRANSCRIPT = const AnnotationType._(4, 'TRANSCRIPT');

  static const List<AnnotationType> values = const <AnnotationType> [
    ANNOTATION_TYPE_UNSPECIFIED,
    GENERIC,
    VARIANT,
    GENE,
    TRANSCRIPT,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static AnnotationType valueOf(int value) => _byValue[value] as AnnotationType;
  static void $checkItem(AnnotationType v) {
    if (v is !AnnotationType) checkItemFailed(v, 'AnnotationType');
  }

  const AnnotationType._(int v, String n) : super(v, n);
}

class VariantAnnotation_Type extends ProtobufEnum {
  static const VariantAnnotation_Type TYPE_UNSPECIFIED = const VariantAnnotation_Type._(0, 'TYPE_UNSPECIFIED');
  static const VariantAnnotation_Type TYPE_OTHER = const VariantAnnotation_Type._(1, 'TYPE_OTHER');
  static const VariantAnnotation_Type INSERTION = const VariantAnnotation_Type._(2, 'INSERTION');
  static const VariantAnnotation_Type DELETION = const VariantAnnotation_Type._(3, 'DELETION');
  static const VariantAnnotation_Type SUBSTITUTION = const VariantAnnotation_Type._(4, 'SUBSTITUTION');
  static const VariantAnnotation_Type SNP = const VariantAnnotation_Type._(5, 'SNP');
  static const VariantAnnotation_Type STRUCTURAL = const VariantAnnotation_Type._(6, 'STRUCTURAL');
  static const VariantAnnotation_Type CNV = const VariantAnnotation_Type._(7, 'CNV');

  static const List<VariantAnnotation_Type> values = const <VariantAnnotation_Type> [
    TYPE_UNSPECIFIED,
    TYPE_OTHER,
    INSERTION,
    DELETION,
    SUBSTITUTION,
    SNP,
    STRUCTURAL,
    CNV,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static VariantAnnotation_Type valueOf(int value) => _byValue[value] as VariantAnnotation_Type;
  static void $checkItem(VariantAnnotation_Type v) {
    if (v is !VariantAnnotation_Type) checkItemFailed(v, 'VariantAnnotation_Type');
  }

  const VariantAnnotation_Type._(int v, String n) : super(v, n);
}

class VariantAnnotation_Effect extends ProtobufEnum {
  static const VariantAnnotation_Effect EFFECT_UNSPECIFIED = const VariantAnnotation_Effect._(0, 'EFFECT_UNSPECIFIED');
  static const VariantAnnotation_Effect EFFECT_OTHER = const VariantAnnotation_Effect._(1, 'EFFECT_OTHER');
  static const VariantAnnotation_Effect FRAMESHIFT = const VariantAnnotation_Effect._(2, 'FRAMESHIFT');
  static const VariantAnnotation_Effect FRAME_PRESERVING_INDEL = const VariantAnnotation_Effect._(3, 'FRAME_PRESERVING_INDEL');
  static const VariantAnnotation_Effect SYNONYMOUS_SNP = const VariantAnnotation_Effect._(4, 'SYNONYMOUS_SNP');
  static const VariantAnnotation_Effect NONSYNONYMOUS_SNP = const VariantAnnotation_Effect._(5, 'NONSYNONYMOUS_SNP');
  static const VariantAnnotation_Effect STOP_GAIN = const VariantAnnotation_Effect._(6, 'STOP_GAIN');
  static const VariantAnnotation_Effect STOP_LOSS = const VariantAnnotation_Effect._(7, 'STOP_LOSS');
  static const VariantAnnotation_Effect SPLICE_SITE_DISRUPTION = const VariantAnnotation_Effect._(8, 'SPLICE_SITE_DISRUPTION');

  static const List<VariantAnnotation_Effect> values = const <VariantAnnotation_Effect> [
    EFFECT_UNSPECIFIED,
    EFFECT_OTHER,
    FRAMESHIFT,
    FRAME_PRESERVING_INDEL,
    SYNONYMOUS_SNP,
    NONSYNONYMOUS_SNP,
    STOP_GAIN,
    STOP_LOSS,
    SPLICE_SITE_DISRUPTION,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static VariantAnnotation_Effect valueOf(int value) => _byValue[value] as VariantAnnotation_Effect;
  static void $checkItem(VariantAnnotation_Effect v) {
    if (v is !VariantAnnotation_Effect) checkItemFailed(v, 'VariantAnnotation_Effect');
  }

  const VariantAnnotation_Effect._(int v, String n) : super(v, n);
}

class VariantAnnotation_ClinicalSignificance extends ProtobufEnum {
  static const VariantAnnotation_ClinicalSignificance CLINICAL_SIGNIFICANCE_UNSPECIFIED = const VariantAnnotation_ClinicalSignificance._(0, 'CLINICAL_SIGNIFICANCE_UNSPECIFIED');
  static const VariantAnnotation_ClinicalSignificance CLINICAL_SIGNIFICANCE_OTHER = const VariantAnnotation_ClinicalSignificance._(1, 'CLINICAL_SIGNIFICANCE_OTHER');
  static const VariantAnnotation_ClinicalSignificance UNCERTAIN = const VariantAnnotation_ClinicalSignificance._(2, 'UNCERTAIN');
  static const VariantAnnotation_ClinicalSignificance BENIGN = const VariantAnnotation_ClinicalSignificance._(3, 'BENIGN');
  static const VariantAnnotation_ClinicalSignificance LIKELY_BENIGN = const VariantAnnotation_ClinicalSignificance._(4, 'LIKELY_BENIGN');
  static const VariantAnnotation_ClinicalSignificance LIKELY_PATHOGENIC = const VariantAnnotation_ClinicalSignificance._(5, 'LIKELY_PATHOGENIC');
  static const VariantAnnotation_ClinicalSignificance PATHOGENIC = const VariantAnnotation_ClinicalSignificance._(6, 'PATHOGENIC');
  static const VariantAnnotation_ClinicalSignificance DRUG_RESPONSE = const VariantAnnotation_ClinicalSignificance._(7, 'DRUG_RESPONSE');
  static const VariantAnnotation_ClinicalSignificance HISTOCOMPATIBILITY = const VariantAnnotation_ClinicalSignificance._(8, 'HISTOCOMPATIBILITY');
  static const VariantAnnotation_ClinicalSignificance CONFERS_SENSITIVITY = const VariantAnnotation_ClinicalSignificance._(9, 'CONFERS_SENSITIVITY');
  static const VariantAnnotation_ClinicalSignificance RISK_FACTOR = const VariantAnnotation_ClinicalSignificance._(10, 'RISK_FACTOR');
  static const VariantAnnotation_ClinicalSignificance ASSOCIATION = const VariantAnnotation_ClinicalSignificance._(11, 'ASSOCIATION');
  static const VariantAnnotation_ClinicalSignificance PROTECTIVE = const VariantAnnotation_ClinicalSignificance._(12, 'PROTECTIVE');
  static const VariantAnnotation_ClinicalSignificance MULTIPLE_REPORTED = const VariantAnnotation_ClinicalSignificance._(13, 'MULTIPLE_REPORTED');

  static const List<VariantAnnotation_ClinicalSignificance> values = const <VariantAnnotation_ClinicalSignificance> [
    CLINICAL_SIGNIFICANCE_UNSPECIFIED,
    CLINICAL_SIGNIFICANCE_OTHER,
    UNCERTAIN,
    BENIGN,
    LIKELY_BENIGN,
    LIKELY_PATHOGENIC,
    PATHOGENIC,
    DRUG_RESPONSE,
    HISTOCOMPATIBILITY,
    CONFERS_SENSITIVITY,
    RISK_FACTOR,
    ASSOCIATION,
    PROTECTIVE,
    MULTIPLE_REPORTED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static VariantAnnotation_ClinicalSignificance valueOf(int value) => _byValue[value] as VariantAnnotation_ClinicalSignificance;
  static void $checkItem(VariantAnnotation_ClinicalSignificance v) {
    if (v is !VariantAnnotation_ClinicalSignificance) checkItemFailed(v, 'VariantAnnotation_ClinicalSignificance');
  }

  const VariantAnnotation_ClinicalSignificance._(int v, String n) : super(v, n);
}

