///
//  Generated code. Do not modify.
///
library google.cloud.vision.v1_text_annotation;

import 'package:protobuf/protobuf.dart';

import 'geometry.pb.dart';

import 'text_annotation.pbenum.dart';

export 'text_annotation.pbenum.dart';

class TextAnnotation_DetectedLanguage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TextAnnotation_DetectedLanguage')
    ..a/*<String>*/(1, 'languageCode', PbFieldType.OS)
    ..a/*<double>*/(2, 'confidence', PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  TextAnnotation_DetectedLanguage() : super();
  TextAnnotation_DetectedLanguage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TextAnnotation_DetectedLanguage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TextAnnotation_DetectedLanguage clone() => new TextAnnotation_DetectedLanguage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TextAnnotation_DetectedLanguage create() => new TextAnnotation_DetectedLanguage();
  static PbList<TextAnnotation_DetectedLanguage> createRepeated() => new PbList<TextAnnotation_DetectedLanguage>();
  static TextAnnotation_DetectedLanguage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTextAnnotation_DetectedLanguage();
    return _defaultInstance;
  }
  static TextAnnotation_DetectedLanguage _defaultInstance;
  static void $checkItem(TextAnnotation_DetectedLanguage v) {
    if (v is !TextAnnotation_DetectedLanguage) checkItemFailed(v, 'TextAnnotation_DetectedLanguage');
  }

  String get languageCode => $_get(0, 1, '');
  void set languageCode(String v) { $_setString(0, 1, v); }
  bool hasLanguageCode() => $_has(0, 1);
  void clearLanguageCode() => clearField(1);

  double get confidence => $_get(1, 2, null);
  void set confidence(double v) { $_setFloat(1, 2, v); }
  bool hasConfidence() => $_has(1, 2);
  void clearConfidence() => clearField(2);
}

class _ReadonlyTextAnnotation_DetectedLanguage extends TextAnnotation_DetectedLanguage with ReadonlyMessageMixin {}

class TextAnnotation_DetectedBreak extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TextAnnotation_DetectedBreak')
    ..e/*<TextAnnotation_DetectedBreak_BreakType>*/(1, 'type', PbFieldType.OE, TextAnnotation_DetectedBreak_BreakType.UNKNOWN, TextAnnotation_DetectedBreak_BreakType.valueOf)
    ..a/*<bool>*/(2, 'isPrefix', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  TextAnnotation_DetectedBreak() : super();
  TextAnnotation_DetectedBreak.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TextAnnotation_DetectedBreak.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TextAnnotation_DetectedBreak clone() => new TextAnnotation_DetectedBreak()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TextAnnotation_DetectedBreak create() => new TextAnnotation_DetectedBreak();
  static PbList<TextAnnotation_DetectedBreak> createRepeated() => new PbList<TextAnnotation_DetectedBreak>();
  static TextAnnotation_DetectedBreak getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTextAnnotation_DetectedBreak();
    return _defaultInstance;
  }
  static TextAnnotation_DetectedBreak _defaultInstance;
  static void $checkItem(TextAnnotation_DetectedBreak v) {
    if (v is !TextAnnotation_DetectedBreak) checkItemFailed(v, 'TextAnnotation_DetectedBreak');
  }

  TextAnnotation_DetectedBreak_BreakType get type => $_get(0, 1, null);
  void set type(TextAnnotation_DetectedBreak_BreakType v) { setField(1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  bool get isPrefix => $_get(1, 2, false);
  void set isPrefix(bool v) { $_setBool(1, 2, v); }
  bool hasIsPrefix() => $_has(1, 2);
  void clearIsPrefix() => clearField(2);
}

class _ReadonlyTextAnnotation_DetectedBreak extends TextAnnotation_DetectedBreak with ReadonlyMessageMixin {}

class TextAnnotation_TextProperty extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TextAnnotation_TextProperty')
    ..pp/*<TextAnnotation_DetectedLanguage>*/(1, 'detectedLanguages', PbFieldType.PM, TextAnnotation_DetectedLanguage.$checkItem, TextAnnotation_DetectedLanguage.create)
    ..a/*<TextAnnotation_DetectedBreak>*/(2, 'detectedBreak', PbFieldType.OM, TextAnnotation_DetectedBreak.getDefault, TextAnnotation_DetectedBreak.create)
    ..hasRequiredFields = false
  ;

  TextAnnotation_TextProperty() : super();
  TextAnnotation_TextProperty.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TextAnnotation_TextProperty.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TextAnnotation_TextProperty clone() => new TextAnnotation_TextProperty()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TextAnnotation_TextProperty create() => new TextAnnotation_TextProperty();
  static PbList<TextAnnotation_TextProperty> createRepeated() => new PbList<TextAnnotation_TextProperty>();
  static TextAnnotation_TextProperty getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTextAnnotation_TextProperty();
    return _defaultInstance;
  }
  static TextAnnotation_TextProperty _defaultInstance;
  static void $checkItem(TextAnnotation_TextProperty v) {
    if (v is !TextAnnotation_TextProperty) checkItemFailed(v, 'TextAnnotation_TextProperty');
  }

  List<TextAnnotation_DetectedLanguage> get detectedLanguages => $_get(0, 1, null);

  TextAnnotation_DetectedBreak get detectedBreak => $_get(1, 2, null);
  void set detectedBreak(TextAnnotation_DetectedBreak v) { setField(2, v); }
  bool hasDetectedBreak() => $_has(1, 2);
  void clearDetectedBreak() => clearField(2);
}

class _ReadonlyTextAnnotation_TextProperty extends TextAnnotation_TextProperty with ReadonlyMessageMixin {}

class TextAnnotation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TextAnnotation')
    ..pp/*<Page>*/(1, 'pages', PbFieldType.PM, Page.$checkItem, Page.create)
    ..a/*<String>*/(2, 'text', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  TextAnnotation() : super();
  TextAnnotation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TextAnnotation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TextAnnotation clone() => new TextAnnotation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TextAnnotation create() => new TextAnnotation();
  static PbList<TextAnnotation> createRepeated() => new PbList<TextAnnotation>();
  static TextAnnotation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTextAnnotation();
    return _defaultInstance;
  }
  static TextAnnotation _defaultInstance;
  static void $checkItem(TextAnnotation v) {
    if (v is !TextAnnotation) checkItemFailed(v, 'TextAnnotation');
  }

  List<Page> get pages => $_get(0, 1, null);

  String get text => $_get(1, 2, '');
  void set text(String v) { $_setString(1, 2, v); }
  bool hasText() => $_has(1, 2);
  void clearText() => clearField(2);
}

class _ReadonlyTextAnnotation extends TextAnnotation with ReadonlyMessageMixin {}

class Page extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Page')
    ..a/*<TextAnnotation_TextProperty>*/(1, 'property', PbFieldType.OM, TextAnnotation_TextProperty.getDefault, TextAnnotation_TextProperty.create)
    ..a/*<int>*/(2, 'width', PbFieldType.O3)
    ..a/*<int>*/(3, 'height', PbFieldType.O3)
    ..pp/*<Block>*/(4, 'blocks', PbFieldType.PM, Block.$checkItem, Block.create)
    ..hasRequiredFields = false
  ;

  Page() : super();
  Page.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Page.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Page clone() => new Page()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Page create() => new Page();
  static PbList<Page> createRepeated() => new PbList<Page>();
  static Page getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPage();
    return _defaultInstance;
  }
  static Page _defaultInstance;
  static void $checkItem(Page v) {
    if (v is !Page) checkItemFailed(v, 'Page');
  }

  TextAnnotation_TextProperty get property => $_get(0, 1, null);
  void set property(TextAnnotation_TextProperty v) { setField(1, v); }
  bool hasProperty() => $_has(0, 1);
  void clearProperty() => clearField(1);

  int get width => $_get(1, 2, 0);
  void set width(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasWidth() => $_has(1, 2);
  void clearWidth() => clearField(2);

  int get height => $_get(2, 3, 0);
  void set height(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasHeight() => $_has(2, 3);
  void clearHeight() => clearField(3);

  List<Block> get blocks => $_get(3, 4, null);
}

class _ReadonlyPage extends Page with ReadonlyMessageMixin {}

class Block extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Block')
    ..a/*<TextAnnotation_TextProperty>*/(1, 'property', PbFieldType.OM, TextAnnotation_TextProperty.getDefault, TextAnnotation_TextProperty.create)
    ..a/*<BoundingPoly>*/(2, 'boundingBox', PbFieldType.OM, BoundingPoly.getDefault, BoundingPoly.create)
    ..pp/*<Paragraph>*/(3, 'paragraphs', PbFieldType.PM, Paragraph.$checkItem, Paragraph.create)
    ..e/*<Block_BlockType>*/(4, 'blockType', PbFieldType.OE, Block_BlockType.UNKNOWN, Block_BlockType.valueOf)
    ..hasRequiredFields = false
  ;

  Block() : super();
  Block.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Block.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Block clone() => new Block()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Block create() => new Block();
  static PbList<Block> createRepeated() => new PbList<Block>();
  static Block getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBlock();
    return _defaultInstance;
  }
  static Block _defaultInstance;
  static void $checkItem(Block v) {
    if (v is !Block) checkItemFailed(v, 'Block');
  }

  TextAnnotation_TextProperty get property => $_get(0, 1, null);
  void set property(TextAnnotation_TextProperty v) { setField(1, v); }
  bool hasProperty() => $_has(0, 1);
  void clearProperty() => clearField(1);

  BoundingPoly get boundingBox => $_get(1, 2, null);
  void set boundingBox(BoundingPoly v) { setField(2, v); }
  bool hasBoundingBox() => $_has(1, 2);
  void clearBoundingBox() => clearField(2);

  List<Paragraph> get paragraphs => $_get(2, 3, null);

  Block_BlockType get blockType => $_get(3, 4, null);
  void set blockType(Block_BlockType v) { setField(4, v); }
  bool hasBlockType() => $_has(3, 4);
  void clearBlockType() => clearField(4);
}

class _ReadonlyBlock extends Block with ReadonlyMessageMixin {}

class Paragraph extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Paragraph')
    ..a/*<TextAnnotation_TextProperty>*/(1, 'property', PbFieldType.OM, TextAnnotation_TextProperty.getDefault, TextAnnotation_TextProperty.create)
    ..a/*<BoundingPoly>*/(2, 'boundingBox', PbFieldType.OM, BoundingPoly.getDefault, BoundingPoly.create)
    ..pp/*<Word>*/(3, 'words', PbFieldType.PM, Word.$checkItem, Word.create)
    ..hasRequiredFields = false
  ;

  Paragraph() : super();
  Paragraph.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Paragraph.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Paragraph clone() => new Paragraph()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Paragraph create() => new Paragraph();
  static PbList<Paragraph> createRepeated() => new PbList<Paragraph>();
  static Paragraph getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyParagraph();
    return _defaultInstance;
  }
  static Paragraph _defaultInstance;
  static void $checkItem(Paragraph v) {
    if (v is !Paragraph) checkItemFailed(v, 'Paragraph');
  }

  TextAnnotation_TextProperty get property => $_get(0, 1, null);
  void set property(TextAnnotation_TextProperty v) { setField(1, v); }
  bool hasProperty() => $_has(0, 1);
  void clearProperty() => clearField(1);

  BoundingPoly get boundingBox => $_get(1, 2, null);
  void set boundingBox(BoundingPoly v) { setField(2, v); }
  bool hasBoundingBox() => $_has(1, 2);
  void clearBoundingBox() => clearField(2);

  List<Word> get words => $_get(2, 3, null);
}

class _ReadonlyParagraph extends Paragraph with ReadonlyMessageMixin {}

class Word extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Word')
    ..a/*<TextAnnotation_TextProperty>*/(1, 'property', PbFieldType.OM, TextAnnotation_TextProperty.getDefault, TextAnnotation_TextProperty.create)
    ..a/*<BoundingPoly>*/(2, 'boundingBox', PbFieldType.OM, BoundingPoly.getDefault, BoundingPoly.create)
    ..pp/*<Symbol>*/(3, 'symbols', PbFieldType.PM, Symbol.$checkItem, Symbol.create)
    ..hasRequiredFields = false
  ;

  Word() : super();
  Word.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Word.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Word clone() => new Word()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Word create() => new Word();
  static PbList<Word> createRepeated() => new PbList<Word>();
  static Word getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWord();
    return _defaultInstance;
  }
  static Word _defaultInstance;
  static void $checkItem(Word v) {
    if (v is !Word) checkItemFailed(v, 'Word');
  }

  TextAnnotation_TextProperty get property => $_get(0, 1, null);
  void set property(TextAnnotation_TextProperty v) { setField(1, v); }
  bool hasProperty() => $_has(0, 1);
  void clearProperty() => clearField(1);

  BoundingPoly get boundingBox => $_get(1, 2, null);
  void set boundingBox(BoundingPoly v) { setField(2, v); }
  bool hasBoundingBox() => $_has(1, 2);
  void clearBoundingBox() => clearField(2);

  List<Symbol> get symbols => $_get(2, 3, null);
}

class _ReadonlyWord extends Word with ReadonlyMessageMixin {}

class Symbol extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Symbol')
    ..a/*<TextAnnotation_TextProperty>*/(1, 'property', PbFieldType.OM, TextAnnotation_TextProperty.getDefault, TextAnnotation_TextProperty.create)
    ..a/*<BoundingPoly>*/(2, 'boundingBox', PbFieldType.OM, BoundingPoly.getDefault, BoundingPoly.create)
    ..a/*<String>*/(3, 'text', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Symbol() : super();
  Symbol.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Symbol.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Symbol clone() => new Symbol()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Symbol create() => new Symbol();
  static PbList<Symbol> createRepeated() => new PbList<Symbol>();
  static Symbol getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySymbol();
    return _defaultInstance;
  }
  static Symbol _defaultInstance;
  static void $checkItem(Symbol v) {
    if (v is !Symbol) checkItemFailed(v, 'Symbol');
  }

  TextAnnotation_TextProperty get property => $_get(0, 1, null);
  void set property(TextAnnotation_TextProperty v) { setField(1, v); }
  bool hasProperty() => $_has(0, 1);
  void clearProperty() => clearField(1);

  BoundingPoly get boundingBox => $_get(1, 2, null);
  void set boundingBox(BoundingPoly v) { setField(2, v); }
  bool hasBoundingBox() => $_has(1, 2);
  void clearBoundingBox() => clearField(2);

  String get text => $_get(2, 3, '');
  void set text(String v) { $_setString(2, 3, v); }
  bool hasText() => $_has(2, 3);
  void clearText() => clearField(3);
}

class _ReadonlySymbol extends Symbol with ReadonlyMessageMixin {}

