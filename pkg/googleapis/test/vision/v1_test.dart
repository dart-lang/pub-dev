library googleapis.vision.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/vision/v1.dart' as api;

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

buildUnnamed1177() {
  var o = new core.List<api.Feature>();
  o.add(buildFeature());
  o.add(buildFeature());
  return o;
}

checkUnnamed1177(core.List<api.Feature> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFeature(o[0]);
  checkFeature(o[1]);
}

core.int buildCounterAnnotateImageRequest = 0;
buildAnnotateImageRequest() {
  var o = new api.AnnotateImageRequest();
  buildCounterAnnotateImageRequest++;
  if (buildCounterAnnotateImageRequest < 3) {
    o.features = buildUnnamed1177();
    o.image = buildImage();
    o.imageContext = buildImageContext();
  }
  buildCounterAnnotateImageRequest--;
  return o;
}

checkAnnotateImageRequest(api.AnnotateImageRequest o) {
  buildCounterAnnotateImageRequest++;
  if (buildCounterAnnotateImageRequest < 3) {
    checkUnnamed1177(o.features);
    checkImage(o.image);
    checkImageContext(o.imageContext);
  }
  buildCounterAnnotateImageRequest--;
}

buildUnnamed1178() {
  var o = new core.List<api.FaceAnnotation>();
  o.add(buildFaceAnnotation());
  o.add(buildFaceAnnotation());
  return o;
}

checkUnnamed1178(core.List<api.FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFaceAnnotation(o[0]);
  checkFaceAnnotation(o[1]);
}

buildUnnamed1179() {
  var o = new core.List<api.EntityAnnotation>();
  o.add(buildEntityAnnotation());
  o.add(buildEntityAnnotation());
  return o;
}

checkUnnamed1179(core.List<api.EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntityAnnotation(o[0]);
  checkEntityAnnotation(o[1]);
}

buildUnnamed1180() {
  var o = new core.List<api.EntityAnnotation>();
  o.add(buildEntityAnnotation());
  o.add(buildEntityAnnotation());
  return o;
}

checkUnnamed1180(core.List<api.EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntityAnnotation(o[0]);
  checkEntityAnnotation(o[1]);
}

buildUnnamed1181() {
  var o = new core.List<api.EntityAnnotation>();
  o.add(buildEntityAnnotation());
  o.add(buildEntityAnnotation());
  return o;
}

checkUnnamed1181(core.List<api.EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntityAnnotation(o[0]);
  checkEntityAnnotation(o[1]);
}

buildUnnamed1182() {
  var o = new core.List<api.EntityAnnotation>();
  o.add(buildEntityAnnotation());
  o.add(buildEntityAnnotation());
  return o;
}

checkUnnamed1182(core.List<api.EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntityAnnotation(o[0]);
  checkEntityAnnotation(o[1]);
}

core.int buildCounterAnnotateImageResponse = 0;
buildAnnotateImageResponse() {
  var o = new api.AnnotateImageResponse();
  buildCounterAnnotateImageResponse++;
  if (buildCounterAnnotateImageResponse < 3) {
    o.cropHintsAnnotation = buildCropHintsAnnotation();
    o.error = buildStatus();
    o.faceAnnotations = buildUnnamed1178();
    o.fullTextAnnotation = buildTextAnnotation();
    o.imagePropertiesAnnotation = buildImageProperties();
    o.labelAnnotations = buildUnnamed1179();
    o.landmarkAnnotations = buildUnnamed1180();
    o.logoAnnotations = buildUnnamed1181();
    o.safeSearchAnnotation = buildSafeSearchAnnotation();
    o.textAnnotations = buildUnnamed1182();
    o.webDetection = buildWebDetection();
  }
  buildCounterAnnotateImageResponse--;
  return o;
}

checkAnnotateImageResponse(api.AnnotateImageResponse o) {
  buildCounterAnnotateImageResponse++;
  if (buildCounterAnnotateImageResponse < 3) {
    checkCropHintsAnnotation(o.cropHintsAnnotation);
    checkStatus(o.error);
    checkUnnamed1178(o.faceAnnotations);
    checkTextAnnotation(o.fullTextAnnotation);
    checkImageProperties(o.imagePropertiesAnnotation);
    checkUnnamed1179(o.labelAnnotations);
    checkUnnamed1180(o.landmarkAnnotations);
    checkUnnamed1181(o.logoAnnotations);
    checkSafeSearchAnnotation(o.safeSearchAnnotation);
    checkUnnamed1182(o.textAnnotations);
    checkWebDetection(o.webDetection);
  }
  buildCounterAnnotateImageResponse--;
}

buildUnnamed1183() {
  var o = new core.List<api.AnnotateImageRequest>();
  o.add(buildAnnotateImageRequest());
  o.add(buildAnnotateImageRequest());
  return o;
}

checkUnnamed1183(core.List<api.AnnotateImageRequest> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotateImageRequest(o[0]);
  checkAnnotateImageRequest(o[1]);
}

core.int buildCounterBatchAnnotateImagesRequest = 0;
buildBatchAnnotateImagesRequest() {
  var o = new api.BatchAnnotateImagesRequest();
  buildCounterBatchAnnotateImagesRequest++;
  if (buildCounterBatchAnnotateImagesRequest < 3) {
    o.requests = buildUnnamed1183();
  }
  buildCounterBatchAnnotateImagesRequest--;
  return o;
}

checkBatchAnnotateImagesRequest(api.BatchAnnotateImagesRequest o) {
  buildCounterBatchAnnotateImagesRequest++;
  if (buildCounterBatchAnnotateImagesRequest < 3) {
    checkUnnamed1183(o.requests);
  }
  buildCounterBatchAnnotateImagesRequest--;
}

buildUnnamed1184() {
  var o = new core.List<api.AnnotateImageResponse>();
  o.add(buildAnnotateImageResponse());
  o.add(buildAnnotateImageResponse());
  return o;
}

checkUnnamed1184(core.List<api.AnnotateImageResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotateImageResponse(o[0]);
  checkAnnotateImageResponse(o[1]);
}

core.int buildCounterBatchAnnotateImagesResponse = 0;
buildBatchAnnotateImagesResponse() {
  var o = new api.BatchAnnotateImagesResponse();
  buildCounterBatchAnnotateImagesResponse++;
  if (buildCounterBatchAnnotateImagesResponse < 3) {
    o.responses = buildUnnamed1184();
  }
  buildCounterBatchAnnotateImagesResponse--;
  return o;
}

checkBatchAnnotateImagesResponse(api.BatchAnnotateImagesResponse o) {
  buildCounterBatchAnnotateImagesResponse++;
  if (buildCounterBatchAnnotateImagesResponse < 3) {
    checkUnnamed1184(o.responses);
  }
  buildCounterBatchAnnotateImagesResponse--;
}

buildUnnamed1185() {
  var o = new core.List<api.Paragraph>();
  o.add(buildParagraph());
  o.add(buildParagraph());
  return o;
}

checkUnnamed1185(core.List<api.Paragraph> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParagraph(o[0]);
  checkParagraph(o[1]);
}

core.int buildCounterBlock = 0;
buildBlock() {
  var o = new api.Block();
  buildCounterBlock++;
  if (buildCounterBlock < 3) {
    o.blockType = "foo";
    o.boundingBox = buildBoundingPoly();
    o.paragraphs = buildUnnamed1185();
    o.property = buildTextProperty();
  }
  buildCounterBlock--;
  return o;
}

checkBlock(api.Block o) {
  buildCounterBlock++;
  if (buildCounterBlock < 3) {
    unittest.expect(o.blockType, unittest.equals('foo'));
    checkBoundingPoly(o.boundingBox);
    checkUnnamed1185(o.paragraphs);
    checkTextProperty(o.property);
  }
  buildCounterBlock--;
}

buildUnnamed1186() {
  var o = new core.List<api.Vertex>();
  o.add(buildVertex());
  o.add(buildVertex());
  return o;
}

checkUnnamed1186(core.List<api.Vertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVertex(o[0]);
  checkVertex(o[1]);
}

core.int buildCounterBoundingPoly = 0;
buildBoundingPoly() {
  var o = new api.BoundingPoly();
  buildCounterBoundingPoly++;
  if (buildCounterBoundingPoly < 3) {
    o.vertices = buildUnnamed1186();
  }
  buildCounterBoundingPoly--;
  return o;
}

checkBoundingPoly(api.BoundingPoly o) {
  buildCounterBoundingPoly++;
  if (buildCounterBoundingPoly < 3) {
    checkUnnamed1186(o.vertices);
  }
  buildCounterBoundingPoly--;
}

core.int buildCounterColor = 0;
buildColor() {
  var o = new api.Color();
  buildCounterColor++;
  if (buildCounterColor < 3) {
    o.alpha = 42.0;
    o.blue = 42.0;
    o.green = 42.0;
    o.red = 42.0;
  }
  buildCounterColor--;
  return o;
}

checkColor(api.Color o) {
  buildCounterColor++;
  if (buildCounterColor < 3) {
    unittest.expect(o.alpha, unittest.equals(42.0));
    unittest.expect(o.blue, unittest.equals(42.0));
    unittest.expect(o.green, unittest.equals(42.0));
    unittest.expect(o.red, unittest.equals(42.0));
  }
  buildCounterColor--;
}

core.int buildCounterColorInfo = 0;
buildColorInfo() {
  var o = new api.ColorInfo();
  buildCounterColorInfo++;
  if (buildCounterColorInfo < 3) {
    o.color = buildColor();
    o.pixelFraction = 42.0;
    o.score = 42.0;
  }
  buildCounterColorInfo--;
  return o;
}

checkColorInfo(api.ColorInfo o) {
  buildCounterColorInfo++;
  if (buildCounterColorInfo < 3) {
    checkColor(o.color);
    unittest.expect(o.pixelFraction, unittest.equals(42.0));
    unittest.expect(o.score, unittest.equals(42.0));
  }
  buildCounterColorInfo--;
}

core.int buildCounterCropHint = 0;
buildCropHint() {
  var o = new api.CropHint();
  buildCounterCropHint++;
  if (buildCounterCropHint < 3) {
    o.boundingPoly = buildBoundingPoly();
    o.confidence = 42.0;
    o.importanceFraction = 42.0;
  }
  buildCounterCropHint--;
  return o;
}

checkCropHint(api.CropHint o) {
  buildCounterCropHint++;
  if (buildCounterCropHint < 3) {
    checkBoundingPoly(o.boundingPoly);
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.importanceFraction, unittest.equals(42.0));
  }
  buildCounterCropHint--;
}

buildUnnamed1187() {
  var o = new core.List<api.CropHint>();
  o.add(buildCropHint());
  o.add(buildCropHint());
  return o;
}

checkUnnamed1187(core.List<api.CropHint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCropHint(o[0]);
  checkCropHint(o[1]);
}

core.int buildCounterCropHintsAnnotation = 0;
buildCropHintsAnnotation() {
  var o = new api.CropHintsAnnotation();
  buildCounterCropHintsAnnotation++;
  if (buildCounterCropHintsAnnotation < 3) {
    o.cropHints = buildUnnamed1187();
  }
  buildCounterCropHintsAnnotation--;
  return o;
}

checkCropHintsAnnotation(api.CropHintsAnnotation o) {
  buildCounterCropHintsAnnotation++;
  if (buildCounterCropHintsAnnotation < 3) {
    checkUnnamed1187(o.cropHints);
  }
  buildCounterCropHintsAnnotation--;
}

buildUnnamed1188() {
  var o = new core.List<core.double>();
  o.add(42.0);
  o.add(42.0);
  return o;
}

checkUnnamed1188(core.List<core.double> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42.0));
  unittest.expect(o[1], unittest.equals(42.0));
}

core.int buildCounterCropHintsParams = 0;
buildCropHintsParams() {
  var o = new api.CropHintsParams();
  buildCounterCropHintsParams++;
  if (buildCounterCropHintsParams < 3) {
    o.aspectRatios = buildUnnamed1188();
  }
  buildCounterCropHintsParams--;
  return o;
}

checkCropHintsParams(api.CropHintsParams o) {
  buildCounterCropHintsParams++;
  if (buildCounterCropHintsParams < 3) {
    checkUnnamed1188(o.aspectRatios);
  }
  buildCounterCropHintsParams--;
}

core.int buildCounterDetectedBreak = 0;
buildDetectedBreak() {
  var o = new api.DetectedBreak();
  buildCounterDetectedBreak++;
  if (buildCounterDetectedBreak < 3) {
    o.isPrefix = true;
    o.type = "foo";
  }
  buildCounterDetectedBreak--;
  return o;
}

checkDetectedBreak(api.DetectedBreak o) {
  buildCounterDetectedBreak++;
  if (buildCounterDetectedBreak < 3) {
    unittest.expect(o.isPrefix, unittest.isTrue);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterDetectedBreak--;
}

core.int buildCounterDetectedLanguage = 0;
buildDetectedLanguage() {
  var o = new api.DetectedLanguage();
  buildCounterDetectedLanguage++;
  if (buildCounterDetectedLanguage < 3) {
    o.confidence = 42.0;
    o.languageCode = "foo";
  }
  buildCounterDetectedLanguage--;
  return o;
}

checkDetectedLanguage(api.DetectedLanguage o) {
  buildCounterDetectedLanguage++;
  if (buildCounterDetectedLanguage < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.languageCode, unittest.equals('foo'));
  }
  buildCounterDetectedLanguage--;
}

buildUnnamed1189() {
  var o = new core.List<api.ColorInfo>();
  o.add(buildColorInfo());
  o.add(buildColorInfo());
  return o;
}

checkUnnamed1189(core.List<api.ColorInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkColorInfo(o[0]);
  checkColorInfo(o[1]);
}

core.int buildCounterDominantColorsAnnotation = 0;
buildDominantColorsAnnotation() {
  var o = new api.DominantColorsAnnotation();
  buildCounterDominantColorsAnnotation++;
  if (buildCounterDominantColorsAnnotation < 3) {
    o.colors = buildUnnamed1189();
  }
  buildCounterDominantColorsAnnotation--;
  return o;
}

checkDominantColorsAnnotation(api.DominantColorsAnnotation o) {
  buildCounterDominantColorsAnnotation++;
  if (buildCounterDominantColorsAnnotation < 3) {
    checkUnnamed1189(o.colors);
  }
  buildCounterDominantColorsAnnotation--;
}

buildUnnamed1190() {
  var o = new core.List<api.LocationInfo>();
  o.add(buildLocationInfo());
  o.add(buildLocationInfo());
  return o;
}

checkUnnamed1190(core.List<api.LocationInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLocationInfo(o[0]);
  checkLocationInfo(o[1]);
}

buildUnnamed1191() {
  var o = new core.List<api.Property>();
  o.add(buildProperty());
  o.add(buildProperty());
  return o;
}

checkUnnamed1191(core.List<api.Property> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProperty(o[0]);
  checkProperty(o[1]);
}

core.int buildCounterEntityAnnotation = 0;
buildEntityAnnotation() {
  var o = new api.EntityAnnotation();
  buildCounterEntityAnnotation++;
  if (buildCounterEntityAnnotation < 3) {
    o.boundingPoly = buildBoundingPoly();
    o.confidence = 42.0;
    o.description = "foo";
    o.locale = "foo";
    o.locations = buildUnnamed1190();
    o.mid = "foo";
    o.properties = buildUnnamed1191();
    o.score = 42.0;
    o.topicality = 42.0;
  }
  buildCounterEntityAnnotation--;
  return o;
}

checkEntityAnnotation(api.EntityAnnotation o) {
  buildCounterEntityAnnotation++;
  if (buildCounterEntityAnnotation < 3) {
    checkBoundingPoly(o.boundingPoly);
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.locale, unittest.equals('foo'));
    checkUnnamed1190(o.locations);
    unittest.expect(o.mid, unittest.equals('foo'));
    checkUnnamed1191(o.properties);
    unittest.expect(o.score, unittest.equals(42.0));
    unittest.expect(o.topicality, unittest.equals(42.0));
  }
  buildCounterEntityAnnotation--;
}

buildUnnamed1192() {
  var o = new core.List<api.Landmark>();
  o.add(buildLandmark());
  o.add(buildLandmark());
  return o;
}

checkUnnamed1192(core.List<api.Landmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLandmark(o[0]);
  checkLandmark(o[1]);
}

core.int buildCounterFaceAnnotation = 0;
buildFaceAnnotation() {
  var o = new api.FaceAnnotation();
  buildCounterFaceAnnotation++;
  if (buildCounterFaceAnnotation < 3) {
    o.angerLikelihood = "foo";
    o.blurredLikelihood = "foo";
    o.boundingPoly = buildBoundingPoly();
    o.detectionConfidence = 42.0;
    o.fdBoundingPoly = buildBoundingPoly();
    o.headwearLikelihood = "foo";
    o.joyLikelihood = "foo";
    o.landmarkingConfidence = 42.0;
    o.landmarks = buildUnnamed1192();
    o.panAngle = 42.0;
    o.rollAngle = 42.0;
    o.sorrowLikelihood = "foo";
    o.surpriseLikelihood = "foo";
    o.tiltAngle = 42.0;
    o.underExposedLikelihood = "foo";
  }
  buildCounterFaceAnnotation--;
  return o;
}

checkFaceAnnotation(api.FaceAnnotation o) {
  buildCounterFaceAnnotation++;
  if (buildCounterFaceAnnotation < 3) {
    unittest.expect(o.angerLikelihood, unittest.equals('foo'));
    unittest.expect(o.blurredLikelihood, unittest.equals('foo'));
    checkBoundingPoly(o.boundingPoly);
    unittest.expect(o.detectionConfidence, unittest.equals(42.0));
    checkBoundingPoly(o.fdBoundingPoly);
    unittest.expect(o.headwearLikelihood, unittest.equals('foo'));
    unittest.expect(o.joyLikelihood, unittest.equals('foo'));
    unittest.expect(o.landmarkingConfidence, unittest.equals(42.0));
    checkUnnamed1192(o.landmarks);
    unittest.expect(o.panAngle, unittest.equals(42.0));
    unittest.expect(o.rollAngle, unittest.equals(42.0));
    unittest.expect(o.sorrowLikelihood, unittest.equals('foo'));
    unittest.expect(o.surpriseLikelihood, unittest.equals('foo'));
    unittest.expect(o.tiltAngle, unittest.equals(42.0));
    unittest.expect(o.underExposedLikelihood, unittest.equals('foo'));
  }
  buildCounterFaceAnnotation--;
}

core.int buildCounterFeature = 0;
buildFeature() {
  var o = new api.Feature();
  buildCounterFeature++;
  if (buildCounterFeature < 3) {
    o.maxResults = 42;
    o.type = "foo";
  }
  buildCounterFeature--;
  return o;
}

checkFeature(api.Feature o) {
  buildCounterFeature++;
  if (buildCounterFeature < 3) {
    unittest.expect(o.maxResults, unittest.equals(42));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterFeature--;
}

core.int buildCounterImage = 0;
buildImage() {
  var o = new api.Image();
  buildCounterImage++;
  if (buildCounterImage < 3) {
    o.content = "foo";
    o.source = buildImageSource();
  }
  buildCounterImage--;
  return o;
}

checkImage(api.Image o) {
  buildCounterImage++;
  if (buildCounterImage < 3) {
    unittest.expect(o.content, unittest.equals('foo'));
    checkImageSource(o.source);
  }
  buildCounterImage--;
}

buildUnnamed1193() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1193(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterImageContext = 0;
buildImageContext() {
  var o = new api.ImageContext();
  buildCounterImageContext++;
  if (buildCounterImageContext < 3) {
    o.cropHintsParams = buildCropHintsParams();
    o.languageHints = buildUnnamed1193();
    o.latLongRect = buildLatLongRect();
  }
  buildCounterImageContext--;
  return o;
}

checkImageContext(api.ImageContext o) {
  buildCounterImageContext++;
  if (buildCounterImageContext < 3) {
    checkCropHintsParams(o.cropHintsParams);
    checkUnnamed1193(o.languageHints);
    checkLatLongRect(o.latLongRect);
  }
  buildCounterImageContext--;
}

core.int buildCounterImageProperties = 0;
buildImageProperties() {
  var o = new api.ImageProperties();
  buildCounterImageProperties++;
  if (buildCounterImageProperties < 3) {
    o.dominantColors = buildDominantColorsAnnotation();
  }
  buildCounterImageProperties--;
  return o;
}

checkImageProperties(api.ImageProperties o) {
  buildCounterImageProperties++;
  if (buildCounterImageProperties < 3) {
    checkDominantColorsAnnotation(o.dominantColors);
  }
  buildCounterImageProperties--;
}

core.int buildCounterImageSource = 0;
buildImageSource() {
  var o = new api.ImageSource();
  buildCounterImageSource++;
  if (buildCounterImageSource < 3) {
    o.gcsImageUri = "foo";
    o.imageUri = "foo";
  }
  buildCounterImageSource--;
  return o;
}

checkImageSource(api.ImageSource o) {
  buildCounterImageSource++;
  if (buildCounterImageSource < 3) {
    unittest.expect(o.gcsImageUri, unittest.equals('foo'));
    unittest.expect(o.imageUri, unittest.equals('foo'));
  }
  buildCounterImageSource--;
}

core.int buildCounterLandmark = 0;
buildLandmark() {
  var o = new api.Landmark();
  buildCounterLandmark++;
  if (buildCounterLandmark < 3) {
    o.position = buildPosition();
    o.type = "foo";
  }
  buildCounterLandmark--;
  return o;
}

checkLandmark(api.Landmark o) {
  buildCounterLandmark++;
  if (buildCounterLandmark < 3) {
    checkPosition(o.position);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterLandmark--;
}

core.int buildCounterLatLng = 0;
buildLatLng() {
  var o = new api.LatLng();
  buildCounterLatLng++;
  if (buildCounterLatLng < 3) {
    o.latitude = 42.0;
    o.longitude = 42.0;
  }
  buildCounterLatLng--;
  return o;
}

checkLatLng(api.LatLng o) {
  buildCounterLatLng++;
  if (buildCounterLatLng < 3) {
    unittest.expect(o.latitude, unittest.equals(42.0));
    unittest.expect(o.longitude, unittest.equals(42.0));
  }
  buildCounterLatLng--;
}

core.int buildCounterLatLongRect = 0;
buildLatLongRect() {
  var o = new api.LatLongRect();
  buildCounterLatLongRect++;
  if (buildCounterLatLongRect < 3) {
    o.maxLatLng = buildLatLng();
    o.minLatLng = buildLatLng();
  }
  buildCounterLatLongRect--;
  return o;
}

checkLatLongRect(api.LatLongRect o) {
  buildCounterLatLongRect++;
  if (buildCounterLatLongRect < 3) {
    checkLatLng(o.maxLatLng);
    checkLatLng(o.minLatLng);
  }
  buildCounterLatLongRect--;
}

core.int buildCounterLocationInfo = 0;
buildLocationInfo() {
  var o = new api.LocationInfo();
  buildCounterLocationInfo++;
  if (buildCounterLocationInfo < 3) {
    o.latLng = buildLatLng();
  }
  buildCounterLocationInfo--;
  return o;
}

checkLocationInfo(api.LocationInfo o) {
  buildCounterLocationInfo++;
  if (buildCounterLocationInfo < 3) {
    checkLatLng(o.latLng);
  }
  buildCounterLocationInfo--;
}

buildUnnamed1194() {
  var o = new core.List<api.Block>();
  o.add(buildBlock());
  o.add(buildBlock());
  return o;
}

checkUnnamed1194(core.List<api.Block> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBlock(o[0]);
  checkBlock(o[1]);
}

core.int buildCounterPage = 0;
buildPage() {
  var o = new api.Page();
  buildCounterPage++;
  if (buildCounterPage < 3) {
    o.blocks = buildUnnamed1194();
    o.height = 42;
    o.property = buildTextProperty();
    o.width = 42;
  }
  buildCounterPage--;
  return o;
}

checkPage(api.Page o) {
  buildCounterPage++;
  if (buildCounterPage < 3) {
    checkUnnamed1194(o.blocks);
    unittest.expect(o.height, unittest.equals(42));
    checkTextProperty(o.property);
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterPage--;
}

buildUnnamed1195() {
  var o = new core.List<api.Word>();
  o.add(buildWord());
  o.add(buildWord());
  return o;
}

checkUnnamed1195(core.List<api.Word> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWord(o[0]);
  checkWord(o[1]);
}

core.int buildCounterParagraph = 0;
buildParagraph() {
  var o = new api.Paragraph();
  buildCounterParagraph++;
  if (buildCounterParagraph < 3) {
    o.boundingBox = buildBoundingPoly();
    o.property = buildTextProperty();
    o.words = buildUnnamed1195();
  }
  buildCounterParagraph--;
  return o;
}

checkParagraph(api.Paragraph o) {
  buildCounterParagraph++;
  if (buildCounterParagraph < 3) {
    checkBoundingPoly(o.boundingBox);
    checkTextProperty(o.property);
    checkUnnamed1195(o.words);
  }
  buildCounterParagraph--;
}

core.int buildCounterPosition = 0;
buildPosition() {
  var o = new api.Position();
  buildCounterPosition++;
  if (buildCounterPosition < 3) {
    o.x = 42.0;
    o.y = 42.0;
    o.z = 42.0;
  }
  buildCounterPosition--;
  return o;
}

checkPosition(api.Position o) {
  buildCounterPosition++;
  if (buildCounterPosition < 3) {
    unittest.expect(o.x, unittest.equals(42.0));
    unittest.expect(o.y, unittest.equals(42.0));
    unittest.expect(o.z, unittest.equals(42.0));
  }
  buildCounterPosition--;
}

core.int buildCounterProperty = 0;
buildProperty() {
  var o = new api.Property();
  buildCounterProperty++;
  if (buildCounterProperty < 3) {
    o.name = "foo";
    o.uint64Value = "foo";
    o.value = "foo";
  }
  buildCounterProperty--;
  return o;
}

checkProperty(api.Property o) {
  buildCounterProperty++;
  if (buildCounterProperty < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.uint64Value, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterProperty--;
}

core.int buildCounterSafeSearchAnnotation = 0;
buildSafeSearchAnnotation() {
  var o = new api.SafeSearchAnnotation();
  buildCounterSafeSearchAnnotation++;
  if (buildCounterSafeSearchAnnotation < 3) {
    o.adult = "foo";
    o.medical = "foo";
    o.spoof = "foo";
    o.violence = "foo";
  }
  buildCounterSafeSearchAnnotation--;
  return o;
}

checkSafeSearchAnnotation(api.SafeSearchAnnotation o) {
  buildCounterSafeSearchAnnotation++;
  if (buildCounterSafeSearchAnnotation < 3) {
    unittest.expect(o.adult, unittest.equals('foo'));
    unittest.expect(o.medical, unittest.equals('foo'));
    unittest.expect(o.spoof, unittest.equals('foo'));
    unittest.expect(o.violence, unittest.equals('foo'));
  }
  buildCounterSafeSearchAnnotation--;
}

buildUnnamed1196() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  o["y"] = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
  return o;
}

checkUnnamed1196(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o["x"]) as core.Map; unittest.expect(casted1, unittest.hasLength(3)); unittest.expect(casted1["list"], unittest.equals([1, 2, 3])); unittest.expect(casted1["bool"], unittest.equals(true)); unittest.expect(casted1["string"], unittest.equals('foo')); 
  var casted2 = (o["y"]) as core.Map; unittest.expect(casted2, unittest.hasLength(3)); unittest.expect(casted2["list"], unittest.equals([1, 2, 3])); unittest.expect(casted2["bool"], unittest.equals(true)); unittest.expect(casted2["string"], unittest.equals('foo')); 
}

buildUnnamed1197() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed1196());
  o.add(buildUnnamed1196());
  return o;
}

checkUnnamed1197(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed1196(o[0]);
  checkUnnamed1196(o[1]);
}

core.int buildCounterStatus = 0;
buildStatus() {
  var o = new api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed1197();
    o.message = "foo";
  }
  buildCounterStatus--;
  return o;
}

checkStatus(api.Status o) {
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed1197(o.details);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterStatus--;
}

core.int buildCounterSymbol = 0;
buildSymbol() {
  var o = new api.Symbol();
  buildCounterSymbol++;
  if (buildCounterSymbol < 3) {
    o.boundingBox = buildBoundingPoly();
    o.property = buildTextProperty();
    o.text = "foo";
  }
  buildCounterSymbol--;
  return o;
}

checkSymbol(api.Symbol o) {
  buildCounterSymbol++;
  if (buildCounterSymbol < 3) {
    checkBoundingPoly(o.boundingBox);
    checkTextProperty(o.property);
    unittest.expect(o.text, unittest.equals('foo'));
  }
  buildCounterSymbol--;
}

buildUnnamed1198() {
  var o = new core.List<api.Page>();
  o.add(buildPage());
  o.add(buildPage());
  return o;
}

checkUnnamed1198(core.List<api.Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPage(o[0]);
  checkPage(o[1]);
}

core.int buildCounterTextAnnotation = 0;
buildTextAnnotation() {
  var o = new api.TextAnnotation();
  buildCounterTextAnnotation++;
  if (buildCounterTextAnnotation < 3) {
    o.pages = buildUnnamed1198();
    o.text = "foo";
  }
  buildCounterTextAnnotation--;
  return o;
}

checkTextAnnotation(api.TextAnnotation o) {
  buildCounterTextAnnotation++;
  if (buildCounterTextAnnotation < 3) {
    checkUnnamed1198(o.pages);
    unittest.expect(o.text, unittest.equals('foo'));
  }
  buildCounterTextAnnotation--;
}

buildUnnamed1199() {
  var o = new core.List<api.DetectedLanguage>();
  o.add(buildDetectedLanguage());
  o.add(buildDetectedLanguage());
  return o;
}

checkUnnamed1199(core.List<api.DetectedLanguage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDetectedLanguage(o[0]);
  checkDetectedLanguage(o[1]);
}

core.int buildCounterTextProperty = 0;
buildTextProperty() {
  var o = new api.TextProperty();
  buildCounterTextProperty++;
  if (buildCounterTextProperty < 3) {
    o.detectedBreak = buildDetectedBreak();
    o.detectedLanguages = buildUnnamed1199();
  }
  buildCounterTextProperty--;
  return o;
}

checkTextProperty(api.TextProperty o) {
  buildCounterTextProperty++;
  if (buildCounterTextProperty < 3) {
    checkDetectedBreak(o.detectedBreak);
    checkUnnamed1199(o.detectedLanguages);
  }
  buildCounterTextProperty--;
}

core.int buildCounterVertex = 0;
buildVertex() {
  var o = new api.Vertex();
  buildCounterVertex++;
  if (buildCounterVertex < 3) {
    o.x = 42;
    o.y = 42;
  }
  buildCounterVertex--;
  return o;
}

checkVertex(api.Vertex o) {
  buildCounterVertex++;
  if (buildCounterVertex < 3) {
    unittest.expect(o.x, unittest.equals(42));
    unittest.expect(o.y, unittest.equals(42));
  }
  buildCounterVertex--;
}

buildUnnamed1200() {
  var o = new core.List<api.WebImage>();
  o.add(buildWebImage());
  o.add(buildWebImage());
  return o;
}

checkUnnamed1200(core.List<api.WebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebImage(o[0]);
  checkWebImage(o[1]);
}

buildUnnamed1201() {
  var o = new core.List<api.WebPage>();
  o.add(buildWebPage());
  o.add(buildWebPage());
  return o;
}

checkUnnamed1201(core.List<api.WebPage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebPage(o[0]);
  checkWebPage(o[1]);
}

buildUnnamed1202() {
  var o = new core.List<api.WebImage>();
  o.add(buildWebImage());
  o.add(buildWebImage());
  return o;
}

checkUnnamed1202(core.List<api.WebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebImage(o[0]);
  checkWebImage(o[1]);
}

buildUnnamed1203() {
  var o = new core.List<api.WebEntity>();
  o.add(buildWebEntity());
  o.add(buildWebEntity());
  return o;
}

checkUnnamed1203(core.List<api.WebEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebEntity(o[0]);
  checkWebEntity(o[1]);
}

core.int buildCounterWebDetection = 0;
buildWebDetection() {
  var o = new api.WebDetection();
  buildCounterWebDetection++;
  if (buildCounterWebDetection < 3) {
    o.fullMatchingImages = buildUnnamed1200();
    o.pagesWithMatchingImages = buildUnnamed1201();
    o.partialMatchingImages = buildUnnamed1202();
    o.webEntities = buildUnnamed1203();
  }
  buildCounterWebDetection--;
  return o;
}

checkWebDetection(api.WebDetection o) {
  buildCounterWebDetection++;
  if (buildCounterWebDetection < 3) {
    checkUnnamed1200(o.fullMatchingImages);
    checkUnnamed1201(o.pagesWithMatchingImages);
    checkUnnamed1202(o.partialMatchingImages);
    checkUnnamed1203(o.webEntities);
  }
  buildCounterWebDetection--;
}

core.int buildCounterWebEntity = 0;
buildWebEntity() {
  var o = new api.WebEntity();
  buildCounterWebEntity++;
  if (buildCounterWebEntity < 3) {
    o.description = "foo";
    o.entityId = "foo";
    o.score = 42.0;
  }
  buildCounterWebEntity--;
  return o;
}

checkWebEntity(api.WebEntity o) {
  buildCounterWebEntity++;
  if (buildCounterWebEntity < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.entityId, unittest.equals('foo'));
    unittest.expect(o.score, unittest.equals(42.0));
  }
  buildCounterWebEntity--;
}

core.int buildCounterWebImage = 0;
buildWebImage() {
  var o = new api.WebImage();
  buildCounterWebImage++;
  if (buildCounterWebImage < 3) {
    o.score = 42.0;
    o.url = "foo";
  }
  buildCounterWebImage--;
  return o;
}

checkWebImage(api.WebImage o) {
  buildCounterWebImage++;
  if (buildCounterWebImage < 3) {
    unittest.expect(o.score, unittest.equals(42.0));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterWebImage--;
}

core.int buildCounterWebPage = 0;
buildWebPage() {
  var o = new api.WebPage();
  buildCounterWebPage++;
  if (buildCounterWebPage < 3) {
    o.score = 42.0;
    o.url = "foo";
  }
  buildCounterWebPage--;
  return o;
}

checkWebPage(api.WebPage o) {
  buildCounterWebPage++;
  if (buildCounterWebPage < 3) {
    unittest.expect(o.score, unittest.equals(42.0));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterWebPage--;
}

buildUnnamed1204() {
  var o = new core.List<api.Symbol>();
  o.add(buildSymbol());
  o.add(buildSymbol());
  return o;
}

checkUnnamed1204(core.List<api.Symbol> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSymbol(o[0]);
  checkSymbol(o[1]);
}

core.int buildCounterWord = 0;
buildWord() {
  var o = new api.Word();
  buildCounterWord++;
  if (buildCounterWord < 3) {
    o.boundingBox = buildBoundingPoly();
    o.property = buildTextProperty();
    o.symbols = buildUnnamed1204();
  }
  buildCounterWord--;
  return o;
}

checkWord(api.Word o) {
  buildCounterWord++;
  if (buildCounterWord < 3) {
    checkBoundingPoly(o.boundingBox);
    checkTextProperty(o.property);
    checkUnnamed1204(o.symbols);
  }
  buildCounterWord--;
}


main() {
  unittest.group("obj-schema-AnnotateImageRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotateImageRequest();
      var od = new api.AnnotateImageRequest.fromJson(o.toJson());
      checkAnnotateImageRequest(od);
    });
  });


  unittest.group("obj-schema-AnnotateImageResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotateImageResponse();
      var od = new api.AnnotateImageResponse.fromJson(o.toJson());
      checkAnnotateImageResponse(od);
    });
  });


  unittest.group("obj-schema-BatchAnnotateImagesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchAnnotateImagesRequest();
      var od = new api.BatchAnnotateImagesRequest.fromJson(o.toJson());
      checkBatchAnnotateImagesRequest(od);
    });
  });


  unittest.group("obj-schema-BatchAnnotateImagesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchAnnotateImagesResponse();
      var od = new api.BatchAnnotateImagesResponse.fromJson(o.toJson());
      checkBatchAnnotateImagesResponse(od);
    });
  });


  unittest.group("obj-schema-Block", () {
    unittest.test("to-json--from-json", () {
      var o = buildBlock();
      var od = new api.Block.fromJson(o.toJson());
      checkBlock(od);
    });
  });


  unittest.group("obj-schema-BoundingPoly", () {
    unittest.test("to-json--from-json", () {
      var o = buildBoundingPoly();
      var od = new api.BoundingPoly.fromJson(o.toJson());
      checkBoundingPoly(od);
    });
  });


  unittest.group("obj-schema-Color", () {
    unittest.test("to-json--from-json", () {
      var o = buildColor();
      var od = new api.Color.fromJson(o.toJson());
      checkColor(od);
    });
  });


  unittest.group("obj-schema-ColorInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildColorInfo();
      var od = new api.ColorInfo.fromJson(o.toJson());
      checkColorInfo(od);
    });
  });


  unittest.group("obj-schema-CropHint", () {
    unittest.test("to-json--from-json", () {
      var o = buildCropHint();
      var od = new api.CropHint.fromJson(o.toJson());
      checkCropHint(od);
    });
  });


  unittest.group("obj-schema-CropHintsAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildCropHintsAnnotation();
      var od = new api.CropHintsAnnotation.fromJson(o.toJson());
      checkCropHintsAnnotation(od);
    });
  });


  unittest.group("obj-schema-CropHintsParams", () {
    unittest.test("to-json--from-json", () {
      var o = buildCropHintsParams();
      var od = new api.CropHintsParams.fromJson(o.toJson());
      checkCropHintsParams(od);
    });
  });


  unittest.group("obj-schema-DetectedBreak", () {
    unittest.test("to-json--from-json", () {
      var o = buildDetectedBreak();
      var od = new api.DetectedBreak.fromJson(o.toJson());
      checkDetectedBreak(od);
    });
  });


  unittest.group("obj-schema-DetectedLanguage", () {
    unittest.test("to-json--from-json", () {
      var o = buildDetectedLanguage();
      var od = new api.DetectedLanguage.fromJson(o.toJson());
      checkDetectedLanguage(od);
    });
  });


  unittest.group("obj-schema-DominantColorsAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildDominantColorsAnnotation();
      var od = new api.DominantColorsAnnotation.fromJson(o.toJson());
      checkDominantColorsAnnotation(od);
    });
  });


  unittest.group("obj-schema-EntityAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildEntityAnnotation();
      var od = new api.EntityAnnotation.fromJson(o.toJson());
      checkEntityAnnotation(od);
    });
  });


  unittest.group("obj-schema-FaceAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildFaceAnnotation();
      var od = new api.FaceAnnotation.fromJson(o.toJson());
      checkFaceAnnotation(od);
    });
  });


  unittest.group("obj-schema-Feature", () {
    unittest.test("to-json--from-json", () {
      var o = buildFeature();
      var od = new api.Feature.fromJson(o.toJson());
      checkFeature(od);
    });
  });


  unittest.group("obj-schema-Image", () {
    unittest.test("to-json--from-json", () {
      var o = buildImage();
      var od = new api.Image.fromJson(o.toJson());
      checkImage(od);
    });
  });


  unittest.group("obj-schema-ImageContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildImageContext();
      var od = new api.ImageContext.fromJson(o.toJson());
      checkImageContext(od);
    });
  });


  unittest.group("obj-schema-ImageProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildImageProperties();
      var od = new api.ImageProperties.fromJson(o.toJson());
      checkImageProperties(od);
    });
  });


  unittest.group("obj-schema-ImageSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildImageSource();
      var od = new api.ImageSource.fromJson(o.toJson());
      checkImageSource(od);
    });
  });


  unittest.group("obj-schema-Landmark", () {
    unittest.test("to-json--from-json", () {
      var o = buildLandmark();
      var od = new api.Landmark.fromJson(o.toJson());
      checkLandmark(od);
    });
  });


  unittest.group("obj-schema-LatLng", () {
    unittest.test("to-json--from-json", () {
      var o = buildLatLng();
      var od = new api.LatLng.fromJson(o.toJson());
      checkLatLng(od);
    });
  });


  unittest.group("obj-schema-LatLongRect", () {
    unittest.test("to-json--from-json", () {
      var o = buildLatLongRect();
      var od = new api.LatLongRect.fromJson(o.toJson());
      checkLatLongRect(od);
    });
  });


  unittest.group("obj-schema-LocationInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildLocationInfo();
      var od = new api.LocationInfo.fromJson(o.toJson());
      checkLocationInfo(od);
    });
  });


  unittest.group("obj-schema-Page", () {
    unittest.test("to-json--from-json", () {
      var o = buildPage();
      var od = new api.Page.fromJson(o.toJson());
      checkPage(od);
    });
  });


  unittest.group("obj-schema-Paragraph", () {
    unittest.test("to-json--from-json", () {
      var o = buildParagraph();
      var od = new api.Paragraph.fromJson(o.toJson());
      checkParagraph(od);
    });
  });


  unittest.group("obj-schema-Position", () {
    unittest.test("to-json--from-json", () {
      var o = buildPosition();
      var od = new api.Position.fromJson(o.toJson());
      checkPosition(od);
    });
  });


  unittest.group("obj-schema-Property", () {
    unittest.test("to-json--from-json", () {
      var o = buildProperty();
      var od = new api.Property.fromJson(o.toJson());
      checkProperty(od);
    });
  });


  unittest.group("obj-schema-SafeSearchAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildSafeSearchAnnotation();
      var od = new api.SafeSearchAnnotation.fromJson(o.toJson());
      checkSafeSearchAnnotation(od);
    });
  });


  unittest.group("obj-schema-Status", () {
    unittest.test("to-json--from-json", () {
      var o = buildStatus();
      var od = new api.Status.fromJson(o.toJson());
      checkStatus(od);
    });
  });


  unittest.group("obj-schema-Symbol", () {
    unittest.test("to-json--from-json", () {
      var o = buildSymbol();
      var od = new api.Symbol.fromJson(o.toJson());
      checkSymbol(od);
    });
  });


  unittest.group("obj-schema-TextAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextAnnotation();
      var od = new api.TextAnnotation.fromJson(o.toJson());
      checkTextAnnotation(od);
    });
  });


  unittest.group("obj-schema-TextProperty", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextProperty();
      var od = new api.TextProperty.fromJson(o.toJson());
      checkTextProperty(od);
    });
  });


  unittest.group("obj-schema-Vertex", () {
    unittest.test("to-json--from-json", () {
      var o = buildVertex();
      var od = new api.Vertex.fromJson(o.toJson());
      checkVertex(od);
    });
  });


  unittest.group("obj-schema-WebDetection", () {
    unittest.test("to-json--from-json", () {
      var o = buildWebDetection();
      var od = new api.WebDetection.fromJson(o.toJson());
      checkWebDetection(od);
    });
  });


  unittest.group("obj-schema-WebEntity", () {
    unittest.test("to-json--from-json", () {
      var o = buildWebEntity();
      var od = new api.WebEntity.fromJson(o.toJson());
      checkWebEntity(od);
    });
  });


  unittest.group("obj-schema-WebImage", () {
    unittest.test("to-json--from-json", () {
      var o = buildWebImage();
      var od = new api.WebImage.fromJson(o.toJson());
      checkWebImage(od);
    });
  });


  unittest.group("obj-schema-WebPage", () {
    unittest.test("to-json--from-json", () {
      var o = buildWebPage();
      var od = new api.WebPage.fromJson(o.toJson());
      checkWebPage(od);
    });
  });


  unittest.group("obj-schema-Word", () {
    unittest.test("to-json--from-json", () {
      var o = buildWord();
      var od = new api.Word.fromJson(o.toJson());
      checkWord(od);
    });
  });


  unittest.group("resource-ImagesResourceApi", () {
    unittest.test("method--annotate", () {

      var mock = new HttpServerMock();
      api.ImagesResourceApi res = new api.VisionApi(mock).images;
      var arg_request = buildBatchAnnotateImagesRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.BatchAnnotateImagesRequest.fromJson(json);
        checkBatchAnnotateImagesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 18), unittest.equals("v1/images:annotate"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBatchAnnotateImagesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.annotate(arg_request).then(unittest.expectAsync(((api.BatchAnnotateImagesResponse response) {
        checkBatchAnnotateImagesResponse(response);
      })));
    });

  });


}

