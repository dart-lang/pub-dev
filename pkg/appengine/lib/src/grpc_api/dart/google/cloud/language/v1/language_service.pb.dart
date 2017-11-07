///
//  Generated code. Do not modify.
///
library google.cloud.language.v1_language_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'language_service.pbenum.dart';

export 'language_service.pbenum.dart';

class Document extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Document')
    ..e/*<Document_Type>*/(1, 'type', PbFieldType.OE, Document_Type.TYPE_UNSPECIFIED, Document_Type.valueOf)
    ..a/*<String>*/(2, 'content', PbFieldType.OS)
    ..a/*<String>*/(3, 'gcsContentUri', PbFieldType.OS)
    ..a/*<String>*/(4, 'language', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Document() : super();
  Document.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Document.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Document clone() => new Document()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Document create() => new Document();
  static PbList<Document> createRepeated() => new PbList<Document>();
  static Document getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDocument();
    return _defaultInstance;
  }
  static Document _defaultInstance;
  static void $checkItem(Document v) {
    if (v is !Document) checkItemFailed(v, 'Document');
  }

  Document_Type get type => $_get(0, 1, null);
  void set type(Document_Type v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  String get content => $_get(1, 2, '');
  void set content(String v) { $_setString(1, 2, v); }
  bool hasContent() => $_has(1, 2);
  void clearContent() => clearField(2);

  String get gcsContentUri => $_get(2, 3, '');
  void set gcsContentUri(String v) { $_setString(2, 3, v); }
  bool hasGcsContentUri() => $_has(2, 3);
  void clearGcsContentUri() => clearField(3);

  String get language => $_get(3, 4, '');
  void set language(String v) { $_setString(3, 4, v); }
  bool hasLanguage() => $_has(3, 4);
  void clearLanguage() => clearField(4);
}

class _ReadonlyDocument extends Document with ReadonlyMessageMixin {}

class Sentence extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Sentence')
    ..a/*<TextSpan>*/(1, 'text', PbFieldType.OM, TextSpan.getDefault, TextSpan.create)
    ..a/*<Sentiment>*/(2, 'sentiment', PbFieldType.OM, Sentiment.getDefault, Sentiment.create)
    ..hasRequiredFields = false
  ;

  Sentence() : super();
  Sentence.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Sentence.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Sentence clone() => new Sentence()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Sentence create() => new Sentence();
  static PbList<Sentence> createRepeated() => new PbList<Sentence>();
  static Sentence getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySentence();
    return _defaultInstance;
  }
  static Sentence _defaultInstance;
  static void $checkItem(Sentence v) {
    if (v is !Sentence) checkItemFailed(v, 'Sentence');
  }

  TextSpan get text => $_get(0, 1, null);
  void set text(TextSpan v) { setField(1, v); }
  bool hasText() => $_has(0, 1);
  void clearText() => clearField(1);

  Sentiment get sentiment => $_get(1, 2, null);
  void set sentiment(Sentiment v) { setField(2, v); }
  bool hasSentiment() => $_has(1, 2);
  void clearSentiment() => clearField(2);
}

class _ReadonlySentence extends Sentence with ReadonlyMessageMixin {}

class Entity_MetadataEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Entity_MetadataEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Entity_MetadataEntry() : super();
  Entity_MetadataEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Entity_MetadataEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Entity_MetadataEntry clone() => new Entity_MetadataEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Entity_MetadataEntry create() => new Entity_MetadataEntry();
  static PbList<Entity_MetadataEntry> createRepeated() => new PbList<Entity_MetadataEntry>();
  static Entity_MetadataEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEntity_MetadataEntry();
    return _defaultInstance;
  }
  static Entity_MetadataEntry _defaultInstance;
  static void $checkItem(Entity_MetadataEntry v) {
    if (v is !Entity_MetadataEntry) checkItemFailed(v, 'Entity_MetadataEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyEntity_MetadataEntry extends Entity_MetadataEntry with ReadonlyMessageMixin {}

class Entity extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Entity')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..e/*<Entity_Type>*/(2, 'type', PbFieldType.OE, Entity_Type.UNKNOWN, Entity_Type.valueOf)
    ..pp/*<Entity_MetadataEntry>*/(3, 'metadata', PbFieldType.PM, Entity_MetadataEntry.$checkItem, Entity_MetadataEntry.create)
    ..a/*<double>*/(4, 'salience', PbFieldType.OF)
    ..pp/*<EntityMention>*/(5, 'mentions', PbFieldType.PM, EntityMention.$checkItem, EntityMention.create)
    ..hasRequiredFields = false
  ;

  Entity() : super();
  Entity.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Entity.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Entity clone() => new Entity()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Entity create() => new Entity();
  static PbList<Entity> createRepeated() => new PbList<Entity>();
  static Entity getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEntity();
    return _defaultInstance;
  }
  static Entity _defaultInstance;
  static void $checkItem(Entity v) {
    if (v is !Entity) checkItemFailed(v, 'Entity');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Entity_Type get type => $_get(1, 2, null);
  void set type(Entity_Type v) { setField(2, v); }
  bool hasType() => $_has(1, 2);
  void clearType() => clearField(2);

  List<Entity_MetadataEntry> get metadata => $_get(2, 3, null);

  double get salience => $_get(3, 4, null);
  void set salience(double v) { $_setFloat(3, 4, v); }
  bool hasSalience() => $_has(3, 4);
  void clearSalience() => clearField(4);

  List<EntityMention> get mentions => $_get(4, 5, null);
}

class _ReadonlyEntity extends Entity with ReadonlyMessageMixin {}

class Token extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Token')
    ..a/*<TextSpan>*/(1, 'text', PbFieldType.OM, TextSpan.getDefault, TextSpan.create)
    ..a/*<PartOfSpeech>*/(2, 'partOfSpeech', PbFieldType.OM, PartOfSpeech.getDefault, PartOfSpeech.create)
    ..a/*<DependencyEdge>*/(3, 'dependencyEdge', PbFieldType.OM, DependencyEdge.getDefault, DependencyEdge.create)
    ..a/*<String>*/(4, 'lemma', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Token() : super();
  Token.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Token.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Token clone() => new Token()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Token create() => new Token();
  static PbList<Token> createRepeated() => new PbList<Token>();
  static Token getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyToken();
    return _defaultInstance;
  }
  static Token _defaultInstance;
  static void $checkItem(Token v) {
    if (v is !Token) checkItemFailed(v, 'Token');
  }

  TextSpan get text => $_get(0, 1, null);
  void set text(TextSpan v) { setField(1, v); }
  bool hasText() => $_has(0, 1);
  void clearText() => clearField(1);

  PartOfSpeech get partOfSpeech => $_get(1, 2, null);
  void set partOfSpeech(PartOfSpeech v) { setField(2, v); }
  bool hasPartOfSpeech() => $_has(1, 2);
  void clearPartOfSpeech() => clearField(2);

  DependencyEdge get dependencyEdge => $_get(2, 3, null);
  void set dependencyEdge(DependencyEdge v) { setField(3, v); }
  bool hasDependencyEdge() => $_has(2, 3);
  void clearDependencyEdge() => clearField(3);

  String get lemma => $_get(3, 4, '');
  void set lemma(String v) { $_setString(3, 4, v); }
  bool hasLemma() => $_has(3, 4);
  void clearLemma() => clearField(4);
}

class _ReadonlyToken extends Token with ReadonlyMessageMixin {}

class Sentiment extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Sentiment')
    ..a/*<double>*/(2, 'magnitude', PbFieldType.OF)
    ..a/*<double>*/(3, 'score', PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  Sentiment() : super();
  Sentiment.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Sentiment.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Sentiment clone() => new Sentiment()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Sentiment create() => new Sentiment();
  static PbList<Sentiment> createRepeated() => new PbList<Sentiment>();
  static Sentiment getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySentiment();
    return _defaultInstance;
  }
  static Sentiment _defaultInstance;
  static void $checkItem(Sentiment v) {
    if (v is !Sentiment) checkItemFailed(v, 'Sentiment');
  }

  double get magnitude => $_get(0, 2, null);
  void set magnitude(double v) { $_setFloat(0, 2, v); }
  bool hasMagnitude() => $_has(0, 2);
  void clearMagnitude() => clearField(2);

  double get score => $_get(1, 3, null);
  void set score(double v) { $_setFloat(1, 3, v); }
  bool hasScore() => $_has(1, 3);
  void clearScore() => clearField(3);
}

class _ReadonlySentiment extends Sentiment with ReadonlyMessageMixin {}

class PartOfSpeech extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PartOfSpeech')
    ..e/*<PartOfSpeech_Tag>*/(1, 'tag', PbFieldType.OE, PartOfSpeech_Tag.UNKNOWN, PartOfSpeech_Tag.valueOf)
    ..e/*<PartOfSpeech_Aspect>*/(2, 'aspect', PbFieldType.OE, PartOfSpeech_Aspect.ASPECT_UNKNOWN, PartOfSpeech_Aspect.valueOf)
    ..e/*<PartOfSpeech_Case>*/(3, 'case_3', PbFieldType.OE, PartOfSpeech_Case.CASE_UNKNOWN, PartOfSpeech_Case.valueOf)
    ..e/*<PartOfSpeech_Form>*/(4, 'form', PbFieldType.OE, PartOfSpeech_Form.FORM_UNKNOWN, PartOfSpeech_Form.valueOf)
    ..e/*<PartOfSpeech_Gender>*/(5, 'gender', PbFieldType.OE, PartOfSpeech_Gender.GENDER_UNKNOWN, PartOfSpeech_Gender.valueOf)
    ..e/*<PartOfSpeech_Mood>*/(6, 'mood', PbFieldType.OE, PartOfSpeech_Mood.MOOD_UNKNOWN, PartOfSpeech_Mood.valueOf)
    ..e/*<PartOfSpeech_Number>*/(7, 'number', PbFieldType.OE, PartOfSpeech_Number.NUMBER_UNKNOWN, PartOfSpeech_Number.valueOf)
    ..e/*<PartOfSpeech_Person>*/(8, 'person', PbFieldType.OE, PartOfSpeech_Person.PERSON_UNKNOWN, PartOfSpeech_Person.valueOf)
    ..e/*<PartOfSpeech_Proper>*/(9, 'proper', PbFieldType.OE, PartOfSpeech_Proper.PROPER_UNKNOWN, PartOfSpeech_Proper.valueOf)
    ..e/*<PartOfSpeech_Reciprocity>*/(10, 'reciprocity', PbFieldType.OE, PartOfSpeech_Reciprocity.RECIPROCITY_UNKNOWN, PartOfSpeech_Reciprocity.valueOf)
    ..e/*<PartOfSpeech_Tense>*/(11, 'tense', PbFieldType.OE, PartOfSpeech_Tense.TENSE_UNKNOWN, PartOfSpeech_Tense.valueOf)
    ..e/*<PartOfSpeech_Voice>*/(12, 'voice', PbFieldType.OE, PartOfSpeech_Voice.VOICE_UNKNOWN, PartOfSpeech_Voice.valueOf)
    ..hasRequiredFields = false
  ;

  PartOfSpeech() : super();
  PartOfSpeech.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PartOfSpeech.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PartOfSpeech clone() => new PartOfSpeech()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PartOfSpeech create() => new PartOfSpeech();
  static PbList<PartOfSpeech> createRepeated() => new PbList<PartOfSpeech>();
  static PartOfSpeech getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPartOfSpeech();
    return _defaultInstance;
  }
  static PartOfSpeech _defaultInstance;
  static void $checkItem(PartOfSpeech v) {
    if (v is !PartOfSpeech) checkItemFailed(v, 'PartOfSpeech');
  }

  PartOfSpeech_Tag get tag => $_get(0, 1, null);
  void set tag(PartOfSpeech_Tag v) { setField(1, v); }
  bool hasTag() => $_has(0, 1);
  void clearTag() => clearField(1);

  PartOfSpeech_Aspect get aspect => $_get(1, 2, null);
  void set aspect(PartOfSpeech_Aspect v) { setField(2, v); }
  bool hasAspect() => $_has(1, 2);
  void clearAspect() => clearField(2);

  PartOfSpeech_Case get case_3 => $_get(2, 3, null);
  void set case_3(PartOfSpeech_Case v) { setField(3, v); }
  bool hasCase_3() => $_has(2, 3);
  void clearCase_3() => clearField(3);

  PartOfSpeech_Form get form => $_get(3, 4, null);
  void set form(PartOfSpeech_Form v) { setField(4, v); }
  bool hasForm() => $_has(3, 4);
  void clearForm() => clearField(4);

  PartOfSpeech_Gender get gender => $_get(4, 5, null);
  void set gender(PartOfSpeech_Gender v) { setField(5, v); }
  bool hasGender() => $_has(4, 5);
  void clearGender() => clearField(5);

  PartOfSpeech_Mood get mood => $_get(5, 6, null);
  void set mood(PartOfSpeech_Mood v) { setField(6, v); }
  bool hasMood() => $_has(5, 6);
  void clearMood() => clearField(6);

  PartOfSpeech_Number get number => $_get(6, 7, null);
  void set number(PartOfSpeech_Number v) { setField(7, v); }
  bool hasNumber() => $_has(6, 7);
  void clearNumber() => clearField(7);

  PartOfSpeech_Person get person => $_get(7, 8, null);
  void set person(PartOfSpeech_Person v) { setField(8, v); }
  bool hasPerson() => $_has(7, 8);
  void clearPerson() => clearField(8);

  PartOfSpeech_Proper get proper => $_get(8, 9, null);
  void set proper(PartOfSpeech_Proper v) { setField(9, v); }
  bool hasProper() => $_has(8, 9);
  void clearProper() => clearField(9);

  PartOfSpeech_Reciprocity get reciprocity => $_get(9, 10, null);
  void set reciprocity(PartOfSpeech_Reciprocity v) { setField(10, v); }
  bool hasReciprocity() => $_has(9, 10);
  void clearReciprocity() => clearField(10);

  PartOfSpeech_Tense get tense => $_get(10, 11, null);
  void set tense(PartOfSpeech_Tense v) { setField(11, v); }
  bool hasTense() => $_has(10, 11);
  void clearTense() => clearField(11);

  PartOfSpeech_Voice get voice => $_get(11, 12, null);
  void set voice(PartOfSpeech_Voice v) { setField(12, v); }
  bool hasVoice() => $_has(11, 12);
  void clearVoice() => clearField(12);
}

class _ReadonlyPartOfSpeech extends PartOfSpeech with ReadonlyMessageMixin {}

class DependencyEdge extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DependencyEdge')
    ..a/*<int>*/(1, 'headTokenIndex', PbFieldType.O3)
    ..e/*<DependencyEdge_Label>*/(2, 'label', PbFieldType.OE, DependencyEdge_Label.UNKNOWN, DependencyEdge_Label.valueOf)
    ..hasRequiredFields = false
  ;

  DependencyEdge() : super();
  DependencyEdge.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DependencyEdge.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DependencyEdge clone() => new DependencyEdge()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DependencyEdge create() => new DependencyEdge();
  static PbList<DependencyEdge> createRepeated() => new PbList<DependencyEdge>();
  static DependencyEdge getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDependencyEdge();
    return _defaultInstance;
  }
  static DependencyEdge _defaultInstance;
  static void $checkItem(DependencyEdge v) {
    if (v is !DependencyEdge) checkItemFailed(v, 'DependencyEdge');
  }

  int get headTokenIndex => $_get(0, 1, 0);
  void set headTokenIndex(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasHeadTokenIndex() => $_has(0, 1);
  void clearHeadTokenIndex() => clearField(1);

  DependencyEdge_Label get label => $_get(1, 2, null);
  void set label(DependencyEdge_Label v) { setField(2, v); }
  bool hasLabel() => $_has(1, 2);
  void clearLabel() => clearField(2);
}

class _ReadonlyDependencyEdge extends DependencyEdge with ReadonlyMessageMixin {}

class EntityMention extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EntityMention')
    ..a/*<TextSpan>*/(1, 'text', PbFieldType.OM, TextSpan.getDefault, TextSpan.create)
    ..e/*<EntityMention_Type>*/(2, 'type', PbFieldType.OE, EntityMention_Type.TYPE_UNKNOWN, EntityMention_Type.valueOf)
    ..hasRequiredFields = false
  ;

  EntityMention() : super();
  EntityMention.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EntityMention.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EntityMention clone() => new EntityMention()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static EntityMention create() => new EntityMention();
  static PbList<EntityMention> createRepeated() => new PbList<EntityMention>();
  static EntityMention getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEntityMention();
    return _defaultInstance;
  }
  static EntityMention _defaultInstance;
  static void $checkItem(EntityMention v) {
    if (v is !EntityMention) checkItemFailed(v, 'EntityMention');
  }

  TextSpan get text => $_get(0, 1, null);
  void set text(TextSpan v) { setField(1, v); }
  bool hasText() => $_has(0, 1);
  void clearText() => clearField(1);

  EntityMention_Type get type => $_get(1, 2, null);
  void set type(EntityMention_Type v) { setField(2, v); }
  bool hasType() => $_has(1, 2);
  void clearType() => clearField(2);
}

class _ReadonlyEntityMention extends EntityMention with ReadonlyMessageMixin {}

class TextSpan extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TextSpan')
    ..a/*<String>*/(1, 'content', PbFieldType.OS)
    ..a/*<int>*/(2, 'beginOffset', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  TextSpan() : super();
  TextSpan.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TextSpan.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TextSpan clone() => new TextSpan()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TextSpan create() => new TextSpan();
  static PbList<TextSpan> createRepeated() => new PbList<TextSpan>();
  static TextSpan getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTextSpan();
    return _defaultInstance;
  }
  static TextSpan _defaultInstance;
  static void $checkItem(TextSpan v) {
    if (v is !TextSpan) checkItemFailed(v, 'TextSpan');
  }

  String get content => $_get(0, 1, '');
  void set content(String v) { $_setString(0, 1, v); }
  bool hasContent() => $_has(0, 1);
  void clearContent() => clearField(1);

  int get beginOffset => $_get(1, 2, 0);
  void set beginOffset(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasBeginOffset() => $_has(1, 2);
  void clearBeginOffset() => clearField(2);
}

class _ReadonlyTextSpan extends TextSpan with ReadonlyMessageMixin {}

class AnalyzeSentimentRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AnalyzeSentimentRequest')
    ..a/*<Document>*/(1, 'document', PbFieldType.OM, Document.getDefault, Document.create)
    ..e/*<EncodingType>*/(2, 'encodingType', PbFieldType.OE, EncodingType.NONE, EncodingType.valueOf)
    ..hasRequiredFields = false
  ;

  AnalyzeSentimentRequest() : super();
  AnalyzeSentimentRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AnalyzeSentimentRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AnalyzeSentimentRequest clone() => new AnalyzeSentimentRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AnalyzeSentimentRequest create() => new AnalyzeSentimentRequest();
  static PbList<AnalyzeSentimentRequest> createRepeated() => new PbList<AnalyzeSentimentRequest>();
  static AnalyzeSentimentRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAnalyzeSentimentRequest();
    return _defaultInstance;
  }
  static AnalyzeSentimentRequest _defaultInstance;
  static void $checkItem(AnalyzeSentimentRequest v) {
    if (v is !AnalyzeSentimentRequest) checkItemFailed(v, 'AnalyzeSentimentRequest');
  }

  Document get document => $_get(0, 1, null);
  void set document(Document v) { setField(1, v); }
  bool hasDocument() => $_has(0, 1);
  void clearDocument() => clearField(1);

  EncodingType get encodingType => $_get(1, 2, null);
  void set encodingType(EncodingType v) { setField(2, v); }
  bool hasEncodingType() => $_has(1, 2);
  void clearEncodingType() => clearField(2);
}

class _ReadonlyAnalyzeSentimentRequest extends AnalyzeSentimentRequest with ReadonlyMessageMixin {}

class AnalyzeSentimentResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AnalyzeSentimentResponse')
    ..a/*<Sentiment>*/(1, 'documentSentiment', PbFieldType.OM, Sentiment.getDefault, Sentiment.create)
    ..a/*<String>*/(2, 'language', PbFieldType.OS)
    ..pp/*<Sentence>*/(3, 'sentences', PbFieldType.PM, Sentence.$checkItem, Sentence.create)
    ..hasRequiredFields = false
  ;

  AnalyzeSentimentResponse() : super();
  AnalyzeSentimentResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AnalyzeSentimentResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AnalyzeSentimentResponse clone() => new AnalyzeSentimentResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AnalyzeSentimentResponse create() => new AnalyzeSentimentResponse();
  static PbList<AnalyzeSentimentResponse> createRepeated() => new PbList<AnalyzeSentimentResponse>();
  static AnalyzeSentimentResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAnalyzeSentimentResponse();
    return _defaultInstance;
  }
  static AnalyzeSentimentResponse _defaultInstance;
  static void $checkItem(AnalyzeSentimentResponse v) {
    if (v is !AnalyzeSentimentResponse) checkItemFailed(v, 'AnalyzeSentimentResponse');
  }

  Sentiment get documentSentiment => $_get(0, 1, null);
  void set documentSentiment(Sentiment v) { setField(1, v); }
  bool hasDocumentSentiment() => $_has(0, 1);
  void clearDocumentSentiment() => clearField(1);

  String get language => $_get(1, 2, '');
  void set language(String v) { $_setString(1, 2, v); }
  bool hasLanguage() => $_has(1, 2);
  void clearLanguage() => clearField(2);

  List<Sentence> get sentences => $_get(2, 3, null);
}

class _ReadonlyAnalyzeSentimentResponse extends AnalyzeSentimentResponse with ReadonlyMessageMixin {}

class AnalyzeEntitiesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AnalyzeEntitiesRequest')
    ..a/*<Document>*/(1, 'document', PbFieldType.OM, Document.getDefault, Document.create)
    ..e/*<EncodingType>*/(2, 'encodingType', PbFieldType.OE, EncodingType.NONE, EncodingType.valueOf)
    ..hasRequiredFields = false
  ;

  AnalyzeEntitiesRequest() : super();
  AnalyzeEntitiesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AnalyzeEntitiesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AnalyzeEntitiesRequest clone() => new AnalyzeEntitiesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AnalyzeEntitiesRequest create() => new AnalyzeEntitiesRequest();
  static PbList<AnalyzeEntitiesRequest> createRepeated() => new PbList<AnalyzeEntitiesRequest>();
  static AnalyzeEntitiesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAnalyzeEntitiesRequest();
    return _defaultInstance;
  }
  static AnalyzeEntitiesRequest _defaultInstance;
  static void $checkItem(AnalyzeEntitiesRequest v) {
    if (v is !AnalyzeEntitiesRequest) checkItemFailed(v, 'AnalyzeEntitiesRequest');
  }

  Document get document => $_get(0, 1, null);
  void set document(Document v) { setField(1, v); }
  bool hasDocument() => $_has(0, 1);
  void clearDocument() => clearField(1);

  EncodingType get encodingType => $_get(1, 2, null);
  void set encodingType(EncodingType v) { setField(2, v); }
  bool hasEncodingType() => $_has(1, 2);
  void clearEncodingType() => clearField(2);
}

class _ReadonlyAnalyzeEntitiesRequest extends AnalyzeEntitiesRequest with ReadonlyMessageMixin {}

class AnalyzeEntitiesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AnalyzeEntitiesResponse')
    ..pp/*<Entity>*/(1, 'entities', PbFieldType.PM, Entity.$checkItem, Entity.create)
    ..a/*<String>*/(2, 'language', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AnalyzeEntitiesResponse() : super();
  AnalyzeEntitiesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AnalyzeEntitiesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AnalyzeEntitiesResponse clone() => new AnalyzeEntitiesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AnalyzeEntitiesResponse create() => new AnalyzeEntitiesResponse();
  static PbList<AnalyzeEntitiesResponse> createRepeated() => new PbList<AnalyzeEntitiesResponse>();
  static AnalyzeEntitiesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAnalyzeEntitiesResponse();
    return _defaultInstance;
  }
  static AnalyzeEntitiesResponse _defaultInstance;
  static void $checkItem(AnalyzeEntitiesResponse v) {
    if (v is !AnalyzeEntitiesResponse) checkItemFailed(v, 'AnalyzeEntitiesResponse');
  }

  List<Entity> get entities => $_get(0, 1, null);

  String get language => $_get(1, 2, '');
  void set language(String v) { $_setString(1, 2, v); }
  bool hasLanguage() => $_has(1, 2);
  void clearLanguage() => clearField(2);
}

class _ReadonlyAnalyzeEntitiesResponse extends AnalyzeEntitiesResponse with ReadonlyMessageMixin {}

class AnalyzeSyntaxRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AnalyzeSyntaxRequest')
    ..a/*<Document>*/(1, 'document', PbFieldType.OM, Document.getDefault, Document.create)
    ..e/*<EncodingType>*/(2, 'encodingType', PbFieldType.OE, EncodingType.NONE, EncodingType.valueOf)
    ..hasRequiredFields = false
  ;

  AnalyzeSyntaxRequest() : super();
  AnalyzeSyntaxRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AnalyzeSyntaxRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AnalyzeSyntaxRequest clone() => new AnalyzeSyntaxRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AnalyzeSyntaxRequest create() => new AnalyzeSyntaxRequest();
  static PbList<AnalyzeSyntaxRequest> createRepeated() => new PbList<AnalyzeSyntaxRequest>();
  static AnalyzeSyntaxRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAnalyzeSyntaxRequest();
    return _defaultInstance;
  }
  static AnalyzeSyntaxRequest _defaultInstance;
  static void $checkItem(AnalyzeSyntaxRequest v) {
    if (v is !AnalyzeSyntaxRequest) checkItemFailed(v, 'AnalyzeSyntaxRequest');
  }

  Document get document => $_get(0, 1, null);
  void set document(Document v) { setField(1, v); }
  bool hasDocument() => $_has(0, 1);
  void clearDocument() => clearField(1);

  EncodingType get encodingType => $_get(1, 2, null);
  void set encodingType(EncodingType v) { setField(2, v); }
  bool hasEncodingType() => $_has(1, 2);
  void clearEncodingType() => clearField(2);
}

class _ReadonlyAnalyzeSyntaxRequest extends AnalyzeSyntaxRequest with ReadonlyMessageMixin {}

class AnalyzeSyntaxResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AnalyzeSyntaxResponse')
    ..pp/*<Sentence>*/(1, 'sentences', PbFieldType.PM, Sentence.$checkItem, Sentence.create)
    ..pp/*<Token>*/(2, 'tokens', PbFieldType.PM, Token.$checkItem, Token.create)
    ..a/*<String>*/(3, 'language', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AnalyzeSyntaxResponse() : super();
  AnalyzeSyntaxResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AnalyzeSyntaxResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AnalyzeSyntaxResponse clone() => new AnalyzeSyntaxResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AnalyzeSyntaxResponse create() => new AnalyzeSyntaxResponse();
  static PbList<AnalyzeSyntaxResponse> createRepeated() => new PbList<AnalyzeSyntaxResponse>();
  static AnalyzeSyntaxResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAnalyzeSyntaxResponse();
    return _defaultInstance;
  }
  static AnalyzeSyntaxResponse _defaultInstance;
  static void $checkItem(AnalyzeSyntaxResponse v) {
    if (v is !AnalyzeSyntaxResponse) checkItemFailed(v, 'AnalyzeSyntaxResponse');
  }

  List<Sentence> get sentences => $_get(0, 1, null);

  List<Token> get tokens => $_get(1, 2, null);

  String get language => $_get(2, 3, '');
  void set language(String v) { $_setString(2, 3, v); }
  bool hasLanguage() => $_has(2, 3);
  void clearLanguage() => clearField(3);
}

class _ReadonlyAnalyzeSyntaxResponse extends AnalyzeSyntaxResponse with ReadonlyMessageMixin {}

class AnnotateTextRequest_Features extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AnnotateTextRequest_Features')
    ..a/*<bool>*/(1, 'extractSyntax', PbFieldType.OB)
    ..a/*<bool>*/(2, 'extractEntities', PbFieldType.OB)
    ..a/*<bool>*/(3, 'extractDocumentSentiment', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  AnnotateTextRequest_Features() : super();
  AnnotateTextRequest_Features.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AnnotateTextRequest_Features.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AnnotateTextRequest_Features clone() => new AnnotateTextRequest_Features()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AnnotateTextRequest_Features create() => new AnnotateTextRequest_Features();
  static PbList<AnnotateTextRequest_Features> createRepeated() => new PbList<AnnotateTextRequest_Features>();
  static AnnotateTextRequest_Features getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAnnotateTextRequest_Features();
    return _defaultInstance;
  }
  static AnnotateTextRequest_Features _defaultInstance;
  static void $checkItem(AnnotateTextRequest_Features v) {
    if (v is !AnnotateTextRequest_Features) checkItemFailed(v, 'AnnotateTextRequest_Features');
  }

  bool get extractSyntax => $_get(0, 1, false);
  void set extractSyntax(bool v) { $_setBool(0, 1, v); }
  bool hasExtractSyntax() => $_has(0, 1);
  void clearExtractSyntax() => clearField(1);

  bool get extractEntities => $_get(1, 2, false);
  void set extractEntities(bool v) { $_setBool(1, 2, v); }
  bool hasExtractEntities() => $_has(1, 2);
  void clearExtractEntities() => clearField(2);

  bool get extractDocumentSentiment => $_get(2, 3, false);
  void set extractDocumentSentiment(bool v) { $_setBool(2, 3, v); }
  bool hasExtractDocumentSentiment() => $_has(2, 3);
  void clearExtractDocumentSentiment() => clearField(3);
}

class _ReadonlyAnnotateTextRequest_Features extends AnnotateTextRequest_Features with ReadonlyMessageMixin {}

class AnnotateTextRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AnnotateTextRequest')
    ..a/*<Document>*/(1, 'document', PbFieldType.OM, Document.getDefault, Document.create)
    ..a/*<AnnotateTextRequest_Features>*/(2, 'features', PbFieldType.OM, AnnotateTextRequest_Features.getDefault, AnnotateTextRequest_Features.create)
    ..e/*<EncodingType>*/(3, 'encodingType', PbFieldType.OE, EncodingType.NONE, EncodingType.valueOf)
    ..hasRequiredFields = false
  ;

  AnnotateTextRequest() : super();
  AnnotateTextRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AnnotateTextRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AnnotateTextRequest clone() => new AnnotateTextRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AnnotateTextRequest create() => new AnnotateTextRequest();
  static PbList<AnnotateTextRequest> createRepeated() => new PbList<AnnotateTextRequest>();
  static AnnotateTextRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAnnotateTextRequest();
    return _defaultInstance;
  }
  static AnnotateTextRequest _defaultInstance;
  static void $checkItem(AnnotateTextRequest v) {
    if (v is !AnnotateTextRequest) checkItemFailed(v, 'AnnotateTextRequest');
  }

  Document get document => $_get(0, 1, null);
  void set document(Document v) { setField(1, v); }
  bool hasDocument() => $_has(0, 1);
  void clearDocument() => clearField(1);

  AnnotateTextRequest_Features get features => $_get(1, 2, null);
  void set features(AnnotateTextRequest_Features v) { setField(2, v); }
  bool hasFeatures() => $_has(1, 2);
  void clearFeatures() => clearField(2);

  EncodingType get encodingType => $_get(2, 3, null);
  void set encodingType(EncodingType v) { setField(3, v); }
  bool hasEncodingType() => $_has(2, 3);
  void clearEncodingType() => clearField(3);
}

class _ReadonlyAnnotateTextRequest extends AnnotateTextRequest with ReadonlyMessageMixin {}

class AnnotateTextResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AnnotateTextResponse')
    ..pp/*<Sentence>*/(1, 'sentences', PbFieldType.PM, Sentence.$checkItem, Sentence.create)
    ..pp/*<Token>*/(2, 'tokens', PbFieldType.PM, Token.$checkItem, Token.create)
    ..pp/*<Entity>*/(3, 'entities', PbFieldType.PM, Entity.$checkItem, Entity.create)
    ..a/*<Sentiment>*/(4, 'documentSentiment', PbFieldType.OM, Sentiment.getDefault, Sentiment.create)
    ..a/*<String>*/(5, 'language', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AnnotateTextResponse() : super();
  AnnotateTextResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AnnotateTextResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AnnotateTextResponse clone() => new AnnotateTextResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AnnotateTextResponse create() => new AnnotateTextResponse();
  static PbList<AnnotateTextResponse> createRepeated() => new PbList<AnnotateTextResponse>();
  static AnnotateTextResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAnnotateTextResponse();
    return _defaultInstance;
  }
  static AnnotateTextResponse _defaultInstance;
  static void $checkItem(AnnotateTextResponse v) {
    if (v is !AnnotateTextResponse) checkItemFailed(v, 'AnnotateTextResponse');
  }

  List<Sentence> get sentences => $_get(0, 1, null);

  List<Token> get tokens => $_get(1, 2, null);

  List<Entity> get entities => $_get(2, 3, null);

  Sentiment get documentSentiment => $_get(3, 4, null);
  void set documentSentiment(Sentiment v) { setField(4, v); }
  bool hasDocumentSentiment() => $_has(3, 4);
  void clearDocumentSentiment() => clearField(4);

  String get language => $_get(4, 5, '');
  void set language(String v) { $_setString(4, 5, v); }
  bool hasLanguage() => $_has(4, 5);
  void clearLanguage() => clearField(5);
}

class _ReadonlyAnnotateTextResponse extends AnnotateTextResponse with ReadonlyMessageMixin {}

class LanguageServiceApi {
  RpcClient _client;
  LanguageServiceApi(this._client);

  Future<AnalyzeSentimentResponse> analyzeSentiment(ClientContext ctx, AnalyzeSentimentRequest request) {
    var emptyResponse = new AnalyzeSentimentResponse();
    return _client.invoke(ctx, 'LanguageService', 'AnalyzeSentiment', request, emptyResponse);
  }
  Future<AnalyzeEntitiesResponse> analyzeEntities(ClientContext ctx, AnalyzeEntitiesRequest request) {
    var emptyResponse = new AnalyzeEntitiesResponse();
    return _client.invoke(ctx, 'LanguageService', 'AnalyzeEntities', request, emptyResponse);
  }
  Future<AnalyzeSyntaxResponse> analyzeSyntax(ClientContext ctx, AnalyzeSyntaxRequest request) {
    var emptyResponse = new AnalyzeSyntaxResponse();
    return _client.invoke(ctx, 'LanguageService', 'AnalyzeSyntax', request, emptyResponse);
  }
  Future<AnnotateTextResponse> annotateText(ClientContext ctx, AnnotateTextRequest request) {
    var emptyResponse = new AnnotateTextResponse();
    return _client.invoke(ctx, 'LanguageService', 'AnnotateText', request, emptyResponse);
  }
}

