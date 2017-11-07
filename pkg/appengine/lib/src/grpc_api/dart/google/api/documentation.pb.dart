///
//  Generated code. Do not modify.
///
library google.api_documentation;

import 'package:protobuf/protobuf.dart';

class Documentation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Documentation')
    ..a/*<String>*/(1, 'summary', PbFieldType.OS)
    ..a/*<String>*/(2, 'overview', PbFieldType.OS)
    ..pp/*<DocumentationRule>*/(3, 'rules', PbFieldType.PM, DocumentationRule.$checkItem, DocumentationRule.create)
    ..a/*<String>*/(4, 'documentationRootUrl', PbFieldType.OS)
    ..pp/*<Page>*/(5, 'pages', PbFieldType.PM, Page.$checkItem, Page.create)
    ..hasRequiredFields = false
  ;

  Documentation() : super();
  Documentation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Documentation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Documentation clone() => new Documentation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Documentation create() => new Documentation();
  static PbList<Documentation> createRepeated() => new PbList<Documentation>();
  static Documentation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDocumentation();
    return _defaultInstance;
  }
  static Documentation _defaultInstance;
  static void $checkItem(Documentation v) {
    if (v is !Documentation) checkItemFailed(v, 'Documentation');
  }

  String get summary => $_get(0, 1, '');
  void set summary(String v) { $_setString(0, 1, v); }
  bool hasSummary() => $_has(0, 1);
  void clearSummary() => clearField(1);

  String get overview => $_get(1, 2, '');
  void set overview(String v) { $_setString(1, 2, v); }
  bool hasOverview() => $_has(1, 2);
  void clearOverview() => clearField(2);

  List<DocumentationRule> get rules => $_get(2, 3, null);

  String get documentationRootUrl => $_get(3, 4, '');
  void set documentationRootUrl(String v) { $_setString(3, 4, v); }
  bool hasDocumentationRootUrl() => $_has(3, 4);
  void clearDocumentationRootUrl() => clearField(4);

  List<Page> get pages => $_get(4, 5, null);
}

class _ReadonlyDocumentation extends Documentation with ReadonlyMessageMixin {}

class DocumentationRule extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DocumentationRule')
    ..a/*<String>*/(1, 'selector', PbFieldType.OS)
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..a/*<String>*/(3, 'deprecationDescription', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DocumentationRule() : super();
  DocumentationRule.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DocumentationRule.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DocumentationRule clone() => new DocumentationRule()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DocumentationRule create() => new DocumentationRule();
  static PbList<DocumentationRule> createRepeated() => new PbList<DocumentationRule>();
  static DocumentationRule getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDocumentationRule();
    return _defaultInstance;
  }
  static DocumentationRule _defaultInstance;
  static void $checkItem(DocumentationRule v) {
    if (v is !DocumentationRule) checkItemFailed(v, 'DocumentationRule');
  }

  String get selector => $_get(0, 1, '');
  void set selector(String v) { $_setString(0, 1, v); }
  bool hasSelector() => $_has(0, 1);
  void clearSelector() => clearField(1);

  String get description => $_get(1, 2, '');
  void set description(String v) { $_setString(1, 2, v); }
  bool hasDescription() => $_has(1, 2);
  void clearDescription() => clearField(2);

  String get deprecationDescription => $_get(2, 3, '');
  void set deprecationDescription(String v) { $_setString(2, 3, v); }
  bool hasDeprecationDescription() => $_has(2, 3);
  void clearDeprecationDescription() => clearField(3);
}

class _ReadonlyDocumentationRule extends DocumentationRule with ReadonlyMessageMixin {}

class Page extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Page')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'content', PbFieldType.OS)
    ..pp/*<Page>*/(3, 'subpages', PbFieldType.PM, Page.$checkItem, Page.create)
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

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get content => $_get(1, 2, '');
  void set content(String v) { $_setString(1, 2, v); }
  bool hasContent() => $_has(1, 2);
  void clearContent() => clearField(2);

  List<Page> get subpages => $_get(2, 3, null);
}

class _ReadonlyPage extends Page with ReadonlyMessageMixin {}

