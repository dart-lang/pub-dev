library googleapis.prediction.v1_6.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/prediction/v1_6.dart' as api;

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

core.int buildCounterAnalyzeDataDescriptionFeaturesCategoricalValues = 0;
buildAnalyzeDataDescriptionFeaturesCategoricalValues() {
  var o = new api.AnalyzeDataDescriptionFeaturesCategoricalValues();
  buildCounterAnalyzeDataDescriptionFeaturesCategoricalValues++;
  if (buildCounterAnalyzeDataDescriptionFeaturesCategoricalValues < 3) {
    o.count = "foo";
    o.value = "foo";
  }
  buildCounterAnalyzeDataDescriptionFeaturesCategoricalValues--;
  return o;
}

checkAnalyzeDataDescriptionFeaturesCategoricalValues(api.AnalyzeDataDescriptionFeaturesCategoricalValues o) {
  buildCounterAnalyzeDataDescriptionFeaturesCategoricalValues++;
  if (buildCounterAnalyzeDataDescriptionFeaturesCategoricalValues < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterAnalyzeDataDescriptionFeaturesCategoricalValues--;
}

buildUnnamed1586() {
  var o = new core.List<api.AnalyzeDataDescriptionFeaturesCategoricalValues>();
  o.add(buildAnalyzeDataDescriptionFeaturesCategoricalValues());
  o.add(buildAnalyzeDataDescriptionFeaturesCategoricalValues());
  return o;
}

checkUnnamed1586(core.List<api.AnalyzeDataDescriptionFeaturesCategoricalValues> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnalyzeDataDescriptionFeaturesCategoricalValues(o[0]);
  checkAnalyzeDataDescriptionFeaturesCategoricalValues(o[1]);
}

core.int buildCounterAnalyzeDataDescriptionFeaturesCategorical = 0;
buildAnalyzeDataDescriptionFeaturesCategorical() {
  var o = new api.AnalyzeDataDescriptionFeaturesCategorical();
  buildCounterAnalyzeDataDescriptionFeaturesCategorical++;
  if (buildCounterAnalyzeDataDescriptionFeaturesCategorical < 3) {
    o.count = "foo";
    o.values = buildUnnamed1586();
  }
  buildCounterAnalyzeDataDescriptionFeaturesCategorical--;
  return o;
}

checkAnalyzeDataDescriptionFeaturesCategorical(api.AnalyzeDataDescriptionFeaturesCategorical o) {
  buildCounterAnalyzeDataDescriptionFeaturesCategorical++;
  if (buildCounterAnalyzeDataDescriptionFeaturesCategorical < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
    checkUnnamed1586(o.values);
  }
  buildCounterAnalyzeDataDescriptionFeaturesCategorical--;
}

core.int buildCounterAnalyzeDataDescriptionFeaturesNumeric = 0;
buildAnalyzeDataDescriptionFeaturesNumeric() {
  var o = new api.AnalyzeDataDescriptionFeaturesNumeric();
  buildCounterAnalyzeDataDescriptionFeaturesNumeric++;
  if (buildCounterAnalyzeDataDescriptionFeaturesNumeric < 3) {
    o.count = "foo";
    o.mean = "foo";
    o.variance = "foo";
  }
  buildCounterAnalyzeDataDescriptionFeaturesNumeric--;
  return o;
}

checkAnalyzeDataDescriptionFeaturesNumeric(api.AnalyzeDataDescriptionFeaturesNumeric o) {
  buildCounterAnalyzeDataDescriptionFeaturesNumeric++;
  if (buildCounterAnalyzeDataDescriptionFeaturesNumeric < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
    unittest.expect(o.mean, unittest.equals('foo'));
    unittest.expect(o.variance, unittest.equals('foo'));
  }
  buildCounterAnalyzeDataDescriptionFeaturesNumeric--;
}

core.int buildCounterAnalyzeDataDescriptionFeaturesText = 0;
buildAnalyzeDataDescriptionFeaturesText() {
  var o = new api.AnalyzeDataDescriptionFeaturesText();
  buildCounterAnalyzeDataDescriptionFeaturesText++;
  if (buildCounterAnalyzeDataDescriptionFeaturesText < 3) {
    o.count = "foo";
  }
  buildCounterAnalyzeDataDescriptionFeaturesText--;
  return o;
}

checkAnalyzeDataDescriptionFeaturesText(api.AnalyzeDataDescriptionFeaturesText o) {
  buildCounterAnalyzeDataDescriptionFeaturesText++;
  if (buildCounterAnalyzeDataDescriptionFeaturesText < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
  }
  buildCounterAnalyzeDataDescriptionFeaturesText--;
}

core.int buildCounterAnalyzeDataDescriptionFeatures = 0;
buildAnalyzeDataDescriptionFeatures() {
  var o = new api.AnalyzeDataDescriptionFeatures();
  buildCounterAnalyzeDataDescriptionFeatures++;
  if (buildCounterAnalyzeDataDescriptionFeatures < 3) {
    o.categorical = buildAnalyzeDataDescriptionFeaturesCategorical();
    o.index = "foo";
    o.numeric = buildAnalyzeDataDescriptionFeaturesNumeric();
    o.text = buildAnalyzeDataDescriptionFeaturesText();
  }
  buildCounterAnalyzeDataDescriptionFeatures--;
  return o;
}

checkAnalyzeDataDescriptionFeatures(api.AnalyzeDataDescriptionFeatures o) {
  buildCounterAnalyzeDataDescriptionFeatures++;
  if (buildCounterAnalyzeDataDescriptionFeatures < 3) {
    checkAnalyzeDataDescriptionFeaturesCategorical(o.categorical);
    unittest.expect(o.index, unittest.equals('foo'));
    checkAnalyzeDataDescriptionFeaturesNumeric(o.numeric);
    checkAnalyzeDataDescriptionFeaturesText(o.text);
  }
  buildCounterAnalyzeDataDescriptionFeatures--;
}

buildUnnamed1587() {
  var o = new core.List<api.AnalyzeDataDescriptionFeatures>();
  o.add(buildAnalyzeDataDescriptionFeatures());
  o.add(buildAnalyzeDataDescriptionFeatures());
  return o;
}

checkUnnamed1587(core.List<api.AnalyzeDataDescriptionFeatures> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnalyzeDataDescriptionFeatures(o[0]);
  checkAnalyzeDataDescriptionFeatures(o[1]);
}

core.int buildCounterAnalyzeDataDescriptionOutputFeatureNumeric = 0;
buildAnalyzeDataDescriptionOutputFeatureNumeric() {
  var o = new api.AnalyzeDataDescriptionOutputFeatureNumeric();
  buildCounterAnalyzeDataDescriptionOutputFeatureNumeric++;
  if (buildCounterAnalyzeDataDescriptionOutputFeatureNumeric < 3) {
    o.count = "foo";
    o.mean = "foo";
    o.variance = "foo";
  }
  buildCounterAnalyzeDataDescriptionOutputFeatureNumeric--;
  return o;
}

checkAnalyzeDataDescriptionOutputFeatureNumeric(api.AnalyzeDataDescriptionOutputFeatureNumeric o) {
  buildCounterAnalyzeDataDescriptionOutputFeatureNumeric++;
  if (buildCounterAnalyzeDataDescriptionOutputFeatureNumeric < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
    unittest.expect(o.mean, unittest.equals('foo'));
    unittest.expect(o.variance, unittest.equals('foo'));
  }
  buildCounterAnalyzeDataDescriptionOutputFeatureNumeric--;
}

core.int buildCounterAnalyzeDataDescriptionOutputFeatureText = 0;
buildAnalyzeDataDescriptionOutputFeatureText() {
  var o = new api.AnalyzeDataDescriptionOutputFeatureText();
  buildCounterAnalyzeDataDescriptionOutputFeatureText++;
  if (buildCounterAnalyzeDataDescriptionOutputFeatureText < 3) {
    o.count = "foo";
    o.value = "foo";
  }
  buildCounterAnalyzeDataDescriptionOutputFeatureText--;
  return o;
}

checkAnalyzeDataDescriptionOutputFeatureText(api.AnalyzeDataDescriptionOutputFeatureText o) {
  buildCounterAnalyzeDataDescriptionOutputFeatureText++;
  if (buildCounterAnalyzeDataDescriptionOutputFeatureText < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterAnalyzeDataDescriptionOutputFeatureText--;
}

buildUnnamed1588() {
  var o = new core.List<api.AnalyzeDataDescriptionOutputFeatureText>();
  o.add(buildAnalyzeDataDescriptionOutputFeatureText());
  o.add(buildAnalyzeDataDescriptionOutputFeatureText());
  return o;
}

checkUnnamed1588(core.List<api.AnalyzeDataDescriptionOutputFeatureText> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnalyzeDataDescriptionOutputFeatureText(o[0]);
  checkAnalyzeDataDescriptionOutputFeatureText(o[1]);
}

core.int buildCounterAnalyzeDataDescriptionOutputFeature = 0;
buildAnalyzeDataDescriptionOutputFeature() {
  var o = new api.AnalyzeDataDescriptionOutputFeature();
  buildCounterAnalyzeDataDescriptionOutputFeature++;
  if (buildCounterAnalyzeDataDescriptionOutputFeature < 3) {
    o.numeric = buildAnalyzeDataDescriptionOutputFeatureNumeric();
    o.text = buildUnnamed1588();
  }
  buildCounterAnalyzeDataDescriptionOutputFeature--;
  return o;
}

checkAnalyzeDataDescriptionOutputFeature(api.AnalyzeDataDescriptionOutputFeature o) {
  buildCounterAnalyzeDataDescriptionOutputFeature++;
  if (buildCounterAnalyzeDataDescriptionOutputFeature < 3) {
    checkAnalyzeDataDescriptionOutputFeatureNumeric(o.numeric);
    checkUnnamed1588(o.text);
  }
  buildCounterAnalyzeDataDescriptionOutputFeature--;
}

core.int buildCounterAnalyzeDataDescription = 0;
buildAnalyzeDataDescription() {
  var o = new api.AnalyzeDataDescription();
  buildCounterAnalyzeDataDescription++;
  if (buildCounterAnalyzeDataDescription < 3) {
    o.features = buildUnnamed1587();
    o.outputFeature = buildAnalyzeDataDescriptionOutputFeature();
  }
  buildCounterAnalyzeDataDescription--;
  return o;
}

checkAnalyzeDataDescription(api.AnalyzeDataDescription o) {
  buildCounterAnalyzeDataDescription++;
  if (buildCounterAnalyzeDataDescription < 3) {
    checkUnnamed1587(o.features);
    checkAnalyzeDataDescriptionOutputFeature(o.outputFeature);
  }
  buildCounterAnalyzeDataDescription--;
}

buildUnnamed1589() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed1589(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

buildUnnamed1590() {
  var o = new core.List<core.Map<core.String, core.String>>();
  o.add(buildUnnamed1589());
  o.add(buildUnnamed1589());
  return o;
}

checkUnnamed1590(core.List<core.Map<core.String, core.String>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed1589(o[0]);
  checkUnnamed1589(o[1]);
}

buildUnnamed1591() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed1591(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

buildUnnamed1592() {
  var o = new core.Map<core.String, core.Map<core.String, core.String>>();
  o["x"] = buildUnnamed1591();
  o["y"] = buildUnnamed1591();
  return o;
}

checkUnnamed1592(core.Map<core.String, core.Map<core.String, core.String>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed1591(o["x"]);
  checkUnnamed1591(o["y"]);
}

buildUnnamed1593() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed1593(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterAnalyzeModelDescription = 0;
buildAnalyzeModelDescription() {
  var o = new api.AnalyzeModelDescription();
  buildCounterAnalyzeModelDescription++;
  if (buildCounterAnalyzeModelDescription < 3) {
    o.confusionMatrix = buildUnnamed1592();
    o.confusionMatrixRowTotals = buildUnnamed1593();
    o.modelinfo = buildInsert2();
  }
  buildCounterAnalyzeModelDescription--;
  return o;
}

checkAnalyzeModelDescription(api.AnalyzeModelDescription o) {
  buildCounterAnalyzeModelDescription++;
  if (buildCounterAnalyzeModelDescription < 3) {
    checkUnnamed1592(o.confusionMatrix);
    checkUnnamed1593(o.confusionMatrixRowTotals);
    checkInsert2(o.modelinfo);
  }
  buildCounterAnalyzeModelDescription--;
}

core.int buildCounterAnalyze = 0;
buildAnalyze() {
  var o = new api.Analyze();
  buildCounterAnalyze++;
  if (buildCounterAnalyze < 3) {
    o.dataDescription = buildAnalyzeDataDescription();
    o.errors = buildUnnamed1590();
    o.id = "foo";
    o.kind = "foo";
    o.modelDescription = buildAnalyzeModelDescription();
    o.selfLink = "foo";
  }
  buildCounterAnalyze--;
  return o;
}

checkAnalyze(api.Analyze o) {
  buildCounterAnalyze++;
  if (buildCounterAnalyze < 3) {
    checkAnalyzeDataDescription(o.dataDescription);
    checkUnnamed1590(o.errors);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkAnalyzeModelDescription(o.modelDescription);
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterAnalyze--;
}

buildUnnamed1594() {
  var o = new core.List<core.Object>();
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  return o;
}

checkUnnamed1594(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o[0]) as core.Map; unittest.expect(casted1, unittest.hasLength(3)); unittest.expect(casted1["list"], unittest.equals([1, 2, 3])); unittest.expect(casted1["bool"], unittest.equals(true)); unittest.expect(casted1["string"], unittest.equals('foo')); 
  var casted2 = (o[1]) as core.Map; unittest.expect(casted2, unittest.hasLength(3)); unittest.expect(casted2["list"], unittest.equals([1, 2, 3])); unittest.expect(casted2["bool"], unittest.equals(true)); unittest.expect(casted2["string"], unittest.equals('foo')); 
}

core.int buildCounterInputInput = 0;
buildInputInput() {
  var o = new api.InputInput();
  buildCounterInputInput++;
  if (buildCounterInputInput < 3) {
    o.csvInstance = buildUnnamed1594();
  }
  buildCounterInputInput--;
  return o;
}

checkInputInput(api.InputInput o) {
  buildCounterInputInput++;
  if (buildCounterInputInput < 3) {
    checkUnnamed1594(o.csvInstance);
  }
  buildCounterInputInput--;
}

core.int buildCounterInput = 0;
buildInput() {
  var o = new api.Input();
  buildCounterInput++;
  if (buildCounterInput < 3) {
    o.input = buildInputInput();
  }
  buildCounterInput--;
  return o;
}

checkInput(api.Input o) {
  buildCounterInput++;
  if (buildCounterInput < 3) {
    checkInputInput(o.input);
  }
  buildCounterInput--;
}

buildUnnamed1595() {
  var o = new core.List<core.Object>();
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  return o;
}

checkUnnamed1595(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted3 = (o[0]) as core.Map; unittest.expect(casted3, unittest.hasLength(3)); unittest.expect(casted3["list"], unittest.equals([1, 2, 3])); unittest.expect(casted3["bool"], unittest.equals(true)); unittest.expect(casted3["string"], unittest.equals('foo')); 
  var casted4 = (o[1]) as core.Map; unittest.expect(casted4, unittest.hasLength(3)); unittest.expect(casted4["list"], unittest.equals([1, 2, 3])); unittest.expect(casted4["bool"], unittest.equals(true)); unittest.expect(casted4["string"], unittest.equals('foo')); 
}

core.int buildCounterInsertTrainingInstances = 0;
buildInsertTrainingInstances() {
  var o = new api.InsertTrainingInstances();
  buildCounterInsertTrainingInstances++;
  if (buildCounterInsertTrainingInstances < 3) {
    o.csvInstance = buildUnnamed1595();
    o.output = "foo";
  }
  buildCounterInsertTrainingInstances--;
  return o;
}

checkInsertTrainingInstances(api.InsertTrainingInstances o) {
  buildCounterInsertTrainingInstances++;
  if (buildCounterInsertTrainingInstances < 3) {
    checkUnnamed1595(o.csvInstance);
    unittest.expect(o.output, unittest.equals('foo'));
  }
  buildCounterInsertTrainingInstances--;
}

buildUnnamed1596() {
  var o = new core.List<api.InsertTrainingInstances>();
  o.add(buildInsertTrainingInstances());
  o.add(buildInsertTrainingInstances());
  return o;
}

checkUnnamed1596(core.List<api.InsertTrainingInstances> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkInsertTrainingInstances(o[0]);
  checkInsertTrainingInstances(o[1]);
}

buildUnnamed1597() {
  var o = new core.Map<core.String, core.double>();
  o["x"] = 42.0;
  o["y"] = 42.0;
  return o;
}

checkUnnamed1597(core.Map<core.String, core.double> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals(42.0));
  unittest.expect(o["y"], unittest.equals(42.0));
}

buildUnnamed1598() {
  var o = new core.List<core.Map<core.String, core.double>>();
  o.add(buildUnnamed1597());
  o.add(buildUnnamed1597());
  return o;
}

checkUnnamed1598(core.List<core.Map<core.String, core.double>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed1597(o[0]);
  checkUnnamed1597(o[1]);
}

core.int buildCounterInsert = 0;
buildInsert() {
  var o = new api.Insert();
  buildCounterInsert++;
  if (buildCounterInsert < 3) {
    o.id = "foo";
    o.modelType = "foo";
    o.sourceModel = "foo";
    o.storageDataLocation = "foo";
    o.storagePMMLLocation = "foo";
    o.storagePMMLModelLocation = "foo";
    o.trainingInstances = buildUnnamed1596();
    o.utility = buildUnnamed1598();
  }
  buildCounterInsert--;
  return o;
}

checkInsert(api.Insert o) {
  buildCounterInsert++;
  if (buildCounterInsert < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.modelType, unittest.equals('foo'));
    unittest.expect(o.sourceModel, unittest.equals('foo'));
    unittest.expect(o.storageDataLocation, unittest.equals('foo'));
    unittest.expect(o.storagePMMLLocation, unittest.equals('foo'));
    unittest.expect(o.storagePMMLModelLocation, unittest.equals('foo'));
    checkUnnamed1596(o.trainingInstances);
    checkUnnamed1598(o.utility);
  }
  buildCounterInsert--;
}

core.int buildCounterInsert2ModelInfo = 0;
buildInsert2ModelInfo() {
  var o = new api.Insert2ModelInfo();
  buildCounterInsert2ModelInfo++;
  if (buildCounterInsert2ModelInfo < 3) {
    o.classWeightedAccuracy = "foo";
    o.classificationAccuracy = "foo";
    o.meanSquaredError = "foo";
    o.modelType = "foo";
    o.numberInstances = "foo";
    o.numberLabels = "foo";
  }
  buildCounterInsert2ModelInfo--;
  return o;
}

checkInsert2ModelInfo(api.Insert2ModelInfo o) {
  buildCounterInsert2ModelInfo++;
  if (buildCounterInsert2ModelInfo < 3) {
    unittest.expect(o.classWeightedAccuracy, unittest.equals('foo'));
    unittest.expect(o.classificationAccuracy, unittest.equals('foo'));
    unittest.expect(o.meanSquaredError, unittest.equals('foo'));
    unittest.expect(o.modelType, unittest.equals('foo'));
    unittest.expect(o.numberInstances, unittest.equals('foo'));
    unittest.expect(o.numberLabels, unittest.equals('foo'));
  }
  buildCounterInsert2ModelInfo--;
}

core.int buildCounterInsert2 = 0;
buildInsert2() {
  var o = new api.Insert2();
  buildCounterInsert2++;
  if (buildCounterInsert2 < 3) {
    o.created = core.DateTime.parse("2002-02-27T14:01:02");
    o.id = "foo";
    o.kind = "foo";
    o.modelInfo = buildInsert2ModelInfo();
    o.modelType = "foo";
    o.selfLink = "foo";
    o.storageDataLocation = "foo";
    o.storagePMMLLocation = "foo";
    o.storagePMMLModelLocation = "foo";
    o.trainingComplete = core.DateTime.parse("2002-02-27T14:01:02");
    o.trainingStatus = "foo";
  }
  buildCounterInsert2--;
  return o;
}

checkInsert2(api.Insert2 o) {
  buildCounterInsert2++;
  if (buildCounterInsert2 < 3) {
    unittest.expect(o.created, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkInsert2ModelInfo(o.modelInfo);
    unittest.expect(o.modelType, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.storageDataLocation, unittest.equals('foo'));
    unittest.expect(o.storagePMMLLocation, unittest.equals('foo'));
    unittest.expect(o.storagePMMLModelLocation, unittest.equals('foo'));
    unittest.expect(o.trainingComplete, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.trainingStatus, unittest.equals('foo'));
  }
  buildCounterInsert2--;
}

buildUnnamed1599() {
  var o = new core.List<api.Insert2>();
  o.add(buildInsert2());
  o.add(buildInsert2());
  return o;
}

checkUnnamed1599(core.List<api.Insert2> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkInsert2(o[0]);
  checkInsert2(o[1]);
}

core.int buildCounterList = 0;
buildList() {
  var o = new api.List();
  buildCounterList++;
  if (buildCounterList < 3) {
    o.items = buildUnnamed1599();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.selfLink = "foo";
  }
  buildCounterList--;
  return o;
}

checkList(api.List o) {
  buildCounterList++;
  if (buildCounterList < 3) {
    checkUnnamed1599(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterList--;
}

core.int buildCounterOutputOutputMulti = 0;
buildOutputOutputMulti() {
  var o = new api.OutputOutputMulti();
  buildCounterOutputOutputMulti++;
  if (buildCounterOutputOutputMulti < 3) {
    o.label = "foo";
    o.score = "foo";
  }
  buildCounterOutputOutputMulti--;
  return o;
}

checkOutputOutputMulti(api.OutputOutputMulti o) {
  buildCounterOutputOutputMulti++;
  if (buildCounterOutputOutputMulti < 3) {
    unittest.expect(o.label, unittest.equals('foo'));
    unittest.expect(o.score, unittest.equals('foo'));
  }
  buildCounterOutputOutputMulti--;
}

buildUnnamed1600() {
  var o = new core.List<api.OutputOutputMulti>();
  o.add(buildOutputOutputMulti());
  o.add(buildOutputOutputMulti());
  return o;
}

checkUnnamed1600(core.List<api.OutputOutputMulti> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOutputOutputMulti(o[0]);
  checkOutputOutputMulti(o[1]);
}

core.int buildCounterOutput = 0;
buildOutput() {
  var o = new api.Output();
  buildCounterOutput++;
  if (buildCounterOutput < 3) {
    o.id = "foo";
    o.kind = "foo";
    o.outputLabel = "foo";
    o.outputMulti = buildUnnamed1600();
    o.outputValue = "foo";
    o.selfLink = "foo";
  }
  buildCounterOutput--;
  return o;
}

checkOutput(api.Output o) {
  buildCounterOutput++;
  if (buildCounterOutput < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.outputLabel, unittest.equals('foo'));
    checkUnnamed1600(o.outputMulti);
    unittest.expect(o.outputValue, unittest.equals('foo'));
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterOutput--;
}

buildUnnamed1601() {
  var o = new core.List<core.Object>();
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  return o;
}

checkUnnamed1601(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted5 = (o[0]) as core.Map; unittest.expect(casted5, unittest.hasLength(3)); unittest.expect(casted5["list"], unittest.equals([1, 2, 3])); unittest.expect(casted5["bool"], unittest.equals(true)); unittest.expect(casted5["string"], unittest.equals('foo')); 
  var casted6 = (o[1]) as core.Map; unittest.expect(casted6, unittest.hasLength(3)); unittest.expect(casted6["list"], unittest.equals([1, 2, 3])); unittest.expect(casted6["bool"], unittest.equals(true)); unittest.expect(casted6["string"], unittest.equals('foo')); 
}

core.int buildCounterUpdate = 0;
buildUpdate() {
  var o = new api.Update();
  buildCounterUpdate++;
  if (buildCounterUpdate < 3) {
    o.csvInstance = buildUnnamed1601();
    o.output = "foo";
  }
  buildCounterUpdate--;
  return o;
}

checkUpdate(api.Update o) {
  buildCounterUpdate++;
  if (buildCounterUpdate < 3) {
    checkUnnamed1601(o.csvInstance);
    unittest.expect(o.output, unittest.equals('foo'));
  }
  buildCounterUpdate--;
}


main() {
  unittest.group("obj-schema-AnalyzeDataDescriptionFeaturesCategoricalValues", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeDataDescriptionFeaturesCategoricalValues();
      var od = new api.AnalyzeDataDescriptionFeaturesCategoricalValues.fromJson(o.toJson());
      checkAnalyzeDataDescriptionFeaturesCategoricalValues(od);
    });
  });


  unittest.group("obj-schema-AnalyzeDataDescriptionFeaturesCategorical", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeDataDescriptionFeaturesCategorical();
      var od = new api.AnalyzeDataDescriptionFeaturesCategorical.fromJson(o.toJson());
      checkAnalyzeDataDescriptionFeaturesCategorical(od);
    });
  });


  unittest.group("obj-schema-AnalyzeDataDescriptionFeaturesNumeric", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeDataDescriptionFeaturesNumeric();
      var od = new api.AnalyzeDataDescriptionFeaturesNumeric.fromJson(o.toJson());
      checkAnalyzeDataDescriptionFeaturesNumeric(od);
    });
  });


  unittest.group("obj-schema-AnalyzeDataDescriptionFeaturesText", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeDataDescriptionFeaturesText();
      var od = new api.AnalyzeDataDescriptionFeaturesText.fromJson(o.toJson());
      checkAnalyzeDataDescriptionFeaturesText(od);
    });
  });


  unittest.group("obj-schema-AnalyzeDataDescriptionFeatures", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeDataDescriptionFeatures();
      var od = new api.AnalyzeDataDescriptionFeatures.fromJson(o.toJson());
      checkAnalyzeDataDescriptionFeatures(od);
    });
  });


  unittest.group("obj-schema-AnalyzeDataDescriptionOutputFeatureNumeric", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeDataDescriptionOutputFeatureNumeric();
      var od = new api.AnalyzeDataDescriptionOutputFeatureNumeric.fromJson(o.toJson());
      checkAnalyzeDataDescriptionOutputFeatureNumeric(od);
    });
  });


  unittest.group("obj-schema-AnalyzeDataDescriptionOutputFeatureText", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeDataDescriptionOutputFeatureText();
      var od = new api.AnalyzeDataDescriptionOutputFeatureText.fromJson(o.toJson());
      checkAnalyzeDataDescriptionOutputFeatureText(od);
    });
  });


  unittest.group("obj-schema-AnalyzeDataDescriptionOutputFeature", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeDataDescriptionOutputFeature();
      var od = new api.AnalyzeDataDescriptionOutputFeature.fromJson(o.toJson());
      checkAnalyzeDataDescriptionOutputFeature(od);
    });
  });


  unittest.group("obj-schema-AnalyzeDataDescription", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeDataDescription();
      var od = new api.AnalyzeDataDescription.fromJson(o.toJson());
      checkAnalyzeDataDescription(od);
    });
  });


  unittest.group("obj-schema-AnalyzeModelDescription", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeModelDescription();
      var od = new api.AnalyzeModelDescription.fromJson(o.toJson());
      checkAnalyzeModelDescription(od);
    });
  });


  unittest.group("obj-schema-Analyze", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyze();
      var od = new api.Analyze.fromJson(o.toJson());
      checkAnalyze(od);
    });
  });


  unittest.group("obj-schema-InputInput", () {
    unittest.test("to-json--from-json", () {
      var o = buildInputInput();
      var od = new api.InputInput.fromJson(o.toJson());
      checkInputInput(od);
    });
  });


  unittest.group("obj-schema-Input", () {
    unittest.test("to-json--from-json", () {
      var o = buildInput();
      var od = new api.Input.fromJson(o.toJson());
      checkInput(od);
    });
  });


  unittest.group("obj-schema-InsertTrainingInstances", () {
    unittest.test("to-json--from-json", () {
      var o = buildInsertTrainingInstances();
      var od = new api.InsertTrainingInstances.fromJson(o.toJson());
      checkInsertTrainingInstances(od);
    });
  });


  unittest.group("obj-schema-Insert", () {
    unittest.test("to-json--from-json", () {
      var o = buildInsert();
      var od = new api.Insert.fromJson(o.toJson());
      checkInsert(od);
    });
  });


  unittest.group("obj-schema-Insert2ModelInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildInsert2ModelInfo();
      var od = new api.Insert2ModelInfo.fromJson(o.toJson());
      checkInsert2ModelInfo(od);
    });
  });


  unittest.group("obj-schema-Insert2", () {
    unittest.test("to-json--from-json", () {
      var o = buildInsert2();
      var od = new api.Insert2.fromJson(o.toJson());
      checkInsert2(od);
    });
  });


  unittest.group("obj-schema-List", () {
    unittest.test("to-json--from-json", () {
      var o = buildList();
      var od = new api.List.fromJson(o.toJson());
      checkList(od);
    });
  });


  unittest.group("obj-schema-OutputOutputMulti", () {
    unittest.test("to-json--from-json", () {
      var o = buildOutputOutputMulti();
      var od = new api.OutputOutputMulti.fromJson(o.toJson());
      checkOutputOutputMulti(od);
    });
  });


  unittest.group("obj-schema-Output", () {
    unittest.test("to-json--from-json", () {
      var o = buildOutput();
      var od = new api.Output.fromJson(o.toJson());
      checkOutput(od);
    });
  });


  unittest.group("obj-schema-Update", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdate();
      var od = new api.Update.fromJson(o.toJson());
      checkUpdate(od);
    });
  });


  unittest.group("resource-HostedmodelsResourceApi", () {
    unittest.test("method--predict", () {

      var mock = new HttpServerMock();
      api.HostedmodelsResourceApi res = new api.PredictionApi(mock).hostedmodels;
      var arg_request = buildInput();
      var arg_project = "foo";
      var arg_hostedModelName = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Input.fromJson(json);
        checkInput(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOutput());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.predict(arg_request, arg_project, arg_hostedModelName).then(unittest.expectAsync(((api.Output response) {
        checkOutput(response);
      })));
    });

  });


  unittest.group("resource-TrainedmodelsResourceApi", () {
    unittest.test("method--analyze", () {

      var mock = new HttpServerMock();
      api.TrainedmodelsResourceApi res = new api.PredictionApi(mock).trainedmodels;
      var arg_project = "foo";
      var arg_id = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildAnalyze());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.analyze(arg_project, arg_id).then(unittest.expectAsync(((api.Analyze response) {
        checkAnalyze(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.TrainedmodelsResourceApi res = new api.PredictionApi(mock).trainedmodels;
      var arg_project = "foo";
      var arg_id = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_project, arg_id).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.TrainedmodelsResourceApi res = new api.PredictionApi(mock).trainedmodels;
      var arg_project = "foo";
      var arg_id = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildInsert2());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_project, arg_id).then(unittest.expectAsync(((api.Insert2 response) {
        checkInsert2(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.TrainedmodelsResourceApi res = new api.PredictionApi(mock).trainedmodels;
      var arg_request = buildInsert();
      var arg_project = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Insert.fromJson(json);
        checkInsert(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildInsert2());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_project).then(unittest.expectAsync(((api.Insert2 response) {
        checkInsert2(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.TrainedmodelsResourceApi res = new api.PredictionApi(mock).trainedmodels;
      var arg_project = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_project, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.List response) {
        checkList(response);
      })));
    });

    unittest.test("method--predict", () {

      var mock = new HttpServerMock();
      api.TrainedmodelsResourceApi res = new api.PredictionApi(mock).trainedmodels;
      var arg_request = buildInput();
      var arg_project = "foo";
      var arg_id = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Input.fromJson(json);
        checkInput(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildOutput());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.predict(arg_request, arg_project, arg_id).then(unittest.expectAsync(((api.Output response) {
        checkOutput(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.TrainedmodelsResourceApi res = new api.PredictionApi(mock).trainedmodels;
      var arg_request = buildUpdate();
      var arg_project = "foo";
      var arg_id = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Update.fromJson(json);
        checkUpdate(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        var resp = convert.JSON.encode(buildInsert2());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_project, arg_id).then(unittest.expectAsync(((api.Insert2 response) {
        checkInsert2(response);
      })));
    });

  });


}

