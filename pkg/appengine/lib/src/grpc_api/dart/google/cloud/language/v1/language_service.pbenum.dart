///
//  Generated code. Do not modify.
///
library google.cloud.language.v1_language_service_pbenum;

import 'package:protobuf/protobuf.dart';

class EncodingType extends ProtobufEnum {
  static const EncodingType NONE = const EncodingType._(0, 'NONE');
  static const EncodingType UTF8 = const EncodingType._(1, 'UTF8');
  static const EncodingType UTF16 = const EncodingType._(2, 'UTF16');
  static const EncodingType UTF32 = const EncodingType._(3, 'UTF32');

  static const List<EncodingType> values = const <EncodingType> [
    NONE,
    UTF8,
    UTF16,
    UTF32,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static EncodingType valueOf(int value) => _byValue[value] as EncodingType;
  static void $checkItem(EncodingType v) {
    if (v is !EncodingType) checkItemFailed(v, 'EncodingType');
  }

  const EncodingType._(int v, String n) : super(v, n);
}

class Document_Type extends ProtobufEnum {
  static const Document_Type TYPE_UNSPECIFIED = const Document_Type._(0, 'TYPE_UNSPECIFIED');
  static const Document_Type PLAIN_TEXT = const Document_Type._(1, 'PLAIN_TEXT');
  static const Document_Type HTML = const Document_Type._(2, 'HTML');

  static const List<Document_Type> values = const <Document_Type> [
    TYPE_UNSPECIFIED,
    PLAIN_TEXT,
    HTML,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Document_Type valueOf(int value) => _byValue[value] as Document_Type;
  static void $checkItem(Document_Type v) {
    if (v is !Document_Type) checkItemFailed(v, 'Document_Type');
  }

  const Document_Type._(int v, String n) : super(v, n);
}

class Entity_Type extends ProtobufEnum {
  static const Entity_Type UNKNOWN = const Entity_Type._(0, 'UNKNOWN');
  static const Entity_Type PERSON = const Entity_Type._(1, 'PERSON');
  static const Entity_Type LOCATION = const Entity_Type._(2, 'LOCATION');
  static const Entity_Type ORGANIZATION = const Entity_Type._(3, 'ORGANIZATION');
  static const Entity_Type EVENT = const Entity_Type._(4, 'EVENT');
  static const Entity_Type WORK_OF_ART = const Entity_Type._(5, 'WORK_OF_ART');
  static const Entity_Type CONSUMER_GOOD = const Entity_Type._(6, 'CONSUMER_GOOD');
  static const Entity_Type OTHER = const Entity_Type._(7, 'OTHER');

  static const List<Entity_Type> values = const <Entity_Type> [
    UNKNOWN,
    PERSON,
    LOCATION,
    ORGANIZATION,
    EVENT,
    WORK_OF_ART,
    CONSUMER_GOOD,
    OTHER,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Entity_Type valueOf(int value) => _byValue[value] as Entity_Type;
  static void $checkItem(Entity_Type v) {
    if (v is !Entity_Type) checkItemFailed(v, 'Entity_Type');
  }

  const Entity_Type._(int v, String n) : super(v, n);
}

class PartOfSpeech_Tag extends ProtobufEnum {
  static const PartOfSpeech_Tag UNKNOWN = const PartOfSpeech_Tag._(0, 'UNKNOWN');
  static const PartOfSpeech_Tag ADJ = const PartOfSpeech_Tag._(1, 'ADJ');
  static const PartOfSpeech_Tag ADP = const PartOfSpeech_Tag._(2, 'ADP');
  static const PartOfSpeech_Tag ADV = const PartOfSpeech_Tag._(3, 'ADV');
  static const PartOfSpeech_Tag CONJ = const PartOfSpeech_Tag._(4, 'CONJ');
  static const PartOfSpeech_Tag DET = const PartOfSpeech_Tag._(5, 'DET');
  static const PartOfSpeech_Tag NOUN = const PartOfSpeech_Tag._(6, 'NOUN');
  static const PartOfSpeech_Tag NUM = const PartOfSpeech_Tag._(7, 'NUM');
  static const PartOfSpeech_Tag PRON = const PartOfSpeech_Tag._(8, 'PRON');
  static const PartOfSpeech_Tag PRT = const PartOfSpeech_Tag._(9, 'PRT');
  static const PartOfSpeech_Tag PUNCT = const PartOfSpeech_Tag._(10, 'PUNCT');
  static const PartOfSpeech_Tag VERB = const PartOfSpeech_Tag._(11, 'VERB');
  static const PartOfSpeech_Tag X = const PartOfSpeech_Tag._(12, 'X');
  static const PartOfSpeech_Tag AFFIX = const PartOfSpeech_Tag._(13, 'AFFIX');

  static const List<PartOfSpeech_Tag> values = const <PartOfSpeech_Tag> [
    UNKNOWN,
    ADJ,
    ADP,
    ADV,
    CONJ,
    DET,
    NOUN,
    NUM,
    PRON,
    PRT,
    PUNCT,
    VERB,
    X,
    AFFIX,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Tag valueOf(int value) => _byValue[value] as PartOfSpeech_Tag;
  static void $checkItem(PartOfSpeech_Tag v) {
    if (v is !PartOfSpeech_Tag) checkItemFailed(v, 'PartOfSpeech_Tag');
  }

  const PartOfSpeech_Tag._(int v, String n) : super(v, n);
}

class PartOfSpeech_Aspect extends ProtobufEnum {
  static const PartOfSpeech_Aspect ASPECT_UNKNOWN = const PartOfSpeech_Aspect._(0, 'ASPECT_UNKNOWN');
  static const PartOfSpeech_Aspect PERFECTIVE = const PartOfSpeech_Aspect._(1, 'PERFECTIVE');
  static const PartOfSpeech_Aspect IMPERFECTIVE = const PartOfSpeech_Aspect._(2, 'IMPERFECTIVE');
  static const PartOfSpeech_Aspect PROGRESSIVE = const PartOfSpeech_Aspect._(3, 'PROGRESSIVE');

  static const List<PartOfSpeech_Aspect> values = const <PartOfSpeech_Aspect> [
    ASPECT_UNKNOWN,
    PERFECTIVE,
    IMPERFECTIVE,
    PROGRESSIVE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Aspect valueOf(int value) => _byValue[value] as PartOfSpeech_Aspect;
  static void $checkItem(PartOfSpeech_Aspect v) {
    if (v is !PartOfSpeech_Aspect) checkItemFailed(v, 'PartOfSpeech_Aspect');
  }

  const PartOfSpeech_Aspect._(int v, String n) : super(v, n);
}

class PartOfSpeech_Case extends ProtobufEnum {
  static const PartOfSpeech_Case CASE_UNKNOWN = const PartOfSpeech_Case._(0, 'CASE_UNKNOWN');
  static const PartOfSpeech_Case ACCUSATIVE = const PartOfSpeech_Case._(1, 'ACCUSATIVE');
  static const PartOfSpeech_Case ADVERBIAL = const PartOfSpeech_Case._(2, 'ADVERBIAL');
  static const PartOfSpeech_Case COMPLEMENTIVE = const PartOfSpeech_Case._(3, 'COMPLEMENTIVE');
  static const PartOfSpeech_Case DATIVE = const PartOfSpeech_Case._(4, 'DATIVE');
  static const PartOfSpeech_Case GENITIVE = const PartOfSpeech_Case._(5, 'GENITIVE');
  static const PartOfSpeech_Case INSTRUMENTAL = const PartOfSpeech_Case._(6, 'INSTRUMENTAL');
  static const PartOfSpeech_Case LOCATIVE = const PartOfSpeech_Case._(7, 'LOCATIVE');
  static const PartOfSpeech_Case NOMINATIVE = const PartOfSpeech_Case._(8, 'NOMINATIVE');
  static const PartOfSpeech_Case OBLIQUE = const PartOfSpeech_Case._(9, 'OBLIQUE');
  static const PartOfSpeech_Case PARTITIVE = const PartOfSpeech_Case._(10, 'PARTITIVE');
  static const PartOfSpeech_Case PREPOSITIONAL = const PartOfSpeech_Case._(11, 'PREPOSITIONAL');
  static const PartOfSpeech_Case REFLEXIVE_CASE = const PartOfSpeech_Case._(12, 'REFLEXIVE_CASE');
  static const PartOfSpeech_Case RELATIVE_CASE = const PartOfSpeech_Case._(13, 'RELATIVE_CASE');
  static const PartOfSpeech_Case VOCATIVE = const PartOfSpeech_Case._(14, 'VOCATIVE');

  static const List<PartOfSpeech_Case> values = const <PartOfSpeech_Case> [
    CASE_UNKNOWN,
    ACCUSATIVE,
    ADVERBIAL,
    COMPLEMENTIVE,
    DATIVE,
    GENITIVE,
    INSTRUMENTAL,
    LOCATIVE,
    NOMINATIVE,
    OBLIQUE,
    PARTITIVE,
    PREPOSITIONAL,
    REFLEXIVE_CASE,
    RELATIVE_CASE,
    VOCATIVE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Case valueOf(int value) => _byValue[value] as PartOfSpeech_Case;
  static void $checkItem(PartOfSpeech_Case v) {
    if (v is !PartOfSpeech_Case) checkItemFailed(v, 'PartOfSpeech_Case');
  }

  const PartOfSpeech_Case._(int v, String n) : super(v, n);
}

class PartOfSpeech_Form extends ProtobufEnum {
  static const PartOfSpeech_Form FORM_UNKNOWN = const PartOfSpeech_Form._(0, 'FORM_UNKNOWN');
  static const PartOfSpeech_Form ADNOMIAL = const PartOfSpeech_Form._(1, 'ADNOMIAL');
  static const PartOfSpeech_Form AUXILIARY = const PartOfSpeech_Form._(2, 'AUXILIARY');
  static const PartOfSpeech_Form COMPLEMENTIZER = const PartOfSpeech_Form._(3, 'COMPLEMENTIZER');
  static const PartOfSpeech_Form FINAL_ENDING = const PartOfSpeech_Form._(4, 'FINAL_ENDING');
  static const PartOfSpeech_Form GERUND = const PartOfSpeech_Form._(5, 'GERUND');
  static const PartOfSpeech_Form REALIS = const PartOfSpeech_Form._(6, 'REALIS');
  static const PartOfSpeech_Form IRREALIS = const PartOfSpeech_Form._(7, 'IRREALIS');
  static const PartOfSpeech_Form SHORT = const PartOfSpeech_Form._(8, 'SHORT');
  static const PartOfSpeech_Form LONG = const PartOfSpeech_Form._(9, 'LONG');
  static const PartOfSpeech_Form ORDER = const PartOfSpeech_Form._(10, 'ORDER');
  static const PartOfSpeech_Form SPECIFIC = const PartOfSpeech_Form._(11, 'SPECIFIC');

  static const List<PartOfSpeech_Form> values = const <PartOfSpeech_Form> [
    FORM_UNKNOWN,
    ADNOMIAL,
    AUXILIARY,
    COMPLEMENTIZER,
    FINAL_ENDING,
    GERUND,
    REALIS,
    IRREALIS,
    SHORT,
    LONG,
    ORDER,
    SPECIFIC,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Form valueOf(int value) => _byValue[value] as PartOfSpeech_Form;
  static void $checkItem(PartOfSpeech_Form v) {
    if (v is !PartOfSpeech_Form) checkItemFailed(v, 'PartOfSpeech_Form');
  }

  const PartOfSpeech_Form._(int v, String n) : super(v, n);
}

class PartOfSpeech_Gender extends ProtobufEnum {
  static const PartOfSpeech_Gender GENDER_UNKNOWN = const PartOfSpeech_Gender._(0, 'GENDER_UNKNOWN');
  static const PartOfSpeech_Gender FEMININE = const PartOfSpeech_Gender._(1, 'FEMININE');
  static const PartOfSpeech_Gender MASCULINE = const PartOfSpeech_Gender._(2, 'MASCULINE');
  static const PartOfSpeech_Gender NEUTER = const PartOfSpeech_Gender._(3, 'NEUTER');

  static const List<PartOfSpeech_Gender> values = const <PartOfSpeech_Gender> [
    GENDER_UNKNOWN,
    FEMININE,
    MASCULINE,
    NEUTER,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Gender valueOf(int value) => _byValue[value] as PartOfSpeech_Gender;
  static void $checkItem(PartOfSpeech_Gender v) {
    if (v is !PartOfSpeech_Gender) checkItemFailed(v, 'PartOfSpeech_Gender');
  }

  const PartOfSpeech_Gender._(int v, String n) : super(v, n);
}

class PartOfSpeech_Mood extends ProtobufEnum {
  static const PartOfSpeech_Mood MOOD_UNKNOWN = const PartOfSpeech_Mood._(0, 'MOOD_UNKNOWN');
  static const PartOfSpeech_Mood CONDITIONAL_MOOD = const PartOfSpeech_Mood._(1, 'CONDITIONAL_MOOD');
  static const PartOfSpeech_Mood IMPERATIVE = const PartOfSpeech_Mood._(2, 'IMPERATIVE');
  static const PartOfSpeech_Mood INDICATIVE = const PartOfSpeech_Mood._(3, 'INDICATIVE');
  static const PartOfSpeech_Mood INTERROGATIVE = const PartOfSpeech_Mood._(4, 'INTERROGATIVE');
  static const PartOfSpeech_Mood JUSSIVE = const PartOfSpeech_Mood._(5, 'JUSSIVE');
  static const PartOfSpeech_Mood SUBJUNCTIVE = const PartOfSpeech_Mood._(6, 'SUBJUNCTIVE');

  static const List<PartOfSpeech_Mood> values = const <PartOfSpeech_Mood> [
    MOOD_UNKNOWN,
    CONDITIONAL_MOOD,
    IMPERATIVE,
    INDICATIVE,
    INTERROGATIVE,
    JUSSIVE,
    SUBJUNCTIVE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Mood valueOf(int value) => _byValue[value] as PartOfSpeech_Mood;
  static void $checkItem(PartOfSpeech_Mood v) {
    if (v is !PartOfSpeech_Mood) checkItemFailed(v, 'PartOfSpeech_Mood');
  }

  const PartOfSpeech_Mood._(int v, String n) : super(v, n);
}

class PartOfSpeech_Number extends ProtobufEnum {
  static const PartOfSpeech_Number NUMBER_UNKNOWN = const PartOfSpeech_Number._(0, 'NUMBER_UNKNOWN');
  static const PartOfSpeech_Number SINGULAR = const PartOfSpeech_Number._(1, 'SINGULAR');
  static const PartOfSpeech_Number PLURAL = const PartOfSpeech_Number._(2, 'PLURAL');
  static const PartOfSpeech_Number DUAL = const PartOfSpeech_Number._(3, 'DUAL');

  static const List<PartOfSpeech_Number> values = const <PartOfSpeech_Number> [
    NUMBER_UNKNOWN,
    SINGULAR,
    PLURAL,
    DUAL,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Number valueOf(int value) => _byValue[value] as PartOfSpeech_Number;
  static void $checkItem(PartOfSpeech_Number v) {
    if (v is !PartOfSpeech_Number) checkItemFailed(v, 'PartOfSpeech_Number');
  }

  const PartOfSpeech_Number._(int v, String n) : super(v, n);
}

class PartOfSpeech_Person extends ProtobufEnum {
  static const PartOfSpeech_Person PERSON_UNKNOWN = const PartOfSpeech_Person._(0, 'PERSON_UNKNOWN');
  static const PartOfSpeech_Person FIRST = const PartOfSpeech_Person._(1, 'FIRST');
  static const PartOfSpeech_Person SECOND = const PartOfSpeech_Person._(2, 'SECOND');
  static const PartOfSpeech_Person THIRD = const PartOfSpeech_Person._(3, 'THIRD');
  static const PartOfSpeech_Person REFLEXIVE_PERSON = const PartOfSpeech_Person._(4, 'REFLEXIVE_PERSON');

  static const List<PartOfSpeech_Person> values = const <PartOfSpeech_Person> [
    PERSON_UNKNOWN,
    FIRST,
    SECOND,
    THIRD,
    REFLEXIVE_PERSON,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Person valueOf(int value) => _byValue[value] as PartOfSpeech_Person;
  static void $checkItem(PartOfSpeech_Person v) {
    if (v is !PartOfSpeech_Person) checkItemFailed(v, 'PartOfSpeech_Person');
  }

  const PartOfSpeech_Person._(int v, String n) : super(v, n);
}

class PartOfSpeech_Proper extends ProtobufEnum {
  static const PartOfSpeech_Proper PROPER_UNKNOWN = const PartOfSpeech_Proper._(0, 'PROPER_UNKNOWN');
  static const PartOfSpeech_Proper PROPER = const PartOfSpeech_Proper._(1, 'PROPER');
  static const PartOfSpeech_Proper NOT_PROPER = const PartOfSpeech_Proper._(2, 'NOT_PROPER');

  static const List<PartOfSpeech_Proper> values = const <PartOfSpeech_Proper> [
    PROPER_UNKNOWN,
    PROPER,
    NOT_PROPER,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Proper valueOf(int value) => _byValue[value] as PartOfSpeech_Proper;
  static void $checkItem(PartOfSpeech_Proper v) {
    if (v is !PartOfSpeech_Proper) checkItemFailed(v, 'PartOfSpeech_Proper');
  }

  const PartOfSpeech_Proper._(int v, String n) : super(v, n);
}

class PartOfSpeech_Reciprocity extends ProtobufEnum {
  static const PartOfSpeech_Reciprocity RECIPROCITY_UNKNOWN = const PartOfSpeech_Reciprocity._(0, 'RECIPROCITY_UNKNOWN');
  static const PartOfSpeech_Reciprocity RECIPROCAL = const PartOfSpeech_Reciprocity._(1, 'RECIPROCAL');
  static const PartOfSpeech_Reciprocity NON_RECIPROCAL = const PartOfSpeech_Reciprocity._(2, 'NON_RECIPROCAL');

  static const List<PartOfSpeech_Reciprocity> values = const <PartOfSpeech_Reciprocity> [
    RECIPROCITY_UNKNOWN,
    RECIPROCAL,
    NON_RECIPROCAL,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Reciprocity valueOf(int value) => _byValue[value] as PartOfSpeech_Reciprocity;
  static void $checkItem(PartOfSpeech_Reciprocity v) {
    if (v is !PartOfSpeech_Reciprocity) checkItemFailed(v, 'PartOfSpeech_Reciprocity');
  }

  const PartOfSpeech_Reciprocity._(int v, String n) : super(v, n);
}

class PartOfSpeech_Tense extends ProtobufEnum {
  static const PartOfSpeech_Tense TENSE_UNKNOWN = const PartOfSpeech_Tense._(0, 'TENSE_UNKNOWN');
  static const PartOfSpeech_Tense CONDITIONAL_TENSE = const PartOfSpeech_Tense._(1, 'CONDITIONAL_TENSE');
  static const PartOfSpeech_Tense FUTURE = const PartOfSpeech_Tense._(2, 'FUTURE');
  static const PartOfSpeech_Tense PAST = const PartOfSpeech_Tense._(3, 'PAST');
  static const PartOfSpeech_Tense PRESENT = const PartOfSpeech_Tense._(4, 'PRESENT');
  static const PartOfSpeech_Tense IMPERFECT = const PartOfSpeech_Tense._(5, 'IMPERFECT');
  static const PartOfSpeech_Tense PLUPERFECT = const PartOfSpeech_Tense._(6, 'PLUPERFECT');

  static const List<PartOfSpeech_Tense> values = const <PartOfSpeech_Tense> [
    TENSE_UNKNOWN,
    CONDITIONAL_TENSE,
    FUTURE,
    PAST,
    PRESENT,
    IMPERFECT,
    PLUPERFECT,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Tense valueOf(int value) => _byValue[value] as PartOfSpeech_Tense;
  static void $checkItem(PartOfSpeech_Tense v) {
    if (v is !PartOfSpeech_Tense) checkItemFailed(v, 'PartOfSpeech_Tense');
  }

  const PartOfSpeech_Tense._(int v, String n) : super(v, n);
}

class PartOfSpeech_Voice extends ProtobufEnum {
  static const PartOfSpeech_Voice VOICE_UNKNOWN = const PartOfSpeech_Voice._(0, 'VOICE_UNKNOWN');
  static const PartOfSpeech_Voice ACTIVE = const PartOfSpeech_Voice._(1, 'ACTIVE');
  static const PartOfSpeech_Voice CAUSATIVE = const PartOfSpeech_Voice._(2, 'CAUSATIVE');
  static const PartOfSpeech_Voice PASSIVE = const PartOfSpeech_Voice._(3, 'PASSIVE');

  static const List<PartOfSpeech_Voice> values = const <PartOfSpeech_Voice> [
    VOICE_UNKNOWN,
    ACTIVE,
    CAUSATIVE,
    PASSIVE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PartOfSpeech_Voice valueOf(int value) => _byValue[value] as PartOfSpeech_Voice;
  static void $checkItem(PartOfSpeech_Voice v) {
    if (v is !PartOfSpeech_Voice) checkItemFailed(v, 'PartOfSpeech_Voice');
  }

  const PartOfSpeech_Voice._(int v, String n) : super(v, n);
}

class DependencyEdge_Label extends ProtobufEnum {
  static const DependencyEdge_Label UNKNOWN = const DependencyEdge_Label._(0, 'UNKNOWN');
  static const DependencyEdge_Label ABBREV = const DependencyEdge_Label._(1, 'ABBREV');
  static const DependencyEdge_Label ACOMP = const DependencyEdge_Label._(2, 'ACOMP');
  static const DependencyEdge_Label ADVCL = const DependencyEdge_Label._(3, 'ADVCL');
  static const DependencyEdge_Label ADVMOD = const DependencyEdge_Label._(4, 'ADVMOD');
  static const DependencyEdge_Label AMOD = const DependencyEdge_Label._(5, 'AMOD');
  static const DependencyEdge_Label APPOS = const DependencyEdge_Label._(6, 'APPOS');
  static const DependencyEdge_Label ATTR = const DependencyEdge_Label._(7, 'ATTR');
  static const DependencyEdge_Label AUX = const DependencyEdge_Label._(8, 'AUX');
  static const DependencyEdge_Label AUXPASS = const DependencyEdge_Label._(9, 'AUXPASS');
  static const DependencyEdge_Label CC = const DependencyEdge_Label._(10, 'CC');
  static const DependencyEdge_Label CCOMP = const DependencyEdge_Label._(11, 'CCOMP');
  static const DependencyEdge_Label CONJ = const DependencyEdge_Label._(12, 'CONJ');
  static const DependencyEdge_Label CSUBJ = const DependencyEdge_Label._(13, 'CSUBJ');
  static const DependencyEdge_Label CSUBJPASS = const DependencyEdge_Label._(14, 'CSUBJPASS');
  static const DependencyEdge_Label DEP = const DependencyEdge_Label._(15, 'DEP');
  static const DependencyEdge_Label DET = const DependencyEdge_Label._(16, 'DET');
  static const DependencyEdge_Label DISCOURSE = const DependencyEdge_Label._(17, 'DISCOURSE');
  static const DependencyEdge_Label DOBJ = const DependencyEdge_Label._(18, 'DOBJ');
  static const DependencyEdge_Label EXPL = const DependencyEdge_Label._(19, 'EXPL');
  static const DependencyEdge_Label GOESWITH = const DependencyEdge_Label._(20, 'GOESWITH');
  static const DependencyEdge_Label IOBJ = const DependencyEdge_Label._(21, 'IOBJ');
  static const DependencyEdge_Label MARK = const DependencyEdge_Label._(22, 'MARK');
  static const DependencyEdge_Label MWE = const DependencyEdge_Label._(23, 'MWE');
  static const DependencyEdge_Label MWV = const DependencyEdge_Label._(24, 'MWV');
  static const DependencyEdge_Label NEG = const DependencyEdge_Label._(25, 'NEG');
  static const DependencyEdge_Label NN = const DependencyEdge_Label._(26, 'NN');
  static const DependencyEdge_Label NPADVMOD = const DependencyEdge_Label._(27, 'NPADVMOD');
  static const DependencyEdge_Label NSUBJ = const DependencyEdge_Label._(28, 'NSUBJ');
  static const DependencyEdge_Label NSUBJPASS = const DependencyEdge_Label._(29, 'NSUBJPASS');
  static const DependencyEdge_Label NUM = const DependencyEdge_Label._(30, 'NUM');
  static const DependencyEdge_Label NUMBER = const DependencyEdge_Label._(31, 'NUMBER');
  static const DependencyEdge_Label P = const DependencyEdge_Label._(32, 'P');
  static const DependencyEdge_Label PARATAXIS = const DependencyEdge_Label._(33, 'PARATAXIS');
  static const DependencyEdge_Label PARTMOD = const DependencyEdge_Label._(34, 'PARTMOD');
  static const DependencyEdge_Label PCOMP = const DependencyEdge_Label._(35, 'PCOMP');
  static const DependencyEdge_Label POBJ = const DependencyEdge_Label._(36, 'POBJ');
  static const DependencyEdge_Label POSS = const DependencyEdge_Label._(37, 'POSS');
  static const DependencyEdge_Label POSTNEG = const DependencyEdge_Label._(38, 'POSTNEG');
  static const DependencyEdge_Label PRECOMP = const DependencyEdge_Label._(39, 'PRECOMP');
  static const DependencyEdge_Label PRECONJ = const DependencyEdge_Label._(40, 'PRECONJ');
  static const DependencyEdge_Label PREDET = const DependencyEdge_Label._(41, 'PREDET');
  static const DependencyEdge_Label PREF = const DependencyEdge_Label._(42, 'PREF');
  static const DependencyEdge_Label PREP = const DependencyEdge_Label._(43, 'PREP');
  static const DependencyEdge_Label PRONL = const DependencyEdge_Label._(44, 'PRONL');
  static const DependencyEdge_Label PRT = const DependencyEdge_Label._(45, 'PRT');
  static const DependencyEdge_Label PS = const DependencyEdge_Label._(46, 'PS');
  static const DependencyEdge_Label QUANTMOD = const DependencyEdge_Label._(47, 'QUANTMOD');
  static const DependencyEdge_Label RCMOD = const DependencyEdge_Label._(48, 'RCMOD');
  static const DependencyEdge_Label RCMODREL = const DependencyEdge_Label._(49, 'RCMODREL');
  static const DependencyEdge_Label RDROP = const DependencyEdge_Label._(50, 'RDROP');
  static const DependencyEdge_Label REF = const DependencyEdge_Label._(51, 'REF');
  static const DependencyEdge_Label REMNANT = const DependencyEdge_Label._(52, 'REMNANT');
  static const DependencyEdge_Label REPARANDUM = const DependencyEdge_Label._(53, 'REPARANDUM');
  static const DependencyEdge_Label ROOT = const DependencyEdge_Label._(54, 'ROOT');
  static const DependencyEdge_Label SNUM = const DependencyEdge_Label._(55, 'SNUM');
  static const DependencyEdge_Label SUFF = const DependencyEdge_Label._(56, 'SUFF');
  static const DependencyEdge_Label TMOD = const DependencyEdge_Label._(57, 'TMOD');
  static const DependencyEdge_Label TOPIC = const DependencyEdge_Label._(58, 'TOPIC');
  static const DependencyEdge_Label VMOD = const DependencyEdge_Label._(59, 'VMOD');
  static const DependencyEdge_Label VOCATIVE = const DependencyEdge_Label._(60, 'VOCATIVE');
  static const DependencyEdge_Label XCOMP = const DependencyEdge_Label._(61, 'XCOMP');
  static const DependencyEdge_Label SUFFIX = const DependencyEdge_Label._(62, 'SUFFIX');
  static const DependencyEdge_Label TITLE = const DependencyEdge_Label._(63, 'TITLE');
  static const DependencyEdge_Label ADVPHMOD = const DependencyEdge_Label._(64, 'ADVPHMOD');
  static const DependencyEdge_Label AUXCAUS = const DependencyEdge_Label._(65, 'AUXCAUS');
  static const DependencyEdge_Label AUXVV = const DependencyEdge_Label._(66, 'AUXVV');
  static const DependencyEdge_Label DTMOD = const DependencyEdge_Label._(67, 'DTMOD');
  static const DependencyEdge_Label FOREIGN = const DependencyEdge_Label._(68, 'FOREIGN');
  static const DependencyEdge_Label KW = const DependencyEdge_Label._(69, 'KW');
  static const DependencyEdge_Label LIST = const DependencyEdge_Label._(70, 'LIST');
  static const DependencyEdge_Label NOMC = const DependencyEdge_Label._(71, 'NOMC');
  static const DependencyEdge_Label NOMCSUBJ = const DependencyEdge_Label._(72, 'NOMCSUBJ');
  static const DependencyEdge_Label NOMCSUBJPASS = const DependencyEdge_Label._(73, 'NOMCSUBJPASS');
  static const DependencyEdge_Label NUMC = const DependencyEdge_Label._(74, 'NUMC');
  static const DependencyEdge_Label COP = const DependencyEdge_Label._(75, 'COP');
  static const DependencyEdge_Label DISLOCATED = const DependencyEdge_Label._(76, 'DISLOCATED');

  static const List<DependencyEdge_Label> values = const <DependencyEdge_Label> [
    UNKNOWN,
    ABBREV,
    ACOMP,
    ADVCL,
    ADVMOD,
    AMOD,
    APPOS,
    ATTR,
    AUX,
    AUXPASS,
    CC,
    CCOMP,
    CONJ,
    CSUBJ,
    CSUBJPASS,
    DEP,
    DET,
    DISCOURSE,
    DOBJ,
    EXPL,
    GOESWITH,
    IOBJ,
    MARK,
    MWE,
    MWV,
    NEG,
    NN,
    NPADVMOD,
    NSUBJ,
    NSUBJPASS,
    NUM,
    NUMBER,
    P,
    PARATAXIS,
    PARTMOD,
    PCOMP,
    POBJ,
    POSS,
    POSTNEG,
    PRECOMP,
    PRECONJ,
    PREDET,
    PREF,
    PREP,
    PRONL,
    PRT,
    PS,
    QUANTMOD,
    RCMOD,
    RCMODREL,
    RDROP,
    REF,
    REMNANT,
    REPARANDUM,
    ROOT,
    SNUM,
    SUFF,
    TMOD,
    TOPIC,
    VMOD,
    VOCATIVE,
    XCOMP,
    SUFFIX,
    TITLE,
    ADVPHMOD,
    AUXCAUS,
    AUXVV,
    DTMOD,
    FOREIGN,
    KW,
    LIST,
    NOMC,
    NOMCSUBJ,
    NOMCSUBJPASS,
    NUMC,
    COP,
    DISLOCATED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static DependencyEdge_Label valueOf(int value) => _byValue[value] as DependencyEdge_Label;
  static void $checkItem(DependencyEdge_Label v) {
    if (v is !DependencyEdge_Label) checkItemFailed(v, 'DependencyEdge_Label');
  }

  const DependencyEdge_Label._(int v, String n) : super(v, n);
}

class EntityMention_Type extends ProtobufEnum {
  static const EntityMention_Type TYPE_UNKNOWN = const EntityMention_Type._(0, 'TYPE_UNKNOWN');
  static const EntityMention_Type PROPER = const EntityMention_Type._(1, 'PROPER');
  static const EntityMention_Type COMMON = const EntityMention_Type._(2, 'COMMON');

  static const List<EntityMention_Type> values = const <EntityMention_Type> [
    TYPE_UNKNOWN,
    PROPER,
    COMMON,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static EntityMention_Type valueOf(int value) => _byValue[value] as EntityMention_Type;
  static void $checkItem(EntityMention_Type v) {
    if (v is !EntityMention_Type) checkItemFailed(v, 'EntityMention_Type');
  }

  const EntityMention_Type._(int v, String n) : super(v, n);
}

