///
//  Generated code. Do not modify.
///
library google.cloud.vision.v1_web_detection;

import 'package:protobuf/protobuf.dart';

class WebDetection_WebEntity extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('WebDetection_WebEntity')
    ..a/*<String>*/(1, 'entityId', PbFieldType.OS)
    ..a/*<double>*/(2, 'score', PbFieldType.OF)
    ..a/*<String>*/(3, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  WebDetection_WebEntity() : super();
  WebDetection_WebEntity.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  WebDetection_WebEntity.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  WebDetection_WebEntity clone() => new WebDetection_WebEntity()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WebDetection_WebEntity create() => new WebDetection_WebEntity();
  static PbList<WebDetection_WebEntity> createRepeated() => new PbList<WebDetection_WebEntity>();
  static WebDetection_WebEntity getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWebDetection_WebEntity();
    return _defaultInstance;
  }
  static WebDetection_WebEntity _defaultInstance;
  static void $checkItem(WebDetection_WebEntity v) {
    if (v is !WebDetection_WebEntity) checkItemFailed(v, 'WebDetection_WebEntity');
  }

  String get entityId => $_get(0, 1, '');
  void set entityId(String v) { $_setString(0, 1, v); }
  bool hasEntityId() => $_has(0, 1);
  void clearEntityId() => clearField(1);

  double get score => $_get(1, 2, null);
  void set score(double v) { $_setFloat(1, 2, v); }
  bool hasScore() => $_has(1, 2);
  void clearScore() => clearField(2);

  String get description => $_get(2, 3, '');
  void set description(String v) { $_setString(2, 3, v); }
  bool hasDescription() => $_has(2, 3);
  void clearDescription() => clearField(3);
}

class _ReadonlyWebDetection_WebEntity extends WebDetection_WebEntity with ReadonlyMessageMixin {}

class WebDetection_WebImage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('WebDetection_WebImage')
    ..a/*<String>*/(1, 'url', PbFieldType.OS)
    ..a/*<double>*/(2, 'score', PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  WebDetection_WebImage() : super();
  WebDetection_WebImage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  WebDetection_WebImage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  WebDetection_WebImage clone() => new WebDetection_WebImage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WebDetection_WebImage create() => new WebDetection_WebImage();
  static PbList<WebDetection_WebImage> createRepeated() => new PbList<WebDetection_WebImage>();
  static WebDetection_WebImage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWebDetection_WebImage();
    return _defaultInstance;
  }
  static WebDetection_WebImage _defaultInstance;
  static void $checkItem(WebDetection_WebImage v) {
    if (v is !WebDetection_WebImage) checkItemFailed(v, 'WebDetection_WebImage');
  }

  String get url => $_get(0, 1, '');
  void set url(String v) { $_setString(0, 1, v); }
  bool hasUrl() => $_has(0, 1);
  void clearUrl() => clearField(1);

  double get score => $_get(1, 2, null);
  void set score(double v) { $_setFloat(1, 2, v); }
  bool hasScore() => $_has(1, 2);
  void clearScore() => clearField(2);
}

class _ReadonlyWebDetection_WebImage extends WebDetection_WebImage with ReadonlyMessageMixin {}

class WebDetection_WebPage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('WebDetection_WebPage')
    ..a/*<String>*/(1, 'url', PbFieldType.OS)
    ..a/*<double>*/(2, 'score', PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  WebDetection_WebPage() : super();
  WebDetection_WebPage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  WebDetection_WebPage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  WebDetection_WebPage clone() => new WebDetection_WebPage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WebDetection_WebPage create() => new WebDetection_WebPage();
  static PbList<WebDetection_WebPage> createRepeated() => new PbList<WebDetection_WebPage>();
  static WebDetection_WebPage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWebDetection_WebPage();
    return _defaultInstance;
  }
  static WebDetection_WebPage _defaultInstance;
  static void $checkItem(WebDetection_WebPage v) {
    if (v is !WebDetection_WebPage) checkItemFailed(v, 'WebDetection_WebPage');
  }

  String get url => $_get(0, 1, '');
  void set url(String v) { $_setString(0, 1, v); }
  bool hasUrl() => $_has(0, 1);
  void clearUrl() => clearField(1);

  double get score => $_get(1, 2, null);
  void set score(double v) { $_setFloat(1, 2, v); }
  bool hasScore() => $_has(1, 2);
  void clearScore() => clearField(2);
}

class _ReadonlyWebDetection_WebPage extends WebDetection_WebPage with ReadonlyMessageMixin {}

class WebDetection extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('WebDetection')
    ..pp/*<WebDetection_WebEntity>*/(1, 'webEntities', PbFieldType.PM, WebDetection_WebEntity.$checkItem, WebDetection_WebEntity.create)
    ..pp/*<WebDetection_WebImage>*/(2, 'fullMatchingImages', PbFieldType.PM, WebDetection_WebImage.$checkItem, WebDetection_WebImage.create)
    ..pp/*<WebDetection_WebImage>*/(3, 'partialMatchingImages', PbFieldType.PM, WebDetection_WebImage.$checkItem, WebDetection_WebImage.create)
    ..pp/*<WebDetection_WebPage>*/(4, 'pagesWithMatchingImages', PbFieldType.PM, WebDetection_WebPage.$checkItem, WebDetection_WebPage.create)
    ..hasRequiredFields = false
  ;

  WebDetection() : super();
  WebDetection.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  WebDetection.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  WebDetection clone() => new WebDetection()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WebDetection create() => new WebDetection();
  static PbList<WebDetection> createRepeated() => new PbList<WebDetection>();
  static WebDetection getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWebDetection();
    return _defaultInstance;
  }
  static WebDetection _defaultInstance;
  static void $checkItem(WebDetection v) {
    if (v is !WebDetection) checkItemFailed(v, 'WebDetection');
  }

  List<WebDetection_WebEntity> get webEntities => $_get(0, 1, null);

  List<WebDetection_WebImage> get fullMatchingImages => $_get(1, 2, null);

  List<WebDetection_WebImage> get partialMatchingImages => $_get(2, 3, null);

  List<WebDetection_WebPage> get pagesWithMatchingImages => $_get(3, 4, null);
}

class _ReadonlyWebDetection extends WebDetection with ReadonlyMessageMixin {}

