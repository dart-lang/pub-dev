library googleapis.slides.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/slides/v1.dart' as api;

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

core.int buildCounterAffineTransform = 0;
buildAffineTransform() {
  var o = new api.AffineTransform();
  buildCounterAffineTransform++;
  if (buildCounterAffineTransform < 3) {
    o.scaleX = 42.0;
    o.scaleY = 42.0;
    o.shearX = 42.0;
    o.shearY = 42.0;
    o.translateX = 42.0;
    o.translateY = 42.0;
    o.unit = "foo";
  }
  buildCounterAffineTransform--;
  return o;
}

checkAffineTransform(api.AffineTransform o) {
  buildCounterAffineTransform++;
  if (buildCounterAffineTransform < 3) {
    unittest.expect(o.scaleX, unittest.equals(42.0));
    unittest.expect(o.scaleY, unittest.equals(42.0));
    unittest.expect(o.shearX, unittest.equals(42.0));
    unittest.expect(o.shearY, unittest.equals(42.0));
    unittest.expect(o.translateX, unittest.equals(42.0));
    unittest.expect(o.translateY, unittest.equals(42.0));
    unittest.expect(o.unit, unittest.equals('foo'));
  }
  buildCounterAffineTransform--;
}

core.int buildCounterAutoText = 0;
buildAutoText() {
  var o = new api.AutoText();
  buildCounterAutoText++;
  if (buildCounterAutoText < 3) {
    o.content = "foo";
    o.style = buildTextStyle();
    o.type = "foo";
  }
  buildCounterAutoText--;
  return o;
}

checkAutoText(api.AutoText o) {
  buildCounterAutoText++;
  if (buildCounterAutoText < 3) {
    unittest.expect(o.content, unittest.equals('foo'));
    checkTextStyle(o.style);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterAutoText--;
}

buildUnnamed1457() {
  var o = new core.List<api.Request>();
  o.add(buildRequest());
  o.add(buildRequest());
  return o;
}

checkUnnamed1457(core.List<api.Request> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRequest(o[0]);
  checkRequest(o[1]);
}

core.int buildCounterBatchUpdatePresentationRequest = 0;
buildBatchUpdatePresentationRequest() {
  var o = new api.BatchUpdatePresentationRequest();
  buildCounterBatchUpdatePresentationRequest++;
  if (buildCounterBatchUpdatePresentationRequest < 3) {
    o.requests = buildUnnamed1457();
  }
  buildCounterBatchUpdatePresentationRequest--;
  return o;
}

checkBatchUpdatePresentationRequest(api.BatchUpdatePresentationRequest o) {
  buildCounterBatchUpdatePresentationRequest++;
  if (buildCounterBatchUpdatePresentationRequest < 3) {
    checkUnnamed1457(o.requests);
  }
  buildCounterBatchUpdatePresentationRequest--;
}

buildUnnamed1458() {
  var o = new core.List<api.Response>();
  o.add(buildResponse());
  o.add(buildResponse());
  return o;
}

checkUnnamed1458(core.List<api.Response> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResponse(o[0]);
  checkResponse(o[1]);
}

core.int buildCounterBatchUpdatePresentationResponse = 0;
buildBatchUpdatePresentationResponse() {
  var o = new api.BatchUpdatePresentationResponse();
  buildCounterBatchUpdatePresentationResponse++;
  if (buildCounterBatchUpdatePresentationResponse < 3) {
    o.presentationId = "foo";
    o.replies = buildUnnamed1458();
  }
  buildCounterBatchUpdatePresentationResponse--;
  return o;
}

checkBatchUpdatePresentationResponse(api.BatchUpdatePresentationResponse o) {
  buildCounterBatchUpdatePresentationResponse++;
  if (buildCounterBatchUpdatePresentationResponse < 3) {
    unittest.expect(o.presentationId, unittest.equals('foo'));
    checkUnnamed1458(o.replies);
  }
  buildCounterBatchUpdatePresentationResponse--;
}

core.int buildCounterBullet = 0;
buildBullet() {
  var o = new api.Bullet();
  buildCounterBullet++;
  if (buildCounterBullet < 3) {
    o.bulletStyle = buildTextStyle();
    o.glyph = "foo";
    o.listId = "foo";
    o.nestingLevel = 42;
  }
  buildCounterBullet--;
  return o;
}

checkBullet(api.Bullet o) {
  buildCounterBullet++;
  if (buildCounterBullet < 3) {
    checkTextStyle(o.bulletStyle);
    unittest.expect(o.glyph, unittest.equals('foo'));
    unittest.expect(o.listId, unittest.equals('foo'));
    unittest.expect(o.nestingLevel, unittest.equals(42));
  }
  buildCounterBullet--;
}

buildUnnamed1459() {
  var o = new core.List<api.ThemeColorPair>();
  o.add(buildThemeColorPair());
  o.add(buildThemeColorPair());
  return o;
}

checkUnnamed1459(core.List<api.ThemeColorPair> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkThemeColorPair(o[0]);
  checkThemeColorPair(o[1]);
}

core.int buildCounterColorScheme = 0;
buildColorScheme() {
  var o = new api.ColorScheme();
  buildCounterColorScheme++;
  if (buildCounterColorScheme < 3) {
    o.colors = buildUnnamed1459();
  }
  buildCounterColorScheme--;
  return o;
}

checkColorScheme(api.ColorScheme o) {
  buildCounterColorScheme++;
  if (buildCounterColorScheme < 3) {
    checkUnnamed1459(o.colors);
  }
  buildCounterColorScheme--;
}

core.int buildCounterColorStop = 0;
buildColorStop() {
  var o = new api.ColorStop();
  buildCounterColorStop++;
  if (buildCounterColorStop < 3) {
    o.alpha = 42.0;
    o.color = buildOpaqueColor();
    o.position = 42.0;
  }
  buildCounterColorStop--;
  return o;
}

checkColorStop(api.ColorStop o) {
  buildCounterColorStop++;
  if (buildCounterColorStop < 3) {
    unittest.expect(o.alpha, unittest.equals(42.0));
    checkOpaqueColor(o.color);
    unittest.expect(o.position, unittest.equals(42.0));
  }
  buildCounterColorStop--;
}

core.int buildCounterCreateImageRequest = 0;
buildCreateImageRequest() {
  var o = new api.CreateImageRequest();
  buildCounterCreateImageRequest++;
  if (buildCounterCreateImageRequest < 3) {
    o.elementProperties = buildPageElementProperties();
    o.objectId = "foo";
    o.url = "foo";
  }
  buildCounterCreateImageRequest--;
  return o;
}

checkCreateImageRequest(api.CreateImageRequest o) {
  buildCounterCreateImageRequest++;
  if (buildCounterCreateImageRequest < 3) {
    checkPageElementProperties(o.elementProperties);
    unittest.expect(o.objectId, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterCreateImageRequest--;
}

core.int buildCounterCreateImageResponse = 0;
buildCreateImageResponse() {
  var o = new api.CreateImageResponse();
  buildCounterCreateImageResponse++;
  if (buildCounterCreateImageResponse < 3) {
    o.objectId = "foo";
  }
  buildCounterCreateImageResponse--;
  return o;
}

checkCreateImageResponse(api.CreateImageResponse o) {
  buildCounterCreateImageResponse++;
  if (buildCounterCreateImageResponse < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterCreateImageResponse--;
}

core.int buildCounterCreateLineRequest = 0;
buildCreateLineRequest() {
  var o = new api.CreateLineRequest();
  buildCounterCreateLineRequest++;
  if (buildCounterCreateLineRequest < 3) {
    o.elementProperties = buildPageElementProperties();
    o.lineCategory = "foo";
    o.objectId = "foo";
  }
  buildCounterCreateLineRequest--;
  return o;
}

checkCreateLineRequest(api.CreateLineRequest o) {
  buildCounterCreateLineRequest++;
  if (buildCounterCreateLineRequest < 3) {
    checkPageElementProperties(o.elementProperties);
    unittest.expect(o.lineCategory, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterCreateLineRequest--;
}

core.int buildCounterCreateLineResponse = 0;
buildCreateLineResponse() {
  var o = new api.CreateLineResponse();
  buildCounterCreateLineResponse++;
  if (buildCounterCreateLineResponse < 3) {
    o.objectId = "foo";
  }
  buildCounterCreateLineResponse--;
  return o;
}

checkCreateLineResponse(api.CreateLineResponse o) {
  buildCounterCreateLineResponse++;
  if (buildCounterCreateLineResponse < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterCreateLineResponse--;
}

core.int buildCounterCreateParagraphBulletsRequest = 0;
buildCreateParagraphBulletsRequest() {
  var o = new api.CreateParagraphBulletsRequest();
  buildCounterCreateParagraphBulletsRequest++;
  if (buildCounterCreateParagraphBulletsRequest < 3) {
    o.bulletPreset = "foo";
    o.cellLocation = buildTableCellLocation();
    o.objectId = "foo";
    o.textRange = buildRange();
  }
  buildCounterCreateParagraphBulletsRequest--;
  return o;
}

checkCreateParagraphBulletsRequest(api.CreateParagraphBulletsRequest o) {
  buildCounterCreateParagraphBulletsRequest++;
  if (buildCounterCreateParagraphBulletsRequest < 3) {
    unittest.expect(o.bulletPreset, unittest.equals('foo'));
    checkTableCellLocation(o.cellLocation);
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkRange(o.textRange);
  }
  buildCounterCreateParagraphBulletsRequest--;
}

core.int buildCounterCreateShapeRequest = 0;
buildCreateShapeRequest() {
  var o = new api.CreateShapeRequest();
  buildCounterCreateShapeRequest++;
  if (buildCounterCreateShapeRequest < 3) {
    o.elementProperties = buildPageElementProperties();
    o.objectId = "foo";
    o.shapeType = "foo";
  }
  buildCounterCreateShapeRequest--;
  return o;
}

checkCreateShapeRequest(api.CreateShapeRequest o) {
  buildCounterCreateShapeRequest++;
  if (buildCounterCreateShapeRequest < 3) {
    checkPageElementProperties(o.elementProperties);
    unittest.expect(o.objectId, unittest.equals('foo'));
    unittest.expect(o.shapeType, unittest.equals('foo'));
  }
  buildCounterCreateShapeRequest--;
}

core.int buildCounterCreateShapeResponse = 0;
buildCreateShapeResponse() {
  var o = new api.CreateShapeResponse();
  buildCounterCreateShapeResponse++;
  if (buildCounterCreateShapeResponse < 3) {
    o.objectId = "foo";
  }
  buildCounterCreateShapeResponse--;
  return o;
}

checkCreateShapeResponse(api.CreateShapeResponse o) {
  buildCounterCreateShapeResponse++;
  if (buildCounterCreateShapeResponse < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterCreateShapeResponse--;
}

core.int buildCounterCreateSheetsChartRequest = 0;
buildCreateSheetsChartRequest() {
  var o = new api.CreateSheetsChartRequest();
  buildCounterCreateSheetsChartRequest++;
  if (buildCounterCreateSheetsChartRequest < 3) {
    o.chartId = 42;
    o.elementProperties = buildPageElementProperties();
    o.linkingMode = "foo";
    o.objectId = "foo";
    o.spreadsheetId = "foo";
  }
  buildCounterCreateSheetsChartRequest--;
  return o;
}

checkCreateSheetsChartRequest(api.CreateSheetsChartRequest o) {
  buildCounterCreateSheetsChartRequest++;
  if (buildCounterCreateSheetsChartRequest < 3) {
    unittest.expect(o.chartId, unittest.equals(42));
    checkPageElementProperties(o.elementProperties);
    unittest.expect(o.linkingMode, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
  }
  buildCounterCreateSheetsChartRequest--;
}

core.int buildCounterCreateSheetsChartResponse = 0;
buildCreateSheetsChartResponse() {
  var o = new api.CreateSheetsChartResponse();
  buildCounterCreateSheetsChartResponse++;
  if (buildCounterCreateSheetsChartResponse < 3) {
    o.objectId = "foo";
  }
  buildCounterCreateSheetsChartResponse--;
  return o;
}

checkCreateSheetsChartResponse(api.CreateSheetsChartResponse o) {
  buildCounterCreateSheetsChartResponse++;
  if (buildCounterCreateSheetsChartResponse < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterCreateSheetsChartResponse--;
}

buildUnnamed1460() {
  var o = new core.List<api.LayoutPlaceholderIdMapping>();
  o.add(buildLayoutPlaceholderIdMapping());
  o.add(buildLayoutPlaceholderIdMapping());
  return o;
}

checkUnnamed1460(core.List<api.LayoutPlaceholderIdMapping> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLayoutPlaceholderIdMapping(o[0]);
  checkLayoutPlaceholderIdMapping(o[1]);
}

core.int buildCounterCreateSlideRequest = 0;
buildCreateSlideRequest() {
  var o = new api.CreateSlideRequest();
  buildCounterCreateSlideRequest++;
  if (buildCounterCreateSlideRequest < 3) {
    o.insertionIndex = 42;
    o.objectId = "foo";
    o.placeholderIdMappings = buildUnnamed1460();
    o.slideLayoutReference = buildLayoutReference();
  }
  buildCounterCreateSlideRequest--;
  return o;
}

checkCreateSlideRequest(api.CreateSlideRequest o) {
  buildCounterCreateSlideRequest++;
  if (buildCounterCreateSlideRequest < 3) {
    unittest.expect(o.insertionIndex, unittest.equals(42));
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkUnnamed1460(o.placeholderIdMappings);
    checkLayoutReference(o.slideLayoutReference);
  }
  buildCounterCreateSlideRequest--;
}

core.int buildCounterCreateSlideResponse = 0;
buildCreateSlideResponse() {
  var o = new api.CreateSlideResponse();
  buildCounterCreateSlideResponse++;
  if (buildCounterCreateSlideResponse < 3) {
    o.objectId = "foo";
  }
  buildCounterCreateSlideResponse--;
  return o;
}

checkCreateSlideResponse(api.CreateSlideResponse o) {
  buildCounterCreateSlideResponse++;
  if (buildCounterCreateSlideResponse < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterCreateSlideResponse--;
}

core.int buildCounterCreateTableRequest = 0;
buildCreateTableRequest() {
  var o = new api.CreateTableRequest();
  buildCounterCreateTableRequest++;
  if (buildCounterCreateTableRequest < 3) {
    o.columns = 42;
    o.elementProperties = buildPageElementProperties();
    o.objectId = "foo";
    o.rows = 42;
  }
  buildCounterCreateTableRequest--;
  return o;
}

checkCreateTableRequest(api.CreateTableRequest o) {
  buildCounterCreateTableRequest++;
  if (buildCounterCreateTableRequest < 3) {
    unittest.expect(o.columns, unittest.equals(42));
    checkPageElementProperties(o.elementProperties);
    unittest.expect(o.objectId, unittest.equals('foo'));
    unittest.expect(o.rows, unittest.equals(42));
  }
  buildCounterCreateTableRequest--;
}

core.int buildCounterCreateTableResponse = 0;
buildCreateTableResponse() {
  var o = new api.CreateTableResponse();
  buildCounterCreateTableResponse++;
  if (buildCounterCreateTableResponse < 3) {
    o.objectId = "foo";
  }
  buildCounterCreateTableResponse--;
  return o;
}

checkCreateTableResponse(api.CreateTableResponse o) {
  buildCounterCreateTableResponse++;
  if (buildCounterCreateTableResponse < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterCreateTableResponse--;
}

core.int buildCounterCreateVideoRequest = 0;
buildCreateVideoRequest() {
  var o = new api.CreateVideoRequest();
  buildCounterCreateVideoRequest++;
  if (buildCounterCreateVideoRequest < 3) {
    o.elementProperties = buildPageElementProperties();
    o.id = "foo";
    o.objectId = "foo";
    o.source = "foo";
  }
  buildCounterCreateVideoRequest--;
  return o;
}

checkCreateVideoRequest(api.CreateVideoRequest o) {
  buildCounterCreateVideoRequest++;
  if (buildCounterCreateVideoRequest < 3) {
    checkPageElementProperties(o.elementProperties);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
    unittest.expect(o.source, unittest.equals('foo'));
  }
  buildCounterCreateVideoRequest--;
}

core.int buildCounterCreateVideoResponse = 0;
buildCreateVideoResponse() {
  var o = new api.CreateVideoResponse();
  buildCounterCreateVideoResponse++;
  if (buildCounterCreateVideoResponse < 3) {
    o.objectId = "foo";
  }
  buildCounterCreateVideoResponse--;
  return o;
}

checkCreateVideoResponse(api.CreateVideoResponse o) {
  buildCounterCreateVideoResponse++;
  if (buildCounterCreateVideoResponse < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterCreateVideoResponse--;
}

core.int buildCounterCropProperties = 0;
buildCropProperties() {
  var o = new api.CropProperties();
  buildCounterCropProperties++;
  if (buildCounterCropProperties < 3) {
    o.angle = 42.0;
    o.bottomOffset = 42.0;
    o.leftOffset = 42.0;
    o.rightOffset = 42.0;
    o.topOffset = 42.0;
  }
  buildCounterCropProperties--;
  return o;
}

checkCropProperties(api.CropProperties o) {
  buildCounterCropProperties++;
  if (buildCounterCropProperties < 3) {
    unittest.expect(o.angle, unittest.equals(42.0));
    unittest.expect(o.bottomOffset, unittest.equals(42.0));
    unittest.expect(o.leftOffset, unittest.equals(42.0));
    unittest.expect(o.rightOffset, unittest.equals(42.0));
    unittest.expect(o.topOffset, unittest.equals(42.0));
  }
  buildCounterCropProperties--;
}

core.int buildCounterDeleteObjectRequest = 0;
buildDeleteObjectRequest() {
  var o = new api.DeleteObjectRequest();
  buildCounterDeleteObjectRequest++;
  if (buildCounterDeleteObjectRequest < 3) {
    o.objectId = "foo";
  }
  buildCounterDeleteObjectRequest--;
  return o;
}

checkDeleteObjectRequest(api.DeleteObjectRequest o) {
  buildCounterDeleteObjectRequest++;
  if (buildCounterDeleteObjectRequest < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterDeleteObjectRequest--;
}

core.int buildCounterDeleteParagraphBulletsRequest = 0;
buildDeleteParagraphBulletsRequest() {
  var o = new api.DeleteParagraphBulletsRequest();
  buildCounterDeleteParagraphBulletsRequest++;
  if (buildCounterDeleteParagraphBulletsRequest < 3) {
    o.cellLocation = buildTableCellLocation();
    o.objectId = "foo";
    o.textRange = buildRange();
  }
  buildCounterDeleteParagraphBulletsRequest--;
  return o;
}

checkDeleteParagraphBulletsRequest(api.DeleteParagraphBulletsRequest o) {
  buildCounterDeleteParagraphBulletsRequest++;
  if (buildCounterDeleteParagraphBulletsRequest < 3) {
    checkTableCellLocation(o.cellLocation);
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkRange(o.textRange);
  }
  buildCounterDeleteParagraphBulletsRequest--;
}

core.int buildCounterDeleteTableColumnRequest = 0;
buildDeleteTableColumnRequest() {
  var o = new api.DeleteTableColumnRequest();
  buildCounterDeleteTableColumnRequest++;
  if (buildCounterDeleteTableColumnRequest < 3) {
    o.cellLocation = buildTableCellLocation();
    o.tableObjectId = "foo";
  }
  buildCounterDeleteTableColumnRequest--;
  return o;
}

checkDeleteTableColumnRequest(api.DeleteTableColumnRequest o) {
  buildCounterDeleteTableColumnRequest++;
  if (buildCounterDeleteTableColumnRequest < 3) {
    checkTableCellLocation(o.cellLocation);
    unittest.expect(o.tableObjectId, unittest.equals('foo'));
  }
  buildCounterDeleteTableColumnRequest--;
}

core.int buildCounterDeleteTableRowRequest = 0;
buildDeleteTableRowRequest() {
  var o = new api.DeleteTableRowRequest();
  buildCounterDeleteTableRowRequest++;
  if (buildCounterDeleteTableRowRequest < 3) {
    o.cellLocation = buildTableCellLocation();
    o.tableObjectId = "foo";
  }
  buildCounterDeleteTableRowRequest--;
  return o;
}

checkDeleteTableRowRequest(api.DeleteTableRowRequest o) {
  buildCounterDeleteTableRowRequest++;
  if (buildCounterDeleteTableRowRequest < 3) {
    checkTableCellLocation(o.cellLocation);
    unittest.expect(o.tableObjectId, unittest.equals('foo'));
  }
  buildCounterDeleteTableRowRequest--;
}

core.int buildCounterDeleteTextRequest = 0;
buildDeleteTextRequest() {
  var o = new api.DeleteTextRequest();
  buildCounterDeleteTextRequest++;
  if (buildCounterDeleteTextRequest < 3) {
    o.cellLocation = buildTableCellLocation();
    o.objectId = "foo";
    o.textRange = buildRange();
  }
  buildCounterDeleteTextRequest--;
  return o;
}

checkDeleteTextRequest(api.DeleteTextRequest o) {
  buildCounterDeleteTextRequest++;
  if (buildCounterDeleteTextRequest < 3) {
    checkTableCellLocation(o.cellLocation);
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkRange(o.textRange);
  }
  buildCounterDeleteTextRequest--;
}

core.int buildCounterDimension = 0;
buildDimension() {
  var o = new api.Dimension();
  buildCounterDimension++;
  if (buildCounterDimension < 3) {
    o.magnitude = 42.0;
    o.unit = "foo";
  }
  buildCounterDimension--;
  return o;
}

checkDimension(api.Dimension o) {
  buildCounterDimension++;
  if (buildCounterDimension < 3) {
    unittest.expect(o.magnitude, unittest.equals(42.0));
    unittest.expect(o.unit, unittest.equals('foo'));
  }
  buildCounterDimension--;
}

buildUnnamed1461() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed1461(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterDuplicateObjectRequest = 0;
buildDuplicateObjectRequest() {
  var o = new api.DuplicateObjectRequest();
  buildCounterDuplicateObjectRequest++;
  if (buildCounterDuplicateObjectRequest < 3) {
    o.objectId = "foo";
    o.objectIds = buildUnnamed1461();
  }
  buildCounterDuplicateObjectRequest--;
  return o;
}

checkDuplicateObjectRequest(api.DuplicateObjectRequest o) {
  buildCounterDuplicateObjectRequest++;
  if (buildCounterDuplicateObjectRequest < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkUnnamed1461(o.objectIds);
  }
  buildCounterDuplicateObjectRequest--;
}

core.int buildCounterDuplicateObjectResponse = 0;
buildDuplicateObjectResponse() {
  var o = new api.DuplicateObjectResponse();
  buildCounterDuplicateObjectResponse++;
  if (buildCounterDuplicateObjectResponse < 3) {
    o.objectId = "foo";
  }
  buildCounterDuplicateObjectResponse--;
  return o;
}

checkDuplicateObjectResponse(api.DuplicateObjectResponse o) {
  buildCounterDuplicateObjectResponse++;
  if (buildCounterDuplicateObjectResponse < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterDuplicateObjectResponse--;
}

buildUnnamed1462() {
  var o = new core.List<api.PageElement>();
  o.add(buildPageElement());
  o.add(buildPageElement());
  return o;
}

checkUnnamed1462(core.List<api.PageElement> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPageElement(o[0]);
  checkPageElement(o[1]);
}

core.int buildCounterGroup = 0;
buildGroup() {
  var o = new api.Group();
  buildCounterGroup++;
  if (buildCounterGroup < 3) {
    o.children = buildUnnamed1462();
  }
  buildCounterGroup--;
  return o;
}

checkGroup(api.Group o) {
  buildCounterGroup++;
  if (buildCounterGroup < 3) {
    checkUnnamed1462(o.children);
  }
  buildCounterGroup--;
}

core.int buildCounterImage = 0;
buildImage() {
  var o = new api.Image();
  buildCounterImage++;
  if (buildCounterImage < 3) {
    o.contentUrl = "foo";
    o.imageProperties = buildImageProperties();
  }
  buildCounterImage--;
  return o;
}

checkImage(api.Image o) {
  buildCounterImage++;
  if (buildCounterImage < 3) {
    unittest.expect(o.contentUrl, unittest.equals('foo'));
    checkImageProperties(o.imageProperties);
  }
  buildCounterImage--;
}

core.int buildCounterImageProperties = 0;
buildImageProperties() {
  var o = new api.ImageProperties();
  buildCounterImageProperties++;
  if (buildCounterImageProperties < 3) {
    o.brightness = 42.0;
    o.contrast = 42.0;
    o.cropProperties = buildCropProperties();
    o.link = buildLink();
    o.outline = buildOutline();
    o.recolor = buildRecolor();
    o.shadow = buildShadow();
    o.transparency = 42.0;
  }
  buildCounterImageProperties--;
  return o;
}

checkImageProperties(api.ImageProperties o) {
  buildCounterImageProperties++;
  if (buildCounterImageProperties < 3) {
    unittest.expect(o.brightness, unittest.equals(42.0));
    unittest.expect(o.contrast, unittest.equals(42.0));
    checkCropProperties(o.cropProperties);
    checkLink(o.link);
    checkOutline(o.outline);
    checkRecolor(o.recolor);
    checkShadow(o.shadow);
    unittest.expect(o.transparency, unittest.equals(42.0));
  }
  buildCounterImageProperties--;
}

core.int buildCounterInsertTableColumnsRequest = 0;
buildInsertTableColumnsRequest() {
  var o = new api.InsertTableColumnsRequest();
  buildCounterInsertTableColumnsRequest++;
  if (buildCounterInsertTableColumnsRequest < 3) {
    o.cellLocation = buildTableCellLocation();
    o.insertRight = true;
    o.number = 42;
    o.tableObjectId = "foo";
  }
  buildCounterInsertTableColumnsRequest--;
  return o;
}

checkInsertTableColumnsRequest(api.InsertTableColumnsRequest o) {
  buildCounterInsertTableColumnsRequest++;
  if (buildCounterInsertTableColumnsRequest < 3) {
    checkTableCellLocation(o.cellLocation);
    unittest.expect(o.insertRight, unittest.isTrue);
    unittest.expect(o.number, unittest.equals(42));
    unittest.expect(o.tableObjectId, unittest.equals('foo'));
  }
  buildCounterInsertTableColumnsRequest--;
}

core.int buildCounterInsertTableRowsRequest = 0;
buildInsertTableRowsRequest() {
  var o = new api.InsertTableRowsRequest();
  buildCounterInsertTableRowsRequest++;
  if (buildCounterInsertTableRowsRequest < 3) {
    o.cellLocation = buildTableCellLocation();
    o.insertBelow = true;
    o.number = 42;
    o.tableObjectId = "foo";
  }
  buildCounterInsertTableRowsRequest--;
  return o;
}

checkInsertTableRowsRequest(api.InsertTableRowsRequest o) {
  buildCounterInsertTableRowsRequest++;
  if (buildCounterInsertTableRowsRequest < 3) {
    checkTableCellLocation(o.cellLocation);
    unittest.expect(o.insertBelow, unittest.isTrue);
    unittest.expect(o.number, unittest.equals(42));
    unittest.expect(o.tableObjectId, unittest.equals('foo'));
  }
  buildCounterInsertTableRowsRequest--;
}

core.int buildCounterInsertTextRequest = 0;
buildInsertTextRequest() {
  var o = new api.InsertTextRequest();
  buildCounterInsertTextRequest++;
  if (buildCounterInsertTextRequest < 3) {
    o.cellLocation = buildTableCellLocation();
    o.insertionIndex = 42;
    o.objectId = "foo";
    o.text = "foo";
  }
  buildCounterInsertTextRequest--;
  return o;
}

checkInsertTextRequest(api.InsertTextRequest o) {
  buildCounterInsertTextRequest++;
  if (buildCounterInsertTextRequest < 3) {
    checkTableCellLocation(o.cellLocation);
    unittest.expect(o.insertionIndex, unittest.equals(42));
    unittest.expect(o.objectId, unittest.equals('foo'));
    unittest.expect(o.text, unittest.equals('foo'));
  }
  buildCounterInsertTextRequest--;
}

core.int buildCounterLayoutPlaceholderIdMapping = 0;
buildLayoutPlaceholderIdMapping() {
  var o = new api.LayoutPlaceholderIdMapping();
  buildCounterLayoutPlaceholderIdMapping++;
  if (buildCounterLayoutPlaceholderIdMapping < 3) {
    o.layoutPlaceholder = buildPlaceholder();
    o.layoutPlaceholderObjectId = "foo";
    o.objectId = "foo";
  }
  buildCounterLayoutPlaceholderIdMapping--;
  return o;
}

checkLayoutPlaceholderIdMapping(api.LayoutPlaceholderIdMapping o) {
  buildCounterLayoutPlaceholderIdMapping++;
  if (buildCounterLayoutPlaceholderIdMapping < 3) {
    checkPlaceholder(o.layoutPlaceholder);
    unittest.expect(o.layoutPlaceholderObjectId, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterLayoutPlaceholderIdMapping--;
}

core.int buildCounterLayoutProperties = 0;
buildLayoutProperties() {
  var o = new api.LayoutProperties();
  buildCounterLayoutProperties++;
  if (buildCounterLayoutProperties < 3) {
    o.displayName = "foo";
    o.masterObjectId = "foo";
    o.name = "foo";
  }
  buildCounterLayoutProperties--;
  return o;
}

checkLayoutProperties(api.LayoutProperties o) {
  buildCounterLayoutProperties++;
  if (buildCounterLayoutProperties < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.masterObjectId, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterLayoutProperties--;
}

core.int buildCounterLayoutReference = 0;
buildLayoutReference() {
  var o = new api.LayoutReference();
  buildCounterLayoutReference++;
  if (buildCounterLayoutReference < 3) {
    o.layoutId = "foo";
    o.predefinedLayout = "foo";
  }
  buildCounterLayoutReference--;
  return o;
}

checkLayoutReference(api.LayoutReference o) {
  buildCounterLayoutReference++;
  if (buildCounterLayoutReference < 3) {
    unittest.expect(o.layoutId, unittest.equals('foo'));
    unittest.expect(o.predefinedLayout, unittest.equals('foo'));
  }
  buildCounterLayoutReference--;
}

core.int buildCounterLine = 0;
buildLine() {
  var o = new api.Line();
  buildCounterLine++;
  if (buildCounterLine < 3) {
    o.lineProperties = buildLineProperties();
    o.lineType = "foo";
  }
  buildCounterLine--;
  return o;
}

checkLine(api.Line o) {
  buildCounterLine++;
  if (buildCounterLine < 3) {
    checkLineProperties(o.lineProperties);
    unittest.expect(o.lineType, unittest.equals('foo'));
  }
  buildCounterLine--;
}

core.int buildCounterLineFill = 0;
buildLineFill() {
  var o = new api.LineFill();
  buildCounterLineFill++;
  if (buildCounterLineFill < 3) {
    o.solidFill = buildSolidFill();
  }
  buildCounterLineFill--;
  return o;
}

checkLineFill(api.LineFill o) {
  buildCounterLineFill++;
  if (buildCounterLineFill < 3) {
    checkSolidFill(o.solidFill);
  }
  buildCounterLineFill--;
}

core.int buildCounterLineProperties = 0;
buildLineProperties() {
  var o = new api.LineProperties();
  buildCounterLineProperties++;
  if (buildCounterLineProperties < 3) {
    o.dashStyle = "foo";
    o.endArrow = "foo";
    o.lineFill = buildLineFill();
    o.link = buildLink();
    o.startArrow = "foo";
    o.weight = buildDimension();
  }
  buildCounterLineProperties--;
  return o;
}

checkLineProperties(api.LineProperties o) {
  buildCounterLineProperties++;
  if (buildCounterLineProperties < 3) {
    unittest.expect(o.dashStyle, unittest.equals('foo'));
    unittest.expect(o.endArrow, unittest.equals('foo'));
    checkLineFill(o.lineFill);
    checkLink(o.link);
    unittest.expect(o.startArrow, unittest.equals('foo'));
    checkDimension(o.weight);
  }
  buildCounterLineProperties--;
}

core.int buildCounterLink = 0;
buildLink() {
  var o = new api.Link();
  buildCounterLink++;
  if (buildCounterLink < 3) {
    o.pageObjectId = "foo";
    o.relativeLink = "foo";
    o.slideIndex = 42;
    o.url = "foo";
  }
  buildCounterLink--;
  return o;
}

checkLink(api.Link o) {
  buildCounterLink++;
  if (buildCounterLink < 3) {
    unittest.expect(o.pageObjectId, unittest.equals('foo'));
    unittest.expect(o.relativeLink, unittest.equals('foo'));
    unittest.expect(o.slideIndex, unittest.equals(42));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterLink--;
}

buildUnnamed1463() {
  var o = new core.Map<core.String, api.NestingLevel>();
  o["x"] = buildNestingLevel();
  o["y"] = buildNestingLevel();
  return o;
}

checkUnnamed1463(core.Map<core.String, api.NestingLevel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkNestingLevel(o["x"]);
  checkNestingLevel(o["y"]);
}

core.int buildCounterList = 0;
buildList() {
  var o = new api.List();
  buildCounterList++;
  if (buildCounterList < 3) {
    o.listId = "foo";
    o.nestingLevel = buildUnnamed1463();
  }
  buildCounterList--;
  return o;
}

checkList(api.List o) {
  buildCounterList++;
  if (buildCounterList < 3) {
    unittest.expect(o.listId, unittest.equals('foo'));
    checkUnnamed1463(o.nestingLevel);
  }
  buildCounterList--;
}

core.int buildCounterNestingLevel = 0;
buildNestingLevel() {
  var o = new api.NestingLevel();
  buildCounterNestingLevel++;
  if (buildCounterNestingLevel < 3) {
    o.bulletStyle = buildTextStyle();
  }
  buildCounterNestingLevel--;
  return o;
}

checkNestingLevel(api.NestingLevel o) {
  buildCounterNestingLevel++;
  if (buildCounterNestingLevel < 3) {
    checkTextStyle(o.bulletStyle);
  }
  buildCounterNestingLevel--;
}

core.int buildCounterNotesProperties = 0;
buildNotesProperties() {
  var o = new api.NotesProperties();
  buildCounterNotesProperties++;
  if (buildCounterNotesProperties < 3) {
    o.speakerNotesObjectId = "foo";
  }
  buildCounterNotesProperties--;
  return o;
}

checkNotesProperties(api.NotesProperties o) {
  buildCounterNotesProperties++;
  if (buildCounterNotesProperties < 3) {
    unittest.expect(o.speakerNotesObjectId, unittest.equals('foo'));
  }
  buildCounterNotesProperties--;
}

core.int buildCounterOpaqueColor = 0;
buildOpaqueColor() {
  var o = new api.OpaqueColor();
  buildCounterOpaqueColor++;
  if (buildCounterOpaqueColor < 3) {
    o.rgbColor = buildRgbColor();
    o.themeColor = "foo";
  }
  buildCounterOpaqueColor--;
  return o;
}

checkOpaqueColor(api.OpaqueColor o) {
  buildCounterOpaqueColor++;
  if (buildCounterOpaqueColor < 3) {
    checkRgbColor(o.rgbColor);
    unittest.expect(o.themeColor, unittest.equals('foo'));
  }
  buildCounterOpaqueColor--;
}

core.int buildCounterOptionalColor = 0;
buildOptionalColor() {
  var o = new api.OptionalColor();
  buildCounterOptionalColor++;
  if (buildCounterOptionalColor < 3) {
    o.opaqueColor = buildOpaqueColor();
  }
  buildCounterOptionalColor--;
  return o;
}

checkOptionalColor(api.OptionalColor o) {
  buildCounterOptionalColor++;
  if (buildCounterOptionalColor < 3) {
    checkOpaqueColor(o.opaqueColor);
  }
  buildCounterOptionalColor--;
}

core.int buildCounterOutline = 0;
buildOutline() {
  var o = new api.Outline();
  buildCounterOutline++;
  if (buildCounterOutline < 3) {
    o.dashStyle = "foo";
    o.outlineFill = buildOutlineFill();
    o.propertyState = "foo";
    o.weight = buildDimension();
  }
  buildCounterOutline--;
  return o;
}

checkOutline(api.Outline o) {
  buildCounterOutline++;
  if (buildCounterOutline < 3) {
    unittest.expect(o.dashStyle, unittest.equals('foo'));
    checkOutlineFill(o.outlineFill);
    unittest.expect(o.propertyState, unittest.equals('foo'));
    checkDimension(o.weight);
  }
  buildCounterOutline--;
}

core.int buildCounterOutlineFill = 0;
buildOutlineFill() {
  var o = new api.OutlineFill();
  buildCounterOutlineFill++;
  if (buildCounterOutlineFill < 3) {
    o.solidFill = buildSolidFill();
  }
  buildCounterOutlineFill--;
  return o;
}

checkOutlineFill(api.OutlineFill o) {
  buildCounterOutlineFill++;
  if (buildCounterOutlineFill < 3) {
    checkSolidFill(o.solidFill);
  }
  buildCounterOutlineFill--;
}

buildUnnamed1464() {
  var o = new core.List<api.PageElement>();
  o.add(buildPageElement());
  o.add(buildPageElement());
  return o;
}

checkUnnamed1464(core.List<api.PageElement> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPageElement(o[0]);
  checkPageElement(o[1]);
}

core.int buildCounterPage = 0;
buildPage() {
  var o = new api.Page();
  buildCounterPage++;
  if (buildCounterPage < 3) {
    o.layoutProperties = buildLayoutProperties();
    o.notesProperties = buildNotesProperties();
    o.objectId = "foo";
    o.pageElements = buildUnnamed1464();
    o.pageProperties = buildPageProperties();
    o.pageType = "foo";
    o.slideProperties = buildSlideProperties();
  }
  buildCounterPage--;
  return o;
}

checkPage(api.Page o) {
  buildCounterPage++;
  if (buildCounterPage < 3) {
    checkLayoutProperties(o.layoutProperties);
    checkNotesProperties(o.notesProperties);
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkUnnamed1464(o.pageElements);
    checkPageProperties(o.pageProperties);
    unittest.expect(o.pageType, unittest.equals('foo'));
    checkSlideProperties(o.slideProperties);
  }
  buildCounterPage--;
}

core.int buildCounterPageBackgroundFill = 0;
buildPageBackgroundFill() {
  var o = new api.PageBackgroundFill();
  buildCounterPageBackgroundFill++;
  if (buildCounterPageBackgroundFill < 3) {
    o.propertyState = "foo";
    o.solidFill = buildSolidFill();
    o.stretchedPictureFill = buildStretchedPictureFill();
  }
  buildCounterPageBackgroundFill--;
  return o;
}

checkPageBackgroundFill(api.PageBackgroundFill o) {
  buildCounterPageBackgroundFill++;
  if (buildCounterPageBackgroundFill < 3) {
    unittest.expect(o.propertyState, unittest.equals('foo'));
    checkSolidFill(o.solidFill);
    checkStretchedPictureFill(o.stretchedPictureFill);
  }
  buildCounterPageBackgroundFill--;
}

core.int buildCounterPageElement = 0;
buildPageElement() {
  var o = new api.PageElement();
  buildCounterPageElement++;
  if (buildCounterPageElement < 3) {
    o.description = "foo";
    o.elementGroup = buildGroup();
    o.image = buildImage();
    o.line = buildLine();
    o.objectId = "foo";
    o.shape = buildShape();
    o.sheetsChart = buildSheetsChart();
    o.size = buildSize();
    o.table = buildTable();
    o.title = "foo";
    o.transform = buildAffineTransform();
    o.video = buildVideo();
    o.wordArt = buildWordArt();
  }
  buildCounterPageElement--;
  return o;
}

checkPageElement(api.PageElement o) {
  buildCounterPageElement++;
  if (buildCounterPageElement < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    checkGroup(o.elementGroup);
    checkImage(o.image);
    checkLine(o.line);
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkShape(o.shape);
    checkSheetsChart(o.sheetsChart);
    checkSize(o.size);
    checkTable(o.table);
    unittest.expect(o.title, unittest.equals('foo'));
    checkAffineTransform(o.transform);
    checkVideo(o.video);
    checkWordArt(o.wordArt);
  }
  buildCounterPageElement--;
}

core.int buildCounterPageElementProperties = 0;
buildPageElementProperties() {
  var o = new api.PageElementProperties();
  buildCounterPageElementProperties++;
  if (buildCounterPageElementProperties < 3) {
    o.pageObjectId = "foo";
    o.size = buildSize();
    o.transform = buildAffineTransform();
  }
  buildCounterPageElementProperties--;
  return o;
}

checkPageElementProperties(api.PageElementProperties o) {
  buildCounterPageElementProperties++;
  if (buildCounterPageElementProperties < 3) {
    unittest.expect(o.pageObjectId, unittest.equals('foo'));
    checkSize(o.size);
    checkAffineTransform(o.transform);
  }
  buildCounterPageElementProperties--;
}

core.int buildCounterPageProperties = 0;
buildPageProperties() {
  var o = new api.PageProperties();
  buildCounterPageProperties++;
  if (buildCounterPageProperties < 3) {
    o.colorScheme = buildColorScheme();
    o.pageBackgroundFill = buildPageBackgroundFill();
  }
  buildCounterPageProperties--;
  return o;
}

checkPageProperties(api.PageProperties o) {
  buildCounterPageProperties++;
  if (buildCounterPageProperties < 3) {
    checkColorScheme(o.colorScheme);
    checkPageBackgroundFill(o.pageBackgroundFill);
  }
  buildCounterPageProperties--;
}

core.int buildCounterParagraphMarker = 0;
buildParagraphMarker() {
  var o = new api.ParagraphMarker();
  buildCounterParagraphMarker++;
  if (buildCounterParagraphMarker < 3) {
    o.bullet = buildBullet();
    o.style = buildParagraphStyle();
  }
  buildCounterParagraphMarker--;
  return o;
}

checkParagraphMarker(api.ParagraphMarker o) {
  buildCounterParagraphMarker++;
  if (buildCounterParagraphMarker < 3) {
    checkBullet(o.bullet);
    checkParagraphStyle(o.style);
  }
  buildCounterParagraphMarker--;
}

core.int buildCounterParagraphStyle = 0;
buildParagraphStyle() {
  var o = new api.ParagraphStyle();
  buildCounterParagraphStyle++;
  if (buildCounterParagraphStyle < 3) {
    o.alignment = "foo";
    o.direction = "foo";
    o.indentEnd = buildDimension();
    o.indentFirstLine = buildDimension();
    o.indentStart = buildDimension();
    o.lineSpacing = 42.0;
    o.spaceAbove = buildDimension();
    o.spaceBelow = buildDimension();
    o.spacingMode = "foo";
  }
  buildCounterParagraphStyle--;
  return o;
}

checkParagraphStyle(api.ParagraphStyle o) {
  buildCounterParagraphStyle++;
  if (buildCounterParagraphStyle < 3) {
    unittest.expect(o.alignment, unittest.equals('foo'));
    unittest.expect(o.direction, unittest.equals('foo'));
    checkDimension(o.indentEnd);
    checkDimension(o.indentFirstLine);
    checkDimension(o.indentStart);
    unittest.expect(o.lineSpacing, unittest.equals(42.0));
    checkDimension(o.spaceAbove);
    checkDimension(o.spaceBelow);
    unittest.expect(o.spacingMode, unittest.equals('foo'));
  }
  buildCounterParagraphStyle--;
}

core.int buildCounterPlaceholder = 0;
buildPlaceholder() {
  var o = new api.Placeholder();
  buildCounterPlaceholder++;
  if (buildCounterPlaceholder < 3) {
    o.index = 42;
    o.parentObjectId = "foo";
    o.type = "foo";
  }
  buildCounterPlaceholder--;
  return o;
}

checkPlaceholder(api.Placeholder o) {
  buildCounterPlaceholder++;
  if (buildCounterPlaceholder < 3) {
    unittest.expect(o.index, unittest.equals(42));
    unittest.expect(o.parentObjectId, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterPlaceholder--;
}

buildUnnamed1465() {
  var o = new core.List<api.Page>();
  o.add(buildPage());
  o.add(buildPage());
  return o;
}

checkUnnamed1465(core.List<api.Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPage(o[0]);
  checkPage(o[1]);
}

buildUnnamed1466() {
  var o = new core.List<api.Page>();
  o.add(buildPage());
  o.add(buildPage());
  return o;
}

checkUnnamed1466(core.List<api.Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPage(o[0]);
  checkPage(o[1]);
}

buildUnnamed1467() {
  var o = new core.List<api.Page>();
  o.add(buildPage());
  o.add(buildPage());
  return o;
}

checkUnnamed1467(core.List<api.Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPage(o[0]);
  checkPage(o[1]);
}

core.int buildCounterPresentation = 0;
buildPresentation() {
  var o = new api.Presentation();
  buildCounterPresentation++;
  if (buildCounterPresentation < 3) {
    o.layouts = buildUnnamed1465();
    o.locale = "foo";
    o.masters = buildUnnamed1466();
    o.notesMaster = buildPage();
    o.pageSize = buildSize();
    o.presentationId = "foo";
    o.slides = buildUnnamed1467();
    o.title = "foo";
  }
  buildCounterPresentation--;
  return o;
}

checkPresentation(api.Presentation o) {
  buildCounterPresentation++;
  if (buildCounterPresentation < 3) {
    checkUnnamed1465(o.layouts);
    unittest.expect(o.locale, unittest.equals('foo'));
    checkUnnamed1466(o.masters);
    checkPage(o.notesMaster);
    checkSize(o.pageSize);
    unittest.expect(o.presentationId, unittest.equals('foo'));
    checkUnnamed1467(o.slides);
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterPresentation--;
}

core.int buildCounterRange = 0;
buildRange() {
  var o = new api.Range();
  buildCounterRange++;
  if (buildCounterRange < 3) {
    o.endIndex = 42;
    o.startIndex = 42;
    o.type = "foo";
  }
  buildCounterRange--;
  return o;
}

checkRange(api.Range o) {
  buildCounterRange++;
  if (buildCounterRange < 3) {
    unittest.expect(o.endIndex, unittest.equals(42));
    unittest.expect(o.startIndex, unittest.equals(42));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterRange--;
}

buildUnnamed1468() {
  var o = new core.List<api.ColorStop>();
  o.add(buildColorStop());
  o.add(buildColorStop());
  return o;
}

checkUnnamed1468(core.List<api.ColorStop> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkColorStop(o[0]);
  checkColorStop(o[1]);
}

core.int buildCounterRecolor = 0;
buildRecolor() {
  var o = new api.Recolor();
  buildCounterRecolor++;
  if (buildCounterRecolor < 3) {
    o.name = "foo";
    o.recolorStops = buildUnnamed1468();
  }
  buildCounterRecolor--;
  return o;
}

checkRecolor(api.Recolor o) {
  buildCounterRecolor++;
  if (buildCounterRecolor < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed1468(o.recolorStops);
  }
  buildCounterRecolor--;
}

core.int buildCounterRefreshSheetsChartRequest = 0;
buildRefreshSheetsChartRequest() {
  var o = new api.RefreshSheetsChartRequest();
  buildCounterRefreshSheetsChartRequest++;
  if (buildCounterRefreshSheetsChartRequest < 3) {
    o.objectId = "foo";
  }
  buildCounterRefreshSheetsChartRequest--;
  return o;
}

checkRefreshSheetsChartRequest(api.RefreshSheetsChartRequest o) {
  buildCounterRefreshSheetsChartRequest++;
  if (buildCounterRefreshSheetsChartRequest < 3) {
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterRefreshSheetsChartRequest--;
}

core.int buildCounterReplaceAllShapesWithImageRequest = 0;
buildReplaceAllShapesWithImageRequest() {
  var o = new api.ReplaceAllShapesWithImageRequest();
  buildCounterReplaceAllShapesWithImageRequest++;
  if (buildCounterReplaceAllShapesWithImageRequest < 3) {
    o.containsText = buildSubstringMatchCriteria();
    o.imageUrl = "foo";
    o.replaceMethod = "foo";
  }
  buildCounterReplaceAllShapesWithImageRequest--;
  return o;
}

checkReplaceAllShapesWithImageRequest(api.ReplaceAllShapesWithImageRequest o) {
  buildCounterReplaceAllShapesWithImageRequest++;
  if (buildCounterReplaceAllShapesWithImageRequest < 3) {
    checkSubstringMatchCriteria(o.containsText);
    unittest.expect(o.imageUrl, unittest.equals('foo'));
    unittest.expect(o.replaceMethod, unittest.equals('foo'));
  }
  buildCounterReplaceAllShapesWithImageRequest--;
}

core.int buildCounterReplaceAllShapesWithImageResponse = 0;
buildReplaceAllShapesWithImageResponse() {
  var o = new api.ReplaceAllShapesWithImageResponse();
  buildCounterReplaceAllShapesWithImageResponse++;
  if (buildCounterReplaceAllShapesWithImageResponse < 3) {
    o.occurrencesChanged = 42;
  }
  buildCounterReplaceAllShapesWithImageResponse--;
  return o;
}

checkReplaceAllShapesWithImageResponse(api.ReplaceAllShapesWithImageResponse o) {
  buildCounterReplaceAllShapesWithImageResponse++;
  if (buildCounterReplaceAllShapesWithImageResponse < 3) {
    unittest.expect(o.occurrencesChanged, unittest.equals(42));
  }
  buildCounterReplaceAllShapesWithImageResponse--;
}

core.int buildCounterReplaceAllShapesWithSheetsChartRequest = 0;
buildReplaceAllShapesWithSheetsChartRequest() {
  var o = new api.ReplaceAllShapesWithSheetsChartRequest();
  buildCounterReplaceAllShapesWithSheetsChartRequest++;
  if (buildCounterReplaceAllShapesWithSheetsChartRequest < 3) {
    o.chartId = 42;
    o.containsText = buildSubstringMatchCriteria();
    o.linkingMode = "foo";
    o.spreadsheetId = "foo";
  }
  buildCounterReplaceAllShapesWithSheetsChartRequest--;
  return o;
}

checkReplaceAllShapesWithSheetsChartRequest(api.ReplaceAllShapesWithSheetsChartRequest o) {
  buildCounterReplaceAllShapesWithSheetsChartRequest++;
  if (buildCounterReplaceAllShapesWithSheetsChartRequest < 3) {
    unittest.expect(o.chartId, unittest.equals(42));
    checkSubstringMatchCriteria(o.containsText);
    unittest.expect(o.linkingMode, unittest.equals('foo'));
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
  }
  buildCounterReplaceAllShapesWithSheetsChartRequest--;
}

core.int buildCounterReplaceAllShapesWithSheetsChartResponse = 0;
buildReplaceAllShapesWithSheetsChartResponse() {
  var o = new api.ReplaceAllShapesWithSheetsChartResponse();
  buildCounterReplaceAllShapesWithSheetsChartResponse++;
  if (buildCounterReplaceAllShapesWithSheetsChartResponse < 3) {
    o.occurrencesChanged = 42;
  }
  buildCounterReplaceAllShapesWithSheetsChartResponse--;
  return o;
}

checkReplaceAllShapesWithSheetsChartResponse(api.ReplaceAllShapesWithSheetsChartResponse o) {
  buildCounterReplaceAllShapesWithSheetsChartResponse++;
  if (buildCounterReplaceAllShapesWithSheetsChartResponse < 3) {
    unittest.expect(o.occurrencesChanged, unittest.equals(42));
  }
  buildCounterReplaceAllShapesWithSheetsChartResponse--;
}

core.int buildCounterReplaceAllTextRequest = 0;
buildReplaceAllTextRequest() {
  var o = new api.ReplaceAllTextRequest();
  buildCounterReplaceAllTextRequest++;
  if (buildCounterReplaceAllTextRequest < 3) {
    o.containsText = buildSubstringMatchCriteria();
    o.replaceText = "foo";
  }
  buildCounterReplaceAllTextRequest--;
  return o;
}

checkReplaceAllTextRequest(api.ReplaceAllTextRequest o) {
  buildCounterReplaceAllTextRequest++;
  if (buildCounterReplaceAllTextRequest < 3) {
    checkSubstringMatchCriteria(o.containsText);
    unittest.expect(o.replaceText, unittest.equals('foo'));
  }
  buildCounterReplaceAllTextRequest--;
}

core.int buildCounterReplaceAllTextResponse = 0;
buildReplaceAllTextResponse() {
  var o = new api.ReplaceAllTextResponse();
  buildCounterReplaceAllTextResponse++;
  if (buildCounterReplaceAllTextResponse < 3) {
    o.occurrencesChanged = 42;
  }
  buildCounterReplaceAllTextResponse--;
  return o;
}

checkReplaceAllTextResponse(api.ReplaceAllTextResponse o) {
  buildCounterReplaceAllTextResponse++;
  if (buildCounterReplaceAllTextResponse < 3) {
    unittest.expect(o.occurrencesChanged, unittest.equals(42));
  }
  buildCounterReplaceAllTextResponse--;
}

core.int buildCounterRequest = 0;
buildRequest() {
  var o = new api.Request();
  buildCounterRequest++;
  if (buildCounterRequest < 3) {
    o.createImage = buildCreateImageRequest();
    o.createLine = buildCreateLineRequest();
    o.createParagraphBullets = buildCreateParagraphBulletsRequest();
    o.createShape = buildCreateShapeRequest();
    o.createSheetsChart = buildCreateSheetsChartRequest();
    o.createSlide = buildCreateSlideRequest();
    o.createTable = buildCreateTableRequest();
    o.createVideo = buildCreateVideoRequest();
    o.deleteObject = buildDeleteObjectRequest();
    o.deleteParagraphBullets = buildDeleteParagraphBulletsRequest();
    o.deleteTableColumn = buildDeleteTableColumnRequest();
    o.deleteTableRow = buildDeleteTableRowRequest();
    o.deleteText = buildDeleteTextRequest();
    o.duplicateObject = buildDuplicateObjectRequest();
    o.insertTableColumns = buildInsertTableColumnsRequest();
    o.insertTableRows = buildInsertTableRowsRequest();
    o.insertText = buildInsertTextRequest();
    o.refreshSheetsChart = buildRefreshSheetsChartRequest();
    o.replaceAllShapesWithImage = buildReplaceAllShapesWithImageRequest();
    o.replaceAllShapesWithSheetsChart = buildReplaceAllShapesWithSheetsChartRequest();
    o.replaceAllText = buildReplaceAllTextRequest();
    o.updateImageProperties = buildUpdateImagePropertiesRequest();
    o.updateLineProperties = buildUpdateLinePropertiesRequest();
    o.updatePageElementTransform = buildUpdatePageElementTransformRequest();
    o.updatePageProperties = buildUpdatePagePropertiesRequest();
    o.updateParagraphStyle = buildUpdateParagraphStyleRequest();
    o.updateShapeProperties = buildUpdateShapePropertiesRequest();
    o.updateSlidesPosition = buildUpdateSlidesPositionRequest();
    o.updateTableCellProperties = buildUpdateTableCellPropertiesRequest();
    o.updateTextStyle = buildUpdateTextStyleRequest();
    o.updateVideoProperties = buildUpdateVideoPropertiesRequest();
  }
  buildCounterRequest--;
  return o;
}

checkRequest(api.Request o) {
  buildCounterRequest++;
  if (buildCounterRequest < 3) {
    checkCreateImageRequest(o.createImage);
    checkCreateLineRequest(o.createLine);
    checkCreateParagraphBulletsRequest(o.createParagraphBullets);
    checkCreateShapeRequest(o.createShape);
    checkCreateSheetsChartRequest(o.createSheetsChart);
    checkCreateSlideRequest(o.createSlide);
    checkCreateTableRequest(o.createTable);
    checkCreateVideoRequest(o.createVideo);
    checkDeleteObjectRequest(o.deleteObject);
    checkDeleteParagraphBulletsRequest(o.deleteParagraphBullets);
    checkDeleteTableColumnRequest(o.deleteTableColumn);
    checkDeleteTableRowRequest(o.deleteTableRow);
    checkDeleteTextRequest(o.deleteText);
    checkDuplicateObjectRequest(o.duplicateObject);
    checkInsertTableColumnsRequest(o.insertTableColumns);
    checkInsertTableRowsRequest(o.insertTableRows);
    checkInsertTextRequest(o.insertText);
    checkRefreshSheetsChartRequest(o.refreshSheetsChart);
    checkReplaceAllShapesWithImageRequest(o.replaceAllShapesWithImage);
    checkReplaceAllShapesWithSheetsChartRequest(o.replaceAllShapesWithSheetsChart);
    checkReplaceAllTextRequest(o.replaceAllText);
    checkUpdateImagePropertiesRequest(o.updateImageProperties);
    checkUpdateLinePropertiesRequest(o.updateLineProperties);
    checkUpdatePageElementTransformRequest(o.updatePageElementTransform);
    checkUpdatePagePropertiesRequest(o.updatePageProperties);
    checkUpdateParagraphStyleRequest(o.updateParagraphStyle);
    checkUpdateShapePropertiesRequest(o.updateShapeProperties);
    checkUpdateSlidesPositionRequest(o.updateSlidesPosition);
    checkUpdateTableCellPropertiesRequest(o.updateTableCellProperties);
    checkUpdateTextStyleRequest(o.updateTextStyle);
    checkUpdateVideoPropertiesRequest(o.updateVideoProperties);
  }
  buildCounterRequest--;
}

core.int buildCounterResponse = 0;
buildResponse() {
  var o = new api.Response();
  buildCounterResponse++;
  if (buildCounterResponse < 3) {
    o.createImage = buildCreateImageResponse();
    o.createLine = buildCreateLineResponse();
    o.createShape = buildCreateShapeResponse();
    o.createSheetsChart = buildCreateSheetsChartResponse();
    o.createSlide = buildCreateSlideResponse();
    o.createTable = buildCreateTableResponse();
    o.createVideo = buildCreateVideoResponse();
    o.duplicateObject = buildDuplicateObjectResponse();
    o.replaceAllShapesWithImage = buildReplaceAllShapesWithImageResponse();
    o.replaceAllShapesWithSheetsChart = buildReplaceAllShapesWithSheetsChartResponse();
    o.replaceAllText = buildReplaceAllTextResponse();
  }
  buildCounterResponse--;
  return o;
}

checkResponse(api.Response o) {
  buildCounterResponse++;
  if (buildCounterResponse < 3) {
    checkCreateImageResponse(o.createImage);
    checkCreateLineResponse(o.createLine);
    checkCreateShapeResponse(o.createShape);
    checkCreateSheetsChartResponse(o.createSheetsChart);
    checkCreateSlideResponse(o.createSlide);
    checkCreateTableResponse(o.createTable);
    checkCreateVideoResponse(o.createVideo);
    checkDuplicateObjectResponse(o.duplicateObject);
    checkReplaceAllShapesWithImageResponse(o.replaceAllShapesWithImage);
    checkReplaceAllShapesWithSheetsChartResponse(o.replaceAllShapesWithSheetsChart);
    checkReplaceAllTextResponse(o.replaceAllText);
  }
  buildCounterResponse--;
}

core.int buildCounterRgbColor = 0;
buildRgbColor() {
  var o = new api.RgbColor();
  buildCounterRgbColor++;
  if (buildCounterRgbColor < 3) {
    o.blue = 42.0;
    o.green = 42.0;
    o.red = 42.0;
  }
  buildCounterRgbColor--;
  return o;
}

checkRgbColor(api.RgbColor o) {
  buildCounterRgbColor++;
  if (buildCounterRgbColor < 3) {
    unittest.expect(o.blue, unittest.equals(42.0));
    unittest.expect(o.green, unittest.equals(42.0));
    unittest.expect(o.red, unittest.equals(42.0));
  }
  buildCounterRgbColor--;
}

core.int buildCounterShadow = 0;
buildShadow() {
  var o = new api.Shadow();
  buildCounterShadow++;
  if (buildCounterShadow < 3) {
    o.alignment = "foo";
    o.alpha = 42.0;
    o.blurRadius = buildDimension();
    o.color = buildOpaqueColor();
    o.propertyState = "foo";
    o.rotateWithShape = true;
    o.transform = buildAffineTransform();
    o.type = "foo";
  }
  buildCounterShadow--;
  return o;
}

checkShadow(api.Shadow o) {
  buildCounterShadow++;
  if (buildCounterShadow < 3) {
    unittest.expect(o.alignment, unittest.equals('foo'));
    unittest.expect(o.alpha, unittest.equals(42.0));
    checkDimension(o.blurRadius);
    checkOpaqueColor(o.color);
    unittest.expect(o.propertyState, unittest.equals('foo'));
    unittest.expect(o.rotateWithShape, unittest.isTrue);
    checkAffineTransform(o.transform);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterShadow--;
}

core.int buildCounterShape = 0;
buildShape() {
  var o = new api.Shape();
  buildCounterShape++;
  if (buildCounterShape < 3) {
    o.placeholder = buildPlaceholder();
    o.shapeProperties = buildShapeProperties();
    o.shapeType = "foo";
    o.text = buildTextContent();
  }
  buildCounterShape--;
  return o;
}

checkShape(api.Shape o) {
  buildCounterShape++;
  if (buildCounterShape < 3) {
    checkPlaceholder(o.placeholder);
    checkShapeProperties(o.shapeProperties);
    unittest.expect(o.shapeType, unittest.equals('foo'));
    checkTextContent(o.text);
  }
  buildCounterShape--;
}

core.int buildCounterShapeBackgroundFill = 0;
buildShapeBackgroundFill() {
  var o = new api.ShapeBackgroundFill();
  buildCounterShapeBackgroundFill++;
  if (buildCounterShapeBackgroundFill < 3) {
    o.propertyState = "foo";
    o.solidFill = buildSolidFill();
  }
  buildCounterShapeBackgroundFill--;
  return o;
}

checkShapeBackgroundFill(api.ShapeBackgroundFill o) {
  buildCounterShapeBackgroundFill++;
  if (buildCounterShapeBackgroundFill < 3) {
    unittest.expect(o.propertyState, unittest.equals('foo'));
    checkSolidFill(o.solidFill);
  }
  buildCounterShapeBackgroundFill--;
}

core.int buildCounterShapeProperties = 0;
buildShapeProperties() {
  var o = new api.ShapeProperties();
  buildCounterShapeProperties++;
  if (buildCounterShapeProperties < 3) {
    o.link = buildLink();
    o.outline = buildOutline();
    o.shadow = buildShadow();
    o.shapeBackgroundFill = buildShapeBackgroundFill();
  }
  buildCounterShapeProperties--;
  return o;
}

checkShapeProperties(api.ShapeProperties o) {
  buildCounterShapeProperties++;
  if (buildCounterShapeProperties < 3) {
    checkLink(o.link);
    checkOutline(o.outline);
    checkShadow(o.shadow);
    checkShapeBackgroundFill(o.shapeBackgroundFill);
  }
  buildCounterShapeProperties--;
}

core.int buildCounterSheetsChart = 0;
buildSheetsChart() {
  var o = new api.SheetsChart();
  buildCounterSheetsChart++;
  if (buildCounterSheetsChart < 3) {
    o.chartId = 42;
    o.contentUrl = "foo";
    o.sheetsChartProperties = buildSheetsChartProperties();
    o.spreadsheetId = "foo";
  }
  buildCounterSheetsChart--;
  return o;
}

checkSheetsChart(api.SheetsChart o) {
  buildCounterSheetsChart++;
  if (buildCounterSheetsChart < 3) {
    unittest.expect(o.chartId, unittest.equals(42));
    unittest.expect(o.contentUrl, unittest.equals('foo'));
    checkSheetsChartProperties(o.sheetsChartProperties);
    unittest.expect(o.spreadsheetId, unittest.equals('foo'));
  }
  buildCounterSheetsChart--;
}

core.int buildCounterSheetsChartProperties = 0;
buildSheetsChartProperties() {
  var o = new api.SheetsChartProperties();
  buildCounterSheetsChartProperties++;
  if (buildCounterSheetsChartProperties < 3) {
    o.chartImageProperties = buildImageProperties();
  }
  buildCounterSheetsChartProperties--;
  return o;
}

checkSheetsChartProperties(api.SheetsChartProperties o) {
  buildCounterSheetsChartProperties++;
  if (buildCounterSheetsChartProperties < 3) {
    checkImageProperties(o.chartImageProperties);
  }
  buildCounterSheetsChartProperties--;
}

core.int buildCounterSize = 0;
buildSize() {
  var o = new api.Size();
  buildCounterSize++;
  if (buildCounterSize < 3) {
    o.height = buildDimension();
    o.width = buildDimension();
  }
  buildCounterSize--;
  return o;
}

checkSize(api.Size o) {
  buildCounterSize++;
  if (buildCounterSize < 3) {
    checkDimension(o.height);
    checkDimension(o.width);
  }
  buildCounterSize--;
}

core.int buildCounterSlideProperties = 0;
buildSlideProperties() {
  var o = new api.SlideProperties();
  buildCounterSlideProperties++;
  if (buildCounterSlideProperties < 3) {
    o.layoutObjectId = "foo";
    o.masterObjectId = "foo";
    o.notesPage = buildPage();
  }
  buildCounterSlideProperties--;
  return o;
}

checkSlideProperties(api.SlideProperties o) {
  buildCounterSlideProperties++;
  if (buildCounterSlideProperties < 3) {
    unittest.expect(o.layoutObjectId, unittest.equals('foo'));
    unittest.expect(o.masterObjectId, unittest.equals('foo'));
    checkPage(o.notesPage);
  }
  buildCounterSlideProperties--;
}

core.int buildCounterSolidFill = 0;
buildSolidFill() {
  var o = new api.SolidFill();
  buildCounterSolidFill++;
  if (buildCounterSolidFill < 3) {
    o.alpha = 42.0;
    o.color = buildOpaqueColor();
  }
  buildCounterSolidFill--;
  return o;
}

checkSolidFill(api.SolidFill o) {
  buildCounterSolidFill++;
  if (buildCounterSolidFill < 3) {
    unittest.expect(o.alpha, unittest.equals(42.0));
    checkOpaqueColor(o.color);
  }
  buildCounterSolidFill--;
}

core.int buildCounterStretchedPictureFill = 0;
buildStretchedPictureFill() {
  var o = new api.StretchedPictureFill();
  buildCounterStretchedPictureFill++;
  if (buildCounterStretchedPictureFill < 3) {
    o.contentUrl = "foo";
    o.size = buildSize();
  }
  buildCounterStretchedPictureFill--;
  return o;
}

checkStretchedPictureFill(api.StretchedPictureFill o) {
  buildCounterStretchedPictureFill++;
  if (buildCounterStretchedPictureFill < 3) {
    unittest.expect(o.contentUrl, unittest.equals('foo'));
    checkSize(o.size);
  }
  buildCounterStretchedPictureFill--;
}

core.int buildCounterSubstringMatchCriteria = 0;
buildSubstringMatchCriteria() {
  var o = new api.SubstringMatchCriteria();
  buildCounterSubstringMatchCriteria++;
  if (buildCounterSubstringMatchCriteria < 3) {
    o.matchCase = true;
    o.text = "foo";
  }
  buildCounterSubstringMatchCriteria--;
  return o;
}

checkSubstringMatchCriteria(api.SubstringMatchCriteria o) {
  buildCounterSubstringMatchCriteria++;
  if (buildCounterSubstringMatchCriteria < 3) {
    unittest.expect(o.matchCase, unittest.isTrue);
    unittest.expect(o.text, unittest.equals('foo'));
  }
  buildCounterSubstringMatchCriteria--;
}

buildUnnamed1469() {
  var o = new core.List<api.TableColumnProperties>();
  o.add(buildTableColumnProperties());
  o.add(buildTableColumnProperties());
  return o;
}

checkUnnamed1469(core.List<api.TableColumnProperties> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTableColumnProperties(o[0]);
  checkTableColumnProperties(o[1]);
}

buildUnnamed1470() {
  var o = new core.List<api.TableRow>();
  o.add(buildTableRow());
  o.add(buildTableRow());
  return o;
}

checkUnnamed1470(core.List<api.TableRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTableRow(o[0]);
  checkTableRow(o[1]);
}

core.int buildCounterTable = 0;
buildTable() {
  var o = new api.Table();
  buildCounterTable++;
  if (buildCounterTable < 3) {
    o.columns = 42;
    o.rows = 42;
    o.tableColumns = buildUnnamed1469();
    o.tableRows = buildUnnamed1470();
  }
  buildCounterTable--;
  return o;
}

checkTable(api.Table o) {
  buildCounterTable++;
  if (buildCounterTable < 3) {
    unittest.expect(o.columns, unittest.equals(42));
    unittest.expect(o.rows, unittest.equals(42));
    checkUnnamed1469(o.tableColumns);
    checkUnnamed1470(o.tableRows);
  }
  buildCounterTable--;
}

core.int buildCounterTableCell = 0;
buildTableCell() {
  var o = new api.TableCell();
  buildCounterTableCell++;
  if (buildCounterTableCell < 3) {
    o.columnSpan = 42;
    o.location = buildTableCellLocation();
    o.rowSpan = 42;
    o.tableCellProperties = buildTableCellProperties();
    o.text = buildTextContent();
  }
  buildCounterTableCell--;
  return o;
}

checkTableCell(api.TableCell o) {
  buildCounterTableCell++;
  if (buildCounterTableCell < 3) {
    unittest.expect(o.columnSpan, unittest.equals(42));
    checkTableCellLocation(o.location);
    unittest.expect(o.rowSpan, unittest.equals(42));
    checkTableCellProperties(o.tableCellProperties);
    checkTextContent(o.text);
  }
  buildCounterTableCell--;
}

core.int buildCounterTableCellBackgroundFill = 0;
buildTableCellBackgroundFill() {
  var o = new api.TableCellBackgroundFill();
  buildCounterTableCellBackgroundFill++;
  if (buildCounterTableCellBackgroundFill < 3) {
    o.propertyState = "foo";
    o.solidFill = buildSolidFill();
  }
  buildCounterTableCellBackgroundFill--;
  return o;
}

checkTableCellBackgroundFill(api.TableCellBackgroundFill o) {
  buildCounterTableCellBackgroundFill++;
  if (buildCounterTableCellBackgroundFill < 3) {
    unittest.expect(o.propertyState, unittest.equals('foo'));
    checkSolidFill(o.solidFill);
  }
  buildCounterTableCellBackgroundFill--;
}

core.int buildCounterTableCellLocation = 0;
buildTableCellLocation() {
  var o = new api.TableCellLocation();
  buildCounterTableCellLocation++;
  if (buildCounterTableCellLocation < 3) {
    o.columnIndex = 42;
    o.rowIndex = 42;
  }
  buildCounterTableCellLocation--;
  return o;
}

checkTableCellLocation(api.TableCellLocation o) {
  buildCounterTableCellLocation++;
  if (buildCounterTableCellLocation < 3) {
    unittest.expect(o.columnIndex, unittest.equals(42));
    unittest.expect(o.rowIndex, unittest.equals(42));
  }
  buildCounterTableCellLocation--;
}

core.int buildCounterTableCellProperties = 0;
buildTableCellProperties() {
  var o = new api.TableCellProperties();
  buildCounterTableCellProperties++;
  if (buildCounterTableCellProperties < 3) {
    o.tableCellBackgroundFill = buildTableCellBackgroundFill();
  }
  buildCounterTableCellProperties--;
  return o;
}

checkTableCellProperties(api.TableCellProperties o) {
  buildCounterTableCellProperties++;
  if (buildCounterTableCellProperties < 3) {
    checkTableCellBackgroundFill(o.tableCellBackgroundFill);
  }
  buildCounterTableCellProperties--;
}

core.int buildCounterTableColumnProperties = 0;
buildTableColumnProperties() {
  var o = new api.TableColumnProperties();
  buildCounterTableColumnProperties++;
  if (buildCounterTableColumnProperties < 3) {
    o.columnWidth = buildDimension();
  }
  buildCounterTableColumnProperties--;
  return o;
}

checkTableColumnProperties(api.TableColumnProperties o) {
  buildCounterTableColumnProperties++;
  if (buildCounterTableColumnProperties < 3) {
    checkDimension(o.columnWidth);
  }
  buildCounterTableColumnProperties--;
}

core.int buildCounterTableRange = 0;
buildTableRange() {
  var o = new api.TableRange();
  buildCounterTableRange++;
  if (buildCounterTableRange < 3) {
    o.columnSpan = 42;
    o.location = buildTableCellLocation();
    o.rowSpan = 42;
  }
  buildCounterTableRange--;
  return o;
}

checkTableRange(api.TableRange o) {
  buildCounterTableRange++;
  if (buildCounterTableRange < 3) {
    unittest.expect(o.columnSpan, unittest.equals(42));
    checkTableCellLocation(o.location);
    unittest.expect(o.rowSpan, unittest.equals(42));
  }
  buildCounterTableRange--;
}

buildUnnamed1471() {
  var o = new core.List<api.TableCell>();
  o.add(buildTableCell());
  o.add(buildTableCell());
  return o;
}

checkUnnamed1471(core.List<api.TableCell> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTableCell(o[0]);
  checkTableCell(o[1]);
}

core.int buildCounterTableRow = 0;
buildTableRow() {
  var o = new api.TableRow();
  buildCounterTableRow++;
  if (buildCounterTableRow < 3) {
    o.rowHeight = buildDimension();
    o.tableCells = buildUnnamed1471();
  }
  buildCounterTableRow--;
  return o;
}

checkTableRow(api.TableRow o) {
  buildCounterTableRow++;
  if (buildCounterTableRow < 3) {
    checkDimension(o.rowHeight);
    checkUnnamed1471(o.tableCells);
  }
  buildCounterTableRow--;
}

buildUnnamed1472() {
  var o = new core.Map<core.String, api.List>();
  o["x"] = buildList();
  o["y"] = buildList();
  return o;
}

checkUnnamed1472(core.Map<core.String, api.List> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkList(o["x"]);
  checkList(o["y"]);
}

buildUnnamed1473() {
  var o = new core.List<api.TextElement>();
  o.add(buildTextElement());
  o.add(buildTextElement());
  return o;
}

checkUnnamed1473(core.List<api.TextElement> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTextElement(o[0]);
  checkTextElement(o[1]);
}

core.int buildCounterTextContent = 0;
buildTextContent() {
  var o = new api.TextContent();
  buildCounterTextContent++;
  if (buildCounterTextContent < 3) {
    o.lists = buildUnnamed1472();
    o.textElements = buildUnnamed1473();
  }
  buildCounterTextContent--;
  return o;
}

checkTextContent(api.TextContent o) {
  buildCounterTextContent++;
  if (buildCounterTextContent < 3) {
    checkUnnamed1472(o.lists);
    checkUnnamed1473(o.textElements);
  }
  buildCounterTextContent--;
}

core.int buildCounterTextElement = 0;
buildTextElement() {
  var o = new api.TextElement();
  buildCounterTextElement++;
  if (buildCounterTextElement < 3) {
    o.autoText = buildAutoText();
    o.endIndex = 42;
    o.paragraphMarker = buildParagraphMarker();
    o.startIndex = 42;
    o.textRun = buildTextRun();
  }
  buildCounterTextElement--;
  return o;
}

checkTextElement(api.TextElement o) {
  buildCounterTextElement++;
  if (buildCounterTextElement < 3) {
    checkAutoText(o.autoText);
    unittest.expect(o.endIndex, unittest.equals(42));
    checkParagraphMarker(o.paragraphMarker);
    unittest.expect(o.startIndex, unittest.equals(42));
    checkTextRun(o.textRun);
  }
  buildCounterTextElement--;
}

core.int buildCounterTextRun = 0;
buildTextRun() {
  var o = new api.TextRun();
  buildCounterTextRun++;
  if (buildCounterTextRun < 3) {
    o.content = "foo";
    o.style = buildTextStyle();
  }
  buildCounterTextRun--;
  return o;
}

checkTextRun(api.TextRun o) {
  buildCounterTextRun++;
  if (buildCounterTextRun < 3) {
    unittest.expect(o.content, unittest.equals('foo'));
    checkTextStyle(o.style);
  }
  buildCounterTextRun--;
}

core.int buildCounterTextStyle = 0;
buildTextStyle() {
  var o = new api.TextStyle();
  buildCounterTextStyle++;
  if (buildCounterTextStyle < 3) {
    o.backgroundColor = buildOptionalColor();
    o.baselineOffset = "foo";
    o.bold = true;
    o.fontFamily = "foo";
    o.fontSize = buildDimension();
    o.foregroundColor = buildOptionalColor();
    o.italic = true;
    o.link = buildLink();
    o.smallCaps = true;
    o.strikethrough = true;
    o.underline = true;
  }
  buildCounterTextStyle--;
  return o;
}

checkTextStyle(api.TextStyle o) {
  buildCounterTextStyle++;
  if (buildCounterTextStyle < 3) {
    checkOptionalColor(o.backgroundColor);
    unittest.expect(o.baselineOffset, unittest.equals('foo'));
    unittest.expect(o.bold, unittest.isTrue);
    unittest.expect(o.fontFamily, unittest.equals('foo'));
    checkDimension(o.fontSize);
    checkOptionalColor(o.foregroundColor);
    unittest.expect(o.italic, unittest.isTrue);
    checkLink(o.link);
    unittest.expect(o.smallCaps, unittest.isTrue);
    unittest.expect(o.strikethrough, unittest.isTrue);
    unittest.expect(o.underline, unittest.isTrue);
  }
  buildCounterTextStyle--;
}

core.int buildCounterThemeColorPair = 0;
buildThemeColorPair() {
  var o = new api.ThemeColorPair();
  buildCounterThemeColorPair++;
  if (buildCounterThemeColorPair < 3) {
    o.color = buildRgbColor();
    o.type = "foo";
  }
  buildCounterThemeColorPair--;
  return o;
}

checkThemeColorPair(api.ThemeColorPair o) {
  buildCounterThemeColorPair++;
  if (buildCounterThemeColorPair < 3) {
    checkRgbColor(o.color);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterThemeColorPair--;
}

core.int buildCounterUpdateImagePropertiesRequest = 0;
buildUpdateImagePropertiesRequest() {
  var o = new api.UpdateImagePropertiesRequest();
  buildCounterUpdateImagePropertiesRequest++;
  if (buildCounterUpdateImagePropertiesRequest < 3) {
    o.fields = "foo";
    o.imageProperties = buildImageProperties();
    o.objectId = "foo";
  }
  buildCounterUpdateImagePropertiesRequest--;
  return o;
}

checkUpdateImagePropertiesRequest(api.UpdateImagePropertiesRequest o) {
  buildCounterUpdateImagePropertiesRequest++;
  if (buildCounterUpdateImagePropertiesRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkImageProperties(o.imageProperties);
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterUpdateImagePropertiesRequest--;
}

core.int buildCounterUpdateLinePropertiesRequest = 0;
buildUpdateLinePropertiesRequest() {
  var o = new api.UpdateLinePropertiesRequest();
  buildCounterUpdateLinePropertiesRequest++;
  if (buildCounterUpdateLinePropertiesRequest < 3) {
    o.fields = "foo";
    o.lineProperties = buildLineProperties();
    o.objectId = "foo";
  }
  buildCounterUpdateLinePropertiesRequest--;
  return o;
}

checkUpdateLinePropertiesRequest(api.UpdateLinePropertiesRequest o) {
  buildCounterUpdateLinePropertiesRequest++;
  if (buildCounterUpdateLinePropertiesRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    checkLineProperties(o.lineProperties);
    unittest.expect(o.objectId, unittest.equals('foo'));
  }
  buildCounterUpdateLinePropertiesRequest--;
}

core.int buildCounterUpdatePageElementTransformRequest = 0;
buildUpdatePageElementTransformRequest() {
  var o = new api.UpdatePageElementTransformRequest();
  buildCounterUpdatePageElementTransformRequest++;
  if (buildCounterUpdatePageElementTransformRequest < 3) {
    o.applyMode = "foo";
    o.objectId = "foo";
    o.transform = buildAffineTransform();
  }
  buildCounterUpdatePageElementTransformRequest--;
  return o;
}

checkUpdatePageElementTransformRequest(api.UpdatePageElementTransformRequest o) {
  buildCounterUpdatePageElementTransformRequest++;
  if (buildCounterUpdatePageElementTransformRequest < 3) {
    unittest.expect(o.applyMode, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkAffineTransform(o.transform);
  }
  buildCounterUpdatePageElementTransformRequest--;
}

core.int buildCounterUpdatePagePropertiesRequest = 0;
buildUpdatePagePropertiesRequest() {
  var o = new api.UpdatePagePropertiesRequest();
  buildCounterUpdatePagePropertiesRequest++;
  if (buildCounterUpdatePagePropertiesRequest < 3) {
    o.fields = "foo";
    o.objectId = "foo";
    o.pageProperties = buildPageProperties();
  }
  buildCounterUpdatePagePropertiesRequest--;
  return o;
}

checkUpdatePagePropertiesRequest(api.UpdatePagePropertiesRequest o) {
  buildCounterUpdatePagePropertiesRequest++;
  if (buildCounterUpdatePagePropertiesRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkPageProperties(o.pageProperties);
  }
  buildCounterUpdatePagePropertiesRequest--;
}

core.int buildCounterUpdateParagraphStyleRequest = 0;
buildUpdateParagraphStyleRequest() {
  var o = new api.UpdateParagraphStyleRequest();
  buildCounterUpdateParagraphStyleRequest++;
  if (buildCounterUpdateParagraphStyleRequest < 3) {
    o.cellLocation = buildTableCellLocation();
    o.fields = "foo";
    o.objectId = "foo";
    o.style = buildParagraphStyle();
    o.textRange = buildRange();
  }
  buildCounterUpdateParagraphStyleRequest--;
  return o;
}

checkUpdateParagraphStyleRequest(api.UpdateParagraphStyleRequest o) {
  buildCounterUpdateParagraphStyleRequest++;
  if (buildCounterUpdateParagraphStyleRequest < 3) {
    checkTableCellLocation(o.cellLocation);
    unittest.expect(o.fields, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkParagraphStyle(o.style);
    checkRange(o.textRange);
  }
  buildCounterUpdateParagraphStyleRequest--;
}

core.int buildCounterUpdateShapePropertiesRequest = 0;
buildUpdateShapePropertiesRequest() {
  var o = new api.UpdateShapePropertiesRequest();
  buildCounterUpdateShapePropertiesRequest++;
  if (buildCounterUpdateShapePropertiesRequest < 3) {
    o.fields = "foo";
    o.objectId = "foo";
    o.shapeProperties = buildShapeProperties();
  }
  buildCounterUpdateShapePropertiesRequest--;
  return o;
}

checkUpdateShapePropertiesRequest(api.UpdateShapePropertiesRequest o) {
  buildCounterUpdateShapePropertiesRequest++;
  if (buildCounterUpdateShapePropertiesRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkShapeProperties(o.shapeProperties);
  }
  buildCounterUpdateShapePropertiesRequest--;
}

buildUnnamed1474() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1474(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterUpdateSlidesPositionRequest = 0;
buildUpdateSlidesPositionRequest() {
  var o = new api.UpdateSlidesPositionRequest();
  buildCounterUpdateSlidesPositionRequest++;
  if (buildCounterUpdateSlidesPositionRequest < 3) {
    o.insertionIndex = 42;
    o.slideObjectIds = buildUnnamed1474();
  }
  buildCounterUpdateSlidesPositionRequest--;
  return o;
}

checkUpdateSlidesPositionRequest(api.UpdateSlidesPositionRequest o) {
  buildCounterUpdateSlidesPositionRequest++;
  if (buildCounterUpdateSlidesPositionRequest < 3) {
    unittest.expect(o.insertionIndex, unittest.equals(42));
    checkUnnamed1474(o.slideObjectIds);
  }
  buildCounterUpdateSlidesPositionRequest--;
}

core.int buildCounterUpdateTableCellPropertiesRequest = 0;
buildUpdateTableCellPropertiesRequest() {
  var o = new api.UpdateTableCellPropertiesRequest();
  buildCounterUpdateTableCellPropertiesRequest++;
  if (buildCounterUpdateTableCellPropertiesRequest < 3) {
    o.fields = "foo";
    o.objectId = "foo";
    o.tableCellProperties = buildTableCellProperties();
    o.tableRange = buildTableRange();
  }
  buildCounterUpdateTableCellPropertiesRequest--;
  return o;
}

checkUpdateTableCellPropertiesRequest(api.UpdateTableCellPropertiesRequest o) {
  buildCounterUpdateTableCellPropertiesRequest++;
  if (buildCounterUpdateTableCellPropertiesRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkTableCellProperties(o.tableCellProperties);
    checkTableRange(o.tableRange);
  }
  buildCounterUpdateTableCellPropertiesRequest--;
}

core.int buildCounterUpdateTextStyleRequest = 0;
buildUpdateTextStyleRequest() {
  var o = new api.UpdateTextStyleRequest();
  buildCounterUpdateTextStyleRequest++;
  if (buildCounterUpdateTextStyleRequest < 3) {
    o.cellLocation = buildTableCellLocation();
    o.fields = "foo";
    o.objectId = "foo";
    o.style = buildTextStyle();
    o.textRange = buildRange();
  }
  buildCounterUpdateTextStyleRequest--;
  return o;
}

checkUpdateTextStyleRequest(api.UpdateTextStyleRequest o) {
  buildCounterUpdateTextStyleRequest++;
  if (buildCounterUpdateTextStyleRequest < 3) {
    checkTableCellLocation(o.cellLocation);
    unittest.expect(o.fields, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkTextStyle(o.style);
    checkRange(o.textRange);
  }
  buildCounterUpdateTextStyleRequest--;
}

core.int buildCounterUpdateVideoPropertiesRequest = 0;
buildUpdateVideoPropertiesRequest() {
  var o = new api.UpdateVideoPropertiesRequest();
  buildCounterUpdateVideoPropertiesRequest++;
  if (buildCounterUpdateVideoPropertiesRequest < 3) {
    o.fields = "foo";
    o.objectId = "foo";
    o.videoProperties = buildVideoProperties();
  }
  buildCounterUpdateVideoPropertiesRequest--;
  return o;
}

checkUpdateVideoPropertiesRequest(api.UpdateVideoPropertiesRequest o) {
  buildCounterUpdateVideoPropertiesRequest++;
  if (buildCounterUpdateVideoPropertiesRequest < 3) {
    unittest.expect(o.fields, unittest.equals('foo'));
    unittest.expect(o.objectId, unittest.equals('foo'));
    checkVideoProperties(o.videoProperties);
  }
  buildCounterUpdateVideoPropertiesRequest--;
}

core.int buildCounterVideo = 0;
buildVideo() {
  var o = new api.Video();
  buildCounterVideo++;
  if (buildCounterVideo < 3) {
    o.id = "foo";
    o.source = "foo";
    o.url = "foo";
    o.videoProperties = buildVideoProperties();
  }
  buildCounterVideo--;
  return o;
}

checkVideo(api.Video o) {
  buildCounterVideo++;
  if (buildCounterVideo < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.source, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
    checkVideoProperties(o.videoProperties);
  }
  buildCounterVideo--;
}

core.int buildCounterVideoProperties = 0;
buildVideoProperties() {
  var o = new api.VideoProperties();
  buildCounterVideoProperties++;
  if (buildCounterVideoProperties < 3) {
    o.outline = buildOutline();
  }
  buildCounterVideoProperties--;
  return o;
}

checkVideoProperties(api.VideoProperties o) {
  buildCounterVideoProperties++;
  if (buildCounterVideoProperties < 3) {
    checkOutline(o.outline);
  }
  buildCounterVideoProperties--;
}

core.int buildCounterWordArt = 0;
buildWordArt() {
  var o = new api.WordArt();
  buildCounterWordArt++;
  if (buildCounterWordArt < 3) {
    o.renderedText = "foo";
  }
  buildCounterWordArt--;
  return o;
}

checkWordArt(api.WordArt o) {
  buildCounterWordArt++;
  if (buildCounterWordArt < 3) {
    unittest.expect(o.renderedText, unittest.equals('foo'));
  }
  buildCounterWordArt--;
}


main() {
  unittest.group("obj-schema-AffineTransform", () {
    unittest.test("to-json--from-json", () {
      var o = buildAffineTransform();
      var od = new api.AffineTransform.fromJson(o.toJson());
      checkAffineTransform(od);
    });
  });


  unittest.group("obj-schema-AutoText", () {
    unittest.test("to-json--from-json", () {
      var o = buildAutoText();
      var od = new api.AutoText.fromJson(o.toJson());
      checkAutoText(od);
    });
  });


  unittest.group("obj-schema-BatchUpdatePresentationRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchUpdatePresentationRequest();
      var od = new api.BatchUpdatePresentationRequest.fromJson(o.toJson());
      checkBatchUpdatePresentationRequest(od);
    });
  });


  unittest.group("obj-schema-BatchUpdatePresentationResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchUpdatePresentationResponse();
      var od = new api.BatchUpdatePresentationResponse.fromJson(o.toJson());
      checkBatchUpdatePresentationResponse(od);
    });
  });


  unittest.group("obj-schema-Bullet", () {
    unittest.test("to-json--from-json", () {
      var o = buildBullet();
      var od = new api.Bullet.fromJson(o.toJson());
      checkBullet(od);
    });
  });


  unittest.group("obj-schema-ColorScheme", () {
    unittest.test("to-json--from-json", () {
      var o = buildColorScheme();
      var od = new api.ColorScheme.fromJson(o.toJson());
      checkColorScheme(od);
    });
  });


  unittest.group("obj-schema-ColorStop", () {
    unittest.test("to-json--from-json", () {
      var o = buildColorStop();
      var od = new api.ColorStop.fromJson(o.toJson());
      checkColorStop(od);
    });
  });


  unittest.group("obj-schema-CreateImageRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateImageRequest();
      var od = new api.CreateImageRequest.fromJson(o.toJson());
      checkCreateImageRequest(od);
    });
  });


  unittest.group("obj-schema-CreateImageResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateImageResponse();
      var od = new api.CreateImageResponse.fromJson(o.toJson());
      checkCreateImageResponse(od);
    });
  });


  unittest.group("obj-schema-CreateLineRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateLineRequest();
      var od = new api.CreateLineRequest.fromJson(o.toJson());
      checkCreateLineRequest(od);
    });
  });


  unittest.group("obj-schema-CreateLineResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateLineResponse();
      var od = new api.CreateLineResponse.fromJson(o.toJson());
      checkCreateLineResponse(od);
    });
  });


  unittest.group("obj-schema-CreateParagraphBulletsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateParagraphBulletsRequest();
      var od = new api.CreateParagraphBulletsRequest.fromJson(o.toJson());
      checkCreateParagraphBulletsRequest(od);
    });
  });


  unittest.group("obj-schema-CreateShapeRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateShapeRequest();
      var od = new api.CreateShapeRequest.fromJson(o.toJson());
      checkCreateShapeRequest(od);
    });
  });


  unittest.group("obj-schema-CreateShapeResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateShapeResponse();
      var od = new api.CreateShapeResponse.fromJson(o.toJson());
      checkCreateShapeResponse(od);
    });
  });


  unittest.group("obj-schema-CreateSheetsChartRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateSheetsChartRequest();
      var od = new api.CreateSheetsChartRequest.fromJson(o.toJson());
      checkCreateSheetsChartRequest(od);
    });
  });


  unittest.group("obj-schema-CreateSheetsChartResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateSheetsChartResponse();
      var od = new api.CreateSheetsChartResponse.fromJson(o.toJson());
      checkCreateSheetsChartResponse(od);
    });
  });


  unittest.group("obj-schema-CreateSlideRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateSlideRequest();
      var od = new api.CreateSlideRequest.fromJson(o.toJson());
      checkCreateSlideRequest(od);
    });
  });


  unittest.group("obj-schema-CreateSlideResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateSlideResponse();
      var od = new api.CreateSlideResponse.fromJson(o.toJson());
      checkCreateSlideResponse(od);
    });
  });


  unittest.group("obj-schema-CreateTableRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateTableRequest();
      var od = new api.CreateTableRequest.fromJson(o.toJson());
      checkCreateTableRequest(od);
    });
  });


  unittest.group("obj-schema-CreateTableResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateTableResponse();
      var od = new api.CreateTableResponse.fromJson(o.toJson());
      checkCreateTableResponse(od);
    });
  });


  unittest.group("obj-schema-CreateVideoRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateVideoRequest();
      var od = new api.CreateVideoRequest.fromJson(o.toJson());
      checkCreateVideoRequest(od);
    });
  });


  unittest.group("obj-schema-CreateVideoResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateVideoResponse();
      var od = new api.CreateVideoResponse.fromJson(o.toJson());
      checkCreateVideoResponse(od);
    });
  });


  unittest.group("obj-schema-CropProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildCropProperties();
      var od = new api.CropProperties.fromJson(o.toJson());
      checkCropProperties(od);
    });
  });


  unittest.group("obj-schema-DeleteObjectRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteObjectRequest();
      var od = new api.DeleteObjectRequest.fromJson(o.toJson());
      checkDeleteObjectRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteParagraphBulletsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteParagraphBulletsRequest();
      var od = new api.DeleteParagraphBulletsRequest.fromJson(o.toJson());
      checkDeleteParagraphBulletsRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteTableColumnRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteTableColumnRequest();
      var od = new api.DeleteTableColumnRequest.fromJson(o.toJson());
      checkDeleteTableColumnRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteTableRowRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteTableRowRequest();
      var od = new api.DeleteTableRowRequest.fromJson(o.toJson());
      checkDeleteTableRowRequest(od);
    });
  });


  unittest.group("obj-schema-DeleteTextRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDeleteTextRequest();
      var od = new api.DeleteTextRequest.fromJson(o.toJson());
      checkDeleteTextRequest(od);
    });
  });


  unittest.group("obj-schema-Dimension", () {
    unittest.test("to-json--from-json", () {
      var o = buildDimension();
      var od = new api.Dimension.fromJson(o.toJson());
      checkDimension(od);
    });
  });


  unittest.group("obj-schema-DuplicateObjectRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDuplicateObjectRequest();
      var od = new api.DuplicateObjectRequest.fromJson(o.toJson());
      checkDuplicateObjectRequest(od);
    });
  });


  unittest.group("obj-schema-DuplicateObjectResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDuplicateObjectResponse();
      var od = new api.DuplicateObjectResponse.fromJson(o.toJson());
      checkDuplicateObjectResponse(od);
    });
  });


  unittest.group("obj-schema-Group", () {
    unittest.test("to-json--from-json", () {
      var o = buildGroup();
      var od = new api.Group.fromJson(o.toJson());
      checkGroup(od);
    });
  });


  unittest.group("obj-schema-Image", () {
    unittest.test("to-json--from-json", () {
      var o = buildImage();
      var od = new api.Image.fromJson(o.toJson());
      checkImage(od);
    });
  });


  unittest.group("obj-schema-ImageProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildImageProperties();
      var od = new api.ImageProperties.fromJson(o.toJson());
      checkImageProperties(od);
    });
  });


  unittest.group("obj-schema-InsertTableColumnsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInsertTableColumnsRequest();
      var od = new api.InsertTableColumnsRequest.fromJson(o.toJson());
      checkInsertTableColumnsRequest(od);
    });
  });


  unittest.group("obj-schema-InsertTableRowsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInsertTableRowsRequest();
      var od = new api.InsertTableRowsRequest.fromJson(o.toJson());
      checkInsertTableRowsRequest(od);
    });
  });


  unittest.group("obj-schema-InsertTextRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildInsertTextRequest();
      var od = new api.InsertTextRequest.fromJson(o.toJson());
      checkInsertTextRequest(od);
    });
  });


  unittest.group("obj-schema-LayoutPlaceholderIdMapping", () {
    unittest.test("to-json--from-json", () {
      var o = buildLayoutPlaceholderIdMapping();
      var od = new api.LayoutPlaceholderIdMapping.fromJson(o.toJson());
      checkLayoutPlaceholderIdMapping(od);
    });
  });


  unittest.group("obj-schema-LayoutProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildLayoutProperties();
      var od = new api.LayoutProperties.fromJson(o.toJson());
      checkLayoutProperties(od);
    });
  });


  unittest.group("obj-schema-LayoutReference", () {
    unittest.test("to-json--from-json", () {
      var o = buildLayoutReference();
      var od = new api.LayoutReference.fromJson(o.toJson());
      checkLayoutReference(od);
    });
  });


  unittest.group("obj-schema-Line", () {
    unittest.test("to-json--from-json", () {
      var o = buildLine();
      var od = new api.Line.fromJson(o.toJson());
      checkLine(od);
    });
  });


  unittest.group("obj-schema-LineFill", () {
    unittest.test("to-json--from-json", () {
      var o = buildLineFill();
      var od = new api.LineFill.fromJson(o.toJson());
      checkLineFill(od);
    });
  });


  unittest.group("obj-schema-LineProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildLineProperties();
      var od = new api.LineProperties.fromJson(o.toJson());
      checkLineProperties(od);
    });
  });


  unittest.group("obj-schema-Link", () {
    unittest.test("to-json--from-json", () {
      var o = buildLink();
      var od = new api.Link.fromJson(o.toJson());
      checkLink(od);
    });
  });


  unittest.group("obj-schema-List", () {
    unittest.test("to-json--from-json", () {
      var o = buildList();
      var od = new api.List.fromJson(o.toJson());
      checkList(od);
    });
  });


  unittest.group("obj-schema-NestingLevel", () {
    unittest.test("to-json--from-json", () {
      var o = buildNestingLevel();
      var od = new api.NestingLevel.fromJson(o.toJson());
      checkNestingLevel(od);
    });
  });


  unittest.group("obj-schema-NotesProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildNotesProperties();
      var od = new api.NotesProperties.fromJson(o.toJson());
      checkNotesProperties(od);
    });
  });


  unittest.group("obj-schema-OpaqueColor", () {
    unittest.test("to-json--from-json", () {
      var o = buildOpaqueColor();
      var od = new api.OpaqueColor.fromJson(o.toJson());
      checkOpaqueColor(od);
    });
  });


  unittest.group("obj-schema-OptionalColor", () {
    unittest.test("to-json--from-json", () {
      var o = buildOptionalColor();
      var od = new api.OptionalColor.fromJson(o.toJson());
      checkOptionalColor(od);
    });
  });


  unittest.group("obj-schema-Outline", () {
    unittest.test("to-json--from-json", () {
      var o = buildOutline();
      var od = new api.Outline.fromJson(o.toJson());
      checkOutline(od);
    });
  });


  unittest.group("obj-schema-OutlineFill", () {
    unittest.test("to-json--from-json", () {
      var o = buildOutlineFill();
      var od = new api.OutlineFill.fromJson(o.toJson());
      checkOutlineFill(od);
    });
  });


  unittest.group("obj-schema-Page", () {
    unittest.test("to-json--from-json", () {
      var o = buildPage();
      var od = new api.Page.fromJson(o.toJson());
      checkPage(od);
    });
  });


  unittest.group("obj-schema-PageBackgroundFill", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageBackgroundFill();
      var od = new api.PageBackgroundFill.fromJson(o.toJson());
      checkPageBackgroundFill(od);
    });
  });


  unittest.group("obj-schema-PageElement", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageElement();
      var od = new api.PageElement.fromJson(o.toJson());
      checkPageElement(od);
    });
  });


  unittest.group("obj-schema-PageElementProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageElementProperties();
      var od = new api.PageElementProperties.fromJson(o.toJson());
      checkPageElementProperties(od);
    });
  });


  unittest.group("obj-schema-PageProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageProperties();
      var od = new api.PageProperties.fromJson(o.toJson());
      checkPageProperties(od);
    });
  });


  unittest.group("obj-schema-ParagraphMarker", () {
    unittest.test("to-json--from-json", () {
      var o = buildParagraphMarker();
      var od = new api.ParagraphMarker.fromJson(o.toJson());
      checkParagraphMarker(od);
    });
  });


  unittest.group("obj-schema-ParagraphStyle", () {
    unittest.test("to-json--from-json", () {
      var o = buildParagraphStyle();
      var od = new api.ParagraphStyle.fromJson(o.toJson());
      checkParagraphStyle(od);
    });
  });


  unittest.group("obj-schema-Placeholder", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlaceholder();
      var od = new api.Placeholder.fromJson(o.toJson());
      checkPlaceholder(od);
    });
  });


  unittest.group("obj-schema-Presentation", () {
    unittest.test("to-json--from-json", () {
      var o = buildPresentation();
      var od = new api.Presentation.fromJson(o.toJson());
      checkPresentation(od);
    });
  });


  unittest.group("obj-schema-Range", () {
    unittest.test("to-json--from-json", () {
      var o = buildRange();
      var od = new api.Range.fromJson(o.toJson());
      checkRange(od);
    });
  });


  unittest.group("obj-schema-Recolor", () {
    unittest.test("to-json--from-json", () {
      var o = buildRecolor();
      var od = new api.Recolor.fromJson(o.toJson());
      checkRecolor(od);
    });
  });


  unittest.group("obj-schema-RefreshSheetsChartRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildRefreshSheetsChartRequest();
      var od = new api.RefreshSheetsChartRequest.fromJson(o.toJson());
      checkRefreshSheetsChartRequest(od);
    });
  });


  unittest.group("obj-schema-ReplaceAllShapesWithImageRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildReplaceAllShapesWithImageRequest();
      var od = new api.ReplaceAllShapesWithImageRequest.fromJson(o.toJson());
      checkReplaceAllShapesWithImageRequest(od);
    });
  });


  unittest.group("obj-schema-ReplaceAllShapesWithImageResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildReplaceAllShapesWithImageResponse();
      var od = new api.ReplaceAllShapesWithImageResponse.fromJson(o.toJson());
      checkReplaceAllShapesWithImageResponse(od);
    });
  });


  unittest.group("obj-schema-ReplaceAllShapesWithSheetsChartRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildReplaceAllShapesWithSheetsChartRequest();
      var od = new api.ReplaceAllShapesWithSheetsChartRequest.fromJson(o.toJson());
      checkReplaceAllShapesWithSheetsChartRequest(od);
    });
  });


  unittest.group("obj-schema-ReplaceAllShapesWithSheetsChartResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildReplaceAllShapesWithSheetsChartResponse();
      var od = new api.ReplaceAllShapesWithSheetsChartResponse.fromJson(o.toJson());
      checkReplaceAllShapesWithSheetsChartResponse(od);
    });
  });


  unittest.group("obj-schema-ReplaceAllTextRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildReplaceAllTextRequest();
      var od = new api.ReplaceAllTextRequest.fromJson(o.toJson());
      checkReplaceAllTextRequest(od);
    });
  });


  unittest.group("obj-schema-ReplaceAllTextResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildReplaceAllTextResponse();
      var od = new api.ReplaceAllTextResponse.fromJson(o.toJson());
      checkReplaceAllTextResponse(od);
    });
  });


  unittest.group("obj-schema-Request", () {
    unittest.test("to-json--from-json", () {
      var o = buildRequest();
      var od = new api.Request.fromJson(o.toJson());
      checkRequest(od);
    });
  });


  unittest.group("obj-schema-Response", () {
    unittest.test("to-json--from-json", () {
      var o = buildResponse();
      var od = new api.Response.fromJson(o.toJson());
      checkResponse(od);
    });
  });


  unittest.group("obj-schema-RgbColor", () {
    unittest.test("to-json--from-json", () {
      var o = buildRgbColor();
      var od = new api.RgbColor.fromJson(o.toJson());
      checkRgbColor(od);
    });
  });


  unittest.group("obj-schema-Shadow", () {
    unittest.test("to-json--from-json", () {
      var o = buildShadow();
      var od = new api.Shadow.fromJson(o.toJson());
      checkShadow(od);
    });
  });


  unittest.group("obj-schema-Shape", () {
    unittest.test("to-json--from-json", () {
      var o = buildShape();
      var od = new api.Shape.fromJson(o.toJson());
      checkShape(od);
    });
  });


  unittest.group("obj-schema-ShapeBackgroundFill", () {
    unittest.test("to-json--from-json", () {
      var o = buildShapeBackgroundFill();
      var od = new api.ShapeBackgroundFill.fromJson(o.toJson());
      checkShapeBackgroundFill(od);
    });
  });


  unittest.group("obj-schema-ShapeProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildShapeProperties();
      var od = new api.ShapeProperties.fromJson(o.toJson());
      checkShapeProperties(od);
    });
  });


  unittest.group("obj-schema-SheetsChart", () {
    unittest.test("to-json--from-json", () {
      var o = buildSheetsChart();
      var od = new api.SheetsChart.fromJson(o.toJson());
      checkSheetsChart(od);
    });
  });


  unittest.group("obj-schema-SheetsChartProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildSheetsChartProperties();
      var od = new api.SheetsChartProperties.fromJson(o.toJson());
      checkSheetsChartProperties(od);
    });
  });


  unittest.group("obj-schema-Size", () {
    unittest.test("to-json--from-json", () {
      var o = buildSize();
      var od = new api.Size.fromJson(o.toJson());
      checkSize(od);
    });
  });


  unittest.group("obj-schema-SlideProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildSlideProperties();
      var od = new api.SlideProperties.fromJson(o.toJson());
      checkSlideProperties(od);
    });
  });


  unittest.group("obj-schema-SolidFill", () {
    unittest.test("to-json--from-json", () {
      var o = buildSolidFill();
      var od = new api.SolidFill.fromJson(o.toJson());
      checkSolidFill(od);
    });
  });


  unittest.group("obj-schema-StretchedPictureFill", () {
    unittest.test("to-json--from-json", () {
      var o = buildStretchedPictureFill();
      var od = new api.StretchedPictureFill.fromJson(o.toJson());
      checkStretchedPictureFill(od);
    });
  });


  unittest.group("obj-schema-SubstringMatchCriteria", () {
    unittest.test("to-json--from-json", () {
      var o = buildSubstringMatchCriteria();
      var od = new api.SubstringMatchCriteria.fromJson(o.toJson());
      checkSubstringMatchCriteria(od);
    });
  });


  unittest.group("obj-schema-Table", () {
    unittest.test("to-json--from-json", () {
      var o = buildTable();
      var od = new api.Table.fromJson(o.toJson());
      checkTable(od);
    });
  });


  unittest.group("obj-schema-TableCell", () {
    unittest.test("to-json--from-json", () {
      var o = buildTableCell();
      var od = new api.TableCell.fromJson(o.toJson());
      checkTableCell(od);
    });
  });


  unittest.group("obj-schema-TableCellBackgroundFill", () {
    unittest.test("to-json--from-json", () {
      var o = buildTableCellBackgroundFill();
      var od = new api.TableCellBackgroundFill.fromJson(o.toJson());
      checkTableCellBackgroundFill(od);
    });
  });


  unittest.group("obj-schema-TableCellLocation", () {
    unittest.test("to-json--from-json", () {
      var o = buildTableCellLocation();
      var od = new api.TableCellLocation.fromJson(o.toJson());
      checkTableCellLocation(od);
    });
  });


  unittest.group("obj-schema-TableCellProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildTableCellProperties();
      var od = new api.TableCellProperties.fromJson(o.toJson());
      checkTableCellProperties(od);
    });
  });


  unittest.group("obj-schema-TableColumnProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildTableColumnProperties();
      var od = new api.TableColumnProperties.fromJson(o.toJson());
      checkTableColumnProperties(od);
    });
  });


  unittest.group("obj-schema-TableRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildTableRange();
      var od = new api.TableRange.fromJson(o.toJson());
      checkTableRange(od);
    });
  });


  unittest.group("obj-schema-TableRow", () {
    unittest.test("to-json--from-json", () {
      var o = buildTableRow();
      var od = new api.TableRow.fromJson(o.toJson());
      checkTableRow(od);
    });
  });


  unittest.group("obj-schema-TextContent", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextContent();
      var od = new api.TextContent.fromJson(o.toJson());
      checkTextContent(od);
    });
  });


  unittest.group("obj-schema-TextElement", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextElement();
      var od = new api.TextElement.fromJson(o.toJson());
      checkTextElement(od);
    });
  });


  unittest.group("obj-schema-TextRun", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextRun();
      var od = new api.TextRun.fromJson(o.toJson());
      checkTextRun(od);
    });
  });


  unittest.group("obj-schema-TextStyle", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextStyle();
      var od = new api.TextStyle.fromJson(o.toJson());
      checkTextStyle(od);
    });
  });


  unittest.group("obj-schema-ThemeColorPair", () {
    unittest.test("to-json--from-json", () {
      var o = buildThemeColorPair();
      var od = new api.ThemeColorPair.fromJson(o.toJson());
      checkThemeColorPair(od);
    });
  });


  unittest.group("obj-schema-UpdateImagePropertiesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateImagePropertiesRequest();
      var od = new api.UpdateImagePropertiesRequest.fromJson(o.toJson());
      checkUpdateImagePropertiesRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateLinePropertiesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateLinePropertiesRequest();
      var od = new api.UpdateLinePropertiesRequest.fromJson(o.toJson());
      checkUpdateLinePropertiesRequest(od);
    });
  });


  unittest.group("obj-schema-UpdatePageElementTransformRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdatePageElementTransformRequest();
      var od = new api.UpdatePageElementTransformRequest.fromJson(o.toJson());
      checkUpdatePageElementTransformRequest(od);
    });
  });


  unittest.group("obj-schema-UpdatePagePropertiesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdatePagePropertiesRequest();
      var od = new api.UpdatePagePropertiesRequest.fromJson(o.toJson());
      checkUpdatePagePropertiesRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateParagraphStyleRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateParagraphStyleRequest();
      var od = new api.UpdateParagraphStyleRequest.fromJson(o.toJson());
      checkUpdateParagraphStyleRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateShapePropertiesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateShapePropertiesRequest();
      var od = new api.UpdateShapePropertiesRequest.fromJson(o.toJson());
      checkUpdateShapePropertiesRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateSlidesPositionRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateSlidesPositionRequest();
      var od = new api.UpdateSlidesPositionRequest.fromJson(o.toJson());
      checkUpdateSlidesPositionRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateTableCellPropertiesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateTableCellPropertiesRequest();
      var od = new api.UpdateTableCellPropertiesRequest.fromJson(o.toJson());
      checkUpdateTableCellPropertiesRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateTextStyleRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateTextStyleRequest();
      var od = new api.UpdateTextStyleRequest.fromJson(o.toJson());
      checkUpdateTextStyleRequest(od);
    });
  });


  unittest.group("obj-schema-UpdateVideoPropertiesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateVideoPropertiesRequest();
      var od = new api.UpdateVideoPropertiesRequest.fromJson(o.toJson());
      checkUpdateVideoPropertiesRequest(od);
    });
  });


  unittest.group("obj-schema-Video", () {
    unittest.test("to-json--from-json", () {
      var o = buildVideo();
      var od = new api.Video.fromJson(o.toJson());
      checkVideo(od);
    });
  });


  unittest.group("obj-schema-VideoProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildVideoProperties();
      var od = new api.VideoProperties.fromJson(o.toJson());
      checkVideoProperties(od);
    });
  });


  unittest.group("obj-schema-WordArt", () {
    unittest.test("to-json--from-json", () {
      var o = buildWordArt();
      var od = new api.WordArt.fromJson(o.toJson());
      checkWordArt(od);
    });
  });


  unittest.group("resource-PresentationsResourceApi", () {
    unittest.test("method--batchUpdate", () {

      var mock = new HttpServerMock();
      api.PresentationsResourceApi res = new api.SlidesApi(mock).presentations;
      var arg_request = buildBatchUpdatePresentationRequest();
      var arg_presentationId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.BatchUpdatePresentationRequest.fromJson(json);
        checkBatchUpdatePresentationRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("v1/presentations/"));
        pathOffset += 17;
        index = path.indexOf(":batchUpdate", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_presentationId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals(":batchUpdate"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBatchUpdatePresentationResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.batchUpdate(arg_request, arg_presentationId).then(unittest.expectAsync(((api.BatchUpdatePresentationResponse response) {
        checkBatchUpdatePresentationResponse(response);
      })));
    });

    unittest.test("method--create", () {

      var mock = new HttpServerMock();
      api.PresentationsResourceApi res = new api.SlidesApi(mock).presentations;
      var arg_request = buildPresentation();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Presentation.fromJson(json);
        checkPresentation(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("v1/presentations"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPresentation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request).then(unittest.expectAsync(((api.Presentation response) {
        checkPresentation(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.PresentationsResourceApi res = new api.SlidesApi(mock).presentations;
      var arg_presentationId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("v1/presentations/"));
        pathOffset += 17;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

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
        var resp = convert.JSON.encode(buildPresentation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_presentationId).then(unittest.expectAsync(((api.Presentation response) {
        checkPresentation(response);
      })));
    });

  });


  unittest.group("resource-PresentationsPagesResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.PresentationsPagesResourceApi res = new api.SlidesApi(mock).presentations.pages;
      var arg_presentationId = "foo";
      var arg_pageObjectId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("v1/presentations/"));
        pathOffset += 17;
        index = path.indexOf("/pages/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_presentationId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/pages/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_pageObjectId"));

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
        var resp = convert.JSON.encode(buildPage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_presentationId, arg_pageObjectId).then(unittest.expectAsync(((api.Page response) {
        checkPage(response);
      })));
    });

  });


}

