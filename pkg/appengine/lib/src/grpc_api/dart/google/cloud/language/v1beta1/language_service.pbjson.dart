///
//  Generated code. Do not modify.
///
library google.cloud.language.v1beta1_language_service_pbjson;

const EncodingType$json = const {
  '1': 'EncodingType',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'UTF8', '2': 1},
    const {'1': 'UTF16', '2': 2},
    const {'1': 'UTF32', '2': 3},
  ],
};

const Document$json = const {
  '1': 'Document',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.Document.Type'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9},
    const {'1': 'gcs_content_uri', '3': 3, '4': 1, '5': 9},
    const {'1': 'language', '3': 4, '4': 1, '5': 9},
  ],
  '4': const [Document_Type$json],
};

const Document_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'PLAIN_TEXT', '2': 1},
    const {'1': 'HTML', '2': 2},
  ],
};

const Sentence$json = const {
  '1': 'Sentence',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.TextSpan'},
    const {'1': 'sentiment', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.Sentiment'},
  ],
};

const Entity$json = const {
  '1': 'Entity',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.Entity.Type'},
    const {'1': 'metadata', '3': 3, '4': 3, '5': 11, '6': '.google.cloud.language.v1beta1.Entity.MetadataEntry'},
    const {'1': 'salience', '3': 4, '4': 1, '5': 2},
    const {'1': 'mentions', '3': 5, '4': 3, '5': 11, '6': '.google.cloud.language.v1beta1.EntityMention'},
  ],
  '3': const [Entity_MetadataEntry$json],
  '4': const [Entity_Type$json],
};

const Entity_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const Entity_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'PERSON', '2': 1},
    const {'1': 'LOCATION', '2': 2},
    const {'1': 'ORGANIZATION', '2': 3},
    const {'1': 'EVENT', '2': 4},
    const {'1': 'WORK_OF_ART', '2': 5},
    const {'1': 'CONSUMER_GOOD', '2': 6},
    const {'1': 'OTHER', '2': 7},
  ],
};

const Token$json = const {
  '1': 'Token',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.TextSpan'},
    const {'1': 'part_of_speech', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.PartOfSpeech'},
    const {'1': 'dependency_edge', '3': 3, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.DependencyEdge'},
    const {'1': 'lemma', '3': 4, '4': 1, '5': 9},
  ],
};

const Sentiment$json = const {
  '1': 'Sentiment',
  '2': const [
    const {'1': 'polarity', '3': 1, '4': 1, '5': 2},
    const {'1': 'magnitude', '3': 2, '4': 1, '5': 2},
    const {'1': 'score', '3': 3, '4': 1, '5': 2},
  ],
};

const PartOfSpeech$json = const {
  '1': 'PartOfSpeech',
  '2': const [
    const {'1': 'tag', '3': 1, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Tag'},
    const {'1': 'aspect', '3': 2, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Aspect'},
    const {'1': 'case', '3': 3, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Case'},
    const {'1': 'form', '3': 4, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Form'},
    const {'1': 'gender', '3': 5, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Gender'},
    const {'1': 'mood', '3': 6, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Mood'},
    const {'1': 'number', '3': 7, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Number'},
    const {'1': 'person', '3': 8, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Person'},
    const {'1': 'proper', '3': 9, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Proper'},
    const {'1': 'reciprocity', '3': 10, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Reciprocity'},
    const {'1': 'tense', '3': 11, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Tense'},
    const {'1': 'voice', '3': 12, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.PartOfSpeech.Voice'},
  ],
  '4': const [PartOfSpeech_Tag$json, PartOfSpeech_Aspect$json, PartOfSpeech_Case$json, PartOfSpeech_Form$json, PartOfSpeech_Gender$json, PartOfSpeech_Mood$json, PartOfSpeech_Number$json, PartOfSpeech_Person$json, PartOfSpeech_Proper$json, PartOfSpeech_Reciprocity$json, PartOfSpeech_Tense$json, PartOfSpeech_Voice$json],
};

const PartOfSpeech_Tag$json = const {
  '1': 'Tag',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'ADJ', '2': 1},
    const {'1': 'ADP', '2': 2},
    const {'1': 'ADV', '2': 3},
    const {'1': 'CONJ', '2': 4},
    const {'1': 'DET', '2': 5},
    const {'1': 'NOUN', '2': 6},
    const {'1': 'NUM', '2': 7},
    const {'1': 'PRON', '2': 8},
    const {'1': 'PRT', '2': 9},
    const {'1': 'PUNCT', '2': 10},
    const {'1': 'VERB', '2': 11},
    const {'1': 'X', '2': 12},
    const {'1': 'AFFIX', '2': 13},
  ],
};

const PartOfSpeech_Aspect$json = const {
  '1': 'Aspect',
  '2': const [
    const {'1': 'ASPECT_UNKNOWN', '2': 0},
    const {'1': 'PERFECTIVE', '2': 1},
    const {'1': 'IMPERFECTIVE', '2': 2},
    const {'1': 'PROGRESSIVE', '2': 3},
  ],
};

const PartOfSpeech_Case$json = const {
  '1': 'Case',
  '2': const [
    const {'1': 'CASE_UNKNOWN', '2': 0},
    const {'1': 'ACCUSATIVE', '2': 1},
    const {'1': 'ADVERBIAL', '2': 2},
    const {'1': 'COMPLEMENTIVE', '2': 3},
    const {'1': 'DATIVE', '2': 4},
    const {'1': 'GENITIVE', '2': 5},
    const {'1': 'INSTRUMENTAL', '2': 6},
    const {'1': 'LOCATIVE', '2': 7},
    const {'1': 'NOMINATIVE', '2': 8},
    const {'1': 'OBLIQUE', '2': 9},
    const {'1': 'PARTITIVE', '2': 10},
    const {'1': 'PREPOSITIONAL', '2': 11},
    const {'1': 'REFLEXIVE_CASE', '2': 12},
    const {'1': 'RELATIVE_CASE', '2': 13},
    const {'1': 'VOCATIVE', '2': 14},
  ],
};

const PartOfSpeech_Form$json = const {
  '1': 'Form',
  '2': const [
    const {'1': 'FORM_UNKNOWN', '2': 0},
    const {'1': 'ADNOMIAL', '2': 1},
    const {'1': 'AUXILIARY', '2': 2},
    const {'1': 'COMPLEMENTIZER', '2': 3},
    const {'1': 'FINAL_ENDING', '2': 4},
    const {'1': 'GERUND', '2': 5},
    const {'1': 'REALIS', '2': 6},
    const {'1': 'IRREALIS', '2': 7},
    const {'1': 'SHORT', '2': 8},
    const {'1': 'LONG', '2': 9},
    const {'1': 'ORDER', '2': 10},
    const {'1': 'SPECIFIC', '2': 11},
  ],
};

const PartOfSpeech_Gender$json = const {
  '1': 'Gender',
  '2': const [
    const {'1': 'GENDER_UNKNOWN', '2': 0},
    const {'1': 'FEMININE', '2': 1},
    const {'1': 'MASCULINE', '2': 2},
    const {'1': 'NEUTER', '2': 3},
  ],
};

const PartOfSpeech_Mood$json = const {
  '1': 'Mood',
  '2': const [
    const {'1': 'MOOD_UNKNOWN', '2': 0},
    const {'1': 'CONDITIONAL_MOOD', '2': 1},
    const {'1': 'IMPERATIVE', '2': 2},
    const {'1': 'INDICATIVE', '2': 3},
    const {'1': 'INTERROGATIVE', '2': 4},
    const {'1': 'JUSSIVE', '2': 5},
    const {'1': 'SUBJUNCTIVE', '2': 6},
  ],
};

const PartOfSpeech_Number$json = const {
  '1': 'Number',
  '2': const [
    const {'1': 'NUMBER_UNKNOWN', '2': 0},
    const {'1': 'SINGULAR', '2': 1},
    const {'1': 'PLURAL', '2': 2},
    const {'1': 'DUAL', '2': 3},
  ],
};

const PartOfSpeech_Person$json = const {
  '1': 'Person',
  '2': const [
    const {'1': 'PERSON_UNKNOWN', '2': 0},
    const {'1': 'FIRST', '2': 1},
    const {'1': 'SECOND', '2': 2},
    const {'1': 'THIRD', '2': 3},
    const {'1': 'REFLEXIVE_PERSON', '2': 4},
  ],
};

const PartOfSpeech_Proper$json = const {
  '1': 'Proper',
  '2': const [
    const {'1': 'PROPER_UNKNOWN', '2': 0},
    const {'1': 'PROPER', '2': 1},
    const {'1': 'NOT_PROPER', '2': 2},
  ],
};

const PartOfSpeech_Reciprocity$json = const {
  '1': 'Reciprocity',
  '2': const [
    const {'1': 'RECIPROCITY_UNKNOWN', '2': 0},
    const {'1': 'RECIPROCAL', '2': 1},
    const {'1': 'NON_RECIPROCAL', '2': 2},
  ],
};

const PartOfSpeech_Tense$json = const {
  '1': 'Tense',
  '2': const [
    const {'1': 'TENSE_UNKNOWN', '2': 0},
    const {'1': 'CONDITIONAL_TENSE', '2': 1},
    const {'1': 'FUTURE', '2': 2},
    const {'1': 'PAST', '2': 3},
    const {'1': 'PRESENT', '2': 4},
    const {'1': 'IMPERFECT', '2': 5},
    const {'1': 'PLUPERFECT', '2': 6},
  ],
};

const PartOfSpeech_Voice$json = const {
  '1': 'Voice',
  '2': const [
    const {'1': 'VOICE_UNKNOWN', '2': 0},
    const {'1': 'ACTIVE', '2': 1},
    const {'1': 'CAUSATIVE', '2': 2},
    const {'1': 'PASSIVE', '2': 3},
  ],
};

const DependencyEdge$json = const {
  '1': 'DependencyEdge',
  '2': const [
    const {'1': 'head_token_index', '3': 1, '4': 1, '5': 5},
    const {'1': 'label', '3': 2, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.DependencyEdge.Label'},
  ],
  '4': const [DependencyEdge_Label$json],
};

const DependencyEdge_Label$json = const {
  '1': 'Label',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'ABBREV', '2': 1},
    const {'1': 'ACOMP', '2': 2},
    const {'1': 'ADVCL', '2': 3},
    const {'1': 'ADVMOD', '2': 4},
    const {'1': 'AMOD', '2': 5},
    const {'1': 'APPOS', '2': 6},
    const {'1': 'ATTR', '2': 7},
    const {'1': 'AUX', '2': 8},
    const {'1': 'AUXPASS', '2': 9},
    const {'1': 'CC', '2': 10},
    const {'1': 'CCOMP', '2': 11},
    const {'1': 'CONJ', '2': 12},
    const {'1': 'CSUBJ', '2': 13},
    const {'1': 'CSUBJPASS', '2': 14},
    const {'1': 'DEP', '2': 15},
    const {'1': 'DET', '2': 16},
    const {'1': 'DISCOURSE', '2': 17},
    const {'1': 'DOBJ', '2': 18},
    const {'1': 'EXPL', '2': 19},
    const {'1': 'GOESWITH', '2': 20},
    const {'1': 'IOBJ', '2': 21},
    const {'1': 'MARK', '2': 22},
    const {'1': 'MWE', '2': 23},
    const {'1': 'MWV', '2': 24},
    const {'1': 'NEG', '2': 25},
    const {'1': 'NN', '2': 26},
    const {'1': 'NPADVMOD', '2': 27},
    const {'1': 'NSUBJ', '2': 28},
    const {'1': 'NSUBJPASS', '2': 29},
    const {'1': 'NUM', '2': 30},
    const {'1': 'NUMBER', '2': 31},
    const {'1': 'P', '2': 32},
    const {'1': 'PARATAXIS', '2': 33},
    const {'1': 'PARTMOD', '2': 34},
    const {'1': 'PCOMP', '2': 35},
    const {'1': 'POBJ', '2': 36},
    const {'1': 'POSS', '2': 37},
    const {'1': 'POSTNEG', '2': 38},
    const {'1': 'PRECOMP', '2': 39},
    const {'1': 'PRECONJ', '2': 40},
    const {'1': 'PREDET', '2': 41},
    const {'1': 'PREF', '2': 42},
    const {'1': 'PREP', '2': 43},
    const {'1': 'PRONL', '2': 44},
    const {'1': 'PRT', '2': 45},
    const {'1': 'PS', '2': 46},
    const {'1': 'QUANTMOD', '2': 47},
    const {'1': 'RCMOD', '2': 48},
    const {'1': 'RCMODREL', '2': 49},
    const {'1': 'RDROP', '2': 50},
    const {'1': 'REF', '2': 51},
    const {'1': 'REMNANT', '2': 52},
    const {'1': 'REPARANDUM', '2': 53},
    const {'1': 'ROOT', '2': 54},
    const {'1': 'SNUM', '2': 55},
    const {'1': 'SUFF', '2': 56},
    const {'1': 'TMOD', '2': 57},
    const {'1': 'TOPIC', '2': 58},
    const {'1': 'VMOD', '2': 59},
    const {'1': 'VOCATIVE', '2': 60},
    const {'1': 'XCOMP', '2': 61},
    const {'1': 'SUFFIX', '2': 62},
    const {'1': 'TITLE', '2': 63},
    const {'1': 'ADVPHMOD', '2': 64},
    const {'1': 'AUXCAUS', '2': 65},
    const {'1': 'AUXVV', '2': 66},
    const {'1': 'DTMOD', '2': 67},
    const {'1': 'FOREIGN', '2': 68},
    const {'1': 'KW', '2': 69},
    const {'1': 'LIST', '2': 70},
    const {'1': 'NOMC', '2': 71},
    const {'1': 'NOMCSUBJ', '2': 72},
    const {'1': 'NOMCSUBJPASS', '2': 73},
    const {'1': 'NUMC', '2': 74},
    const {'1': 'COP', '2': 75},
    const {'1': 'DISLOCATED', '2': 76},
  ],
};

const EntityMention$json = const {
  '1': 'EntityMention',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.TextSpan'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.EntityMention.Type'},
  ],
  '4': const [EntityMention_Type$json],
};

const EntityMention_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'TYPE_UNKNOWN', '2': 0},
    const {'1': 'PROPER', '2': 1},
    const {'1': 'COMMON', '2': 2},
  ],
};

const TextSpan$json = const {
  '1': 'TextSpan',
  '2': const [
    const {'1': 'content', '3': 1, '4': 1, '5': 9},
    const {'1': 'begin_offset', '3': 2, '4': 1, '5': 5},
  ],
};

const AnalyzeSentimentRequest$json = const {
  '1': 'AnalyzeSentimentRequest',
  '2': const [
    const {'1': 'document', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.Document'},
    const {'1': 'encoding_type', '3': 2, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.EncodingType'},
  ],
};

const AnalyzeSentimentResponse$json = const {
  '1': 'AnalyzeSentimentResponse',
  '2': const [
    const {'1': 'document_sentiment', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.Sentiment'},
    const {'1': 'language', '3': 2, '4': 1, '5': 9},
    const {'1': 'sentences', '3': 3, '4': 3, '5': 11, '6': '.google.cloud.language.v1beta1.Sentence'},
  ],
};

const AnalyzeEntitiesRequest$json = const {
  '1': 'AnalyzeEntitiesRequest',
  '2': const [
    const {'1': 'document', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.Document'},
    const {'1': 'encoding_type', '3': 2, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.EncodingType'},
  ],
};

const AnalyzeEntitiesResponse$json = const {
  '1': 'AnalyzeEntitiesResponse',
  '2': const [
    const {'1': 'entities', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.language.v1beta1.Entity'},
    const {'1': 'language', '3': 2, '4': 1, '5': 9},
  ],
};

const AnalyzeSyntaxRequest$json = const {
  '1': 'AnalyzeSyntaxRequest',
  '2': const [
    const {'1': 'document', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.Document'},
    const {'1': 'encoding_type', '3': 2, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.EncodingType'},
  ],
};

const AnalyzeSyntaxResponse$json = const {
  '1': 'AnalyzeSyntaxResponse',
  '2': const [
    const {'1': 'sentences', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.language.v1beta1.Sentence'},
    const {'1': 'tokens', '3': 2, '4': 3, '5': 11, '6': '.google.cloud.language.v1beta1.Token'},
    const {'1': 'language', '3': 3, '4': 1, '5': 9},
  ],
};

const AnnotateTextRequest$json = const {
  '1': 'AnnotateTextRequest',
  '2': const [
    const {'1': 'document', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.Document'},
    const {'1': 'features', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.AnnotateTextRequest.Features'},
    const {'1': 'encoding_type', '3': 3, '4': 1, '5': 14, '6': '.google.cloud.language.v1beta1.EncodingType'},
  ],
  '3': const [AnnotateTextRequest_Features$json],
};

const AnnotateTextRequest_Features$json = const {
  '1': 'Features',
  '2': const [
    const {'1': 'extract_syntax', '3': 1, '4': 1, '5': 8},
    const {'1': 'extract_entities', '3': 2, '4': 1, '5': 8},
    const {'1': 'extract_document_sentiment', '3': 3, '4': 1, '5': 8},
  ],
};

const AnnotateTextResponse$json = const {
  '1': 'AnnotateTextResponse',
  '2': const [
    const {'1': 'sentences', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.language.v1beta1.Sentence'},
    const {'1': 'tokens', '3': 2, '4': 3, '5': 11, '6': '.google.cloud.language.v1beta1.Token'},
    const {'1': 'entities', '3': 3, '4': 3, '5': 11, '6': '.google.cloud.language.v1beta1.Entity'},
    const {'1': 'document_sentiment', '3': 4, '4': 1, '5': 11, '6': '.google.cloud.language.v1beta1.Sentiment'},
    const {'1': 'language', '3': 5, '4': 1, '5': 9},
  ],
};

const LanguageService$json = const {
  '1': 'LanguageService',
  '2': const [
    const {'1': 'AnalyzeSentiment', '2': '.google.cloud.language.v1beta1.AnalyzeSentimentRequest', '3': '.google.cloud.language.v1beta1.AnalyzeSentimentResponse', '4': const {}},
    const {'1': 'AnalyzeEntities', '2': '.google.cloud.language.v1beta1.AnalyzeEntitiesRequest', '3': '.google.cloud.language.v1beta1.AnalyzeEntitiesResponse', '4': const {}},
    const {'1': 'AnalyzeSyntax', '2': '.google.cloud.language.v1beta1.AnalyzeSyntaxRequest', '3': '.google.cloud.language.v1beta1.AnalyzeSyntaxResponse', '4': const {}},
    const {'1': 'AnnotateText', '2': '.google.cloud.language.v1beta1.AnnotateTextRequest', '3': '.google.cloud.language.v1beta1.AnnotateTextResponse', '4': const {}},
  ],
};

const LanguageService$messageJson = const {
  '.google.cloud.language.v1beta1.AnalyzeSentimentRequest': AnalyzeSentimentRequest$json,
  '.google.cloud.language.v1beta1.Document': Document$json,
  '.google.cloud.language.v1beta1.AnalyzeSentimentResponse': AnalyzeSentimentResponse$json,
  '.google.cloud.language.v1beta1.Sentiment': Sentiment$json,
  '.google.cloud.language.v1beta1.Sentence': Sentence$json,
  '.google.cloud.language.v1beta1.TextSpan': TextSpan$json,
  '.google.cloud.language.v1beta1.AnalyzeEntitiesRequest': AnalyzeEntitiesRequest$json,
  '.google.cloud.language.v1beta1.AnalyzeEntitiesResponse': AnalyzeEntitiesResponse$json,
  '.google.cloud.language.v1beta1.Entity': Entity$json,
  '.google.cloud.language.v1beta1.Entity.MetadataEntry': Entity_MetadataEntry$json,
  '.google.cloud.language.v1beta1.EntityMention': EntityMention$json,
  '.google.cloud.language.v1beta1.AnalyzeSyntaxRequest': AnalyzeSyntaxRequest$json,
  '.google.cloud.language.v1beta1.AnalyzeSyntaxResponse': AnalyzeSyntaxResponse$json,
  '.google.cloud.language.v1beta1.Token': Token$json,
  '.google.cloud.language.v1beta1.PartOfSpeech': PartOfSpeech$json,
  '.google.cloud.language.v1beta1.DependencyEdge': DependencyEdge$json,
  '.google.cloud.language.v1beta1.AnnotateTextRequest': AnnotateTextRequest$json,
  '.google.cloud.language.v1beta1.AnnotateTextRequest.Features': AnnotateTextRequest_Features$json,
  '.google.cloud.language.v1beta1.AnnotateTextResponse': AnnotateTextResponse$json,
};

