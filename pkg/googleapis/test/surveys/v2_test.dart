library googleapis.surveys.v2.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/surveys/v2.dart' as api;

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

buildUnnamed1889() {
  var o = new core.List<api.FieldMask>();
  o.add(buildFieldMask());
  o.add(buildFieldMask());
  return o;
}

checkUnnamed1889(core.List<api.FieldMask> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFieldMask(o[0]);
  checkFieldMask(o[1]);
}

core.int buildCounterFieldMask = 0;
buildFieldMask() {
  var o = new api.FieldMask();
  buildCounterFieldMask++;
  if (buildCounterFieldMask < 3) {
    o.fields = buildUnnamed1889();
    o.id = 42;
  }
  buildCounterFieldMask--;
  return o;
}

checkFieldMask(api.FieldMask o) {
  buildCounterFieldMask++;
  if (buildCounterFieldMask < 3) {
    checkUnnamed1889(o.fields);
    unittest.expect(o.id, unittest.equals(42));
  }
  buildCounterFieldMask--;
}

buildUnnamed1890() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1890(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterMobileAppPanel = 0;
buildMobileAppPanel() {
  var o = new api.MobileAppPanel();
  buildCounterMobileAppPanel++;
  if (buildCounterMobileAppPanel < 3) {
    o.country = "foo";
    o.isPublicPanel = true;
    o.language = "foo";
    o.mobileAppPanelId = "foo";
    o.name = "foo";
    o.owners = buildUnnamed1890();
  }
  buildCounterMobileAppPanel--;
  return o;
}

checkMobileAppPanel(api.MobileAppPanel o) {
  buildCounterMobileAppPanel++;
  if (buildCounterMobileAppPanel < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.isPublicPanel, unittest.isTrue);
    unittest.expect(o.language, unittest.equals('foo'));
    unittest.expect(o.mobileAppPanelId, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed1890(o.owners);
  }
  buildCounterMobileAppPanel--;
}

buildUnnamed1891() {
  var o = new core.List<api.MobileAppPanel>();
  o.add(buildMobileAppPanel());
  o.add(buildMobileAppPanel());
  return o;
}

checkUnnamed1891(core.List<api.MobileAppPanel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMobileAppPanel(o[0]);
  checkMobileAppPanel(o[1]);
}

core.int buildCounterMobileAppPanelsListResponse = 0;
buildMobileAppPanelsListResponse() {
  var o = new api.MobileAppPanelsListResponse();
  buildCounterMobileAppPanelsListResponse++;
  if (buildCounterMobileAppPanelsListResponse < 3) {
    o.pageInfo = buildPageInfo();
    o.requestId = "foo";
    o.resources = buildUnnamed1891();
    o.tokenPagination = buildTokenPagination();
  }
  buildCounterMobileAppPanelsListResponse--;
  return o;
}

checkMobileAppPanelsListResponse(api.MobileAppPanelsListResponse o) {
  buildCounterMobileAppPanelsListResponse++;
  if (buildCounterMobileAppPanelsListResponse < 3) {
    checkPageInfo(o.pageInfo);
    unittest.expect(o.requestId, unittest.equals('foo'));
    checkUnnamed1891(o.resources);
    checkTokenPagination(o.tokenPagination);
  }
  buildCounterMobileAppPanelsListResponse--;
}

core.int buildCounterPageInfo = 0;
buildPageInfo() {
  var o = new api.PageInfo();
  buildCounterPageInfo++;
  if (buildCounterPageInfo < 3) {
    o.resultPerPage = 42;
    o.startIndex = 42;
    o.totalResults = 42;
  }
  buildCounterPageInfo--;
  return o;
}

checkPageInfo(api.PageInfo o) {
  buildCounterPageInfo++;
  if (buildCounterPageInfo < 3) {
    unittest.expect(o.resultPerPage, unittest.equals(42));
    unittest.expect(o.startIndex, unittest.equals(42));
    unittest.expect(o.totalResults, unittest.equals(42));
  }
  buildCounterPageInfo--;
}

core.int buildCounterResultsGetRequest = 0;
buildResultsGetRequest() {
  var o = new api.ResultsGetRequest();
  buildCounterResultsGetRequest++;
  if (buildCounterResultsGetRequest < 3) {
    o.resultMask = buildResultsMask();
  }
  buildCounterResultsGetRequest--;
  return o;
}

checkResultsGetRequest(api.ResultsGetRequest o) {
  buildCounterResultsGetRequest++;
  if (buildCounterResultsGetRequest < 3) {
    checkResultsMask(o.resultMask);
  }
  buildCounterResultsGetRequest--;
}

buildUnnamed1892() {
  var o = new core.List<api.FieldMask>();
  o.add(buildFieldMask());
  o.add(buildFieldMask());
  return o;
}

checkUnnamed1892(core.List<api.FieldMask> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFieldMask(o[0]);
  checkFieldMask(o[1]);
}

core.int buildCounterResultsMask = 0;
buildResultsMask() {
  var o = new api.ResultsMask();
  buildCounterResultsMask++;
  if (buildCounterResultsMask < 3) {
    o.fields = buildUnnamed1892();
    o.projection = "foo";
  }
  buildCounterResultsMask--;
  return o;
}

checkResultsMask(api.ResultsMask o) {
  buildCounterResultsMask++;
  if (buildCounterResultsMask < 3) {
    checkUnnamed1892(o.fields);
    unittest.expect(o.projection, unittest.equals('foo'));
  }
  buildCounterResultsMask--;
}

buildUnnamed1893() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1893(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1894() {
  var o = new core.List<api.SurveyQuestion>();
  o.add(buildSurveyQuestion());
  o.add(buildSurveyQuestion());
  return o;
}

checkUnnamed1894(core.List<api.SurveyQuestion> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSurveyQuestion(o[0]);
  checkSurveyQuestion(o[1]);
}

core.int buildCounterSurvey = 0;
buildSurvey() {
  var o = new api.Survey();
  buildCounterSurvey++;
  if (buildCounterSurvey < 3) {
    o.audience = buildSurveyAudience();
    o.cost = buildSurveyCost();
    o.customerData = "foo";
    o.description = "foo";
    o.owners = buildUnnamed1893();
    o.questions = buildUnnamed1894();
    o.rejectionReason = buildSurveyRejection();
    o.state = "foo";
    o.surveyUrlId = "foo";
    o.title = "foo";
    o.wantedResponseCount = 42;
  }
  buildCounterSurvey--;
  return o;
}

checkSurvey(api.Survey o) {
  buildCounterSurvey++;
  if (buildCounterSurvey < 3) {
    checkSurveyAudience(o.audience);
    checkSurveyCost(o.cost);
    unittest.expect(o.customerData, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    checkUnnamed1893(o.owners);
    checkUnnamed1894(o.questions);
    checkSurveyRejection(o.rejectionReason);
    unittest.expect(o.state, unittest.equals('foo'));
    unittest.expect(o.surveyUrlId, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.wantedResponseCount, unittest.equals(42));
  }
  buildCounterSurvey--;
}

buildUnnamed1895() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1895(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1896() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1896(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterSurveyAudience = 0;
buildSurveyAudience() {
  var o = new api.SurveyAudience();
  buildCounterSurveyAudience++;
  if (buildCounterSurveyAudience < 3) {
    o.ages = buildUnnamed1895();
    o.country = "foo";
    o.countrySubdivision = "foo";
    o.gender = "foo";
    o.languages = buildUnnamed1896();
    o.mobileAppPanelId = "foo";
    o.populationSource = "foo";
  }
  buildCounterSurveyAudience--;
  return o;
}

checkSurveyAudience(api.SurveyAudience o) {
  buildCounterSurveyAudience++;
  if (buildCounterSurveyAudience < 3) {
    checkUnnamed1895(o.ages);
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.countrySubdivision, unittest.equals('foo'));
    unittest.expect(o.gender, unittest.equals('foo'));
    checkUnnamed1896(o.languages);
    unittest.expect(o.mobileAppPanelId, unittest.equals('foo'));
    unittest.expect(o.populationSource, unittest.equals('foo'));
  }
  buildCounterSurveyAudience--;
}

core.int buildCounterSurveyCost = 0;
buildSurveyCost() {
  var o = new api.SurveyCost();
  buildCounterSurveyCost++;
  if (buildCounterSurveyCost < 3) {
    o.costPerResponseNanos = "foo";
    o.currencyCode = "foo";
    o.maxCostPerResponseNanos = "foo";
    o.nanos = "foo";
  }
  buildCounterSurveyCost--;
  return o;
}

checkSurveyCost(api.SurveyCost o) {
  buildCounterSurveyCost++;
  if (buildCounterSurveyCost < 3) {
    unittest.expect(o.costPerResponseNanos, unittest.equals('foo'));
    unittest.expect(o.currencyCode, unittest.equals('foo'));
    unittest.expect(o.maxCostPerResponseNanos, unittest.equals('foo'));
    unittest.expect(o.nanos, unittest.equals('foo'));
  }
  buildCounterSurveyCost--;
}

buildUnnamed1897() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1897(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1898() {
  var o = new core.List<api.SurveyQuestionImage>();
  o.add(buildSurveyQuestionImage());
  o.add(buildSurveyQuestionImage());
  return o;
}

checkUnnamed1898(core.List<api.SurveyQuestionImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSurveyQuestionImage(o[0]);
  checkSurveyQuestionImage(o[1]);
}

buildUnnamed1899() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1899(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1900() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1900(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterSurveyQuestion = 0;
buildSurveyQuestion() {
  var o = new api.SurveyQuestion();
  buildCounterSurveyQuestion++;
  if (buildCounterSurveyQuestion < 3) {
    o.answerOrder = "foo";
    o.answers = buildUnnamed1897();
    o.hasOther = true;
    o.highValueLabel = "foo";
    o.images = buildUnnamed1898();
    o.lastAnswerPositionPinned = true;
    o.lowValueLabel = "foo";
    o.mustPickSuggestion = true;
    o.numStars = "foo";
    o.openTextPlaceholder = "foo";
    o.openTextSuggestions = buildUnnamed1899();
    o.question = "foo";
    o.sentimentText = "foo";
    o.singleLineResponse = true;
    o.thresholdAnswers = buildUnnamed1900();
    o.type = "foo";
    o.unitOfMeasurementLabel = "foo";
    o.videoId = "foo";
  }
  buildCounterSurveyQuestion--;
  return o;
}

checkSurveyQuestion(api.SurveyQuestion o) {
  buildCounterSurveyQuestion++;
  if (buildCounterSurveyQuestion < 3) {
    unittest.expect(o.answerOrder, unittest.equals('foo'));
    checkUnnamed1897(o.answers);
    unittest.expect(o.hasOther, unittest.isTrue);
    unittest.expect(o.highValueLabel, unittest.equals('foo'));
    checkUnnamed1898(o.images);
    unittest.expect(o.lastAnswerPositionPinned, unittest.isTrue);
    unittest.expect(o.lowValueLabel, unittest.equals('foo'));
    unittest.expect(o.mustPickSuggestion, unittest.isTrue);
    unittest.expect(o.numStars, unittest.equals('foo'));
    unittest.expect(o.openTextPlaceholder, unittest.equals('foo'));
    checkUnnamed1899(o.openTextSuggestions);
    unittest.expect(o.question, unittest.equals('foo'));
    unittest.expect(o.sentimentText, unittest.equals('foo'));
    unittest.expect(o.singleLineResponse, unittest.isTrue);
    checkUnnamed1900(o.thresholdAnswers);
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.unitOfMeasurementLabel, unittest.equals('foo'));
    unittest.expect(o.videoId, unittest.equals('foo'));
  }
  buildCounterSurveyQuestion--;
}

core.int buildCounterSurveyQuestionImage = 0;
buildSurveyQuestionImage() {
  var o = new api.SurveyQuestionImage();
  buildCounterSurveyQuestionImage++;
  if (buildCounterSurveyQuestionImage < 3) {
    o.altText = "foo";
    o.data = "foo";
    o.url = "foo";
  }
  buildCounterSurveyQuestionImage--;
  return o;
}

checkSurveyQuestionImage(api.SurveyQuestionImage o) {
  buildCounterSurveyQuestionImage++;
  if (buildCounterSurveyQuestionImage < 3) {
    unittest.expect(o.altText, unittest.equals('foo'));
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterSurveyQuestionImage--;
}

core.int buildCounterSurveyRejection = 0;
buildSurveyRejection() {
  var o = new api.SurveyRejection();
  buildCounterSurveyRejection++;
  if (buildCounterSurveyRejection < 3) {
    o.explanation = "foo";
    o.type = "foo";
  }
  buildCounterSurveyRejection--;
  return o;
}

checkSurveyRejection(api.SurveyRejection o) {
  buildCounterSurveyRejection++;
  if (buildCounterSurveyRejection < 3) {
    unittest.expect(o.explanation, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterSurveyRejection--;
}

core.int buildCounterSurveyResults = 0;
buildSurveyResults() {
  var o = new api.SurveyResults();
  buildCounterSurveyResults++;
  if (buildCounterSurveyResults < 3) {
    o.status = "foo";
    o.surveyUrlId = "foo";
  }
  buildCounterSurveyResults--;
  return o;
}

checkSurveyResults(api.SurveyResults o) {
  buildCounterSurveyResults++;
  if (buildCounterSurveyResults < 3) {
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.surveyUrlId, unittest.equals('foo'));
  }
  buildCounterSurveyResults--;
}

core.int buildCounterSurveysDeleteResponse = 0;
buildSurveysDeleteResponse() {
  var o = new api.SurveysDeleteResponse();
  buildCounterSurveysDeleteResponse++;
  if (buildCounterSurveysDeleteResponse < 3) {
    o.requestId = "foo";
  }
  buildCounterSurveysDeleteResponse--;
  return o;
}

checkSurveysDeleteResponse(api.SurveysDeleteResponse o) {
  buildCounterSurveysDeleteResponse++;
  if (buildCounterSurveysDeleteResponse < 3) {
    unittest.expect(o.requestId, unittest.equals('foo'));
  }
  buildCounterSurveysDeleteResponse--;
}

buildUnnamed1901() {
  var o = new core.List<api.Survey>();
  o.add(buildSurvey());
  o.add(buildSurvey());
  return o;
}

checkUnnamed1901(core.List<api.Survey> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSurvey(o[0]);
  checkSurvey(o[1]);
}

core.int buildCounterSurveysListResponse = 0;
buildSurveysListResponse() {
  var o = new api.SurveysListResponse();
  buildCounterSurveysListResponse++;
  if (buildCounterSurveysListResponse < 3) {
    o.pageInfo = buildPageInfo();
    o.requestId = "foo";
    o.resources = buildUnnamed1901();
    o.tokenPagination = buildTokenPagination();
  }
  buildCounterSurveysListResponse--;
  return o;
}

checkSurveysListResponse(api.SurveysListResponse o) {
  buildCounterSurveysListResponse++;
  if (buildCounterSurveysListResponse < 3) {
    checkPageInfo(o.pageInfo);
    unittest.expect(o.requestId, unittest.equals('foo'));
    checkUnnamed1901(o.resources);
    checkTokenPagination(o.tokenPagination);
  }
  buildCounterSurveysListResponse--;
}

core.int buildCounterSurveysStartRequest = 0;
buildSurveysStartRequest() {
  var o = new api.SurveysStartRequest();
  buildCounterSurveysStartRequest++;
  if (buildCounterSurveysStartRequest < 3) {
    o.maxCostPerResponseNanos = "foo";
  }
  buildCounterSurveysStartRequest--;
  return o;
}

checkSurveysStartRequest(api.SurveysStartRequest o) {
  buildCounterSurveysStartRequest++;
  if (buildCounterSurveysStartRequest < 3) {
    unittest.expect(o.maxCostPerResponseNanos, unittest.equals('foo'));
  }
  buildCounterSurveysStartRequest--;
}

core.int buildCounterSurveysStartResponse = 0;
buildSurveysStartResponse() {
  var o = new api.SurveysStartResponse();
  buildCounterSurveysStartResponse++;
  if (buildCounterSurveysStartResponse < 3) {
    o.requestId = "foo";
    o.resource = buildSurvey();
  }
  buildCounterSurveysStartResponse--;
  return o;
}

checkSurveysStartResponse(api.SurveysStartResponse o) {
  buildCounterSurveysStartResponse++;
  if (buildCounterSurveysStartResponse < 3) {
    unittest.expect(o.requestId, unittest.equals('foo'));
    checkSurvey(o.resource);
  }
  buildCounterSurveysStartResponse--;
}

core.int buildCounterSurveysStopResponse = 0;
buildSurveysStopResponse() {
  var o = new api.SurveysStopResponse();
  buildCounterSurveysStopResponse++;
  if (buildCounterSurveysStopResponse < 3) {
    o.requestId = "foo";
    o.resource = buildSurvey();
  }
  buildCounterSurveysStopResponse--;
  return o;
}

checkSurveysStopResponse(api.SurveysStopResponse o) {
  buildCounterSurveysStopResponse++;
  if (buildCounterSurveysStopResponse < 3) {
    unittest.expect(o.requestId, unittest.equals('foo'));
    checkSurvey(o.resource);
  }
  buildCounterSurveysStopResponse--;
}

core.int buildCounterTokenPagination = 0;
buildTokenPagination() {
  var o = new api.TokenPagination();
  buildCounterTokenPagination++;
  if (buildCounterTokenPagination < 3) {
    o.nextPageToken = "foo";
    o.previousPageToken = "foo";
  }
  buildCounterTokenPagination--;
  return o;
}

checkTokenPagination(api.TokenPagination o) {
  buildCounterTokenPagination++;
  if (buildCounterTokenPagination < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.previousPageToken, unittest.equals('foo'));
  }
  buildCounterTokenPagination--;
}


main() {
  unittest.group("obj-schema-FieldMask", () {
    unittest.test("to-json--from-json", () {
      var o = buildFieldMask();
      var od = new api.FieldMask.fromJson(o.toJson());
      checkFieldMask(od);
    });
  });


  unittest.group("obj-schema-MobileAppPanel", () {
    unittest.test("to-json--from-json", () {
      var o = buildMobileAppPanel();
      var od = new api.MobileAppPanel.fromJson(o.toJson());
      checkMobileAppPanel(od);
    });
  });


  unittest.group("obj-schema-MobileAppPanelsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildMobileAppPanelsListResponse();
      var od = new api.MobileAppPanelsListResponse.fromJson(o.toJson());
      checkMobileAppPanelsListResponse(od);
    });
  });


  unittest.group("obj-schema-PageInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageInfo();
      var od = new api.PageInfo.fromJson(o.toJson());
      checkPageInfo(od);
    });
  });


  unittest.group("obj-schema-ResultsGetRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultsGetRequest();
      var od = new api.ResultsGetRequest.fromJson(o.toJson());
      checkResultsGetRequest(od);
    });
  });


  unittest.group("obj-schema-ResultsMask", () {
    unittest.test("to-json--from-json", () {
      var o = buildResultsMask();
      var od = new api.ResultsMask.fromJson(o.toJson());
      checkResultsMask(od);
    });
  });


  unittest.group("obj-schema-Survey", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurvey();
      var od = new api.Survey.fromJson(o.toJson());
      checkSurvey(od);
    });
  });


  unittest.group("obj-schema-SurveyAudience", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveyAudience();
      var od = new api.SurveyAudience.fromJson(o.toJson());
      checkSurveyAudience(od);
    });
  });


  unittest.group("obj-schema-SurveyCost", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveyCost();
      var od = new api.SurveyCost.fromJson(o.toJson());
      checkSurveyCost(od);
    });
  });


  unittest.group("obj-schema-SurveyQuestion", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveyQuestion();
      var od = new api.SurveyQuestion.fromJson(o.toJson());
      checkSurveyQuestion(od);
    });
  });


  unittest.group("obj-schema-SurveyQuestionImage", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveyQuestionImage();
      var od = new api.SurveyQuestionImage.fromJson(o.toJson());
      checkSurveyQuestionImage(od);
    });
  });


  unittest.group("obj-schema-SurveyRejection", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveyRejection();
      var od = new api.SurveyRejection.fromJson(o.toJson());
      checkSurveyRejection(od);
    });
  });


  unittest.group("obj-schema-SurveyResults", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveyResults();
      var od = new api.SurveyResults.fromJson(o.toJson());
      checkSurveyResults(od);
    });
  });


  unittest.group("obj-schema-SurveysDeleteResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveysDeleteResponse();
      var od = new api.SurveysDeleteResponse.fromJson(o.toJson());
      checkSurveysDeleteResponse(od);
    });
  });


  unittest.group("obj-schema-SurveysListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveysListResponse();
      var od = new api.SurveysListResponse.fromJson(o.toJson());
      checkSurveysListResponse(od);
    });
  });


  unittest.group("obj-schema-SurveysStartRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveysStartRequest();
      var od = new api.SurveysStartRequest.fromJson(o.toJson());
      checkSurveysStartRequest(od);
    });
  });


  unittest.group("obj-schema-SurveysStartResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveysStartResponse();
      var od = new api.SurveysStartResponse.fromJson(o.toJson());
      checkSurveysStartResponse(od);
    });
  });


  unittest.group("obj-schema-SurveysStopResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSurveysStopResponse();
      var od = new api.SurveysStopResponse.fromJson(o.toJson());
      checkSurveysStopResponse(od);
    });
  });


  unittest.group("obj-schema-TokenPagination", () {
    unittest.test("to-json--from-json", () {
      var o = buildTokenPagination();
      var od = new api.TokenPagination.fromJson(o.toJson());
      checkTokenPagination(od);
    });
  });


  unittest.group("resource-MobileapppanelsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.MobileapppanelsResourceApi res = new api.SurveysApi(mock).mobileapppanels;
      var arg_panelId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("mobileAppPanels/"));
        pathOffset += 16;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_panelId"));

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
        var resp = convert.JSON.encode(buildMobileAppPanel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_panelId).then(unittest.expectAsync(((api.MobileAppPanel response) {
        checkMobileAppPanel(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.MobileapppanelsResourceApi res = new api.SurveysApi(mock).mobileapppanels;
      var arg_maxResults = 42;
      var arg_startIndex = 42;
      var arg_token = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("mobileAppPanels"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(core.int.parse(queryMap["startIndex"].first), unittest.equals(arg_startIndex));
        unittest.expect(queryMap["token"].first, unittest.equals(arg_token));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildMobileAppPanelsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(maxResults: arg_maxResults, startIndex: arg_startIndex, token: arg_token).then(unittest.expectAsync(((api.MobileAppPanelsListResponse response) {
        checkMobileAppPanelsListResponse(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.MobileapppanelsResourceApi res = new api.SurveysApi(mock).mobileapppanels;
      var arg_request = buildMobileAppPanel();
      var arg_panelId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.MobileAppPanel.fromJson(json);
        checkMobileAppPanel(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("mobileAppPanels/"));
        pathOffset += 16;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_panelId"));

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
        var resp = convert.JSON.encode(buildMobileAppPanel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_panelId).then(unittest.expectAsync(((api.MobileAppPanel response) {
        checkMobileAppPanel(response);
      })));
    });

  });


  unittest.group("resource-ResultsResourceApi", () {
    unittest.test("method--get", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.ResultsResourceApi res = new api.SurveysApi(mock).results;
      var arg_request = buildResultsGetRequest();
      var arg_surveyUrlId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.ResultsGetRequest.fromJson(json);
        checkResultsGetRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("surveys/"));
        pathOffset += 8;
        index = path.indexOf("/results", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_surveyUrlId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/results"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSurveyResults());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_request, arg_surveyUrlId).then(unittest.expectAsync(((api.SurveyResults response) {
        checkSurveyResults(response);
      })));
    });

  });


  unittest.group("resource-SurveysResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.SurveysResourceApi res = new api.SurveysApi(mock).surveys;
      var arg_surveyUrlId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("surveys/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_surveyUrlId"));

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
        var resp = convert.JSON.encode(buildSurveysDeleteResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_surveyUrlId).then(unittest.expectAsync(((api.SurveysDeleteResponse response) {
        checkSurveysDeleteResponse(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.SurveysResourceApi res = new api.SurveysApi(mock).surveys;
      var arg_surveyUrlId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("surveys/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_surveyUrlId"));

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
        var resp = convert.JSON.encode(buildSurvey());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_surveyUrlId).then(unittest.expectAsync(((api.Survey response) {
        checkSurvey(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.SurveysResourceApi res = new api.SurveysApi(mock).surveys;
      var arg_request = buildSurvey();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Survey.fromJson(json);
        checkSurvey(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("surveys"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSurvey());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request).then(unittest.expectAsync(((api.Survey response) {
        checkSurvey(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.SurveysResourceApi res = new api.SurveysApi(mock).surveys;
      var arg_maxResults = 42;
      var arg_startIndex = 42;
      var arg_token = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("surveys"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(core.int.parse(queryMap["startIndex"].first), unittest.equals(arg_startIndex));
        unittest.expect(queryMap["token"].first, unittest.equals(arg_token));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSurveysListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(maxResults: arg_maxResults, startIndex: arg_startIndex, token: arg_token).then(unittest.expectAsync(((api.SurveysListResponse response) {
        checkSurveysListResponse(response);
      })));
    });

    unittest.test("method--start", () {

      var mock = new HttpServerMock();
      api.SurveysResourceApi res = new api.SurveysApi(mock).surveys;
      var arg_request = buildSurveysStartRequest();
      var arg_resourceId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.SurveysStartRequest.fromJson(json);
        checkSurveysStartRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("surveys/"));
        pathOffset += 8;
        index = path.indexOf("/start", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_resourceId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/start"));
        pathOffset += 6;

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
        var resp = convert.JSON.encode(buildSurveysStartResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.start(arg_request, arg_resourceId).then(unittest.expectAsync(((api.SurveysStartResponse response) {
        checkSurveysStartResponse(response);
      })));
    });

    unittest.test("method--stop", () {

      var mock = new HttpServerMock();
      api.SurveysResourceApi res = new api.SurveysApi(mock).surveys;
      var arg_resourceId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("surveys/"));
        pathOffset += 8;
        index = path.indexOf("/stop", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_resourceId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/stop"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSurveysStopResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.stop(arg_resourceId).then(unittest.expectAsync(((api.SurveysStopResponse response) {
        checkSurveysStopResponse(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.SurveysResourceApi res = new api.SurveysApi(mock).surveys;
      var arg_request = buildSurvey();
      var arg_surveyUrlId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Survey.fromJson(json);
        checkSurvey(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("surveys/v2/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("surveys/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_surveyUrlId"));

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
        var resp = convert.JSON.encode(buildSurvey());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_surveyUrlId).then(unittest.expectAsync(((api.Survey response) {
        checkSurvey(response);
      })));
    });

  });


}

