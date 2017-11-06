library googleapis.books.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/books/v1.dart' as api;

class HttpServerMock extends http.BaseClient {
  core.Function _callback;
  core.bool _expectJson;

  void register(core.Function callback, core.bool expectJson) {
    _callback = callback;
    _expectJson = expectJson;
  }

  async.Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (_expectJson) {
      return request.finalize()
          .transform(convert.UTF8.decoder)
          .join('')
          .then((core.String jsonString) {
        if (jsonString.isEmpty) {
          return _callback(request, null);
        } else {
          return _callback(request, convert.JSON.decode(jsonString));
        }
      });
    } else {
      var stream = request.finalize();
      if (stream == null) {
        return _callback(request, []);
      } else {
        return stream.toBytes().then((data) {
          return _callback(request, data);
        });
      }
    }
  }
}

http.StreamedResponse stringResponse(
    core.int status, core.Map headers, core.String body) {
  var stream = new async.Stream.fromIterable([convert.UTF8.encode(body)]);
  return new http.StreamedResponse(stream, status, headers: headers);
}

core.int buildCounterAnnotationClientVersionRanges = 0;
buildAnnotationClientVersionRanges() {
  var o = new api.AnnotationClientVersionRanges();
  buildCounterAnnotationClientVersionRanges++;
  if (buildCounterAnnotationClientVersionRanges < 3) {
    o.cfiRange = buildBooksAnnotationsRange();
    o.contentVersion = "foo";
    o.gbImageRange = buildBooksAnnotationsRange();
    o.gbTextRange = buildBooksAnnotationsRange();
    o.imageCfiRange = buildBooksAnnotationsRange();
  }
  buildCounterAnnotationClientVersionRanges--;
  return o;
}

checkAnnotationClientVersionRanges(api.AnnotationClientVersionRanges o) {
  buildCounterAnnotationClientVersionRanges++;
  if (buildCounterAnnotationClientVersionRanges < 3) {
    checkBooksAnnotationsRange(o.cfiRange);
    unittest.expect(o.contentVersion, unittest.equals('foo'));
    checkBooksAnnotationsRange(o.gbImageRange);
    checkBooksAnnotationsRange(o.gbTextRange);
    checkBooksAnnotationsRange(o.imageCfiRange);
  }
  buildCounterAnnotationClientVersionRanges--;
}

core.int buildCounterAnnotationCurrentVersionRanges = 0;
buildAnnotationCurrentVersionRanges() {
  var o = new api.AnnotationCurrentVersionRanges();
  buildCounterAnnotationCurrentVersionRanges++;
  if (buildCounterAnnotationCurrentVersionRanges < 3) {
    o.cfiRange = buildBooksAnnotationsRange();
    o.contentVersion = "foo";
    o.gbImageRange = buildBooksAnnotationsRange();
    o.gbTextRange = buildBooksAnnotationsRange();
    o.imageCfiRange = buildBooksAnnotationsRange();
  }
  buildCounterAnnotationCurrentVersionRanges--;
  return o;
}

checkAnnotationCurrentVersionRanges(api.AnnotationCurrentVersionRanges o) {
  buildCounterAnnotationCurrentVersionRanges++;
  if (buildCounterAnnotationCurrentVersionRanges < 3) {
    checkBooksAnnotationsRange(o.cfiRange);
    unittest.expect(o.contentVersion, unittest.equals('foo'));
    checkBooksAnnotationsRange(o.gbImageRange);
    checkBooksAnnotationsRange(o.gbTextRange);
    checkBooksAnnotationsRange(o.imageCfiRange);
  }
  buildCounterAnnotationCurrentVersionRanges--;
}

core.int buildCounterAnnotationLayerSummary = 0;
buildAnnotationLayerSummary() {
  var o = new api.AnnotationLayerSummary();
  buildCounterAnnotationLayerSummary++;
  if (buildCounterAnnotationLayerSummary < 3) {
    o.allowedCharacterCount = 42;
    o.limitType = "foo";
    o.remainingCharacterCount = 42;
  }
  buildCounterAnnotationLayerSummary--;
  return o;
}

checkAnnotationLayerSummary(api.AnnotationLayerSummary o) {
  buildCounterAnnotationLayerSummary++;
  if (buildCounterAnnotationLayerSummary < 3) {
    unittest.expect(o.allowedCharacterCount, unittest.equals(42));
    unittest.expect(o.limitType, unittest.equals('foo'));
    unittest.expect(o.remainingCharacterCount, unittest.equals(42));
  }
  buildCounterAnnotationLayerSummary--;
}

buildUnnamed792() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed792(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterAnnotation = 0;
buildAnnotation() {
  var o = new api.Annotation();
  buildCounterAnnotation++;
  if (buildCounterAnnotation < 3) {
    o.afterSelectedText = "foo";
    o.beforeSelectedText = "foo";
    o.clientVersionRanges = buildAnnotationClientVersionRanges();
    o.created = core.DateTime.parse("2002-02-27T14:01:02");
    o.currentVersionRanges = buildAnnotationCurrentVersionRanges();
    o.data = "foo";
    o.deleted = true;
    o.highlightStyle = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.layerId = "foo";
    o.layerSummary = buildAnnotationLayerSummary();
    o.pageIds = buildUnnamed792();
    o.selectedText = "foo";
    o.selfLink = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.volumeId = "foo";
  }
  buildCounterAnnotation--;
  return o;
}

checkAnnotation(api.Annotation o) {
  buildCounterAnnotation++;
  if (buildCounterAnnotation < 3) {
    unittest.expect(o.afterSelectedText, unittest.equals('foo'));
    unittest.expect(o.beforeSelectedText, unittest.equals('foo'));
    checkAnnotationClientVersionRanges(o.clientVersionRanges);
    unittest.expect(o.created, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    checkAnnotationCurrentVersionRanges(o.currentVersionRanges);
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.deleted, unittest.isTrue);
    unittest.expect(o.highlightStyle, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.layerId, unittest.equals('foo'));
    checkAnnotationLayerSummary(o.layerSummary);
    checkUnnamed792(o.pageIds);
    unittest.expect(o.selectedText, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.volumeId, unittest.equals('foo'));
  }
  buildCounterAnnotation--;
}

core.int buildCounterAnnotationdata = 0;
buildAnnotationdata() {
  var o = new api.Annotationdata();
  buildCounterAnnotationdata++;
  if (buildCounterAnnotationdata < 3) {
    o.annotationType = "foo";
    o.data = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
    o.encodedData = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.layerId = "foo";
    o.selfLink = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.volumeId = "foo";
  }
  buildCounterAnnotationdata--;
  return o;
}

checkAnnotationdata(api.Annotationdata o) {
  buildCounterAnnotationdata++;
  if (buildCounterAnnotationdata < 3) {
    unittest.expect(o.annotationType, unittest.equals('foo'));
    var casted1 = (o.data) as core.Map; unittest.expect(casted1, unittest.hasLength(3)); unittest.expect(casted1["list"], unittest.equals([1, 2, 3])); unittest.expect(casted1["bool"], unittest.equals(true)); unittest.expect(casted1["string"], unittest.equals('foo')); 
    unittest.expect(o.encodedData, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.layerId, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.volumeId, unittest.equals('foo'));
  }
  buildCounterAnnotationdata--;
}

buildUnnamed793() {
  var o = new core.List<api.Annotation>();
  o.add(buildAnnotation());
  o.add(buildAnnotation());
  return o;
}

checkUnnamed793(core.List<api.Annotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotation(o[0]);
  checkAnnotation(o[1]);
}

core.int buildCounterAnnotations = 0;
buildAnnotations() {
  var o = new api.Annotations();
  buildCounterAnnotations++;
  if (buildCounterAnnotations < 3) {
    o.items = buildUnnamed793();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.totalItems = 42;
  }
  buildCounterAnnotations--;
  return o;
}

checkAnnotations(api.Annotations o) {
  buildCounterAnnotations++;
  if (buildCounterAnnotations < 3) {
    checkUnnamed793(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterAnnotations--;
}

core.int buildCounterAnnotationsSummaryLayers = 0;
buildAnnotationsSummaryLayers() {
  var o = new api.AnnotationsSummaryLayers();
  buildCounterAnnotationsSummaryLayers++;
  if (buildCounterAnnotationsSummaryLayers < 3) {
    o.allowedCharacterCount = 42;
    o.layerId = "foo";
    o.limitType = "foo";
    o.remainingCharacterCount = 42;
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterAnnotationsSummaryLayers--;
  return o;
}

checkAnnotationsSummaryLayers(api.AnnotationsSummaryLayers o) {
  buildCounterAnnotationsSummaryLayers++;
  if (buildCounterAnnotationsSummaryLayers < 3) {
    unittest.expect(o.allowedCharacterCount, unittest.equals(42));
    unittest.expect(o.layerId, unittest.equals('foo'));
    unittest.expect(o.limitType, unittest.equals('foo'));
    unittest.expect(o.remainingCharacterCount, unittest.equals(42));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterAnnotationsSummaryLayers--;
}

buildUnnamed794() {
  var o = new core.List<api.AnnotationsSummaryLayers>();
  o.add(buildAnnotationsSummaryLayers());
  o.add(buildAnnotationsSummaryLayers());
  return o;
}

checkUnnamed794(core.List<api.AnnotationsSummaryLayers> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotationsSummaryLayers(o[0]);
  checkAnnotationsSummaryLayers(o[1]);
}

core.int buildCounterAnnotationsSummary = 0;
buildAnnotationsSummary() {
  var o = new api.AnnotationsSummary();
  buildCounterAnnotationsSummary++;
  if (buildCounterAnnotationsSummary < 3) {
    o.kind = "foo";
    o.layers = buildUnnamed794();
  }
  buildCounterAnnotationsSummary--;
  return o;
}

checkAnnotationsSummary(api.AnnotationsSummary o) {
  buildCounterAnnotationsSummary++;
  if (buildCounterAnnotationsSummary < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed794(o.layers);
  }
  buildCounterAnnotationsSummary--;
}

buildUnnamed795() {
  var o = new core.List<api.Annotationdata>();
  o.add(buildAnnotationdata());
  o.add(buildAnnotationdata());
  return o;
}

checkUnnamed795(core.List<api.Annotationdata> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotationdata(o[0]);
  checkAnnotationdata(o[1]);
}

core.int buildCounterAnnotationsdata = 0;
buildAnnotationsdata() {
  var o = new api.Annotationsdata();
  buildCounterAnnotationsdata++;
  if (buildCounterAnnotationsdata < 3) {
    o.items = buildUnnamed795();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.totalItems = 42;
  }
  buildCounterAnnotationsdata--;
  return o;
}

checkAnnotationsdata(api.Annotationsdata o) {
  buildCounterAnnotationsdata++;
  if (buildCounterAnnotationsdata < 3) {
    checkUnnamed795(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterAnnotationsdata--;
}

core.int buildCounterBooksAnnotationsRange = 0;
buildBooksAnnotationsRange() {
  var o = new api.BooksAnnotationsRange();
  buildCounterBooksAnnotationsRange++;
  if (buildCounterBooksAnnotationsRange < 3) {
    o.endOffset = "foo";
    o.endPosition = "foo";
    o.startOffset = "foo";
    o.startPosition = "foo";
  }
  buildCounterBooksAnnotationsRange--;
  return o;
}

checkBooksAnnotationsRange(api.BooksAnnotationsRange o) {
  buildCounterBooksAnnotationsRange++;
  if (buildCounterBooksAnnotationsRange < 3) {
    unittest.expect(o.endOffset, unittest.equals('foo'));
    unittest.expect(o.endPosition, unittest.equals('foo'));
    unittest.expect(o.startOffset, unittest.equals('foo'));
    unittest.expect(o.startPosition, unittest.equals('foo'));
  }
  buildCounterBooksAnnotationsRange--;
}

core.int buildCounterBooksCloudloadingResource = 0;
buildBooksCloudloadingResource() {
  var o = new api.BooksCloudloadingResource();
  buildCounterBooksCloudloadingResource++;
  if (buildCounterBooksCloudloadingResource < 3) {
    o.author = "foo";
    o.processingState = "foo";
    o.title = "foo";
    o.volumeId = "foo";
  }
  buildCounterBooksCloudloadingResource--;
  return o;
}

checkBooksCloudloadingResource(api.BooksCloudloadingResource o) {
  buildCounterBooksCloudloadingResource++;
  if (buildCounterBooksCloudloadingResource < 3) {
    unittest.expect(o.author, unittest.equals('foo'));
    unittest.expect(o.processingState, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.volumeId, unittest.equals('foo'));
  }
  buildCounterBooksCloudloadingResource--;
}

core.int buildCounterBooksVolumesRecommendedRateResponse = 0;
buildBooksVolumesRecommendedRateResponse() {
  var o = new api.BooksVolumesRecommendedRateResponse();
  buildCounterBooksVolumesRecommendedRateResponse++;
  if (buildCounterBooksVolumesRecommendedRateResponse < 3) {
    o.consistencyToken = "foo";
  }
  buildCounterBooksVolumesRecommendedRateResponse--;
  return o;
}

checkBooksVolumesRecommendedRateResponse(api.BooksVolumesRecommendedRateResponse o) {
  buildCounterBooksVolumesRecommendedRateResponse++;
  if (buildCounterBooksVolumesRecommendedRateResponse < 3) {
    unittest.expect(o.consistencyToken, unittest.equals('foo'));
  }
  buildCounterBooksVolumesRecommendedRateResponse--;
}

core.int buildCounterBookshelf = 0;
buildBookshelf() {
  var o = new api.Bookshelf();
  buildCounterBookshelf++;
  if (buildCounterBookshelf < 3) {
    o.access = "foo";
    o.created = core.DateTime.parse("2002-02-27T14:01:02");
    o.description = "foo";
    o.id = 42;
    o.kind = "foo";
    o.selfLink = "foo";
    o.title = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.volumeCount = 42;
    o.volumesLastUpdated = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterBookshelf--;
  return o;
}

checkBookshelf(api.Bookshelf o) {
  buildCounterBookshelf++;
  if (buildCounterBookshelf < 3) {
    unittest.expect(o.access, unittest.equals('foo'));
    unittest.expect(o.created, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.volumeCount, unittest.equals(42));
    unittest.expect(o.volumesLastUpdated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterBookshelf--;
}

buildUnnamed796() {
  var o = new core.List<api.Bookshelf>();
  o.add(buildBookshelf());
  o.add(buildBookshelf());
  return o;
}

checkUnnamed796(core.List<api.Bookshelf> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBookshelf(o[0]);
  checkBookshelf(o[1]);
}

core.int buildCounterBookshelves = 0;
buildBookshelves() {
  var o = new api.Bookshelves();
  buildCounterBookshelves++;
  if (buildCounterBookshelves < 3) {
    o.items = buildUnnamed796();
    o.kind = "foo";
  }
  buildCounterBookshelves--;
  return o;
}

checkBookshelves(api.Bookshelves o) {
  buildCounterBookshelves++;
  if (buildCounterBookshelves < 3) {
    checkUnnamed796(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterBookshelves--;
}

core.int buildCounterCategoryItems = 0;
buildCategoryItems() {
  var o = new api.CategoryItems();
  buildCounterCategoryItems++;
  if (buildCounterCategoryItems < 3) {
    o.badgeUrl = "foo";
    o.categoryId = "foo";
    o.name = "foo";
  }
  buildCounterCategoryItems--;
  return o;
}

checkCategoryItems(api.CategoryItems o) {
  buildCounterCategoryItems++;
  if (buildCounterCategoryItems < 3) {
    unittest.expect(o.badgeUrl, unittest.equals('foo'));
    unittest.expect(o.categoryId, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterCategoryItems--;
}

buildUnnamed797() {
  var o = new core.List<api.CategoryItems>();
  o.add(buildCategoryItems());
  o.add(buildCategoryItems());
  return o;
}

checkUnnamed797(core.List<api.CategoryItems> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCategoryItems(o[0]);
  checkCategoryItems(o[1]);
}

core.int buildCounterCategory = 0;
buildCategory() {
  var o = new api.Category();
  buildCounterCategory++;
  if (buildCounterCategory < 3) {
    o.items = buildUnnamed797();
    o.kind = "foo";
  }
  buildCounterCategory--;
  return o;
}

checkCategory(api.Category o) {
  buildCounterCategory++;
  if (buildCounterCategory < 3) {
    checkUnnamed797(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterCategory--;
}

core.int buildCounterConcurrentAccessRestriction = 0;
buildConcurrentAccessRestriction() {
  var o = new api.ConcurrentAccessRestriction();
  buildCounterConcurrentAccessRestriction++;
  if (buildCounterConcurrentAccessRestriction < 3) {
    o.deviceAllowed = true;
    o.kind = "foo";
    o.maxConcurrentDevices = 42;
    o.message = "foo";
    o.nonce = "foo";
    o.reasonCode = "foo";
    o.restricted = true;
    o.signature = "foo";
    o.source = "foo";
    o.timeWindowSeconds = 42;
    o.volumeId = "foo";
  }
  buildCounterConcurrentAccessRestriction--;
  return o;
}

checkConcurrentAccessRestriction(api.ConcurrentAccessRestriction o) {
  buildCounterConcurrentAccessRestriction++;
  if (buildCounterConcurrentAccessRestriction < 3) {
    unittest.expect(o.deviceAllowed, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.maxConcurrentDevices, unittest.equals(42));
    unittest.expect(o.message, unittest.equals('foo'));
    unittest.expect(o.nonce, unittest.equals('foo'));
    unittest.expect(o.reasonCode, unittest.equals('foo'));
    unittest.expect(o.restricted, unittest.isTrue);
    unittest.expect(o.signature, unittest.equals('foo'));
    unittest.expect(o.source, unittest.equals('foo'));
    unittest.expect(o.timeWindowSeconds, unittest.equals(42));
    unittest.expect(o.volumeId, unittest.equals('foo'));
  }
  buildCounterConcurrentAccessRestriction--;
}

core.int buildCounterDictlayerdataCommon = 0;
buildDictlayerdataCommon() {
  var o = new api.DictlayerdataCommon();
  buildCounterDictlayerdataCommon++;
  if (buildCounterDictlayerdataCommon < 3) {
    o.title = "foo";
  }
  buildCounterDictlayerdataCommon--;
  return o;
}

checkDictlayerdataCommon(api.DictlayerdataCommon o) {
  buildCounterDictlayerdataCommon++;
  if (buildCounterDictlayerdataCommon < 3) {
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterDictlayerdataCommon--;
}

core.int buildCounterDictlayerdataDictSource = 0;
buildDictlayerdataDictSource() {
  var o = new api.DictlayerdataDictSource();
  buildCounterDictlayerdataDictSource++;
  if (buildCounterDictlayerdataDictSource < 3) {
    o.attribution = "foo";
    o.url = "foo";
  }
  buildCounterDictlayerdataDictSource--;
  return o;
}

checkDictlayerdataDictSource(api.DictlayerdataDictSource o) {
  buildCounterDictlayerdataDictSource++;
  if (buildCounterDictlayerdataDictSource < 3) {
    unittest.expect(o.attribution, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictSource--;
}

core.int buildCounterDictlayerdataDictWordsDerivativesSource = 0;
buildDictlayerdataDictWordsDerivativesSource() {
  var o = new api.DictlayerdataDictWordsDerivativesSource();
  buildCounterDictlayerdataDictWordsDerivativesSource++;
  if (buildCounterDictlayerdataDictWordsDerivativesSource < 3) {
    o.attribution = "foo";
    o.url = "foo";
  }
  buildCounterDictlayerdataDictWordsDerivativesSource--;
  return o;
}

checkDictlayerdataDictWordsDerivativesSource(api.DictlayerdataDictWordsDerivativesSource o) {
  buildCounterDictlayerdataDictWordsDerivativesSource++;
  if (buildCounterDictlayerdataDictWordsDerivativesSource < 3) {
    unittest.expect(o.attribution, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsDerivativesSource--;
}

core.int buildCounterDictlayerdataDictWordsDerivatives = 0;
buildDictlayerdataDictWordsDerivatives() {
  var o = new api.DictlayerdataDictWordsDerivatives();
  buildCounterDictlayerdataDictWordsDerivatives++;
  if (buildCounterDictlayerdataDictWordsDerivatives < 3) {
    o.source = buildDictlayerdataDictWordsDerivativesSource();
    o.text = "foo";
  }
  buildCounterDictlayerdataDictWordsDerivatives--;
  return o;
}

checkDictlayerdataDictWordsDerivatives(api.DictlayerdataDictWordsDerivatives o) {
  buildCounterDictlayerdataDictWordsDerivatives++;
  if (buildCounterDictlayerdataDictWordsDerivatives < 3) {
    checkDictlayerdataDictWordsDerivativesSource(o.source);
    unittest.expect(o.text, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsDerivatives--;
}

buildUnnamed798() {
  var o = new core.List<api.DictlayerdataDictWordsDerivatives>();
  o.add(buildDictlayerdataDictWordsDerivatives());
  o.add(buildDictlayerdataDictWordsDerivatives());
  return o;
}

checkUnnamed798(core.List<api.DictlayerdataDictWordsDerivatives> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDictlayerdataDictWordsDerivatives(o[0]);
  checkDictlayerdataDictWordsDerivatives(o[1]);
}

core.int buildCounterDictlayerdataDictWordsExamplesSource = 0;
buildDictlayerdataDictWordsExamplesSource() {
  var o = new api.DictlayerdataDictWordsExamplesSource();
  buildCounterDictlayerdataDictWordsExamplesSource++;
  if (buildCounterDictlayerdataDictWordsExamplesSource < 3) {
    o.attribution = "foo";
    o.url = "foo";
  }
  buildCounterDictlayerdataDictWordsExamplesSource--;
  return o;
}

checkDictlayerdataDictWordsExamplesSource(api.DictlayerdataDictWordsExamplesSource o) {
  buildCounterDictlayerdataDictWordsExamplesSource++;
  if (buildCounterDictlayerdataDictWordsExamplesSource < 3) {
    unittest.expect(o.attribution, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsExamplesSource--;
}

core.int buildCounterDictlayerdataDictWordsExamples = 0;
buildDictlayerdataDictWordsExamples() {
  var o = new api.DictlayerdataDictWordsExamples();
  buildCounterDictlayerdataDictWordsExamples++;
  if (buildCounterDictlayerdataDictWordsExamples < 3) {
    o.source = buildDictlayerdataDictWordsExamplesSource();
    o.text = "foo";
  }
  buildCounterDictlayerdataDictWordsExamples--;
  return o;
}

checkDictlayerdataDictWordsExamples(api.DictlayerdataDictWordsExamples o) {
  buildCounterDictlayerdataDictWordsExamples++;
  if (buildCounterDictlayerdataDictWordsExamples < 3) {
    checkDictlayerdataDictWordsExamplesSource(o.source);
    unittest.expect(o.text, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsExamples--;
}

buildUnnamed799() {
  var o = new core.List<api.DictlayerdataDictWordsExamples>();
  o.add(buildDictlayerdataDictWordsExamples());
  o.add(buildDictlayerdataDictWordsExamples());
  return o;
}

checkUnnamed799(core.List<api.DictlayerdataDictWordsExamples> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDictlayerdataDictWordsExamples(o[0]);
  checkDictlayerdataDictWordsExamples(o[1]);
}

core.int buildCounterDictlayerdataDictWordsSensesConjugations = 0;
buildDictlayerdataDictWordsSensesConjugations() {
  var o = new api.DictlayerdataDictWordsSensesConjugations();
  buildCounterDictlayerdataDictWordsSensesConjugations++;
  if (buildCounterDictlayerdataDictWordsSensesConjugations < 3) {
    o.type = "foo";
    o.value = "foo";
  }
  buildCounterDictlayerdataDictWordsSensesConjugations--;
  return o;
}

checkDictlayerdataDictWordsSensesConjugations(api.DictlayerdataDictWordsSensesConjugations o) {
  buildCounterDictlayerdataDictWordsSensesConjugations++;
  if (buildCounterDictlayerdataDictWordsSensesConjugations < 3) {
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsSensesConjugations--;
}

buildUnnamed800() {
  var o = new core.List<api.DictlayerdataDictWordsSensesConjugations>();
  o.add(buildDictlayerdataDictWordsSensesConjugations());
  o.add(buildDictlayerdataDictWordsSensesConjugations());
  return o;
}

checkUnnamed800(core.List<api.DictlayerdataDictWordsSensesConjugations> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDictlayerdataDictWordsSensesConjugations(o[0]);
  checkDictlayerdataDictWordsSensesConjugations(o[1]);
}

core.int buildCounterDictlayerdataDictWordsSensesDefinitionsExamplesSource = 0;
buildDictlayerdataDictWordsSensesDefinitionsExamplesSource() {
  var o = new api.DictlayerdataDictWordsSensesDefinitionsExamplesSource();
  buildCounterDictlayerdataDictWordsSensesDefinitionsExamplesSource++;
  if (buildCounterDictlayerdataDictWordsSensesDefinitionsExamplesSource < 3) {
    o.attribution = "foo";
    o.url = "foo";
  }
  buildCounterDictlayerdataDictWordsSensesDefinitionsExamplesSource--;
  return o;
}

checkDictlayerdataDictWordsSensesDefinitionsExamplesSource(api.DictlayerdataDictWordsSensesDefinitionsExamplesSource o) {
  buildCounterDictlayerdataDictWordsSensesDefinitionsExamplesSource++;
  if (buildCounterDictlayerdataDictWordsSensesDefinitionsExamplesSource < 3) {
    unittest.expect(o.attribution, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsSensesDefinitionsExamplesSource--;
}

core.int buildCounterDictlayerdataDictWordsSensesDefinitionsExamples = 0;
buildDictlayerdataDictWordsSensesDefinitionsExamples() {
  var o = new api.DictlayerdataDictWordsSensesDefinitionsExamples();
  buildCounterDictlayerdataDictWordsSensesDefinitionsExamples++;
  if (buildCounterDictlayerdataDictWordsSensesDefinitionsExamples < 3) {
    o.source = buildDictlayerdataDictWordsSensesDefinitionsExamplesSource();
    o.text = "foo";
  }
  buildCounterDictlayerdataDictWordsSensesDefinitionsExamples--;
  return o;
}

checkDictlayerdataDictWordsSensesDefinitionsExamples(api.DictlayerdataDictWordsSensesDefinitionsExamples o) {
  buildCounterDictlayerdataDictWordsSensesDefinitionsExamples++;
  if (buildCounterDictlayerdataDictWordsSensesDefinitionsExamples < 3) {
    checkDictlayerdataDictWordsSensesDefinitionsExamplesSource(o.source);
    unittest.expect(o.text, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsSensesDefinitionsExamples--;
}

buildUnnamed801() {
  var o = new core.List<api.DictlayerdataDictWordsSensesDefinitionsExamples>();
  o.add(buildDictlayerdataDictWordsSensesDefinitionsExamples());
  o.add(buildDictlayerdataDictWordsSensesDefinitionsExamples());
  return o;
}

checkUnnamed801(core.List<api.DictlayerdataDictWordsSensesDefinitionsExamples> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDictlayerdataDictWordsSensesDefinitionsExamples(o[0]);
  checkDictlayerdataDictWordsSensesDefinitionsExamples(o[1]);
}

core.int buildCounterDictlayerdataDictWordsSensesDefinitions = 0;
buildDictlayerdataDictWordsSensesDefinitions() {
  var o = new api.DictlayerdataDictWordsSensesDefinitions();
  buildCounterDictlayerdataDictWordsSensesDefinitions++;
  if (buildCounterDictlayerdataDictWordsSensesDefinitions < 3) {
    o.definition = "foo";
    o.examples = buildUnnamed801();
  }
  buildCounterDictlayerdataDictWordsSensesDefinitions--;
  return o;
}

checkDictlayerdataDictWordsSensesDefinitions(api.DictlayerdataDictWordsSensesDefinitions o) {
  buildCounterDictlayerdataDictWordsSensesDefinitions++;
  if (buildCounterDictlayerdataDictWordsSensesDefinitions < 3) {
    unittest.expect(o.definition, unittest.equals('foo'));
    checkUnnamed801(o.examples);
  }
  buildCounterDictlayerdataDictWordsSensesDefinitions--;
}

buildUnnamed802() {
  var o = new core.List<api.DictlayerdataDictWordsSensesDefinitions>();
  o.add(buildDictlayerdataDictWordsSensesDefinitions());
  o.add(buildDictlayerdataDictWordsSensesDefinitions());
  return o;
}

checkUnnamed802(core.List<api.DictlayerdataDictWordsSensesDefinitions> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDictlayerdataDictWordsSensesDefinitions(o[0]);
  checkDictlayerdataDictWordsSensesDefinitions(o[1]);
}

core.int buildCounterDictlayerdataDictWordsSensesSource = 0;
buildDictlayerdataDictWordsSensesSource() {
  var o = new api.DictlayerdataDictWordsSensesSource();
  buildCounterDictlayerdataDictWordsSensesSource++;
  if (buildCounterDictlayerdataDictWordsSensesSource < 3) {
    o.attribution = "foo";
    o.url = "foo";
  }
  buildCounterDictlayerdataDictWordsSensesSource--;
  return o;
}

checkDictlayerdataDictWordsSensesSource(api.DictlayerdataDictWordsSensesSource o) {
  buildCounterDictlayerdataDictWordsSensesSource++;
  if (buildCounterDictlayerdataDictWordsSensesSource < 3) {
    unittest.expect(o.attribution, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsSensesSource--;
}

core.int buildCounterDictlayerdataDictWordsSensesSynonymsSource = 0;
buildDictlayerdataDictWordsSensesSynonymsSource() {
  var o = new api.DictlayerdataDictWordsSensesSynonymsSource();
  buildCounterDictlayerdataDictWordsSensesSynonymsSource++;
  if (buildCounterDictlayerdataDictWordsSensesSynonymsSource < 3) {
    o.attribution = "foo";
    o.url = "foo";
  }
  buildCounterDictlayerdataDictWordsSensesSynonymsSource--;
  return o;
}

checkDictlayerdataDictWordsSensesSynonymsSource(api.DictlayerdataDictWordsSensesSynonymsSource o) {
  buildCounterDictlayerdataDictWordsSensesSynonymsSource++;
  if (buildCounterDictlayerdataDictWordsSensesSynonymsSource < 3) {
    unittest.expect(o.attribution, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsSensesSynonymsSource--;
}

core.int buildCounterDictlayerdataDictWordsSensesSynonyms = 0;
buildDictlayerdataDictWordsSensesSynonyms() {
  var o = new api.DictlayerdataDictWordsSensesSynonyms();
  buildCounterDictlayerdataDictWordsSensesSynonyms++;
  if (buildCounterDictlayerdataDictWordsSensesSynonyms < 3) {
    o.source = buildDictlayerdataDictWordsSensesSynonymsSource();
    o.text = "foo";
  }
  buildCounterDictlayerdataDictWordsSensesSynonyms--;
  return o;
}

checkDictlayerdataDictWordsSensesSynonyms(api.DictlayerdataDictWordsSensesSynonyms o) {
  buildCounterDictlayerdataDictWordsSensesSynonyms++;
  if (buildCounterDictlayerdataDictWordsSensesSynonyms < 3) {
    checkDictlayerdataDictWordsSensesSynonymsSource(o.source);
    unittest.expect(o.text, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsSensesSynonyms--;
}

buildUnnamed803() {
  var o = new core.List<api.DictlayerdataDictWordsSensesSynonyms>();
  o.add(buildDictlayerdataDictWordsSensesSynonyms());
  o.add(buildDictlayerdataDictWordsSensesSynonyms());
  return o;
}

checkUnnamed803(core.List<api.DictlayerdataDictWordsSensesSynonyms> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDictlayerdataDictWordsSensesSynonyms(o[0]);
  checkDictlayerdataDictWordsSensesSynonyms(o[1]);
}

core.int buildCounterDictlayerdataDictWordsSenses = 0;
buildDictlayerdataDictWordsSenses() {
  var o = new api.DictlayerdataDictWordsSenses();
  buildCounterDictlayerdataDictWordsSenses++;
  if (buildCounterDictlayerdataDictWordsSenses < 3) {
    o.conjugations = buildUnnamed800();
    o.definitions = buildUnnamed802();
    o.partOfSpeech = "foo";
    o.pronunciation = "foo";
    o.pronunciationUrl = "foo";
    o.source = buildDictlayerdataDictWordsSensesSource();
    o.syllabification = "foo";
    o.synonyms = buildUnnamed803();
  }
  buildCounterDictlayerdataDictWordsSenses--;
  return o;
}

checkDictlayerdataDictWordsSenses(api.DictlayerdataDictWordsSenses o) {
  buildCounterDictlayerdataDictWordsSenses++;
  if (buildCounterDictlayerdataDictWordsSenses < 3) {
    checkUnnamed800(o.conjugations);
    checkUnnamed802(o.definitions);
    unittest.expect(o.partOfSpeech, unittest.equals('foo'));
    unittest.expect(o.pronunciation, unittest.equals('foo'));
    unittest.expect(o.pronunciationUrl, unittest.equals('foo'));
    checkDictlayerdataDictWordsSensesSource(o.source);
    unittest.expect(o.syllabification, unittest.equals('foo'));
    checkUnnamed803(o.synonyms);
  }
  buildCounterDictlayerdataDictWordsSenses--;
}

buildUnnamed804() {
  var o = new core.List<api.DictlayerdataDictWordsSenses>();
  o.add(buildDictlayerdataDictWordsSenses());
  o.add(buildDictlayerdataDictWordsSenses());
  return o;
}

checkUnnamed804(core.List<api.DictlayerdataDictWordsSenses> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDictlayerdataDictWordsSenses(o[0]);
  checkDictlayerdataDictWordsSenses(o[1]);
}

core.int buildCounterDictlayerdataDictWordsSource = 0;
buildDictlayerdataDictWordsSource() {
  var o = new api.DictlayerdataDictWordsSource();
  buildCounterDictlayerdataDictWordsSource++;
  if (buildCounterDictlayerdataDictWordsSource < 3) {
    o.attribution = "foo";
    o.url = "foo";
  }
  buildCounterDictlayerdataDictWordsSource--;
  return o;
}

checkDictlayerdataDictWordsSource(api.DictlayerdataDictWordsSource o) {
  buildCounterDictlayerdataDictWordsSource++;
  if (buildCounterDictlayerdataDictWordsSource < 3) {
    unittest.expect(o.attribution, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterDictlayerdataDictWordsSource--;
}

core.int buildCounterDictlayerdataDictWords = 0;
buildDictlayerdataDictWords() {
  var o = new api.DictlayerdataDictWords();
  buildCounterDictlayerdataDictWords++;
  if (buildCounterDictlayerdataDictWords < 3) {
    o.derivatives = buildUnnamed798();
    o.examples = buildUnnamed799();
    o.senses = buildUnnamed804();
    o.source = buildDictlayerdataDictWordsSource();
  }
  buildCounterDictlayerdataDictWords--;
  return o;
}

checkDictlayerdataDictWords(api.DictlayerdataDictWords o) {
  buildCounterDictlayerdataDictWords++;
  if (buildCounterDictlayerdataDictWords < 3) {
    checkUnnamed798(o.derivatives);
    checkUnnamed799(o.examples);
    checkUnnamed804(o.senses);
    checkDictlayerdataDictWordsSource(o.source);
  }
  buildCounterDictlayerdataDictWords--;
}

buildUnnamed805() {
  var o = new core.List<api.DictlayerdataDictWords>();
  o.add(buildDictlayerdataDictWords());
  o.add(buildDictlayerdataDictWords());
  return o;
}

checkUnnamed805(core.List<api.DictlayerdataDictWords> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDictlayerdataDictWords(o[0]);
  checkDictlayerdataDictWords(o[1]);
}

core.int buildCounterDictlayerdataDict = 0;
buildDictlayerdataDict() {
  var o = new api.DictlayerdataDict();
  buildCounterDictlayerdataDict++;
  if (buildCounterDictlayerdataDict < 3) {
    o.source = buildDictlayerdataDictSource();
    o.words = buildUnnamed805();
  }
  buildCounterDictlayerdataDict--;
  return o;
}

checkDictlayerdataDict(api.DictlayerdataDict o) {
  buildCounterDictlayerdataDict++;
  if (buildCounterDictlayerdataDict < 3) {
    checkDictlayerdataDictSource(o.source);
    checkUnnamed805(o.words);
  }
  buildCounterDictlayerdataDict--;
}

core.int buildCounterDictlayerdata = 0;
buildDictlayerdata() {
  var o = new api.Dictlayerdata();
  buildCounterDictlayerdata++;
  if (buildCounterDictlayerdata < 3) {
    o.common = buildDictlayerdataCommon();
    o.dict = buildDictlayerdataDict();
    o.kind = "foo";
  }
  buildCounterDictlayerdata--;
  return o;
}

checkDictlayerdata(api.Dictlayerdata o) {
  buildCounterDictlayerdata++;
  if (buildCounterDictlayerdata < 3) {
    checkDictlayerdataCommon(o.common);
    checkDictlayerdataDict(o.dict);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterDictlayerdata--;
}

core.int buildCounterDiscoveryclustersClustersBannerWithContentContainer = 0;
buildDiscoveryclustersClustersBannerWithContentContainer() {
  var o = new api.DiscoveryclustersClustersBannerWithContentContainer();
  buildCounterDiscoveryclustersClustersBannerWithContentContainer++;
  if (buildCounterDiscoveryclustersClustersBannerWithContentContainer < 3) {
    o.fillColorArgb = "foo";
    o.imageUrl = "foo";
    o.maskColorArgb = "foo";
    o.moreButtonText = "foo";
    o.moreButtonUrl = "foo";
    o.textColorArgb = "foo";
  }
  buildCounterDiscoveryclustersClustersBannerWithContentContainer--;
  return o;
}

checkDiscoveryclustersClustersBannerWithContentContainer(api.DiscoveryclustersClustersBannerWithContentContainer o) {
  buildCounterDiscoveryclustersClustersBannerWithContentContainer++;
  if (buildCounterDiscoveryclustersClustersBannerWithContentContainer < 3) {
    unittest.expect(o.fillColorArgb, unittest.equals('foo'));
    unittest.expect(o.imageUrl, unittest.equals('foo'));
    unittest.expect(o.maskColorArgb, unittest.equals('foo'));
    unittest.expect(o.moreButtonText, unittest.equals('foo'));
    unittest.expect(o.moreButtonUrl, unittest.equals('foo'));
    unittest.expect(o.textColorArgb, unittest.equals('foo'));
  }
  buildCounterDiscoveryclustersClustersBannerWithContentContainer--;
}

buildUnnamed806() {
  var o = new core.List<api.Volume>();
  o.add(buildVolume());
  o.add(buildVolume());
  return o;
}

checkUnnamed806(core.List<api.Volume> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVolume(o[0]);
  checkVolume(o[1]);
}

core.int buildCounterDiscoveryclustersClusters = 0;
buildDiscoveryclustersClusters() {
  var o = new api.DiscoveryclustersClusters();
  buildCounterDiscoveryclustersClusters++;
  if (buildCounterDiscoveryclustersClusters < 3) {
    o.bannerWithContentContainer = buildDiscoveryclustersClustersBannerWithContentContainer();
    o.subTitle = "foo";
    o.title = "foo";
    o.totalVolumes = 42;
    o.uid = "foo";
    o.volumes = buildUnnamed806();
  }
  buildCounterDiscoveryclustersClusters--;
  return o;
}

checkDiscoveryclustersClusters(api.DiscoveryclustersClusters o) {
  buildCounterDiscoveryclustersClusters++;
  if (buildCounterDiscoveryclustersClusters < 3) {
    checkDiscoveryclustersClustersBannerWithContentContainer(o.bannerWithContentContainer);
    unittest.expect(o.subTitle, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.totalVolumes, unittest.equals(42));
    unittest.expect(o.uid, unittest.equals('foo'));
    checkUnnamed806(o.volumes);
  }
  buildCounterDiscoveryclustersClusters--;
}

buildUnnamed807() {
  var o = new core.List<api.DiscoveryclustersClusters>();
  o.add(buildDiscoveryclustersClusters());
  o.add(buildDiscoveryclustersClusters());
  return o;
}

checkUnnamed807(core.List<api.DiscoveryclustersClusters> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDiscoveryclustersClusters(o[0]);
  checkDiscoveryclustersClusters(o[1]);
}

core.int buildCounterDiscoveryclusters = 0;
buildDiscoveryclusters() {
  var o = new api.Discoveryclusters();
  buildCounterDiscoveryclusters++;
  if (buildCounterDiscoveryclusters < 3) {
    o.clusters = buildUnnamed807();
    o.kind = "foo";
    o.totalClusters = 42;
  }
  buildCounterDiscoveryclusters--;
  return o;
}

checkDiscoveryclusters(api.Discoveryclusters o) {
  buildCounterDiscoveryclusters++;
  if (buildCounterDiscoveryclusters < 3) {
    checkUnnamed807(o.clusters);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.totalClusters, unittest.equals(42));
  }
  buildCounterDiscoveryclusters--;
}

core.int buildCounterDownloadAccessRestriction = 0;
buildDownloadAccessRestriction() {
  var o = new api.DownloadAccessRestriction();
  buildCounterDownloadAccessRestriction++;
  if (buildCounterDownloadAccessRestriction < 3) {
    o.deviceAllowed = true;
    o.downloadsAcquired = 42;
    o.justAcquired = true;
    o.kind = "foo";
    o.maxDownloadDevices = 42;
    o.message = "foo";
    o.nonce = "foo";
    o.reasonCode = "foo";
    o.restricted = true;
    o.signature = "foo";
    o.source = "foo";
    o.volumeId = "foo";
  }
  buildCounterDownloadAccessRestriction--;
  return o;
}

checkDownloadAccessRestriction(api.DownloadAccessRestriction o) {
  buildCounterDownloadAccessRestriction++;
  if (buildCounterDownloadAccessRestriction < 3) {
    unittest.expect(o.deviceAllowed, unittest.isTrue);
    unittest.expect(o.downloadsAcquired, unittest.equals(42));
    unittest.expect(o.justAcquired, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.maxDownloadDevices, unittest.equals(42));
    unittest.expect(o.message, unittest.equals('foo'));
    unittest.expect(o.nonce, unittest.equals('foo'));
    unittest.expect(o.reasonCode, unittest.equals('foo'));
    unittest.expect(o.restricted, unittest.isTrue);
    unittest.expect(o.signature, unittest.equals('foo'));
    unittest.expect(o.source, unittest.equals('foo'));
    unittest.expect(o.volumeId, unittest.equals('foo'));
  }
  buildCounterDownloadAccessRestriction--;
}

buildUnnamed808() {
  var o = new core.List<api.DownloadAccessRestriction>();
  o.add(buildDownloadAccessRestriction());
  o.add(buildDownloadAccessRestriction());
  return o;
}

checkUnnamed808(core.List<api.DownloadAccessRestriction> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDownloadAccessRestriction(o[0]);
  checkDownloadAccessRestriction(o[1]);
}

core.int buildCounterDownloadAccesses = 0;
buildDownloadAccesses() {
  var o = new api.DownloadAccesses();
  buildCounterDownloadAccesses++;
  if (buildCounterDownloadAccesses < 3) {
    o.downloadAccessList = buildUnnamed808();
    o.kind = "foo";
  }
  buildCounterDownloadAccesses--;
  return o;
}

checkDownloadAccesses(api.DownloadAccesses o) {
  buildCounterDownloadAccesses++;
  if (buildCounterDownloadAccesses < 3) {
    checkUnnamed808(o.downloadAccessList);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterDownloadAccesses--;
}

core.int buildCounterGeolayerdataCommon = 0;
buildGeolayerdataCommon() {
  var o = new api.GeolayerdataCommon();
  buildCounterGeolayerdataCommon++;
  if (buildCounterGeolayerdataCommon < 3) {
    o.lang = "foo";
    o.previewImageUrl = "foo";
    o.snippet = "foo";
    o.snippetUrl = "foo";
    o.title = "foo";
  }
  buildCounterGeolayerdataCommon--;
  return o;
}

checkGeolayerdataCommon(api.GeolayerdataCommon o) {
  buildCounterGeolayerdataCommon++;
  if (buildCounterGeolayerdataCommon < 3) {
    unittest.expect(o.lang, unittest.equals('foo'));
    unittest.expect(o.previewImageUrl, unittest.equals('foo'));
    unittest.expect(o.snippet, unittest.equals('foo'));
    unittest.expect(o.snippetUrl, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterGeolayerdataCommon--;
}

core.int buildCounterGeolayerdataGeoBoundary = 0;
buildGeolayerdataGeoBoundary() {
  var o = new api.GeolayerdataGeoBoundary();
  buildCounterGeolayerdataGeoBoundary++;
  if (buildCounterGeolayerdataGeoBoundary < 3) {
    o.latitude = 42;
    o.longitude = 42;
  }
  buildCounterGeolayerdataGeoBoundary--;
  return o;
}

checkGeolayerdataGeoBoundary(api.GeolayerdataGeoBoundary o) {
  buildCounterGeolayerdataGeoBoundary++;
  if (buildCounterGeolayerdataGeoBoundary < 3) {
    unittest.expect(o.latitude, unittest.equals(42));
    unittest.expect(o.longitude, unittest.equals(42));
  }
  buildCounterGeolayerdataGeoBoundary--;
}

buildUnnamed809() {
  var o = new core.List<api.GeolayerdataGeoBoundary>();
  o.add(buildGeolayerdataGeoBoundary());
  o.add(buildGeolayerdataGeoBoundary());
  return o;
}

checkUnnamed809(core.List<api.GeolayerdataGeoBoundary> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGeolayerdataGeoBoundary(o[0]);
  checkGeolayerdataGeoBoundary(o[1]);
}

buildUnnamed810() {
  var o = new core.List<core.List<api.GeolayerdataGeoBoundary>>();
  o.add(buildUnnamed809());
  o.add(buildUnnamed809());
  return o;
}

checkUnnamed810(core.List<core.List<api.GeolayerdataGeoBoundary>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed809(o[0]);
  checkUnnamed809(o[1]);
}

core.int buildCounterGeolayerdataGeoViewportHi = 0;
buildGeolayerdataGeoViewportHi() {
  var o = new api.GeolayerdataGeoViewportHi();
  buildCounterGeolayerdataGeoViewportHi++;
  if (buildCounterGeolayerdataGeoViewportHi < 3) {
    o.latitude = 42.0;
    o.longitude = 42.0;
  }
  buildCounterGeolayerdataGeoViewportHi--;
  return o;
}

checkGeolayerdataGeoViewportHi(api.GeolayerdataGeoViewportHi o) {
  buildCounterGeolayerdataGeoViewportHi++;
  if (buildCounterGeolayerdataGeoViewportHi < 3) {
    unittest.expect(o.latitude, unittest.equals(42.0));
    unittest.expect(o.longitude, unittest.equals(42.0));
  }
  buildCounterGeolayerdataGeoViewportHi--;
}

core.int buildCounterGeolayerdataGeoViewportLo = 0;
buildGeolayerdataGeoViewportLo() {
  var o = new api.GeolayerdataGeoViewportLo();
  buildCounterGeolayerdataGeoViewportLo++;
  if (buildCounterGeolayerdataGeoViewportLo < 3) {
    o.latitude = 42.0;
    o.longitude = 42.0;
  }
  buildCounterGeolayerdataGeoViewportLo--;
  return o;
}

checkGeolayerdataGeoViewportLo(api.GeolayerdataGeoViewportLo o) {
  buildCounterGeolayerdataGeoViewportLo++;
  if (buildCounterGeolayerdataGeoViewportLo < 3) {
    unittest.expect(o.latitude, unittest.equals(42.0));
    unittest.expect(o.longitude, unittest.equals(42.0));
  }
  buildCounterGeolayerdataGeoViewportLo--;
}

core.int buildCounterGeolayerdataGeoViewport = 0;
buildGeolayerdataGeoViewport() {
  var o = new api.GeolayerdataGeoViewport();
  buildCounterGeolayerdataGeoViewport++;
  if (buildCounterGeolayerdataGeoViewport < 3) {
    o.hi = buildGeolayerdataGeoViewportHi();
    o.lo = buildGeolayerdataGeoViewportLo();
  }
  buildCounterGeolayerdataGeoViewport--;
  return o;
}

checkGeolayerdataGeoViewport(api.GeolayerdataGeoViewport o) {
  buildCounterGeolayerdataGeoViewport++;
  if (buildCounterGeolayerdataGeoViewport < 3) {
    checkGeolayerdataGeoViewportHi(o.hi);
    checkGeolayerdataGeoViewportLo(o.lo);
  }
  buildCounterGeolayerdataGeoViewport--;
}

core.int buildCounterGeolayerdataGeo = 0;
buildGeolayerdataGeo() {
  var o = new api.GeolayerdataGeo();
  buildCounterGeolayerdataGeo++;
  if (buildCounterGeolayerdataGeo < 3) {
    o.boundary = buildUnnamed810();
    o.cachePolicy = "foo";
    o.countryCode = "foo";
    o.latitude = 42.0;
    o.longitude = 42.0;
    o.mapType = "foo";
    o.viewport = buildGeolayerdataGeoViewport();
    o.zoom = 42;
  }
  buildCounterGeolayerdataGeo--;
  return o;
}

checkGeolayerdataGeo(api.GeolayerdataGeo o) {
  buildCounterGeolayerdataGeo++;
  if (buildCounterGeolayerdataGeo < 3) {
    checkUnnamed810(o.boundary);
    unittest.expect(o.cachePolicy, unittest.equals('foo'));
    unittest.expect(o.countryCode, unittest.equals('foo'));
    unittest.expect(o.latitude, unittest.equals(42.0));
    unittest.expect(o.longitude, unittest.equals(42.0));
    unittest.expect(o.mapType, unittest.equals('foo'));
    checkGeolayerdataGeoViewport(o.viewport);
    unittest.expect(o.zoom, unittest.equals(42));
  }
  buildCounterGeolayerdataGeo--;
}

core.int buildCounterGeolayerdata = 0;
buildGeolayerdata() {
  var o = new api.Geolayerdata();
  buildCounterGeolayerdata++;
  if (buildCounterGeolayerdata < 3) {
    o.common = buildGeolayerdataCommon();
    o.geo = buildGeolayerdataGeo();
    o.kind = "foo";
  }
  buildCounterGeolayerdata--;
  return o;
}

checkGeolayerdata(api.Geolayerdata o) {
  buildCounterGeolayerdata++;
  if (buildCounterGeolayerdata < 3) {
    checkGeolayerdataCommon(o.common);
    checkGeolayerdataGeo(o.geo);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterGeolayerdata--;
}

buildUnnamed811() {
  var o = new core.List<api.Layersummary>();
  o.add(buildLayersummary());
  o.add(buildLayersummary());
  return o;
}

checkUnnamed811(core.List<api.Layersummary> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLayersummary(o[0]);
  checkLayersummary(o[1]);
}

core.int buildCounterLayersummaries = 0;
buildLayersummaries() {
  var o = new api.Layersummaries();
  buildCounterLayersummaries++;
  if (buildCounterLayersummaries < 3) {
    o.items = buildUnnamed811();
    o.kind = "foo";
    o.totalItems = 42;
  }
  buildCounterLayersummaries--;
  return o;
}

checkLayersummaries(api.Layersummaries o) {
  buildCounterLayersummaries++;
  if (buildCounterLayersummaries < 3) {
    checkUnnamed811(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterLayersummaries--;
}

buildUnnamed812() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed812(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterLayersummary = 0;
buildLayersummary() {
  var o = new api.Layersummary();
  buildCounterLayersummary++;
  if (buildCounterLayersummary < 3) {
    o.annotationCount = 42;
    o.annotationTypes = buildUnnamed812();
    o.annotationsDataLink = "foo";
    o.annotationsLink = "foo";
    o.contentVersion = "foo";
    o.dataCount = 42;
    o.id = "foo";
    o.kind = "foo";
    o.layerId = "foo";
    o.selfLink = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.volumeAnnotationsVersion = "foo";
    o.volumeId = "foo";
  }
  buildCounterLayersummary--;
  return o;
}

checkLayersummary(api.Layersummary o) {
  buildCounterLayersummary++;
  if (buildCounterLayersummary < 3) {
    unittest.expect(o.annotationCount, unittest.equals(42));
    checkUnnamed812(o.annotationTypes);
    unittest.expect(o.annotationsDataLink, unittest.equals('foo'));
    unittest.expect(o.annotationsLink, unittest.equals('foo'));
    unittest.expect(o.contentVersion, unittest.equals('foo'));
    unittest.expect(o.dataCount, unittest.equals(42));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.layerId, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.volumeAnnotationsVersion, unittest.equals('foo'));
    unittest.expect(o.volumeId, unittest.equals('foo'));
  }
  buildCounterLayersummary--;
}

core.int buildCounterMetadataItems = 0;
buildMetadataItems() {
  var o = new api.MetadataItems();
  buildCounterMetadataItems++;
  if (buildCounterMetadataItems < 3) {
    o.downloadUrl = "foo";
    o.encryptedKey = "foo";
    o.language = "foo";
    o.size = "foo";
    o.version = "foo";
  }
  buildCounterMetadataItems--;
  return o;
}

checkMetadataItems(api.MetadataItems o) {
  buildCounterMetadataItems++;
  if (buildCounterMetadataItems < 3) {
    unittest.expect(o.downloadUrl, unittest.equals('foo'));
    unittest.expect(o.encryptedKey, unittest.equals('foo'));
    unittest.expect(o.language, unittest.equals('foo'));
    unittest.expect(o.size, unittest.equals('foo'));
    unittest.expect(o.version, unittest.equals('foo'));
  }
  buildCounterMetadataItems--;
}

buildUnnamed813() {
  var o = new core.List<api.MetadataItems>();
  o.add(buildMetadataItems());
  o.add(buildMetadataItems());
  return o;
}

checkUnnamed813(core.List<api.MetadataItems> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetadataItems(o[0]);
  checkMetadataItems(o[1]);
}

core.int buildCounterMetadata = 0;
buildMetadata() {
  var o = new api.Metadata();
  buildCounterMetadata++;
  if (buildCounterMetadata < 3) {
    o.items = buildUnnamed813();
    o.kind = "foo";
  }
  buildCounterMetadata--;
  return o;
}

checkMetadata(api.Metadata o) {
  buildCounterMetadata++;
  if (buildCounterMetadata < 3) {
    checkUnnamed813(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterMetadata--;
}

buildUnnamed814() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed814(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterNotification = 0;
buildNotification() {
  var o = new api.Notification();
  buildCounterNotification++;
  if (buildCounterNotification < 3) {
    o.body = "foo";
    o.crmExperimentIds = buildUnnamed814();
    o.docId = "foo";
    o.docType = "foo";
    o.dontShowNotification = true;
    o.iconUrl = "foo";
    o.kind = "foo";
    o.notificationGroup = "foo";
    o.notificationType = "foo";
    o.pcampaignId = "foo";
    o.reason = "foo";
    o.showNotificationSettingsAction = true;
    o.targetUrl = "foo";
    o.title = "foo";
  }
  buildCounterNotification--;
  return o;
}

checkNotification(api.Notification o) {
  buildCounterNotification++;
  if (buildCounterNotification < 3) {
    unittest.expect(o.body, unittest.equals('foo'));
    checkUnnamed814(o.crmExperimentIds);
    unittest.expect(o.docId, unittest.equals('foo'));
    unittest.expect(o.docType, unittest.equals('foo'));
    unittest.expect(o.dontShowNotification, unittest.isTrue);
    unittest.expect(o.iconUrl, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.notificationGroup, unittest.equals('foo'));
    unittest.expect(o.notificationType, unittest.equals('foo'));
    unittest.expect(o.pcampaignId, unittest.equals('foo'));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.showNotificationSettingsAction, unittest.isTrue);
    unittest.expect(o.targetUrl, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterNotification--;
}

core.int buildCounterOffersItemsItems = 0;
buildOffersItemsItems() {
  var o = new api.OffersItemsItems();
  buildCounterOffersItemsItems++;
  if (buildCounterOffersItemsItems < 3) {
    o.author = "foo";
    o.canonicalVolumeLink = "foo";
    o.coverUrl = "foo";
    o.description = "foo";
    o.title = "foo";
    o.volumeId = "foo";
  }
  buildCounterOffersItemsItems--;
  return o;
}

checkOffersItemsItems(api.OffersItemsItems o) {
  buildCounterOffersItemsItems++;
  if (buildCounterOffersItemsItems < 3) {
    unittest.expect(o.author, unittest.equals('foo'));
    unittest.expect(o.canonicalVolumeLink, unittest.equals('foo'));
    unittest.expect(o.coverUrl, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.volumeId, unittest.equals('foo'));
  }
  buildCounterOffersItemsItems--;
}

buildUnnamed815() {
  var o = new core.List<api.OffersItemsItems>();
  o.add(buildOffersItemsItems());
  o.add(buildOffersItemsItems());
  return o;
}

checkUnnamed815(core.List<api.OffersItemsItems> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOffersItemsItems(o[0]);
  checkOffersItemsItems(o[1]);
}

core.int buildCounterOffersItems = 0;
buildOffersItems() {
  var o = new api.OffersItems();
  buildCounterOffersItems++;
  if (buildCounterOffersItems < 3) {
    o.artUrl = "foo";
    o.gservicesKey = "foo";
    o.id = "foo";
    o.items = buildUnnamed815();
  }
  buildCounterOffersItems--;
  return o;
}

checkOffersItems(api.OffersItems o) {
  buildCounterOffersItems++;
  if (buildCounterOffersItems < 3) {
    unittest.expect(o.artUrl, unittest.equals('foo'));
    unittest.expect(o.gservicesKey, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed815(o.items);
  }
  buildCounterOffersItems--;
}

buildUnnamed816() {
  var o = new core.List<api.OffersItems>();
  o.add(buildOffersItems());
  o.add(buildOffersItems());
  return o;
}

checkUnnamed816(core.List<api.OffersItems> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOffersItems(o[0]);
  checkOffersItems(o[1]);
}

core.int buildCounterOffers = 0;
buildOffers() {
  var o = new api.Offers();
  buildCounterOffers++;
  if (buildCounterOffers < 3) {
    o.items = buildUnnamed816();
    o.kind = "foo";
  }
  buildCounterOffers--;
  return o;
}

checkOffers(api.Offers o) {
  buildCounterOffers++;
  if (buildCounterOffers < 3) {
    checkUnnamed816(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterOffers--;
}

core.int buildCounterReadingPosition = 0;
buildReadingPosition() {
  var o = new api.ReadingPosition();
  buildCounterReadingPosition++;
  if (buildCounterReadingPosition < 3) {
    o.epubCfiPosition = "foo";
    o.gbImagePosition = "foo";
    o.gbTextPosition = "foo";
    o.kind = "foo";
    o.pdfPosition = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.volumeId = "foo";
  }
  buildCounterReadingPosition--;
  return o;
}

checkReadingPosition(api.ReadingPosition o) {
  buildCounterReadingPosition++;
  if (buildCounterReadingPosition < 3) {
    unittest.expect(o.epubCfiPosition, unittest.equals('foo'));
    unittest.expect(o.gbImagePosition, unittest.equals('foo'));
    unittest.expect(o.gbTextPosition, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.pdfPosition, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.volumeId, unittest.equals('foo'));
  }
  buildCounterReadingPosition--;
}

core.int buildCounterRequestAccess = 0;
buildRequestAccess() {
  var o = new api.RequestAccess();
  buildCounterRequestAccess++;
  if (buildCounterRequestAccess < 3) {
    o.concurrentAccess = buildConcurrentAccessRestriction();
    o.downloadAccess = buildDownloadAccessRestriction();
    o.kind = "foo";
  }
  buildCounterRequestAccess--;
  return o;
}

checkRequestAccess(api.RequestAccess o) {
  buildCounterRequestAccess++;
  if (buildCounterRequestAccess < 3) {
    checkConcurrentAccessRestriction(o.concurrentAccess);
    checkDownloadAccessRestriction(o.downloadAccess);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterRequestAccess--;
}

core.int buildCounterReviewAuthor = 0;
buildReviewAuthor() {
  var o = new api.ReviewAuthor();
  buildCounterReviewAuthor++;
  if (buildCounterReviewAuthor < 3) {
    o.displayName = "foo";
  }
  buildCounterReviewAuthor--;
  return o;
}

checkReviewAuthor(api.ReviewAuthor o) {
  buildCounterReviewAuthor++;
  if (buildCounterReviewAuthor < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
  }
  buildCounterReviewAuthor--;
}

core.int buildCounterReviewSource = 0;
buildReviewSource() {
  var o = new api.ReviewSource();
  buildCounterReviewSource++;
  if (buildCounterReviewSource < 3) {
    o.description = "foo";
    o.extraDescription = "foo";
    o.url = "foo";
  }
  buildCounterReviewSource--;
  return o;
}

checkReviewSource(api.ReviewSource o) {
  buildCounterReviewSource++;
  if (buildCounterReviewSource < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.extraDescription, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterReviewSource--;
}

core.int buildCounterReview = 0;
buildReview() {
  var o = new api.Review();
  buildCounterReview++;
  if (buildCounterReview < 3) {
    o.author = buildReviewAuthor();
    o.content = "foo";
    o.date = "foo";
    o.fullTextUrl = "foo";
    o.kind = "foo";
    o.rating = "foo";
    o.source = buildReviewSource();
    o.title = "foo";
    o.type = "foo";
    o.volumeId = "foo";
  }
  buildCounterReview--;
  return o;
}

checkReview(api.Review o) {
  buildCounterReview++;
  if (buildCounterReview < 3) {
    checkReviewAuthor(o.author);
    unittest.expect(o.content, unittest.equals('foo'));
    unittest.expect(o.date, unittest.equals('foo'));
    unittest.expect(o.fullTextUrl, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.rating, unittest.equals('foo'));
    checkReviewSource(o.source);
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.volumeId, unittest.equals('foo'));
  }
  buildCounterReview--;
}

core.int buildCounterSeriesSeries = 0;
buildSeriesSeries() {
  var o = new api.SeriesSeries();
  buildCounterSeriesSeries++;
  if (buildCounterSeriesSeries < 3) {
    o.bannerImageUrl = "foo";
    o.imageUrl = "foo";
    o.seriesId = "foo";
    o.seriesType = "foo";
    o.title = "foo";
  }
  buildCounterSeriesSeries--;
  return o;
}

checkSeriesSeries(api.SeriesSeries o) {
  buildCounterSeriesSeries++;
  if (buildCounterSeriesSeries < 3) {
    unittest.expect(o.bannerImageUrl, unittest.equals('foo'));
    unittest.expect(o.imageUrl, unittest.equals('foo'));
    unittest.expect(o.seriesId, unittest.equals('foo'));
    unittest.expect(o.seriesType, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterSeriesSeries--;
}

buildUnnamed817() {
  var o = new core.List<api.SeriesSeries>();
  o.add(buildSeriesSeries());
  o.add(buildSeriesSeries());
  return o;
}

checkUnnamed817(core.List<api.SeriesSeries> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSeriesSeries(o[0]);
  checkSeriesSeries(o[1]);
}

core.int buildCounterSeries = 0;
buildSeries() {
  var o = new api.Series();
  buildCounterSeries++;
  if (buildCounterSeries < 3) {
    o.kind = "foo";
    o.series = buildUnnamed817();
  }
  buildCounterSeries--;
  return o;
}

checkSeries(api.Series o) {
  buildCounterSeries++;
  if (buildCounterSeries < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed817(o.series);
  }
  buildCounterSeries--;
}

buildUnnamed818() {
  var o = new core.List<api.Volume>();
  o.add(buildVolume());
  o.add(buildVolume());
  return o;
}

checkUnnamed818(core.List<api.Volume> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVolume(o[0]);
  checkVolume(o[1]);
}

core.int buildCounterSeriesmembership = 0;
buildSeriesmembership() {
  var o = new api.Seriesmembership();
  buildCounterSeriesmembership++;
  if (buildCounterSeriesmembership < 3) {
    o.kind = "foo";
    o.member = buildUnnamed818();
    o.nextPageToken = "foo";
  }
  buildCounterSeriesmembership--;
  return o;
}

checkSeriesmembership(api.Seriesmembership o) {
  buildCounterSeriesmembership++;
  if (buildCounterSeriesmembership < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed818(o.member);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterSeriesmembership--;
}

core.int buildCounterUsersettingsNotesExport = 0;
buildUsersettingsNotesExport() {
  var o = new api.UsersettingsNotesExport();
  buildCounterUsersettingsNotesExport++;
  if (buildCounterUsersettingsNotesExport < 3) {
    o.folderName = "foo";
    o.isEnabled = true;
  }
  buildCounterUsersettingsNotesExport--;
  return o;
}

checkUsersettingsNotesExport(api.UsersettingsNotesExport o) {
  buildCounterUsersettingsNotesExport++;
  if (buildCounterUsersettingsNotesExport < 3) {
    unittest.expect(o.folderName, unittest.equals('foo'));
    unittest.expect(o.isEnabled, unittest.isTrue);
  }
  buildCounterUsersettingsNotesExport--;
}

core.int buildCounterUsersettingsNotificationMoreFromAuthors = 0;
buildUsersettingsNotificationMoreFromAuthors() {
  var o = new api.UsersettingsNotificationMoreFromAuthors();
  buildCounterUsersettingsNotificationMoreFromAuthors++;
  if (buildCounterUsersettingsNotificationMoreFromAuthors < 3) {
    o.optedState = "foo";
  }
  buildCounterUsersettingsNotificationMoreFromAuthors--;
  return o;
}

checkUsersettingsNotificationMoreFromAuthors(api.UsersettingsNotificationMoreFromAuthors o) {
  buildCounterUsersettingsNotificationMoreFromAuthors++;
  if (buildCounterUsersettingsNotificationMoreFromAuthors < 3) {
    unittest.expect(o.optedState, unittest.equals('foo'));
  }
  buildCounterUsersettingsNotificationMoreFromAuthors--;
}

core.int buildCounterUsersettingsNotificationMoreFromSeries = 0;
buildUsersettingsNotificationMoreFromSeries() {
  var o = new api.UsersettingsNotificationMoreFromSeries();
  buildCounterUsersettingsNotificationMoreFromSeries++;
  if (buildCounterUsersettingsNotificationMoreFromSeries < 3) {
    o.optedState = "foo";
  }
  buildCounterUsersettingsNotificationMoreFromSeries--;
  return o;
}

checkUsersettingsNotificationMoreFromSeries(api.UsersettingsNotificationMoreFromSeries o) {
  buildCounterUsersettingsNotificationMoreFromSeries++;
  if (buildCounterUsersettingsNotificationMoreFromSeries < 3) {
    unittest.expect(o.optedState, unittest.equals('foo'));
  }
  buildCounterUsersettingsNotificationMoreFromSeries--;
}

core.int buildCounterUsersettingsNotification = 0;
buildUsersettingsNotification() {
  var o = new api.UsersettingsNotification();
  buildCounterUsersettingsNotification++;
  if (buildCounterUsersettingsNotification < 3) {
    o.moreFromAuthors = buildUsersettingsNotificationMoreFromAuthors();
    o.moreFromSeries = buildUsersettingsNotificationMoreFromSeries();
  }
  buildCounterUsersettingsNotification--;
  return o;
}

checkUsersettingsNotification(api.UsersettingsNotification o) {
  buildCounterUsersettingsNotification++;
  if (buildCounterUsersettingsNotification < 3) {
    checkUsersettingsNotificationMoreFromAuthors(o.moreFromAuthors);
    checkUsersettingsNotificationMoreFromSeries(o.moreFromSeries);
  }
  buildCounterUsersettingsNotification--;
}

core.int buildCounterUsersettings = 0;
buildUsersettings() {
  var o = new api.Usersettings();
  buildCounterUsersettings++;
  if (buildCounterUsersettings < 3) {
    o.kind = "foo";
    o.notesExport = buildUsersettingsNotesExport();
    o.notification = buildUsersettingsNotification();
  }
  buildCounterUsersettings--;
  return o;
}

checkUsersettings(api.Usersettings o) {
  buildCounterUsersettings++;
  if (buildCounterUsersettings < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUsersettingsNotesExport(o.notesExport);
    checkUsersettingsNotification(o.notification);
  }
  buildCounterUsersettings--;
}

core.int buildCounterVolumeAccessInfoEpub = 0;
buildVolumeAccessInfoEpub() {
  var o = new api.VolumeAccessInfoEpub();
  buildCounterVolumeAccessInfoEpub++;
  if (buildCounterVolumeAccessInfoEpub < 3) {
    o.acsTokenLink = "foo";
    o.downloadLink = "foo";
    o.isAvailable = true;
  }
  buildCounterVolumeAccessInfoEpub--;
  return o;
}

checkVolumeAccessInfoEpub(api.VolumeAccessInfoEpub o) {
  buildCounterVolumeAccessInfoEpub++;
  if (buildCounterVolumeAccessInfoEpub < 3) {
    unittest.expect(o.acsTokenLink, unittest.equals('foo'));
    unittest.expect(o.downloadLink, unittest.equals('foo'));
    unittest.expect(o.isAvailable, unittest.isTrue);
  }
  buildCounterVolumeAccessInfoEpub--;
}

core.int buildCounterVolumeAccessInfoPdf = 0;
buildVolumeAccessInfoPdf() {
  var o = new api.VolumeAccessInfoPdf();
  buildCounterVolumeAccessInfoPdf++;
  if (buildCounterVolumeAccessInfoPdf < 3) {
    o.acsTokenLink = "foo";
    o.downloadLink = "foo";
    o.isAvailable = true;
  }
  buildCounterVolumeAccessInfoPdf--;
  return o;
}

checkVolumeAccessInfoPdf(api.VolumeAccessInfoPdf o) {
  buildCounterVolumeAccessInfoPdf++;
  if (buildCounterVolumeAccessInfoPdf < 3) {
    unittest.expect(o.acsTokenLink, unittest.equals('foo'));
    unittest.expect(o.downloadLink, unittest.equals('foo'));
    unittest.expect(o.isAvailable, unittest.isTrue);
  }
  buildCounterVolumeAccessInfoPdf--;
}

core.int buildCounterVolumeAccessInfo = 0;
buildVolumeAccessInfo() {
  var o = new api.VolumeAccessInfo();
  buildCounterVolumeAccessInfo++;
  if (buildCounterVolumeAccessInfo < 3) {
    o.accessViewStatus = "foo";
    o.country = "foo";
    o.downloadAccess = buildDownloadAccessRestriction();
    o.driveImportedContentLink = "foo";
    o.embeddable = true;
    o.epub = buildVolumeAccessInfoEpub();
    o.explicitOfflineLicenseManagement = true;
    o.pdf = buildVolumeAccessInfoPdf();
    o.publicDomain = true;
    o.quoteSharingAllowed = true;
    o.textToSpeechPermission = "foo";
    o.viewOrderUrl = "foo";
    o.viewability = "foo";
    o.webReaderLink = "foo";
  }
  buildCounterVolumeAccessInfo--;
  return o;
}

checkVolumeAccessInfo(api.VolumeAccessInfo o) {
  buildCounterVolumeAccessInfo++;
  if (buildCounterVolumeAccessInfo < 3) {
    unittest.expect(o.accessViewStatus, unittest.equals('foo'));
    unittest.expect(o.country, unittest.equals('foo'));
    checkDownloadAccessRestriction(o.downloadAccess);
    unittest.expect(o.driveImportedContentLink, unittest.equals('foo'));
    unittest.expect(o.embeddable, unittest.isTrue);
    checkVolumeAccessInfoEpub(o.epub);
    unittest.expect(o.explicitOfflineLicenseManagement, unittest.isTrue);
    checkVolumeAccessInfoPdf(o.pdf);
    unittest.expect(o.publicDomain, unittest.isTrue);
    unittest.expect(o.quoteSharingAllowed, unittest.isTrue);
    unittest.expect(o.textToSpeechPermission, unittest.equals('foo'));
    unittest.expect(o.viewOrderUrl, unittest.equals('foo'));
    unittest.expect(o.viewability, unittest.equals('foo'));
    unittest.expect(o.webReaderLink, unittest.equals('foo'));
  }
  buildCounterVolumeAccessInfo--;
}

core.int buildCounterVolumeLayerInfoLayers = 0;
buildVolumeLayerInfoLayers() {
  var o = new api.VolumeLayerInfoLayers();
  buildCounterVolumeLayerInfoLayers++;
  if (buildCounterVolumeLayerInfoLayers < 3) {
    o.layerId = "foo";
    o.volumeAnnotationsVersion = "foo";
  }
  buildCounterVolumeLayerInfoLayers--;
  return o;
}

checkVolumeLayerInfoLayers(api.VolumeLayerInfoLayers o) {
  buildCounterVolumeLayerInfoLayers++;
  if (buildCounterVolumeLayerInfoLayers < 3) {
    unittest.expect(o.layerId, unittest.equals('foo'));
    unittest.expect(o.volumeAnnotationsVersion, unittest.equals('foo'));
  }
  buildCounterVolumeLayerInfoLayers--;
}

buildUnnamed819() {
  var o = new core.List<api.VolumeLayerInfoLayers>();
  o.add(buildVolumeLayerInfoLayers());
  o.add(buildVolumeLayerInfoLayers());
  return o;
}

checkUnnamed819(core.List<api.VolumeLayerInfoLayers> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVolumeLayerInfoLayers(o[0]);
  checkVolumeLayerInfoLayers(o[1]);
}

core.int buildCounterVolumeLayerInfo = 0;
buildVolumeLayerInfo() {
  var o = new api.VolumeLayerInfo();
  buildCounterVolumeLayerInfo++;
  if (buildCounterVolumeLayerInfo < 3) {
    o.layers = buildUnnamed819();
  }
  buildCounterVolumeLayerInfo--;
  return o;
}

checkVolumeLayerInfo(api.VolumeLayerInfo o) {
  buildCounterVolumeLayerInfo++;
  if (buildCounterVolumeLayerInfo < 3) {
    checkUnnamed819(o.layers);
  }
  buildCounterVolumeLayerInfo--;
}

core.int buildCounterVolumeRecommendedInfo = 0;
buildVolumeRecommendedInfo() {
  var o = new api.VolumeRecommendedInfo();
  buildCounterVolumeRecommendedInfo++;
  if (buildCounterVolumeRecommendedInfo < 3) {
    o.explanation = "foo";
  }
  buildCounterVolumeRecommendedInfo--;
  return o;
}

checkVolumeRecommendedInfo(api.VolumeRecommendedInfo o) {
  buildCounterVolumeRecommendedInfo++;
  if (buildCounterVolumeRecommendedInfo < 3) {
    unittest.expect(o.explanation, unittest.equals('foo'));
  }
  buildCounterVolumeRecommendedInfo--;
}

core.int buildCounterVolumeSaleInfoListPrice = 0;
buildVolumeSaleInfoListPrice() {
  var o = new api.VolumeSaleInfoListPrice();
  buildCounterVolumeSaleInfoListPrice++;
  if (buildCounterVolumeSaleInfoListPrice < 3) {
    o.amount = 42.0;
    o.currencyCode = "foo";
  }
  buildCounterVolumeSaleInfoListPrice--;
  return o;
}

checkVolumeSaleInfoListPrice(api.VolumeSaleInfoListPrice o) {
  buildCounterVolumeSaleInfoListPrice++;
  if (buildCounterVolumeSaleInfoListPrice < 3) {
    unittest.expect(o.amount, unittest.equals(42.0));
    unittest.expect(o.currencyCode, unittest.equals('foo'));
  }
  buildCounterVolumeSaleInfoListPrice--;
}

core.int buildCounterVolumeSaleInfoOffersListPrice = 0;
buildVolumeSaleInfoOffersListPrice() {
  var o = new api.VolumeSaleInfoOffersListPrice();
  buildCounterVolumeSaleInfoOffersListPrice++;
  if (buildCounterVolumeSaleInfoOffersListPrice < 3) {
    o.amountInMicros = 42.0;
    o.currencyCode = "foo";
  }
  buildCounterVolumeSaleInfoOffersListPrice--;
  return o;
}

checkVolumeSaleInfoOffersListPrice(api.VolumeSaleInfoOffersListPrice o) {
  buildCounterVolumeSaleInfoOffersListPrice++;
  if (buildCounterVolumeSaleInfoOffersListPrice < 3) {
    unittest.expect(o.amountInMicros, unittest.equals(42.0));
    unittest.expect(o.currencyCode, unittest.equals('foo'));
  }
  buildCounterVolumeSaleInfoOffersListPrice--;
}

core.int buildCounterVolumeSaleInfoOffersRentalDuration = 0;
buildVolumeSaleInfoOffersRentalDuration() {
  var o = new api.VolumeSaleInfoOffersRentalDuration();
  buildCounterVolumeSaleInfoOffersRentalDuration++;
  if (buildCounterVolumeSaleInfoOffersRentalDuration < 3) {
    o.count = 42.0;
    o.unit = "foo";
  }
  buildCounterVolumeSaleInfoOffersRentalDuration--;
  return o;
}

checkVolumeSaleInfoOffersRentalDuration(api.VolumeSaleInfoOffersRentalDuration o) {
  buildCounterVolumeSaleInfoOffersRentalDuration++;
  if (buildCounterVolumeSaleInfoOffersRentalDuration < 3) {
    unittest.expect(o.count, unittest.equals(42.0));
    unittest.expect(o.unit, unittest.equals('foo'));
  }
  buildCounterVolumeSaleInfoOffersRentalDuration--;
}

core.int buildCounterVolumeSaleInfoOffersRetailPrice = 0;
buildVolumeSaleInfoOffersRetailPrice() {
  var o = new api.VolumeSaleInfoOffersRetailPrice();
  buildCounterVolumeSaleInfoOffersRetailPrice++;
  if (buildCounterVolumeSaleInfoOffersRetailPrice < 3) {
    o.amountInMicros = 42.0;
    o.currencyCode = "foo";
  }
  buildCounterVolumeSaleInfoOffersRetailPrice--;
  return o;
}

checkVolumeSaleInfoOffersRetailPrice(api.VolumeSaleInfoOffersRetailPrice o) {
  buildCounterVolumeSaleInfoOffersRetailPrice++;
  if (buildCounterVolumeSaleInfoOffersRetailPrice < 3) {
    unittest.expect(o.amountInMicros, unittest.equals(42.0));
    unittest.expect(o.currencyCode, unittest.equals('foo'));
  }
  buildCounterVolumeSaleInfoOffersRetailPrice--;
}

core.int buildCounterVolumeSaleInfoOffers = 0;
buildVolumeSaleInfoOffers() {
  var o = new api.VolumeSaleInfoOffers();
  buildCounterVolumeSaleInfoOffers++;
  if (buildCounterVolumeSaleInfoOffers < 3) {
    o.finskyOfferType = 42;
    o.giftable = true;
    o.listPrice = buildVolumeSaleInfoOffersListPrice();
    o.rentalDuration = buildVolumeSaleInfoOffersRentalDuration();
    o.retailPrice = buildVolumeSaleInfoOffersRetailPrice();
  }
  buildCounterVolumeSaleInfoOffers--;
  return o;
}

checkVolumeSaleInfoOffers(api.VolumeSaleInfoOffers o) {
  buildCounterVolumeSaleInfoOffers++;
  if (buildCounterVolumeSaleInfoOffers < 3) {
    unittest.expect(o.finskyOfferType, unittest.equals(42));
    unittest.expect(o.giftable, unittest.isTrue);
    checkVolumeSaleInfoOffersListPrice(o.listPrice);
    checkVolumeSaleInfoOffersRentalDuration(o.rentalDuration);
    checkVolumeSaleInfoOffersRetailPrice(o.retailPrice);
  }
  buildCounterVolumeSaleInfoOffers--;
}

buildUnnamed820() {
  var o = new core.List<api.VolumeSaleInfoOffers>();
  o.add(buildVolumeSaleInfoOffers());
  o.add(buildVolumeSaleInfoOffers());
  return o;
}

checkUnnamed820(core.List<api.VolumeSaleInfoOffers> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVolumeSaleInfoOffers(o[0]);
  checkVolumeSaleInfoOffers(o[1]);
}

core.int buildCounterVolumeSaleInfoRetailPrice = 0;
buildVolumeSaleInfoRetailPrice() {
  var o = new api.VolumeSaleInfoRetailPrice();
  buildCounterVolumeSaleInfoRetailPrice++;
  if (buildCounterVolumeSaleInfoRetailPrice < 3) {
    o.amount = 42.0;
    o.currencyCode = "foo";
  }
  buildCounterVolumeSaleInfoRetailPrice--;
  return o;
}

checkVolumeSaleInfoRetailPrice(api.VolumeSaleInfoRetailPrice o) {
  buildCounterVolumeSaleInfoRetailPrice++;
  if (buildCounterVolumeSaleInfoRetailPrice < 3) {
    unittest.expect(o.amount, unittest.equals(42.0));
    unittest.expect(o.currencyCode, unittest.equals('foo'));
  }
  buildCounterVolumeSaleInfoRetailPrice--;
}

core.int buildCounterVolumeSaleInfo = 0;
buildVolumeSaleInfo() {
  var o = new api.VolumeSaleInfo();
  buildCounterVolumeSaleInfo++;
  if (buildCounterVolumeSaleInfo < 3) {
    o.buyLink = "foo";
    o.country = "foo";
    o.isEbook = true;
    o.listPrice = buildVolumeSaleInfoListPrice();
    o.offers = buildUnnamed820();
    o.onSaleDate = core.DateTime.parse("2002-02-27T14:01:02");
    o.retailPrice = buildVolumeSaleInfoRetailPrice();
    o.saleability = "foo";
  }
  buildCounterVolumeSaleInfo--;
  return o;
}

checkVolumeSaleInfo(api.VolumeSaleInfo o) {
  buildCounterVolumeSaleInfo++;
  if (buildCounterVolumeSaleInfo < 3) {
    unittest.expect(o.buyLink, unittest.equals('foo'));
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.isEbook, unittest.isTrue);
    checkVolumeSaleInfoListPrice(o.listPrice);
    checkUnnamed820(o.offers);
    unittest.expect(o.onSaleDate, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    checkVolumeSaleInfoRetailPrice(o.retailPrice);
    unittest.expect(o.saleability, unittest.equals('foo'));
  }
  buildCounterVolumeSaleInfo--;
}

core.int buildCounterVolumeSearchInfo = 0;
buildVolumeSearchInfo() {
  var o = new api.VolumeSearchInfo();
  buildCounterVolumeSearchInfo++;
  if (buildCounterVolumeSearchInfo < 3) {
    o.textSnippet = "foo";
  }
  buildCounterVolumeSearchInfo--;
  return o;
}

checkVolumeSearchInfo(api.VolumeSearchInfo o) {
  buildCounterVolumeSearchInfo++;
  if (buildCounterVolumeSearchInfo < 3) {
    unittest.expect(o.textSnippet, unittest.equals('foo'));
  }
  buildCounterVolumeSearchInfo--;
}

core.int buildCounterVolumeUserInfoCopy = 0;
buildVolumeUserInfoCopy() {
  var o = new api.VolumeUserInfoCopy();
  buildCounterVolumeUserInfoCopy++;
  if (buildCounterVolumeUserInfoCopy < 3) {
    o.allowedCharacterCount = 42;
    o.limitType = "foo";
    o.remainingCharacterCount = 42;
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterVolumeUserInfoCopy--;
  return o;
}

checkVolumeUserInfoCopy(api.VolumeUserInfoCopy o) {
  buildCounterVolumeUserInfoCopy++;
  if (buildCounterVolumeUserInfoCopy < 3) {
    unittest.expect(o.allowedCharacterCount, unittest.equals(42));
    unittest.expect(o.limitType, unittest.equals('foo'));
    unittest.expect(o.remainingCharacterCount, unittest.equals(42));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterVolumeUserInfoCopy--;
}

core.int buildCounterVolumeUserInfoFamilySharing = 0;
buildVolumeUserInfoFamilySharing() {
  var o = new api.VolumeUserInfoFamilySharing();
  buildCounterVolumeUserInfoFamilySharing++;
  if (buildCounterVolumeUserInfoFamilySharing < 3) {
    o.familyRole = "foo";
    o.isSharingAllowed = true;
    o.isSharingDisabledByFop = true;
  }
  buildCounterVolumeUserInfoFamilySharing--;
  return o;
}

checkVolumeUserInfoFamilySharing(api.VolumeUserInfoFamilySharing o) {
  buildCounterVolumeUserInfoFamilySharing++;
  if (buildCounterVolumeUserInfoFamilySharing < 3) {
    unittest.expect(o.familyRole, unittest.equals('foo'));
    unittest.expect(o.isSharingAllowed, unittest.isTrue);
    unittest.expect(o.isSharingDisabledByFop, unittest.isTrue);
  }
  buildCounterVolumeUserInfoFamilySharing--;
}

core.int buildCounterVolumeUserInfoRentalPeriod = 0;
buildVolumeUserInfoRentalPeriod() {
  var o = new api.VolumeUserInfoRentalPeriod();
  buildCounterVolumeUserInfoRentalPeriod++;
  if (buildCounterVolumeUserInfoRentalPeriod < 3) {
    o.endUtcSec = "foo";
    o.startUtcSec = "foo";
  }
  buildCounterVolumeUserInfoRentalPeriod--;
  return o;
}

checkVolumeUserInfoRentalPeriod(api.VolumeUserInfoRentalPeriod o) {
  buildCounterVolumeUserInfoRentalPeriod++;
  if (buildCounterVolumeUserInfoRentalPeriod < 3) {
    unittest.expect(o.endUtcSec, unittest.equals('foo'));
    unittest.expect(o.startUtcSec, unittest.equals('foo'));
  }
  buildCounterVolumeUserInfoRentalPeriod--;
}

core.int buildCounterVolumeUserInfoUserUploadedVolumeInfo = 0;
buildVolumeUserInfoUserUploadedVolumeInfo() {
  var o = new api.VolumeUserInfoUserUploadedVolumeInfo();
  buildCounterVolumeUserInfoUserUploadedVolumeInfo++;
  if (buildCounterVolumeUserInfoUserUploadedVolumeInfo < 3) {
    o.processingState = "foo";
  }
  buildCounterVolumeUserInfoUserUploadedVolumeInfo--;
  return o;
}

checkVolumeUserInfoUserUploadedVolumeInfo(api.VolumeUserInfoUserUploadedVolumeInfo o) {
  buildCounterVolumeUserInfoUserUploadedVolumeInfo++;
  if (buildCounterVolumeUserInfoUserUploadedVolumeInfo < 3) {
    unittest.expect(o.processingState, unittest.equals('foo'));
  }
  buildCounterVolumeUserInfoUserUploadedVolumeInfo--;
}

core.int buildCounterVolumeUserInfo = 0;
buildVolumeUserInfo() {
  var o = new api.VolumeUserInfo();
  buildCounterVolumeUserInfo++;
  if (buildCounterVolumeUserInfo < 3) {
    o.acquiredTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.acquisitionType = 42;
    o.copy = buildVolumeUserInfoCopy();
    o.entitlementType = 42;
    o.familySharing = buildVolumeUserInfoFamilySharing();
    o.isFamilySharedFromUser = true;
    o.isFamilySharedToUser = true;
    o.isFamilySharingAllowed = true;
    o.isFamilySharingDisabledByFop = true;
    o.isInMyBooks = true;
    o.isPreordered = true;
    o.isPurchased = true;
    o.isUploaded = true;
    o.readingPosition = buildReadingPosition();
    o.rentalPeriod = buildVolumeUserInfoRentalPeriod();
    o.rentalState = "foo";
    o.review = buildReview();
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.userUploadedVolumeInfo = buildVolumeUserInfoUserUploadedVolumeInfo();
  }
  buildCounterVolumeUserInfo--;
  return o;
}

checkVolumeUserInfo(api.VolumeUserInfo o) {
  buildCounterVolumeUserInfo++;
  if (buildCounterVolumeUserInfo < 3) {
    unittest.expect(o.acquiredTime, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.acquisitionType, unittest.equals(42));
    checkVolumeUserInfoCopy(o.copy);
    unittest.expect(o.entitlementType, unittest.equals(42));
    checkVolumeUserInfoFamilySharing(o.familySharing);
    unittest.expect(o.isFamilySharedFromUser, unittest.isTrue);
    unittest.expect(o.isFamilySharedToUser, unittest.isTrue);
    unittest.expect(o.isFamilySharingAllowed, unittest.isTrue);
    unittest.expect(o.isFamilySharingDisabledByFop, unittest.isTrue);
    unittest.expect(o.isInMyBooks, unittest.isTrue);
    unittest.expect(o.isPreordered, unittest.isTrue);
    unittest.expect(o.isPurchased, unittest.isTrue);
    unittest.expect(o.isUploaded, unittest.isTrue);
    checkReadingPosition(o.readingPosition);
    checkVolumeUserInfoRentalPeriod(o.rentalPeriod);
    unittest.expect(o.rentalState, unittest.equals('foo'));
    checkReview(o.review);
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    checkVolumeUserInfoUserUploadedVolumeInfo(o.userUploadedVolumeInfo);
  }
  buildCounterVolumeUserInfo--;
}

buildUnnamed821() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed821(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed822() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed822(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterVolumeVolumeInfoDimensions = 0;
buildVolumeVolumeInfoDimensions() {
  var o = new api.VolumeVolumeInfoDimensions();
  buildCounterVolumeVolumeInfoDimensions++;
  if (buildCounterVolumeVolumeInfoDimensions < 3) {
    o.height = "foo";
    o.thickness = "foo";
    o.width = "foo";
  }
  buildCounterVolumeVolumeInfoDimensions--;
  return o;
}

checkVolumeVolumeInfoDimensions(api.VolumeVolumeInfoDimensions o) {
  buildCounterVolumeVolumeInfoDimensions++;
  if (buildCounterVolumeVolumeInfoDimensions < 3) {
    unittest.expect(o.height, unittest.equals('foo'));
    unittest.expect(o.thickness, unittest.equals('foo'));
    unittest.expect(o.width, unittest.equals('foo'));
  }
  buildCounterVolumeVolumeInfoDimensions--;
}

core.int buildCounterVolumeVolumeInfoImageLinks = 0;
buildVolumeVolumeInfoImageLinks() {
  var o = new api.VolumeVolumeInfoImageLinks();
  buildCounterVolumeVolumeInfoImageLinks++;
  if (buildCounterVolumeVolumeInfoImageLinks < 3) {
    o.extraLarge = "foo";
    o.large = "foo";
    o.medium = "foo";
    o.small = "foo";
    o.smallThumbnail = "foo";
    o.thumbnail = "foo";
  }
  buildCounterVolumeVolumeInfoImageLinks--;
  return o;
}

checkVolumeVolumeInfoImageLinks(api.VolumeVolumeInfoImageLinks o) {
  buildCounterVolumeVolumeInfoImageLinks++;
  if (buildCounterVolumeVolumeInfoImageLinks < 3) {
    unittest.expect(o.extraLarge, unittest.equals('foo'));
    unittest.expect(o.large, unittest.equals('foo'));
    unittest.expect(o.medium, unittest.equals('foo'));
    unittest.expect(o.small, unittest.equals('foo'));
    unittest.expect(o.smallThumbnail, unittest.equals('foo'));
    unittest.expect(o.thumbnail, unittest.equals('foo'));
  }
  buildCounterVolumeVolumeInfoImageLinks--;
}

core.int buildCounterVolumeVolumeInfoIndustryIdentifiers = 0;
buildVolumeVolumeInfoIndustryIdentifiers() {
  var o = new api.VolumeVolumeInfoIndustryIdentifiers();
  buildCounterVolumeVolumeInfoIndustryIdentifiers++;
  if (buildCounterVolumeVolumeInfoIndustryIdentifiers < 3) {
    o.identifier = "foo";
    o.type = "foo";
  }
  buildCounterVolumeVolumeInfoIndustryIdentifiers--;
  return o;
}

checkVolumeVolumeInfoIndustryIdentifiers(api.VolumeVolumeInfoIndustryIdentifiers o) {
  buildCounterVolumeVolumeInfoIndustryIdentifiers++;
  if (buildCounterVolumeVolumeInfoIndustryIdentifiers < 3) {
    unittest.expect(o.identifier, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterVolumeVolumeInfoIndustryIdentifiers--;
}

buildUnnamed823() {
  var o = new core.List<api.VolumeVolumeInfoIndustryIdentifiers>();
  o.add(buildVolumeVolumeInfoIndustryIdentifiers());
  o.add(buildVolumeVolumeInfoIndustryIdentifiers());
  return o;
}

checkUnnamed823(core.List<api.VolumeVolumeInfoIndustryIdentifiers> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVolumeVolumeInfoIndustryIdentifiers(o[0]);
  checkVolumeVolumeInfoIndustryIdentifiers(o[1]);
}

core.int buildCounterVolumeVolumeInfoPanelizationSummary = 0;
buildVolumeVolumeInfoPanelizationSummary() {
  var o = new api.VolumeVolumeInfoPanelizationSummary();
  buildCounterVolumeVolumeInfoPanelizationSummary++;
  if (buildCounterVolumeVolumeInfoPanelizationSummary < 3) {
    o.containsEpubBubbles = true;
    o.containsImageBubbles = true;
    o.epubBubbleVersion = "foo";
    o.imageBubbleVersion = "foo";
  }
  buildCounterVolumeVolumeInfoPanelizationSummary--;
  return o;
}

checkVolumeVolumeInfoPanelizationSummary(api.VolumeVolumeInfoPanelizationSummary o) {
  buildCounterVolumeVolumeInfoPanelizationSummary++;
  if (buildCounterVolumeVolumeInfoPanelizationSummary < 3) {
    unittest.expect(o.containsEpubBubbles, unittest.isTrue);
    unittest.expect(o.containsImageBubbles, unittest.isTrue);
    unittest.expect(o.epubBubbleVersion, unittest.equals('foo'));
    unittest.expect(o.imageBubbleVersion, unittest.equals('foo'));
  }
  buildCounterVolumeVolumeInfoPanelizationSummary--;
}

core.int buildCounterVolumeVolumeInfo = 0;
buildVolumeVolumeInfo() {
  var o = new api.VolumeVolumeInfo();
  buildCounterVolumeVolumeInfo++;
  if (buildCounterVolumeVolumeInfo < 3) {
    o.allowAnonLogging = true;
    o.authors = buildUnnamed821();
    o.averageRating = 42.0;
    o.canonicalVolumeLink = "foo";
    o.categories = buildUnnamed822();
    o.contentVersion = "foo";
    o.description = "foo";
    o.dimensions = buildVolumeVolumeInfoDimensions();
    o.imageLinks = buildVolumeVolumeInfoImageLinks();
    o.industryIdentifiers = buildUnnamed823();
    o.infoLink = "foo";
    o.language = "foo";
    o.mainCategory = "foo";
    o.maturityRating = "foo";
    o.pageCount = 42;
    o.panelizationSummary = buildVolumeVolumeInfoPanelizationSummary();
    o.previewLink = "foo";
    o.printType = "foo";
    o.printedPageCount = 42;
    o.publishedDate = "foo";
    o.publisher = "foo";
    o.ratingsCount = 42;
    o.readingModes = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
    o.samplePageCount = 42;
    o.seriesInfo = buildVolumeseriesinfo();
    o.subtitle = "foo";
    o.title = "foo";
  }
  buildCounterVolumeVolumeInfo--;
  return o;
}

checkVolumeVolumeInfo(api.VolumeVolumeInfo o) {
  buildCounterVolumeVolumeInfo++;
  if (buildCounterVolumeVolumeInfo < 3) {
    unittest.expect(o.allowAnonLogging, unittest.isTrue);
    checkUnnamed821(o.authors);
    unittest.expect(o.averageRating, unittest.equals(42.0));
    unittest.expect(o.canonicalVolumeLink, unittest.equals('foo'));
    checkUnnamed822(o.categories);
    unittest.expect(o.contentVersion, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    checkVolumeVolumeInfoDimensions(o.dimensions);
    checkVolumeVolumeInfoImageLinks(o.imageLinks);
    checkUnnamed823(o.industryIdentifiers);
    unittest.expect(o.infoLink, unittest.equals('foo'));
    unittest.expect(o.language, unittest.equals('foo'));
    unittest.expect(o.mainCategory, unittest.equals('foo'));
    unittest.expect(o.maturityRating, unittest.equals('foo'));
    unittest.expect(o.pageCount, unittest.equals(42));
    checkVolumeVolumeInfoPanelizationSummary(o.panelizationSummary);
    unittest.expect(o.previewLink, unittest.equals('foo'));
    unittest.expect(o.printType, unittest.equals('foo'));
    unittest.expect(o.printedPageCount, unittest.equals(42));
    unittest.expect(o.publishedDate, unittest.equals('foo'));
    unittest.expect(o.publisher, unittest.equals('foo'));
    unittest.expect(o.ratingsCount, unittest.equals(42));
    var casted2 = (o.readingModes) as core.Map; unittest.expect(casted2, unittest.hasLength(3)); unittest.expect(casted2["list"], unittest.equals([1, 2, 3])); unittest.expect(casted2["bool"], unittest.equals(true)); unittest.expect(casted2["string"], unittest.equals('foo')); 
    unittest.expect(o.samplePageCount, unittest.equals(42));
    checkVolumeseriesinfo(o.seriesInfo);
    unittest.expect(o.subtitle, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterVolumeVolumeInfo--;
}

core.int buildCounterVolume = 0;
buildVolume() {
  var o = new api.Volume();
  buildCounterVolume++;
  if (buildCounterVolume < 3) {
    o.accessInfo = buildVolumeAccessInfo();
    o.etag = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.layerInfo = buildVolumeLayerInfo();
    o.recommendedInfo = buildVolumeRecommendedInfo();
    o.saleInfo = buildVolumeSaleInfo();
    o.searchInfo = buildVolumeSearchInfo();
    o.selfLink = "foo";
    o.userInfo = buildVolumeUserInfo();
    o.volumeInfo = buildVolumeVolumeInfo();
  }
  buildCounterVolume--;
  return o;
}

checkVolume(api.Volume o) {
  buildCounterVolume++;
  if (buildCounterVolume < 3) {
    checkVolumeAccessInfo(o.accessInfo);
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkVolumeLayerInfo(o.layerInfo);
    checkVolumeRecommendedInfo(o.recommendedInfo);
    checkVolumeSaleInfo(o.saleInfo);
    checkVolumeSearchInfo(o.searchInfo);
    unittest.expect(o.selfLink, unittest.equals('foo'));
    checkVolumeUserInfo(o.userInfo);
    checkVolumeVolumeInfo(o.volumeInfo);
  }
  buildCounterVolume--;
}

buildUnnamed824() {
  var o = new core.List<api.Volume>();
  o.add(buildVolume());
  o.add(buildVolume());
  return o;
}

checkUnnamed824(core.List<api.Volume> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVolume(o[0]);
  checkVolume(o[1]);
}

core.int buildCounterVolume2 = 0;
buildVolume2() {
  var o = new api.Volume2();
  buildCounterVolume2++;
  if (buildCounterVolume2 < 3) {
    o.items = buildUnnamed824();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterVolume2--;
  return o;
}

checkVolume2(api.Volume2 o) {
  buildCounterVolume2++;
  if (buildCounterVolume2 < 3) {
    checkUnnamed824(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterVolume2--;
}

core.int buildCounterVolumeannotationContentRanges = 0;
buildVolumeannotationContentRanges() {
  var o = new api.VolumeannotationContentRanges();
  buildCounterVolumeannotationContentRanges++;
  if (buildCounterVolumeannotationContentRanges < 3) {
    o.cfiRange = buildBooksAnnotationsRange();
    o.contentVersion = "foo";
    o.gbImageRange = buildBooksAnnotationsRange();
    o.gbTextRange = buildBooksAnnotationsRange();
  }
  buildCounterVolumeannotationContentRanges--;
  return o;
}

checkVolumeannotationContentRanges(api.VolumeannotationContentRanges o) {
  buildCounterVolumeannotationContentRanges++;
  if (buildCounterVolumeannotationContentRanges < 3) {
    checkBooksAnnotationsRange(o.cfiRange);
    unittest.expect(o.contentVersion, unittest.equals('foo'));
    checkBooksAnnotationsRange(o.gbImageRange);
    checkBooksAnnotationsRange(o.gbTextRange);
  }
  buildCounterVolumeannotationContentRanges--;
}

buildUnnamed825() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed825(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterVolumeannotation = 0;
buildVolumeannotation() {
  var o = new api.Volumeannotation();
  buildCounterVolumeannotation++;
  if (buildCounterVolumeannotation < 3) {
    o.annotationDataId = "foo";
    o.annotationDataLink = "foo";
    o.annotationType = "foo";
    o.contentRanges = buildVolumeannotationContentRanges();
    o.data = "foo";
    o.deleted = true;
    o.id = "foo";
    o.kind = "foo";
    o.layerId = "foo";
    o.pageIds = buildUnnamed825();
    o.selectedText = "foo";
    o.selfLink = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.volumeId = "foo";
  }
  buildCounterVolumeannotation--;
  return o;
}

checkVolumeannotation(api.Volumeannotation o) {
  buildCounterVolumeannotation++;
  if (buildCounterVolumeannotation < 3) {
    unittest.expect(o.annotationDataId, unittest.equals('foo'));
    unittest.expect(o.annotationDataLink, unittest.equals('foo'));
    unittest.expect(o.annotationType, unittest.equals('foo'));
    checkVolumeannotationContentRanges(o.contentRanges);
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.deleted, unittest.isTrue);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.layerId, unittest.equals('foo'));
    checkUnnamed825(o.pageIds);
    unittest.expect(o.selectedText, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.volumeId, unittest.equals('foo'));
  }
  buildCounterVolumeannotation--;
}

buildUnnamed826() {
  var o = new core.List<api.Volumeannotation>();
  o.add(buildVolumeannotation());
  o.add(buildVolumeannotation());
  return o;
}

checkUnnamed826(core.List<api.Volumeannotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVolumeannotation(o[0]);
  checkVolumeannotation(o[1]);
}

core.int buildCounterVolumeannotations = 0;
buildVolumeannotations() {
  var o = new api.Volumeannotations();
  buildCounterVolumeannotations++;
  if (buildCounterVolumeannotations < 3) {
    o.items = buildUnnamed826();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.totalItems = 42;
    o.version = "foo";
  }
  buildCounterVolumeannotations--;
  return o;
}

checkVolumeannotations(api.Volumeannotations o) {
  buildCounterVolumeannotations++;
  if (buildCounterVolumeannotations < 3) {
    checkUnnamed826(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
    unittest.expect(o.version, unittest.equals('foo'));
  }
  buildCounterVolumeannotations--;
}

buildUnnamed827() {
  var o = new core.List<api.Volume>();
  o.add(buildVolume());
  o.add(buildVolume());
  return o;
}

checkUnnamed827(core.List<api.Volume> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVolume(o[0]);
  checkVolume(o[1]);
}

core.int buildCounterVolumes = 0;
buildVolumes() {
  var o = new api.Volumes();
  buildCounterVolumes++;
  if (buildCounterVolumes < 3) {
    o.items = buildUnnamed827();
    o.kind = "foo";
    o.totalItems = 42;
  }
  buildCounterVolumes--;
  return o;
}

checkVolumes(api.Volumes o) {
  buildCounterVolumes++;
  if (buildCounterVolumes < 3) {
    checkUnnamed827(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterVolumes--;
}

core.int buildCounterVolumeseriesinfoVolumeSeriesIssue = 0;
buildVolumeseriesinfoVolumeSeriesIssue() {
  var o = new api.VolumeseriesinfoVolumeSeriesIssue();
  buildCounterVolumeseriesinfoVolumeSeriesIssue++;
  if (buildCounterVolumeseriesinfoVolumeSeriesIssue < 3) {
    o.issueDisplayNumber = "foo";
    o.issueOrderNumber = 42;
  }
  buildCounterVolumeseriesinfoVolumeSeriesIssue--;
  return o;
}

checkVolumeseriesinfoVolumeSeriesIssue(api.VolumeseriesinfoVolumeSeriesIssue o) {
  buildCounterVolumeseriesinfoVolumeSeriesIssue++;
  if (buildCounterVolumeseriesinfoVolumeSeriesIssue < 3) {
    unittest.expect(o.issueDisplayNumber, unittest.equals('foo'));
    unittest.expect(o.issueOrderNumber, unittest.equals(42));
  }
  buildCounterVolumeseriesinfoVolumeSeriesIssue--;
}

buildUnnamed828() {
  var o = new core.List<api.VolumeseriesinfoVolumeSeriesIssue>();
  o.add(buildVolumeseriesinfoVolumeSeriesIssue());
  o.add(buildVolumeseriesinfoVolumeSeriesIssue());
  return o;
}

checkUnnamed828(core.List<api.VolumeseriesinfoVolumeSeriesIssue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVolumeseriesinfoVolumeSeriesIssue(o[0]);
  checkVolumeseriesinfoVolumeSeriesIssue(o[1]);
}

core.int buildCounterVolumeseriesinfoVolumeSeries = 0;
buildVolumeseriesinfoVolumeSeries() {
  var o = new api.VolumeseriesinfoVolumeSeries();
  buildCounterVolumeseriesinfoVolumeSeries++;
  if (buildCounterVolumeseriesinfoVolumeSeries < 3) {
    o.issue = buildUnnamed828();
    o.orderNumber = 42;
    o.seriesBookType = "foo";
    o.seriesId = "foo";
  }
  buildCounterVolumeseriesinfoVolumeSeries--;
  return o;
}

checkVolumeseriesinfoVolumeSeries(api.VolumeseriesinfoVolumeSeries o) {
  buildCounterVolumeseriesinfoVolumeSeries++;
  if (buildCounterVolumeseriesinfoVolumeSeries < 3) {
    checkUnnamed828(o.issue);
    unittest.expect(o.orderNumber, unittest.equals(42));
    unittest.expect(o.seriesBookType, unittest.equals('foo'));
    unittest.expect(o.seriesId, unittest.equals('foo'));
  }
  buildCounterVolumeseriesinfoVolumeSeries--;
}

buildUnnamed829() {
  var o = new core.List<api.VolumeseriesinfoVolumeSeries>();
  o.add(buildVolumeseriesinfoVolumeSeries());
  o.add(buildVolumeseriesinfoVolumeSeries());
  return o;
}

checkUnnamed829(core.List<api.VolumeseriesinfoVolumeSeries> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVolumeseriesinfoVolumeSeries(o[0]);
  checkVolumeseriesinfoVolumeSeries(o[1]);
}

core.int buildCounterVolumeseriesinfo = 0;
buildVolumeseriesinfo() {
  var o = new api.Volumeseriesinfo();
  buildCounterVolumeseriesinfo++;
  if (buildCounterVolumeseriesinfo < 3) {
    o.bookDisplayNumber = "foo";
    o.kind = "foo";
    o.shortSeriesBookTitle = "foo";
    o.volumeSeries = buildUnnamed829();
  }
  buildCounterVolumeseriesinfo--;
  return o;
}

checkVolumeseriesinfo(api.Volumeseriesinfo o) {
  buildCounterVolumeseriesinfo++;
  if (buildCounterVolumeseriesinfo < 3) {
    unittest.expect(o.bookDisplayNumber, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.shortSeriesBookTitle, unittest.equals('foo'));
    checkUnnamed829(o.volumeSeries);
  }
  buildCounterVolumeseriesinfo--;
}

buildUnnamed830() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed830(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed831() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed831(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed832() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed832(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed833() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed833(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed834() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed834(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed835() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed835(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed836() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed836(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed837() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed837(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed838() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed838(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed839() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed839(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed840() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed840(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed841() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed841(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}


main() {
  unittest.group("obj-schema-AnnotationClientVersionRanges", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotationClientVersionRanges();
      var od = new api.AnnotationClientVersionRanges.fromJson(o.toJson());
      checkAnnotationClientVersionRanges(od);
    });
  });


  unittest.group("obj-schema-AnnotationCurrentVersionRanges", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotationCurrentVersionRanges();
      var od = new api.AnnotationCurrentVersionRanges.fromJson(o.toJson());
      checkAnnotationCurrentVersionRanges(od);
    });
  });


  unittest.group("obj-schema-AnnotationLayerSummary", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotationLayerSummary();
      var od = new api.AnnotationLayerSummary.fromJson(o.toJson());
      checkAnnotationLayerSummary(od);
    });
  });


  unittest.group("obj-schema-Annotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotation();
      var od = new api.Annotation.fromJson(o.toJson());
      checkAnnotation(od);
    });
  });


  unittest.group("obj-schema-Annotationdata", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotationdata();
      var od = new api.Annotationdata.fromJson(o.toJson());
      checkAnnotationdata(od);
    });
  });


  unittest.group("obj-schema-Annotations", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotations();
      var od = new api.Annotations.fromJson(o.toJson());
      checkAnnotations(od);
    });
  });


  unittest.group("obj-schema-AnnotationsSummaryLayers", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotationsSummaryLayers();
      var od = new api.AnnotationsSummaryLayers.fromJson(o.toJson());
      checkAnnotationsSummaryLayers(od);
    });
  });


  unittest.group("obj-schema-AnnotationsSummary", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotationsSummary();
      var od = new api.AnnotationsSummary.fromJson(o.toJson());
      checkAnnotationsSummary(od);
    });
  });


  unittest.group("obj-schema-Annotationsdata", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotationsdata();
      var od = new api.Annotationsdata.fromJson(o.toJson());
      checkAnnotationsdata(od);
    });
  });


  unittest.group("obj-schema-BooksAnnotationsRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildBooksAnnotationsRange();
      var od = new api.BooksAnnotationsRange.fromJson(o.toJson());
      checkBooksAnnotationsRange(od);
    });
  });


  unittest.group("obj-schema-BooksCloudloadingResource", () {
    unittest.test("to-json--from-json", () {
      var o = buildBooksCloudloadingResource();
      var od = new api.BooksCloudloadingResource.fromJson(o.toJson());
      checkBooksCloudloadingResource(od);
    });
  });


  unittest.group("obj-schema-BooksVolumesRecommendedRateResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBooksVolumesRecommendedRateResponse();
      var od = new api.BooksVolumesRecommendedRateResponse.fromJson(o.toJson());
      checkBooksVolumesRecommendedRateResponse(od);
    });
  });


  unittest.group("obj-schema-Bookshelf", () {
    unittest.test("to-json--from-json", () {
      var o = buildBookshelf();
      var od = new api.Bookshelf.fromJson(o.toJson());
      checkBookshelf(od);
    });
  });


  unittest.group("obj-schema-Bookshelves", () {
    unittest.test("to-json--from-json", () {
      var o = buildBookshelves();
      var od = new api.Bookshelves.fromJson(o.toJson());
      checkBookshelves(od);
    });
  });


  unittest.group("obj-schema-CategoryItems", () {
    unittest.test("to-json--from-json", () {
      var o = buildCategoryItems();
      var od = new api.CategoryItems.fromJson(o.toJson());
      checkCategoryItems(od);
    });
  });


  unittest.group("obj-schema-Category", () {
    unittest.test("to-json--from-json", () {
      var o = buildCategory();
      var od = new api.Category.fromJson(o.toJson());
      checkCategory(od);
    });
  });


  unittest.group("obj-schema-ConcurrentAccessRestriction", () {
    unittest.test("to-json--from-json", () {
      var o = buildConcurrentAccessRestriction();
      var od = new api.ConcurrentAccessRestriction.fromJson(o.toJson());
      checkConcurrentAccessRestriction(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataCommon", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataCommon();
      var od = new api.DictlayerdataCommon.fromJson(o.toJson());
      checkDictlayerdataCommon(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictSource();
      var od = new api.DictlayerdataDictSource.fromJson(o.toJson());
      checkDictlayerdataDictSource(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsDerivativesSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsDerivativesSource();
      var od = new api.DictlayerdataDictWordsDerivativesSource.fromJson(o.toJson());
      checkDictlayerdataDictWordsDerivativesSource(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsDerivatives", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsDerivatives();
      var od = new api.DictlayerdataDictWordsDerivatives.fromJson(o.toJson());
      checkDictlayerdataDictWordsDerivatives(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsExamplesSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsExamplesSource();
      var od = new api.DictlayerdataDictWordsExamplesSource.fromJson(o.toJson());
      checkDictlayerdataDictWordsExamplesSource(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsExamples", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsExamples();
      var od = new api.DictlayerdataDictWordsExamples.fromJson(o.toJson());
      checkDictlayerdataDictWordsExamples(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsSensesConjugations", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsSensesConjugations();
      var od = new api.DictlayerdataDictWordsSensesConjugations.fromJson(o.toJson());
      checkDictlayerdataDictWordsSensesConjugations(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsSensesDefinitionsExamplesSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsSensesDefinitionsExamplesSource();
      var od = new api.DictlayerdataDictWordsSensesDefinitionsExamplesSource.fromJson(o.toJson());
      checkDictlayerdataDictWordsSensesDefinitionsExamplesSource(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsSensesDefinitionsExamples", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsSensesDefinitionsExamples();
      var od = new api.DictlayerdataDictWordsSensesDefinitionsExamples.fromJson(o.toJson());
      checkDictlayerdataDictWordsSensesDefinitionsExamples(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsSensesDefinitions", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsSensesDefinitions();
      var od = new api.DictlayerdataDictWordsSensesDefinitions.fromJson(o.toJson());
      checkDictlayerdataDictWordsSensesDefinitions(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsSensesSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsSensesSource();
      var od = new api.DictlayerdataDictWordsSensesSource.fromJson(o.toJson());
      checkDictlayerdataDictWordsSensesSource(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsSensesSynonymsSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsSensesSynonymsSource();
      var od = new api.DictlayerdataDictWordsSensesSynonymsSource.fromJson(o.toJson());
      checkDictlayerdataDictWordsSensesSynonymsSource(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsSensesSynonyms", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsSensesSynonyms();
      var od = new api.DictlayerdataDictWordsSensesSynonyms.fromJson(o.toJson());
      checkDictlayerdataDictWordsSensesSynonyms(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsSenses", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsSenses();
      var od = new api.DictlayerdataDictWordsSenses.fromJson(o.toJson());
      checkDictlayerdataDictWordsSenses(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWordsSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWordsSource();
      var od = new api.DictlayerdataDictWordsSource.fromJson(o.toJson());
      checkDictlayerdataDictWordsSource(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDictWords", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDictWords();
      var od = new api.DictlayerdataDictWords.fromJson(o.toJson());
      checkDictlayerdataDictWords(od);
    });
  });


  unittest.group("obj-schema-DictlayerdataDict", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdataDict();
      var od = new api.DictlayerdataDict.fromJson(o.toJson());
      checkDictlayerdataDict(od);
    });
  });


  unittest.group("obj-schema-Dictlayerdata", () {
    unittest.test("to-json--from-json", () {
      var o = buildDictlayerdata();
      var od = new api.Dictlayerdata.fromJson(o.toJson());
      checkDictlayerdata(od);
    });
  });


  unittest.group("obj-schema-DiscoveryclustersClustersBannerWithContentContainer", () {
    unittest.test("to-json--from-json", () {
      var o = buildDiscoveryclustersClustersBannerWithContentContainer();
      var od = new api.DiscoveryclustersClustersBannerWithContentContainer.fromJson(o.toJson());
      checkDiscoveryclustersClustersBannerWithContentContainer(od);
    });
  });


  unittest.group("obj-schema-DiscoveryclustersClusters", () {
    unittest.test("to-json--from-json", () {
      var o = buildDiscoveryclustersClusters();
      var od = new api.DiscoveryclustersClusters.fromJson(o.toJson());
      checkDiscoveryclustersClusters(od);
    });
  });


  unittest.group("obj-schema-Discoveryclusters", () {
    unittest.test("to-json--from-json", () {
      var o = buildDiscoveryclusters();
      var od = new api.Discoveryclusters.fromJson(o.toJson());
      checkDiscoveryclusters(od);
    });
  });


  unittest.group("obj-schema-DownloadAccessRestriction", () {
    unittest.test("to-json--from-json", () {
      var o = buildDownloadAccessRestriction();
      var od = new api.DownloadAccessRestriction.fromJson(o.toJson());
      checkDownloadAccessRestriction(od);
    });
  });


  unittest.group("obj-schema-DownloadAccesses", () {
    unittest.test("to-json--from-json", () {
      var o = buildDownloadAccesses();
      var od = new api.DownloadAccesses.fromJson(o.toJson());
      checkDownloadAccesses(od);
    });
  });


  unittest.group("obj-schema-GeolayerdataCommon", () {
    unittest.test("to-json--from-json", () {
      var o = buildGeolayerdataCommon();
      var od = new api.GeolayerdataCommon.fromJson(o.toJson());
      checkGeolayerdataCommon(od);
    });
  });


  unittest.group("obj-schema-GeolayerdataGeoBoundary", () {
    unittest.test("to-json--from-json", () {
      var o = buildGeolayerdataGeoBoundary();
      var od = new api.GeolayerdataGeoBoundary.fromJson(o.toJson());
      checkGeolayerdataGeoBoundary(od);
    });
  });


  unittest.group("obj-schema-GeolayerdataGeoViewportHi", () {
    unittest.test("to-json--from-json", () {
      var o = buildGeolayerdataGeoViewportHi();
      var od = new api.GeolayerdataGeoViewportHi.fromJson(o.toJson());
      checkGeolayerdataGeoViewportHi(od);
    });
  });


  unittest.group("obj-schema-GeolayerdataGeoViewportLo", () {
    unittest.test("to-json--from-json", () {
      var o = buildGeolayerdataGeoViewportLo();
      var od = new api.GeolayerdataGeoViewportLo.fromJson(o.toJson());
      checkGeolayerdataGeoViewportLo(od);
    });
  });


  unittest.group("obj-schema-GeolayerdataGeoViewport", () {
    unittest.test("to-json--from-json", () {
      var o = buildGeolayerdataGeoViewport();
      var od = new api.GeolayerdataGeoViewport.fromJson(o.toJson());
      checkGeolayerdataGeoViewport(od);
    });
  });


  unittest.group("obj-schema-GeolayerdataGeo", () {
    unittest.test("to-json--from-json", () {
      var o = buildGeolayerdataGeo();
      var od = new api.GeolayerdataGeo.fromJson(o.toJson());
      checkGeolayerdataGeo(od);
    });
  });


  unittest.group("obj-schema-Geolayerdata", () {
    unittest.test("to-json--from-json", () {
      var o = buildGeolayerdata();
      var od = new api.Geolayerdata.fromJson(o.toJson());
      checkGeolayerdata(od);
    });
  });


  unittest.group("obj-schema-Layersummaries", () {
    unittest.test("to-json--from-json", () {
      var o = buildLayersummaries();
      var od = new api.Layersummaries.fromJson(o.toJson());
      checkLayersummaries(od);
    });
  });


  unittest.group("obj-schema-Layersummary", () {
    unittest.test("to-json--from-json", () {
      var o = buildLayersummary();
      var od = new api.Layersummary.fromJson(o.toJson());
      checkLayersummary(od);
    });
  });


  unittest.group("obj-schema-MetadataItems", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetadataItems();
      var od = new api.MetadataItems.fromJson(o.toJson());
      checkMetadataItems(od);
    });
  });


  unittest.group("obj-schema-Metadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetadata();
      var od = new api.Metadata.fromJson(o.toJson());
      checkMetadata(od);
    });
  });


  unittest.group("obj-schema-Notification", () {
    unittest.test("to-json--from-json", () {
      var o = buildNotification();
      var od = new api.Notification.fromJson(o.toJson());
      checkNotification(od);
    });
  });


  unittest.group("obj-schema-OffersItemsItems", () {
    unittest.test("to-json--from-json", () {
      var o = buildOffersItemsItems();
      var od = new api.OffersItemsItems.fromJson(o.toJson());
      checkOffersItemsItems(od);
    });
  });


  unittest.group("obj-schema-OffersItems", () {
    unittest.test("to-json--from-json", () {
      var o = buildOffersItems();
      var od = new api.OffersItems.fromJson(o.toJson());
      checkOffersItems(od);
    });
  });


  unittest.group("obj-schema-Offers", () {
    unittest.test("to-json--from-json", () {
      var o = buildOffers();
      var od = new api.Offers.fromJson(o.toJson());
      checkOffers(od);
    });
  });


  unittest.group("obj-schema-ReadingPosition", () {
    unittest.test("to-json--from-json", () {
      var o = buildReadingPosition();
      var od = new api.ReadingPosition.fromJson(o.toJson());
      checkReadingPosition(od);
    });
  });


  unittest.group("obj-schema-RequestAccess", () {
    unittest.test("to-json--from-json", () {
      var o = buildRequestAccess();
      var od = new api.RequestAccess.fromJson(o.toJson());
      checkRequestAccess(od);
    });
  });


  unittest.group("obj-schema-ReviewAuthor", () {
    unittest.test("to-json--from-json", () {
      var o = buildReviewAuthor();
      var od = new api.ReviewAuthor.fromJson(o.toJson());
      checkReviewAuthor(od);
    });
  });


  unittest.group("obj-schema-ReviewSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildReviewSource();
      var od = new api.ReviewSource.fromJson(o.toJson());
      checkReviewSource(od);
    });
  });


  unittest.group("obj-schema-Review", () {
    unittest.test("to-json--from-json", () {
      var o = buildReview();
      var od = new api.Review.fromJson(o.toJson());
      checkReview(od);
    });
  });


  unittest.group("obj-schema-SeriesSeries", () {
    unittest.test("to-json--from-json", () {
      var o = buildSeriesSeries();
      var od = new api.SeriesSeries.fromJson(o.toJson());
      checkSeriesSeries(od);
    });
  });


  unittest.group("obj-schema-Series", () {
    unittest.test("to-json--from-json", () {
      var o = buildSeries();
      var od = new api.Series.fromJson(o.toJson());
      checkSeries(od);
    });
  });


  unittest.group("obj-schema-Seriesmembership", () {
    unittest.test("to-json--from-json", () {
      var o = buildSeriesmembership();
      var od = new api.Seriesmembership.fromJson(o.toJson());
      checkSeriesmembership(od);
    });
  });


  unittest.group("obj-schema-UsersettingsNotesExport", () {
    unittest.test("to-json--from-json", () {
      var o = buildUsersettingsNotesExport();
      var od = new api.UsersettingsNotesExport.fromJson(o.toJson());
      checkUsersettingsNotesExport(od);
    });
  });


  unittest.group("obj-schema-UsersettingsNotificationMoreFromAuthors", () {
    unittest.test("to-json--from-json", () {
      var o = buildUsersettingsNotificationMoreFromAuthors();
      var od = new api.UsersettingsNotificationMoreFromAuthors.fromJson(o.toJson());
      checkUsersettingsNotificationMoreFromAuthors(od);
    });
  });


  unittest.group("obj-schema-UsersettingsNotificationMoreFromSeries", () {
    unittest.test("to-json--from-json", () {
      var o = buildUsersettingsNotificationMoreFromSeries();
      var od = new api.UsersettingsNotificationMoreFromSeries.fromJson(o.toJson());
      checkUsersettingsNotificationMoreFromSeries(od);
    });
  });


  unittest.group("obj-schema-UsersettingsNotification", () {
    unittest.test("to-json--from-json", () {
      var o = buildUsersettingsNotification();
      var od = new api.UsersettingsNotification.fromJson(o.toJson());
      checkUsersettingsNotification(od);
    });
  });


  unittest.group("obj-schema-Usersettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildUsersettings();
      var od = new api.Usersettings.fromJson(o.toJson());
      checkUsersettings(od);
    });
  });


  unittest.group("obj-schema-VolumeAccessInfoEpub", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeAccessInfoEpub();
      var od = new api.VolumeAccessInfoEpub.fromJson(o.toJson());
      checkVolumeAccessInfoEpub(od);
    });
  });


  unittest.group("obj-schema-VolumeAccessInfoPdf", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeAccessInfoPdf();
      var od = new api.VolumeAccessInfoPdf.fromJson(o.toJson());
      checkVolumeAccessInfoPdf(od);
    });
  });


  unittest.group("obj-schema-VolumeAccessInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeAccessInfo();
      var od = new api.VolumeAccessInfo.fromJson(o.toJson());
      checkVolumeAccessInfo(od);
    });
  });


  unittest.group("obj-schema-VolumeLayerInfoLayers", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeLayerInfoLayers();
      var od = new api.VolumeLayerInfoLayers.fromJson(o.toJson());
      checkVolumeLayerInfoLayers(od);
    });
  });


  unittest.group("obj-schema-VolumeLayerInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeLayerInfo();
      var od = new api.VolumeLayerInfo.fromJson(o.toJson());
      checkVolumeLayerInfo(od);
    });
  });


  unittest.group("obj-schema-VolumeRecommendedInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeRecommendedInfo();
      var od = new api.VolumeRecommendedInfo.fromJson(o.toJson());
      checkVolumeRecommendedInfo(od);
    });
  });


  unittest.group("obj-schema-VolumeSaleInfoListPrice", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeSaleInfoListPrice();
      var od = new api.VolumeSaleInfoListPrice.fromJson(o.toJson());
      checkVolumeSaleInfoListPrice(od);
    });
  });


  unittest.group("obj-schema-VolumeSaleInfoOffersListPrice", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeSaleInfoOffersListPrice();
      var od = new api.VolumeSaleInfoOffersListPrice.fromJson(o.toJson());
      checkVolumeSaleInfoOffersListPrice(od);
    });
  });


  unittest.group("obj-schema-VolumeSaleInfoOffersRentalDuration", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeSaleInfoOffersRentalDuration();
      var od = new api.VolumeSaleInfoOffersRentalDuration.fromJson(o.toJson());
      checkVolumeSaleInfoOffersRentalDuration(od);
    });
  });


  unittest.group("obj-schema-VolumeSaleInfoOffersRetailPrice", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeSaleInfoOffersRetailPrice();
      var od = new api.VolumeSaleInfoOffersRetailPrice.fromJson(o.toJson());
      checkVolumeSaleInfoOffersRetailPrice(od);
    });
  });


  unittest.group("obj-schema-VolumeSaleInfoOffers", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeSaleInfoOffers();
      var od = new api.VolumeSaleInfoOffers.fromJson(o.toJson());
      checkVolumeSaleInfoOffers(od);
    });
  });


  unittest.group("obj-schema-VolumeSaleInfoRetailPrice", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeSaleInfoRetailPrice();
      var od = new api.VolumeSaleInfoRetailPrice.fromJson(o.toJson());
      checkVolumeSaleInfoRetailPrice(od);
    });
  });


  unittest.group("obj-schema-VolumeSaleInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeSaleInfo();
      var od = new api.VolumeSaleInfo.fromJson(o.toJson());
      checkVolumeSaleInfo(od);
    });
  });


  unittest.group("obj-schema-VolumeSearchInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeSearchInfo();
      var od = new api.VolumeSearchInfo.fromJson(o.toJson());
      checkVolumeSearchInfo(od);
    });
  });


  unittest.group("obj-schema-VolumeUserInfoCopy", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeUserInfoCopy();
      var od = new api.VolumeUserInfoCopy.fromJson(o.toJson());
      checkVolumeUserInfoCopy(od);
    });
  });


  unittest.group("obj-schema-VolumeUserInfoFamilySharing", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeUserInfoFamilySharing();
      var od = new api.VolumeUserInfoFamilySharing.fromJson(o.toJson());
      checkVolumeUserInfoFamilySharing(od);
    });
  });


  unittest.group("obj-schema-VolumeUserInfoRentalPeriod", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeUserInfoRentalPeriod();
      var od = new api.VolumeUserInfoRentalPeriod.fromJson(o.toJson());
      checkVolumeUserInfoRentalPeriod(od);
    });
  });


  unittest.group("obj-schema-VolumeUserInfoUserUploadedVolumeInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeUserInfoUserUploadedVolumeInfo();
      var od = new api.VolumeUserInfoUserUploadedVolumeInfo.fromJson(o.toJson());
      checkVolumeUserInfoUserUploadedVolumeInfo(od);
    });
  });


  unittest.group("obj-schema-VolumeUserInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeUserInfo();
      var od = new api.VolumeUserInfo.fromJson(o.toJson());
      checkVolumeUserInfo(od);
    });
  });


  unittest.group("obj-schema-VolumeVolumeInfoDimensions", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeVolumeInfoDimensions();
      var od = new api.VolumeVolumeInfoDimensions.fromJson(o.toJson());
      checkVolumeVolumeInfoDimensions(od);
    });
  });


  unittest.group("obj-schema-VolumeVolumeInfoImageLinks", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeVolumeInfoImageLinks();
      var od = new api.VolumeVolumeInfoImageLinks.fromJson(o.toJson());
      checkVolumeVolumeInfoImageLinks(od);
    });
  });


  unittest.group("obj-schema-VolumeVolumeInfoIndustryIdentifiers", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeVolumeInfoIndustryIdentifiers();
      var od = new api.VolumeVolumeInfoIndustryIdentifiers.fromJson(o.toJson());
      checkVolumeVolumeInfoIndustryIdentifiers(od);
    });
  });


  unittest.group("obj-schema-VolumeVolumeInfoPanelizationSummary", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeVolumeInfoPanelizationSummary();
      var od = new api.VolumeVolumeInfoPanelizationSummary.fromJson(o.toJson());
      checkVolumeVolumeInfoPanelizationSummary(od);
    });
  });


  unittest.group("obj-schema-VolumeVolumeInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeVolumeInfo();
      var od = new api.VolumeVolumeInfo.fromJson(o.toJson());
      checkVolumeVolumeInfo(od);
    });
  });


  unittest.group("obj-schema-Volume", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolume();
      var od = new api.Volume.fromJson(o.toJson());
      checkVolume(od);
    });
  });


  unittest.group("obj-schema-Volume2", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolume2();
      var od = new api.Volume2.fromJson(o.toJson());
      checkVolume2(od);
    });
  });


  unittest.group("obj-schema-VolumeannotationContentRanges", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeannotationContentRanges();
      var od = new api.VolumeannotationContentRanges.fromJson(o.toJson());
      checkVolumeannotationContentRanges(od);
    });
  });


  unittest.group("obj-schema-Volumeannotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeannotation();
      var od = new api.Volumeannotation.fromJson(o.toJson());
      checkVolumeannotation(od);
    });
  });


  unittest.group("obj-schema-Volumeannotations", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeannotations();
      var od = new api.Volumeannotations.fromJson(o.toJson());
      checkVolumeannotations(od);
    });
  });


  unittest.group("obj-schema-Volumes", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumes();
      var od = new api.Volumes.fromJson(o.toJson());
      checkVolumes(od);
    });
  });


  unittest.group("obj-schema-VolumeseriesinfoVolumeSeriesIssue", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeseriesinfoVolumeSeriesIssue();
      var od = new api.VolumeseriesinfoVolumeSeriesIssue.fromJson(o.toJson());
      checkVolumeseriesinfoVolumeSeriesIssue(od);
    });
  });


  unittest.group("obj-schema-VolumeseriesinfoVolumeSeries", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeseriesinfoVolumeSeries();
      var od = new api.VolumeseriesinfoVolumeSeries.fromJson(o.toJson());
      checkVolumeseriesinfoVolumeSeries(od);
    });
  });


  unittest.group("obj-schema-Volumeseriesinfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildVolumeseriesinfo();
      var od = new api.Volumeseriesinfo.fromJson(o.toJson());
      checkVolumeseriesinfo(od);
    });
  });


  unittest.group("resource-BookshelvesResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.BookshelvesResourceApi res = new api.BooksApi(mock).bookshelves;
      var arg_userId = "foo";
      var arg_shelf = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("users/"));
        pathOffset += 6;
        index = path.indexOf("/bookshelves/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_userId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/bookshelves/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_shelf"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBookshelf());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_userId, arg_shelf, source: arg_source).then(unittest.expectAsync(((api.Bookshelf response) {
        checkBookshelf(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.BookshelvesResourceApi res = new api.BooksApi(mock).bookshelves;
      var arg_userId = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("users/"));
        pathOffset += 6;
        index = path.indexOf("/bookshelves", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_userId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("/bookshelves"));
        pathOffset += 12;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBookshelves());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_userId, source: arg_source).then(unittest.expectAsync(((api.Bookshelves response) {
        checkBookshelves(response);
      })));
    });

  });


  unittest.group("resource-BookshelvesVolumesResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.BookshelvesVolumesResourceApi res = new api.BooksApi(mock).bookshelves.volumes;
      var arg_userId = "foo";
      var arg_shelf = "foo";
      var arg_maxResults = 42;
      var arg_showPreorders = true;
      var arg_source = "foo";
      var arg_startIndex = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("users/"));
        pathOffset += 6;
        index = path.indexOf("/bookshelves/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_userId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/bookshelves/"));
        pathOffset += 13;
        index = path.indexOf("/volumes", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_shelf"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/volumes"));
        pathOffset += 8;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["showPreorders"].first, unittest.equals("$arg_showPreorders"));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(core.int.parse(queryMap["startIndex"].first), unittest.equals(arg_startIndex));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolumes());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_userId, arg_shelf, maxResults: arg_maxResults, showPreorders: arg_showPreorders, source: arg_source, startIndex: arg_startIndex).then(unittest.expectAsync(((api.Volumes response) {
        checkVolumes(response);
      })));
    });

  });


  unittest.group("resource-CloudloadingResourceApi", () {
    unittest.test("method--addBook", () {

      var mock = new HttpServerMock();
      api.CloudloadingResourceApi res = new api.BooksApi(mock).cloudloading;
      var arg_driveDocumentId = "foo";
      var arg_mimeType = "foo";
      var arg_name = "foo";
      var arg_uploadClientToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 20), unittest.equals("cloudloading/addBook"));
        pathOffset += 20;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["drive_document_id"].first, unittest.equals(arg_driveDocumentId));
        unittest.expect(queryMap["mime_type"].first, unittest.equals(arg_mimeType));
        unittest.expect(queryMap["name"].first, unittest.equals(arg_name));
        unittest.expect(queryMap["upload_client_token"].first, unittest.equals(arg_uploadClientToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBooksCloudloadingResource());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.addBook(driveDocumentId: arg_driveDocumentId, mimeType: arg_mimeType, name: arg_name, uploadClientToken: arg_uploadClientToken).then(unittest.expectAsync(((api.BooksCloudloadingResource response) {
        checkBooksCloudloadingResource(response);
      })));
    });

    unittest.test("method--deleteBook", () {

      var mock = new HttpServerMock();
      api.CloudloadingResourceApi res = new api.BooksApi(mock).cloudloading;
      var arg_volumeId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 23), unittest.equals("cloudloading/deleteBook"));
        pathOffset += 23;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["volumeId"].first, unittest.equals(arg_volumeId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.deleteBook(arg_volumeId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--updateBook", () {

      var mock = new HttpServerMock();
      api.CloudloadingResourceApi res = new api.BooksApi(mock).cloudloading;
      var arg_request = buildBooksCloudloadingResource();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.BooksCloudloadingResource.fromJson(json);
        checkBooksCloudloadingResource(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 23), unittest.equals("cloudloading/updateBook"));
        pathOffset += 23;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBooksCloudloadingResource());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.updateBook(arg_request).then(unittest.expectAsync(((api.BooksCloudloadingResource response) {
        checkBooksCloudloadingResource(response);
      })));
    });

  });


  unittest.group("resource-DictionaryResourceApi", () {
    unittest.test("method--listOfflineMetadata", () {

      var mock = new HttpServerMock();
      api.DictionaryResourceApi res = new api.BooksApi(mock).dictionary;
      var arg_cpksver = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 30), unittest.equals("dictionary/listOfflineMetadata"));
        pathOffset += 30;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["cpksver"].first, unittest.equals(arg_cpksver));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildMetadata());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listOfflineMetadata(arg_cpksver).then(unittest.expectAsync(((api.Metadata response) {
        checkMetadata(response);
      })));
    });

  });


  unittest.group("resource-LayersResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.LayersResourceApi res = new api.BooksApi(mock).layers;
      var arg_volumeId = "foo";
      var arg_summaryId = "foo";
      var arg_contentVersion = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("volumes/"));
        pathOffset += 8;
        index = path.indexOf("/layersummary/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_volumeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("/layersummary/"));
        pathOffset += 14;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_summaryId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["contentVersion"].first, unittest.equals(arg_contentVersion));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildLayersummary());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_volumeId, arg_summaryId, contentVersion: arg_contentVersion, source: arg_source).then(unittest.expectAsync(((api.Layersummary response) {
        checkLayersummary(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.LayersResourceApi res = new api.BooksApi(mock).layers;
      var arg_volumeId = "foo";
      var arg_contentVersion = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("volumes/"));
        pathOffset += 8;
        index = path.indexOf("/layersummary", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_volumeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/layersummary"));
        pathOffset += 13;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["contentVersion"].first, unittest.equals(arg_contentVersion));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildLayersummaries());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_volumeId, contentVersion: arg_contentVersion, maxResults: arg_maxResults, pageToken: arg_pageToken, source: arg_source).then(unittest.expectAsync(((api.Layersummaries response) {
        checkLayersummaries(response);
      })));
    });

  });


  unittest.group("resource-LayersAnnotationDataResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.LayersAnnotationDataResourceApi res = new api.BooksApi(mock).layers.annotationData;
      var arg_volumeId = "foo";
      var arg_layerId = "foo";
      var arg_annotationDataId = "foo";
      var arg_contentVersion = "foo";
      var arg_allowWebDefinitions = true;
      var arg_h = 42;
      var arg_locale = "foo";
      var arg_scale = 42;
      var arg_source = "foo";
      var arg_w = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("volumes/"));
        pathOffset += 8;
        index = path.indexOf("/layers/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_volumeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/layers/"));
        pathOffset += 8;
        index = path.indexOf("/data/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_layerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/data/"));
        pathOffset += 6;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_annotationDataId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["contentVersion"].first, unittest.equals(arg_contentVersion));
        unittest.expect(queryMap["allowWebDefinitions"].first, unittest.equals("$arg_allowWebDefinitions"));
        unittest.expect(core.int.parse(queryMap["h"].first), unittest.equals(arg_h));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["scale"].first), unittest.equals(arg_scale));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(core.int.parse(queryMap["w"].first), unittest.equals(arg_w));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAnnotationdata());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_volumeId, arg_layerId, arg_annotationDataId, arg_contentVersion, allowWebDefinitions: arg_allowWebDefinitions, h: arg_h, locale: arg_locale, scale: arg_scale, source: arg_source, w: arg_w).then(unittest.expectAsync(((api.Annotationdata response) {
        checkAnnotationdata(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.LayersAnnotationDataResourceApi res = new api.BooksApi(mock).layers.annotationData;
      var arg_volumeId = "foo";
      var arg_layerId = "foo";
      var arg_contentVersion = "foo";
      var arg_annotationDataId = buildUnnamed830();
      var arg_h = 42;
      var arg_locale = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_scale = 42;
      var arg_source = "foo";
      var arg_updatedMax = "foo";
      var arg_updatedMin = "foo";
      var arg_w = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("volumes/"));
        pathOffset += 8;
        index = path.indexOf("/layers/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_volumeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/layers/"));
        pathOffset += 8;
        index = path.indexOf("/data", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_layerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/data"));
        pathOffset += 5;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["contentVersion"].first, unittest.equals(arg_contentVersion));
        unittest.expect(queryMap["annotationDataId"], unittest.equals(arg_annotationDataId));
        unittest.expect(core.int.parse(queryMap["h"].first), unittest.equals(arg_h));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["scale"].first), unittest.equals(arg_scale));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(queryMap["updatedMax"].first, unittest.equals(arg_updatedMax));
        unittest.expect(queryMap["updatedMin"].first, unittest.equals(arg_updatedMin));
        unittest.expect(core.int.parse(queryMap["w"].first), unittest.equals(arg_w));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAnnotationsdata());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_volumeId, arg_layerId, arg_contentVersion, annotationDataId: arg_annotationDataId, h: arg_h, locale: arg_locale, maxResults: arg_maxResults, pageToken: arg_pageToken, scale: arg_scale, source: arg_source, updatedMax: arg_updatedMax, updatedMin: arg_updatedMin, w: arg_w).then(unittest.expectAsync(((api.Annotationsdata response) {
        checkAnnotationsdata(response);
      })));
    });

  });


  unittest.group("resource-LayersVolumeAnnotationsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.LayersVolumeAnnotationsResourceApi res = new api.BooksApi(mock).layers.volumeAnnotations;
      var arg_volumeId = "foo";
      var arg_layerId = "foo";
      var arg_annotationId = "foo";
      var arg_locale = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("volumes/"));
        pathOffset += 8;
        index = path.indexOf("/layers/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_volumeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/layers/"));
        pathOffset += 8;
        index = path.indexOf("/annotations/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_layerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/annotations/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_annotationId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolumeannotation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_volumeId, arg_layerId, arg_annotationId, locale: arg_locale, source: arg_source).then(unittest.expectAsync(((api.Volumeannotation response) {
        checkVolumeannotation(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.LayersVolumeAnnotationsResourceApi res = new api.BooksApi(mock).layers.volumeAnnotations;
      var arg_volumeId = "foo";
      var arg_layerId = "foo";
      var arg_contentVersion = "foo";
      var arg_endOffset = "foo";
      var arg_endPosition = "foo";
      var arg_locale = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_showDeleted = true;
      var arg_source = "foo";
      var arg_startOffset = "foo";
      var arg_startPosition = "foo";
      var arg_updatedMax = "foo";
      var arg_updatedMin = "foo";
      var arg_volumeAnnotationsVersion = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("volumes/"));
        pathOffset += 8;
        index = path.indexOf("/layers/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_volumeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/layers/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_layerId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["contentVersion"].first, unittest.equals(arg_contentVersion));
        unittest.expect(queryMap["endOffset"].first, unittest.equals(arg_endOffset));
        unittest.expect(queryMap["endPosition"].first, unittest.equals(arg_endPosition));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["showDeleted"].first, unittest.equals("$arg_showDeleted"));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(queryMap["startOffset"].first, unittest.equals(arg_startOffset));
        unittest.expect(queryMap["startPosition"].first, unittest.equals(arg_startPosition));
        unittest.expect(queryMap["updatedMax"].first, unittest.equals(arg_updatedMax));
        unittest.expect(queryMap["updatedMin"].first, unittest.equals(arg_updatedMin));
        unittest.expect(queryMap["volumeAnnotationsVersion"].first, unittest.equals(arg_volumeAnnotationsVersion));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolumeannotations());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_volumeId, arg_layerId, arg_contentVersion, endOffset: arg_endOffset, endPosition: arg_endPosition, locale: arg_locale, maxResults: arg_maxResults, pageToken: arg_pageToken, showDeleted: arg_showDeleted, source: arg_source, startOffset: arg_startOffset, startPosition: arg_startPosition, updatedMax: arg_updatedMax, updatedMin: arg_updatedMin, volumeAnnotationsVersion: arg_volumeAnnotationsVersion).then(unittest.expectAsync(((api.Volumeannotations response) {
        checkVolumeannotations(response);
      })));
    });

  });


  unittest.group("resource-MyconfigResourceApi", () {
    unittest.test("method--getUserSettings", () {

      var mock = new HttpServerMock();
      api.MyconfigResourceApi res = new api.BooksApi(mock).myconfig;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 24), unittest.equals("myconfig/getUserSettings"));
        pathOffset += 24;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildUsersettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getUserSettings().then(unittest.expectAsync(((api.Usersettings response) {
        checkUsersettings(response);
      })));
    });

    unittest.test("method--releaseDownloadAccess", () {

      var mock = new HttpServerMock();
      api.MyconfigResourceApi res = new api.BooksApi(mock).myconfig;
      var arg_volumeIds = buildUnnamed831();
      var arg_cpksver = "foo";
      var arg_locale = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 30), unittest.equals("myconfig/releaseDownloadAccess"));
        pathOffset += 30;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["volumeIds"], unittest.equals(arg_volumeIds));
        unittest.expect(queryMap["cpksver"].first, unittest.equals(arg_cpksver));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildDownloadAccesses());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.releaseDownloadAccess(arg_volumeIds, arg_cpksver, locale: arg_locale, source: arg_source).then(unittest.expectAsync(((api.DownloadAccesses response) {
        checkDownloadAccesses(response);
      })));
    });

    unittest.test("method--requestAccess", () {

      var mock = new HttpServerMock();
      api.MyconfigResourceApi res = new api.BooksApi(mock).myconfig;
      var arg_source = "foo";
      var arg_volumeId = "foo";
      var arg_nonce = "foo";
      var arg_cpksver = "foo";
      var arg_licenseTypes = "foo";
      var arg_locale = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("myconfig/requestAccess"));
        pathOffset += 22;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(queryMap["volumeId"].first, unittest.equals(arg_volumeId));
        unittest.expect(queryMap["nonce"].first, unittest.equals(arg_nonce));
        unittest.expect(queryMap["cpksver"].first, unittest.equals(arg_cpksver));
        unittest.expect(queryMap["licenseTypes"].first, unittest.equals(arg_licenseTypes));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildRequestAccess());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.requestAccess(arg_source, arg_volumeId, arg_nonce, arg_cpksver, licenseTypes: arg_licenseTypes, locale: arg_locale).then(unittest.expectAsync(((api.RequestAccess response) {
        checkRequestAccess(response);
      })));
    });

    unittest.test("method--syncVolumeLicenses", () {

      var mock = new HttpServerMock();
      api.MyconfigResourceApi res = new api.BooksApi(mock).myconfig;
      var arg_source = "foo";
      var arg_nonce = "foo";
      var arg_cpksver = "foo";
      var arg_features = buildUnnamed832();
      var arg_includeNonComicsSeries = true;
      var arg_locale = "foo";
      var arg_showPreorders = true;
      var arg_volumeIds = buildUnnamed833();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 27), unittest.equals("myconfig/syncVolumeLicenses"));
        pathOffset += 27;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(queryMap["nonce"].first, unittest.equals(arg_nonce));
        unittest.expect(queryMap["cpksver"].first, unittest.equals(arg_cpksver));
        unittest.expect(queryMap["features"], unittest.equals(arg_features));
        unittest.expect(queryMap["includeNonComicsSeries"].first, unittest.equals("$arg_includeNonComicsSeries"));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["showPreorders"].first, unittest.equals("$arg_showPreorders"));
        unittest.expect(queryMap["volumeIds"], unittest.equals(arg_volumeIds));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolumes());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.syncVolumeLicenses(arg_source, arg_nonce, arg_cpksver, features: arg_features, includeNonComicsSeries: arg_includeNonComicsSeries, locale: arg_locale, showPreorders: arg_showPreorders, volumeIds: arg_volumeIds).then(unittest.expectAsync(((api.Volumes response) {
        checkVolumes(response);
      })));
    });

    unittest.test("method--updateUserSettings", () {

      var mock = new HttpServerMock();
      api.MyconfigResourceApi res = new api.BooksApi(mock).myconfig;
      var arg_request = buildUsersettings();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Usersettings.fromJson(json);
        checkUsersettings(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 27), unittest.equals("myconfig/updateUserSettings"));
        pathOffset += 27;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildUsersettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.updateUserSettings(arg_request).then(unittest.expectAsync(((api.Usersettings response) {
        checkUsersettings(response);
      })));
    });

  });


  unittest.group("resource-MylibraryAnnotationsResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.MylibraryAnnotationsResourceApi res = new api.BooksApi(mock).mylibrary.annotations;
      var arg_annotationId = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("mylibrary/annotations/"));
        pathOffset += 22;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_annotationId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_annotationId, source: arg_source).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.MylibraryAnnotationsResourceApi res = new api.BooksApi(mock).mylibrary.annotations;
      var arg_request = buildAnnotation();
      var arg_country = "foo";
      var arg_showOnlySummaryInResponse = true;
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Annotation.fromJson(json);
        checkAnnotation(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("mylibrary/annotations"));
        pathOffset += 21;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["country"].first, unittest.equals(arg_country));
        unittest.expect(queryMap["showOnlySummaryInResponse"].first, unittest.equals("$arg_showOnlySummaryInResponse"));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAnnotation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, country: arg_country, showOnlySummaryInResponse: arg_showOnlySummaryInResponse, source: arg_source).then(unittest.expectAsync(((api.Annotation response) {
        checkAnnotation(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.MylibraryAnnotationsResourceApi res = new api.BooksApi(mock).mylibrary.annotations;
      var arg_contentVersion = "foo";
      var arg_layerId = "foo";
      var arg_layerIds = buildUnnamed834();
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_showDeleted = true;
      var arg_source = "foo";
      var arg_updatedMax = "foo";
      var arg_updatedMin = "foo";
      var arg_volumeId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("mylibrary/annotations"));
        pathOffset += 21;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["contentVersion"].first, unittest.equals(arg_contentVersion));
        unittest.expect(queryMap["layerId"].first, unittest.equals(arg_layerId));
        unittest.expect(queryMap["layerIds"], unittest.equals(arg_layerIds));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["showDeleted"].first, unittest.equals("$arg_showDeleted"));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(queryMap["updatedMax"].first, unittest.equals(arg_updatedMax));
        unittest.expect(queryMap["updatedMin"].first, unittest.equals(arg_updatedMin));
        unittest.expect(queryMap["volumeId"].first, unittest.equals(arg_volumeId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAnnotations());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(contentVersion: arg_contentVersion, layerId: arg_layerId, layerIds: arg_layerIds, maxResults: arg_maxResults, pageToken: arg_pageToken, showDeleted: arg_showDeleted, source: arg_source, updatedMax: arg_updatedMax, updatedMin: arg_updatedMin, volumeId: arg_volumeId).then(unittest.expectAsync(((api.Annotations response) {
        checkAnnotations(response);
      })));
    });

    unittest.test("method--summary", () {

      var mock = new HttpServerMock();
      api.MylibraryAnnotationsResourceApi res = new api.BooksApi(mock).mylibrary.annotations;
      var arg_layerIds = buildUnnamed835();
      var arg_volumeId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 29), unittest.equals("mylibrary/annotations/summary"));
        pathOffset += 29;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["layerIds"], unittest.equals(arg_layerIds));
        unittest.expect(queryMap["volumeId"].first, unittest.equals(arg_volumeId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAnnotationsSummary());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.summary(arg_layerIds, arg_volumeId).then(unittest.expectAsync(((api.AnnotationsSummary response) {
        checkAnnotationsSummary(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.MylibraryAnnotationsResourceApi res = new api.BooksApi(mock).mylibrary.annotations;
      var arg_request = buildAnnotation();
      var arg_annotationId = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Annotation.fromJson(json);
        checkAnnotation(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("mylibrary/annotations/"));
        pathOffset += 22;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_annotationId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAnnotation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_annotationId, source: arg_source).then(unittest.expectAsync(((api.Annotation response) {
        checkAnnotation(response);
      })));
    });

  });


  unittest.group("resource-MylibraryBookshelvesResourceApi", () {
    unittest.test("method--addVolume", () {

      var mock = new HttpServerMock();
      api.MylibraryBookshelvesResourceApi res = new api.BooksApi(mock).mylibrary.bookshelves;
      var arg_shelf = "foo";
      var arg_volumeId = "foo";
      var arg_reason = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("mylibrary/bookshelves/"));
        pathOffset += 22;
        index = path.indexOf("/addVolume", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_shelf"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/addVolume"));
        pathOffset += 10;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["volumeId"].first, unittest.equals(arg_volumeId));
        unittest.expect(queryMap["reason"].first, unittest.equals(arg_reason));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.addVolume(arg_shelf, arg_volumeId, reason: arg_reason, source: arg_source).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--clearVolumes", () {

      var mock = new HttpServerMock();
      api.MylibraryBookshelvesResourceApi res = new api.BooksApi(mock).mylibrary.bookshelves;
      var arg_shelf = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("mylibrary/bookshelves/"));
        pathOffset += 22;
        index = path.indexOf("/clearVolumes", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_shelf"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/clearVolumes"));
        pathOffset += 13;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.clearVolumes(arg_shelf, source: arg_source).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.MylibraryBookshelvesResourceApi res = new api.BooksApi(mock).mylibrary.bookshelves;
      var arg_shelf = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("mylibrary/bookshelves/"));
        pathOffset += 22;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_shelf"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBookshelf());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_shelf, source: arg_source).then(unittest.expectAsync(((api.Bookshelf response) {
        checkBookshelf(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.MylibraryBookshelvesResourceApi res = new api.BooksApi(mock).mylibrary.bookshelves;
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("mylibrary/bookshelves"));
        pathOffset += 21;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBookshelves());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(source: arg_source).then(unittest.expectAsync(((api.Bookshelves response) {
        checkBookshelves(response);
      })));
    });

    unittest.test("method--moveVolume", () {

      var mock = new HttpServerMock();
      api.MylibraryBookshelvesResourceApi res = new api.BooksApi(mock).mylibrary.bookshelves;
      var arg_shelf = "foo";
      var arg_volumeId = "foo";
      var arg_volumePosition = 42;
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("mylibrary/bookshelves/"));
        pathOffset += 22;
        index = path.indexOf("/moveVolume", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_shelf"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("/moveVolume"));
        pathOffset += 11;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["volumeId"].first, unittest.equals(arg_volumeId));
        unittest.expect(core.int.parse(queryMap["volumePosition"].first), unittest.equals(arg_volumePosition));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.moveVolume(arg_shelf, arg_volumeId, arg_volumePosition, source: arg_source).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--removeVolume", () {

      var mock = new HttpServerMock();
      api.MylibraryBookshelvesResourceApi res = new api.BooksApi(mock).mylibrary.bookshelves;
      var arg_shelf = "foo";
      var arg_volumeId = "foo";
      var arg_reason = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("mylibrary/bookshelves/"));
        pathOffset += 22;
        index = path.indexOf("/removeVolume", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_shelf"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/removeVolume"));
        pathOffset += 13;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["volumeId"].first, unittest.equals(arg_volumeId));
        unittest.expect(queryMap["reason"].first, unittest.equals(arg_reason));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.removeVolume(arg_shelf, arg_volumeId, reason: arg_reason, source: arg_source).then(unittest.expectAsync((_) {}));
    });

  });


  unittest.group("resource-MylibraryBookshelvesVolumesResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.MylibraryBookshelvesVolumesResourceApi res = new api.BooksApi(mock).mylibrary.bookshelves.volumes;
      var arg_shelf = "foo";
      var arg_country = "foo";
      var arg_maxResults = 42;
      var arg_projection = "foo";
      var arg_q = "foo";
      var arg_showPreorders = true;
      var arg_source = "foo";
      var arg_startIndex = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("mylibrary/bookshelves/"));
        pathOffset += 22;
        index = path.indexOf("/volumes", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_shelf"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/volumes"));
        pathOffset += 8;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["country"].first, unittest.equals(arg_country));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["projection"].first, unittest.equals(arg_projection));
        unittest.expect(queryMap["q"].first, unittest.equals(arg_q));
        unittest.expect(queryMap["showPreorders"].first, unittest.equals("$arg_showPreorders"));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(core.int.parse(queryMap["startIndex"].first), unittest.equals(arg_startIndex));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolumes());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_shelf, country: arg_country, maxResults: arg_maxResults, projection: arg_projection, q: arg_q, showPreorders: arg_showPreorders, source: arg_source, startIndex: arg_startIndex).then(unittest.expectAsync(((api.Volumes response) {
        checkVolumes(response);
      })));
    });

  });


  unittest.group("resource-MylibraryReadingpositionsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.MylibraryReadingpositionsResourceApi res = new api.BooksApi(mock).mylibrary.readingpositions;
      var arg_volumeId = "foo";
      var arg_contentVersion = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 27), unittest.equals("mylibrary/readingpositions/"));
        pathOffset += 27;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_volumeId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["contentVersion"].first, unittest.equals(arg_contentVersion));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildReadingPosition());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_volumeId, contentVersion: arg_contentVersion, source: arg_source).then(unittest.expectAsync(((api.ReadingPosition response) {
        checkReadingPosition(response);
      })));
    });

    unittest.test("method--setPosition", () {

      var mock = new HttpServerMock();
      api.MylibraryReadingpositionsResourceApi res = new api.BooksApi(mock).mylibrary.readingpositions;
      var arg_volumeId = "foo";
      var arg_timestamp = "foo";
      var arg_position = "foo";
      var arg_action = "foo";
      var arg_contentVersion = "foo";
      var arg_deviceCookie = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 27), unittest.equals("mylibrary/readingpositions/"));
        pathOffset += 27;
        index = path.indexOf("/setPosition", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_volumeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("/setPosition"));
        pathOffset += 12;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["timestamp"].first, unittest.equals(arg_timestamp));
        unittest.expect(queryMap["position"].first, unittest.equals(arg_position));
        unittest.expect(queryMap["action"].first, unittest.equals(arg_action));
        unittest.expect(queryMap["contentVersion"].first, unittest.equals(arg_contentVersion));
        unittest.expect(queryMap["deviceCookie"].first, unittest.equals(arg_deviceCookie));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.setPosition(arg_volumeId, arg_timestamp, arg_position, action: arg_action, contentVersion: arg_contentVersion, deviceCookie: arg_deviceCookie, source: arg_source).then(unittest.expectAsync((_) {}));
    });

  });


  unittest.group("resource-NotificationResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.NotificationResourceApi res = new api.BooksApi(mock).notification;
      var arg_notificationId = "foo";
      var arg_locale = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("notification/get"));
        pathOffset += 16;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["notification_id"].first, unittest.equals(arg_notificationId));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildNotification());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_notificationId, locale: arg_locale, source: arg_source).then(unittest.expectAsync(((api.Notification response) {
        checkNotification(response);
      })));
    });

  });


  unittest.group("resource-OnboardingResourceApi", () {
    unittest.test("method--listCategories", () {

      var mock = new HttpServerMock();
      api.OnboardingResourceApi res = new api.BooksApi(mock).onboarding;
      var arg_locale = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 25), unittest.equals("onboarding/listCategories"));
        pathOffset += 25;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCategory());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listCategories(locale: arg_locale).then(unittest.expectAsync(((api.Category response) {
        checkCategory(response);
      })));
    });

    unittest.test("method--listCategoryVolumes", () {

      var mock = new HttpServerMock();
      api.OnboardingResourceApi res = new api.BooksApi(mock).onboarding;
      var arg_categoryId = buildUnnamed836();
      var arg_locale = "foo";
      var arg_maxAllowedMaturityRating = "foo";
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 30), unittest.equals("onboarding/listCategoryVolumes"));
        pathOffset += 30;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["categoryId"], unittest.equals(arg_categoryId));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["maxAllowedMaturityRating"].first, unittest.equals(arg_maxAllowedMaturityRating));
        unittest.expect(core.int.parse(queryMap["pageSize"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolume2());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listCategoryVolumes(categoryId: arg_categoryId, locale: arg_locale, maxAllowedMaturityRating: arg_maxAllowedMaturityRating, pageSize: arg_pageSize, pageToken: arg_pageToken).then(unittest.expectAsync(((api.Volume2 response) {
        checkVolume2(response);
      })));
    });

  });


  unittest.group("resource-PersonalizedstreamResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.PersonalizedstreamResourceApi res = new api.BooksApi(mock).personalizedstream;
      var arg_locale = "foo";
      var arg_maxAllowedMaturityRating = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("personalizedstream/get"));
        pathOffset += 22;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["maxAllowedMaturityRating"].first, unittest.equals(arg_maxAllowedMaturityRating));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildDiscoveryclusters());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(locale: arg_locale, maxAllowedMaturityRating: arg_maxAllowedMaturityRating, source: arg_source).then(unittest.expectAsync(((api.Discoveryclusters response) {
        checkDiscoveryclusters(response);
      })));
    });

  });


  unittest.group("resource-PromoofferResourceApi", () {
    unittest.test("method--accept", () {

      var mock = new HttpServerMock();
      api.PromoofferResourceApi res = new api.BooksApi(mock).promooffer;
      var arg_androidId = "foo";
      var arg_device = "foo";
      var arg_manufacturer = "foo";
      var arg_model = "foo";
      var arg_offerId = "foo";
      var arg_product = "foo";
      var arg_serial = "foo";
      var arg_volumeId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("promooffer/accept"));
        pathOffset += 17;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["androidId"].first, unittest.equals(arg_androidId));
        unittest.expect(queryMap["device"].first, unittest.equals(arg_device));
        unittest.expect(queryMap["manufacturer"].first, unittest.equals(arg_manufacturer));
        unittest.expect(queryMap["model"].first, unittest.equals(arg_model));
        unittest.expect(queryMap["offerId"].first, unittest.equals(arg_offerId));
        unittest.expect(queryMap["product"].first, unittest.equals(arg_product));
        unittest.expect(queryMap["serial"].first, unittest.equals(arg_serial));
        unittest.expect(queryMap["volumeId"].first, unittest.equals(arg_volumeId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.accept(androidId: arg_androidId, device: arg_device, manufacturer: arg_manufacturer, model: arg_model, offerId: arg_offerId, product: arg_product, serial: arg_serial, volumeId: arg_volumeId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--dismiss", () {

      var mock = new HttpServerMock();
      api.PromoofferResourceApi res = new api.BooksApi(mock).promooffer;
      var arg_androidId = "foo";
      var arg_device = "foo";
      var arg_manufacturer = "foo";
      var arg_model = "foo";
      var arg_offerId = "foo";
      var arg_product = "foo";
      var arg_serial = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 18), unittest.equals("promooffer/dismiss"));
        pathOffset += 18;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["androidId"].first, unittest.equals(arg_androidId));
        unittest.expect(queryMap["device"].first, unittest.equals(arg_device));
        unittest.expect(queryMap["manufacturer"].first, unittest.equals(arg_manufacturer));
        unittest.expect(queryMap["model"].first, unittest.equals(arg_model));
        unittest.expect(queryMap["offerId"].first, unittest.equals(arg_offerId));
        unittest.expect(queryMap["product"].first, unittest.equals(arg_product));
        unittest.expect(queryMap["serial"].first, unittest.equals(arg_serial));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.dismiss(androidId: arg_androidId, device: arg_device, manufacturer: arg_manufacturer, model: arg_model, offerId: arg_offerId, product: arg_product, serial: arg_serial).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.PromoofferResourceApi res = new api.BooksApi(mock).promooffer;
      var arg_androidId = "foo";
      var arg_device = "foo";
      var arg_manufacturer = "foo";
      var arg_model = "foo";
      var arg_product = "foo";
      var arg_serial = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("promooffer/get"));
        pathOffset += 14;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["androidId"].first, unittest.equals(arg_androidId));
        unittest.expect(queryMap["device"].first, unittest.equals(arg_device));
        unittest.expect(queryMap["manufacturer"].first, unittest.equals(arg_manufacturer));
        unittest.expect(queryMap["model"].first, unittest.equals(arg_model));
        unittest.expect(queryMap["product"].first, unittest.equals(arg_product));
        unittest.expect(queryMap["serial"].first, unittest.equals(arg_serial));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildOffers());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(androidId: arg_androidId, device: arg_device, manufacturer: arg_manufacturer, model: arg_model, product: arg_product, serial: arg_serial).then(unittest.expectAsync(((api.Offers response) {
        checkOffers(response);
      })));
    });

  });


  unittest.group("resource-SeriesResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.SeriesResourceApi res = new api.BooksApi(mock).series;
      var arg_seriesId = buildUnnamed837();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("series/get"));
        pathOffset += 10;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["series_id"], unittest.equals(arg_seriesId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSeries());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_seriesId).then(unittest.expectAsync(((api.Series response) {
        checkSeries(response);
      })));
    });

  });


  unittest.group("resource-SeriesMembershipResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.SeriesMembershipResourceApi res = new api.BooksApi(mock).series.membership;
      var arg_seriesId = "foo";
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("series/membership/get"));
        pathOffset += 21;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["series_id"].first, unittest.equals(arg_seriesId));
        unittest.expect(core.int.parse(queryMap["page_size"].first), unittest.equals(arg_pageSize));
        unittest.expect(queryMap["page_token"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSeriesmembership());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_seriesId, pageSize: arg_pageSize, pageToken: arg_pageToken).then(unittest.expectAsync(((api.Seriesmembership response) {
        checkSeriesmembership(response);
      })));
    });

  });


  unittest.group("resource-VolumesResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.VolumesResourceApi res = new api.BooksApi(mock).volumes;
      var arg_volumeId = "foo";
      var arg_country = "foo";
      var arg_includeNonComicsSeries = true;
      var arg_partner = "foo";
      var arg_projection = "foo";
      var arg_source = "foo";
      var arg_userLibraryConsistentRead = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("volumes/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_volumeId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["country"].first, unittest.equals(arg_country));
        unittest.expect(queryMap["includeNonComicsSeries"].first, unittest.equals("$arg_includeNonComicsSeries"));
        unittest.expect(queryMap["partner"].first, unittest.equals(arg_partner));
        unittest.expect(queryMap["projection"].first, unittest.equals(arg_projection));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(queryMap["user_library_consistent_read"].first, unittest.equals("$arg_userLibraryConsistentRead"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolume());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_volumeId, country: arg_country, includeNonComicsSeries: arg_includeNonComicsSeries, partner: arg_partner, projection: arg_projection, source: arg_source, userLibraryConsistentRead: arg_userLibraryConsistentRead).then(unittest.expectAsync(((api.Volume response) {
        checkVolume(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.VolumesResourceApi res = new api.BooksApi(mock).volumes;
      var arg_q = "foo";
      var arg_download = "foo";
      var arg_filter = "foo";
      var arg_langRestrict = "foo";
      var arg_libraryRestrict = "foo";
      var arg_maxAllowedMaturityRating = "foo";
      var arg_maxResults = 42;
      var arg_orderBy = "foo";
      var arg_partner = "foo";
      var arg_printType = "foo";
      var arg_projection = "foo";
      var arg_showPreorders = true;
      var arg_source = "foo";
      var arg_startIndex = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("volumes"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["q"].first, unittest.equals(arg_q));
        unittest.expect(queryMap["download"].first, unittest.equals(arg_download));
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(queryMap["langRestrict"].first, unittest.equals(arg_langRestrict));
        unittest.expect(queryMap["libraryRestrict"].first, unittest.equals(arg_libraryRestrict));
        unittest.expect(queryMap["maxAllowedMaturityRating"].first, unittest.equals(arg_maxAllowedMaturityRating));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));
        unittest.expect(queryMap["partner"].first, unittest.equals(arg_partner));
        unittest.expect(queryMap["printType"].first, unittest.equals(arg_printType));
        unittest.expect(queryMap["projection"].first, unittest.equals(arg_projection));
        unittest.expect(queryMap["showPreorders"].first, unittest.equals("$arg_showPreorders"));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(core.int.parse(queryMap["startIndex"].first), unittest.equals(arg_startIndex));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolumes());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_q, download: arg_download, filter: arg_filter, langRestrict: arg_langRestrict, libraryRestrict: arg_libraryRestrict, maxAllowedMaturityRating: arg_maxAllowedMaturityRating, maxResults: arg_maxResults, orderBy: arg_orderBy, partner: arg_partner, printType: arg_printType, projection: arg_projection, showPreorders: arg_showPreorders, source: arg_source, startIndex: arg_startIndex).then(unittest.expectAsync(((api.Volumes response) {
        checkVolumes(response);
      })));
    });

  });


  unittest.group("resource-VolumesAssociatedResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.VolumesAssociatedResourceApi res = new api.BooksApi(mock).volumes.associated;
      var arg_volumeId = "foo";
      var arg_association = "foo";
      var arg_locale = "foo";
      var arg_maxAllowedMaturityRating = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("volumes/"));
        pathOffset += 8;
        index = path.indexOf("/associated", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_volumeId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("/associated"));
        pathOffset += 11;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["association"].first, unittest.equals(arg_association));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["maxAllowedMaturityRating"].first, unittest.equals(arg_maxAllowedMaturityRating));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolumes());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_volumeId, association: arg_association, locale: arg_locale, maxAllowedMaturityRating: arg_maxAllowedMaturityRating, source: arg_source).then(unittest.expectAsync(((api.Volumes response) {
        checkVolumes(response);
      })));
    });

  });


  unittest.group("resource-VolumesMybooksResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.VolumesMybooksResourceApi res = new api.BooksApi(mock).volumes.mybooks;
      var arg_acquireMethod = buildUnnamed838();
      var arg_country = "foo";
      var arg_locale = "foo";
      var arg_maxResults = 42;
      var arg_processingState = buildUnnamed839();
      var arg_source = "foo";
      var arg_startIndex = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("volumes/mybooks"));
        pathOffset += 15;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["acquireMethod"], unittest.equals(arg_acquireMethod));
        unittest.expect(queryMap["country"].first, unittest.equals(arg_country));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["processingState"], unittest.equals(arg_processingState));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(core.int.parse(queryMap["startIndex"].first), unittest.equals(arg_startIndex));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolumes());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(acquireMethod: arg_acquireMethod, country: arg_country, locale: arg_locale, maxResults: arg_maxResults, processingState: arg_processingState, source: arg_source, startIndex: arg_startIndex).then(unittest.expectAsync(((api.Volumes response) {
        checkVolumes(response);
      })));
    });

  });


  unittest.group("resource-VolumesRecommendedResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.VolumesRecommendedResourceApi res = new api.BooksApi(mock).volumes.recommended;
      var arg_locale = "foo";
      var arg_maxAllowedMaturityRating = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals("volumes/recommended"));
        pathOffset += 19;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["maxAllowedMaturityRating"].first, unittest.equals(arg_maxAllowedMaturityRating));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolumes());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(locale: arg_locale, maxAllowedMaturityRating: arg_maxAllowedMaturityRating, source: arg_source).then(unittest.expectAsync(((api.Volumes response) {
        checkVolumes(response);
      })));
    });

    unittest.test("method--rate", () {

      var mock = new HttpServerMock();
      api.VolumesRecommendedResourceApi res = new api.BooksApi(mock).volumes.recommended;
      var arg_rating = "foo";
      var arg_volumeId = "foo";
      var arg_locale = "foo";
      var arg_source = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 24), unittest.equals("volumes/recommended/rate"));
        pathOffset += 24;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["rating"].first, unittest.equals(arg_rating));
        unittest.expect(queryMap["volumeId"].first, unittest.equals(arg_volumeId));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBooksVolumesRecommendedRateResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.rate(arg_rating, arg_volumeId, locale: arg_locale, source: arg_source).then(unittest.expectAsync(((api.BooksVolumesRecommendedRateResponse response) {
        checkBooksVolumesRecommendedRateResponse(response);
      })));
    });

  });


  unittest.group("resource-VolumesUseruploadedResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.VolumesUseruploadedResourceApi res = new api.BooksApi(mock).volumes.useruploaded;
      var arg_locale = "foo";
      var arg_maxResults = 42;
      var arg_processingState = buildUnnamed840();
      var arg_source = "foo";
      var arg_startIndex = 42;
      var arg_volumeId = buildUnnamed841();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("books/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 20), unittest.equals("volumes/useruploaded"));
        pathOffset += 20;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["processingState"], unittest.equals(arg_processingState));
        unittest.expect(queryMap["source"].first, unittest.equals(arg_source));
        unittest.expect(core.int.parse(queryMap["startIndex"].first), unittest.equals(arg_startIndex));
        unittest.expect(queryMap["volumeId"], unittest.equals(arg_volumeId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildVolumes());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(locale: arg_locale, maxResults: arg_maxResults, processingState: arg_processingState, source: arg_source, startIndex: arg_startIndex, volumeId: arg_volumeId).then(unittest.expectAsync(((api.Volumes response) {
        checkVolumes(response);
      })));
    });

  });


}

