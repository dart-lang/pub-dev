library googleapis.fusiontables.v2.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/fusiontables/v2.dart' as api;

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

core.int buildCounterBucket = 0;
buildBucket() {
  var o = new api.Bucket();
  buildCounterBucket++;
  if (buildCounterBucket < 3) {
    o.color = "foo";
    o.icon = "foo";
    o.max = 42.0;
    o.min = 42.0;
    o.opacity = 42.0;
    o.weight = 42;
  }
  buildCounterBucket--;
  return o;
}

checkBucket(api.Bucket o) {
  buildCounterBucket++;
  if (buildCounterBucket < 3) {
    unittest.expect(o.color, unittest.equals('foo'));
    unittest.expect(o.icon, unittest.equals('foo'));
    unittest.expect(o.max, unittest.equals(42.0));
    unittest.expect(o.min, unittest.equals(42.0));
    unittest.expect(o.opacity, unittest.equals(42.0));
    unittest.expect(o.weight, unittest.equals(42));
  }
  buildCounterBucket--;
}

core.int buildCounterColumnBaseColumn = 0;
buildColumnBaseColumn() {
  var o = new api.ColumnBaseColumn();
  buildCounterColumnBaseColumn++;
  if (buildCounterColumnBaseColumn < 3) {
    o.columnId = 42;
    o.tableIndex = 42;
  }
  buildCounterColumnBaseColumn--;
  return o;
}

checkColumnBaseColumn(api.ColumnBaseColumn o) {
  buildCounterColumnBaseColumn++;
  if (buildCounterColumnBaseColumn < 3) {
    unittest.expect(o.columnId, unittest.equals(42));
    unittest.expect(o.tableIndex, unittest.equals(42));
  }
  buildCounterColumnBaseColumn--;
}

buildUnnamed408() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed408(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterColumn = 0;
buildColumn() {
  var o = new api.Column();
  buildCounterColumn++;
  if (buildCounterColumn < 3) {
    o.baseColumn = buildColumnBaseColumn();
    o.columnId = 42;
    o.columnJsonSchema = "foo";
    o.columnPropertiesJson = "foo";
    o.description = "foo";
    o.formatPattern = "foo";
    o.graphPredicate = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.type = "foo";
    o.validValues = buildUnnamed408();
    o.validateData = true;
  }
  buildCounterColumn--;
  return o;
}

checkColumn(api.Column o) {
  buildCounterColumn++;
  if (buildCounterColumn < 3) {
    checkColumnBaseColumn(o.baseColumn);
    unittest.expect(o.columnId, unittest.equals(42));
    unittest.expect(o.columnJsonSchema, unittest.equals('foo'));
    unittest.expect(o.columnPropertiesJson, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.formatPattern, unittest.equals('foo'));
    unittest.expect(o.graphPredicate, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    checkUnnamed408(o.validValues);
    unittest.expect(o.validateData, unittest.isTrue);
  }
  buildCounterColumn--;
}

buildUnnamed409() {
  var o = new core.List<api.Column>();
  o.add(buildColumn());
  o.add(buildColumn());
  return o;
}

checkUnnamed409(core.List<api.Column> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkColumn(o[0]);
  checkColumn(o[1]);
}

core.int buildCounterColumnList = 0;
buildColumnList() {
  var o = new api.ColumnList();
  buildCounterColumnList++;
  if (buildCounterColumnList < 3) {
    o.items = buildUnnamed409();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.totalItems = 42;
  }
  buildCounterColumnList--;
  return o;
}

checkColumnList(api.ColumnList o) {
  buildCounterColumnList++;
  if (buildCounterColumnList < 3) {
    checkUnnamed409(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterColumnList--;
}

buildUnnamed410() {
  var o = new core.List<core.Object>();
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  return o;
}

checkUnnamed410(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o[0]) as core.Map; unittest.expect(casted1, unittest.hasLength(3)); unittest.expect(casted1["list"], unittest.equals([1, 2, 3])); unittest.expect(casted1["bool"], unittest.equals(true)); unittest.expect(casted1["string"], unittest.equals('foo')); 
  var casted2 = (o[1]) as core.Map; unittest.expect(casted2, unittest.hasLength(3)); unittest.expect(casted2["list"], unittest.equals([1, 2, 3])); unittest.expect(casted2["bool"], unittest.equals(true)); unittest.expect(casted2["string"], unittest.equals('foo')); 
}

core.int buildCounterGeometry = 0;
buildGeometry() {
  var o = new api.Geometry();
  buildCounterGeometry++;
  if (buildCounterGeometry < 3) {
    o.geometries = buildUnnamed410();
    o.geometry = {'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'};
    o.type = "foo";
  }
  buildCounterGeometry--;
  return o;
}

checkGeometry(api.Geometry o) {
  buildCounterGeometry++;
  if (buildCounterGeometry < 3) {
    checkUnnamed410(o.geometries);
    var casted3 = (o.geometry) as core.Map; unittest.expect(casted3, unittest.hasLength(3)); unittest.expect(casted3["list"], unittest.equals([1, 2, 3])); unittest.expect(casted3["bool"], unittest.equals(true)); unittest.expect(casted3["string"], unittest.equals('foo')); 
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterGeometry--;
}

core.int buildCounterImport = 0;
buildImport() {
  var o = new api.Import();
  buildCounterImport++;
  if (buildCounterImport < 3) {
    o.kind = "foo";
    o.numRowsReceived = "foo";
  }
  buildCounterImport--;
  return o;
}

checkImport(api.Import o) {
  buildCounterImport++;
  if (buildCounterImport < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.numRowsReceived, unittest.equals('foo'));
  }
  buildCounterImport--;
}

buildUnnamed411() {
  var o = new core.List<core.double>();
  o.add(42.0);
  o.add(42.0);
  return o;
}

checkUnnamed411(core.List<core.double> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42.0));
  unittest.expect(o[1], unittest.equals(42.0));
}

buildUnnamed412() {
  var o = new core.List<core.List<core.double>>();
  o.add(buildUnnamed411());
  o.add(buildUnnamed411());
  return o;
}

checkUnnamed412(core.List<core.List<core.double>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed411(o[0]);
  checkUnnamed411(o[1]);
}

core.int buildCounterLine = 0;
buildLine() {
  var o = new api.Line();
  buildCounterLine++;
  if (buildCounterLine < 3) {
    o.coordinates = buildUnnamed412();
    o.type = "foo";
  }
  buildCounterLine--;
  return o;
}

checkLine(api.Line o) {
  buildCounterLine++;
  if (buildCounterLine < 3) {
    checkUnnamed412(o.coordinates);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterLine--;
}

core.int buildCounterLineStyle = 0;
buildLineStyle() {
  var o = new api.LineStyle();
  buildCounterLineStyle++;
  if (buildCounterLineStyle < 3) {
    o.strokeColor = "foo";
    o.strokeColorStyler = buildStyleFunction();
    o.strokeOpacity = 42.0;
    o.strokeWeight = 42;
    o.strokeWeightStyler = buildStyleFunction();
  }
  buildCounterLineStyle--;
  return o;
}

checkLineStyle(api.LineStyle o) {
  buildCounterLineStyle++;
  if (buildCounterLineStyle < 3) {
    unittest.expect(o.strokeColor, unittest.equals('foo'));
    checkStyleFunction(o.strokeColorStyler);
    unittest.expect(o.strokeOpacity, unittest.equals(42.0));
    unittest.expect(o.strokeWeight, unittest.equals(42));
    checkStyleFunction(o.strokeWeightStyler);
  }
  buildCounterLineStyle--;
}

buildUnnamed413() {
  var o = new core.List<core.double>();
  o.add(42.0);
  o.add(42.0);
  return o;
}

checkUnnamed413(core.List<core.double> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42.0));
  unittest.expect(o[1], unittest.equals(42.0));
}

core.int buildCounterPoint = 0;
buildPoint() {
  var o = new api.Point();
  buildCounterPoint++;
  if (buildCounterPoint < 3) {
    o.coordinates = buildUnnamed413();
    o.type = "foo";
  }
  buildCounterPoint--;
  return o;
}

checkPoint(api.Point o) {
  buildCounterPoint++;
  if (buildCounterPoint < 3) {
    checkUnnamed413(o.coordinates);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterPoint--;
}

core.int buildCounterPointStyle = 0;
buildPointStyle() {
  var o = new api.PointStyle();
  buildCounterPointStyle++;
  if (buildCounterPointStyle < 3) {
    o.iconName = "foo";
    o.iconStyler = buildStyleFunction();
  }
  buildCounterPointStyle--;
  return o;
}

checkPointStyle(api.PointStyle o) {
  buildCounterPointStyle++;
  if (buildCounterPointStyle < 3) {
    unittest.expect(o.iconName, unittest.equals('foo'));
    checkStyleFunction(o.iconStyler);
  }
  buildCounterPointStyle--;
}

buildUnnamed414() {
  var o = new core.List<core.double>();
  o.add(42.0);
  o.add(42.0);
  return o;
}

checkUnnamed414(core.List<core.double> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42.0));
  unittest.expect(o[1], unittest.equals(42.0));
}

buildUnnamed415() {
  var o = new core.List<core.List<core.double>>();
  o.add(buildUnnamed414());
  o.add(buildUnnamed414());
  return o;
}

checkUnnamed415(core.List<core.List<core.double>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed414(o[0]);
  checkUnnamed414(o[1]);
}

buildUnnamed416() {
  var o = new core.List<core.List<core.List<core.double>>>();
  o.add(buildUnnamed415());
  o.add(buildUnnamed415());
  return o;
}

checkUnnamed416(core.List<core.List<core.List<core.double>>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed415(o[0]);
  checkUnnamed415(o[1]);
}

core.int buildCounterPolygon = 0;
buildPolygon() {
  var o = new api.Polygon();
  buildCounterPolygon++;
  if (buildCounterPolygon < 3) {
    o.coordinates = buildUnnamed416();
    o.type = "foo";
  }
  buildCounterPolygon--;
  return o;
}

checkPolygon(api.Polygon o) {
  buildCounterPolygon++;
  if (buildCounterPolygon < 3) {
    checkUnnamed416(o.coordinates);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterPolygon--;
}

core.int buildCounterPolygonStyle = 0;
buildPolygonStyle() {
  var o = new api.PolygonStyle();
  buildCounterPolygonStyle++;
  if (buildCounterPolygonStyle < 3) {
    o.fillColor = "foo";
    o.fillColorStyler = buildStyleFunction();
    o.fillOpacity = 42.0;
    o.strokeColor = "foo";
    o.strokeColorStyler = buildStyleFunction();
    o.strokeOpacity = 42.0;
    o.strokeWeight = 42;
    o.strokeWeightStyler = buildStyleFunction();
  }
  buildCounterPolygonStyle--;
  return o;
}

checkPolygonStyle(api.PolygonStyle o) {
  buildCounterPolygonStyle++;
  if (buildCounterPolygonStyle < 3) {
    unittest.expect(o.fillColor, unittest.equals('foo'));
    checkStyleFunction(o.fillColorStyler);
    unittest.expect(o.fillOpacity, unittest.equals(42.0));
    unittest.expect(o.strokeColor, unittest.equals('foo'));
    checkStyleFunction(o.strokeColorStyler);
    unittest.expect(o.strokeOpacity, unittest.equals(42.0));
    unittest.expect(o.strokeWeight, unittest.equals(42));
    checkStyleFunction(o.strokeWeightStyler);
  }
  buildCounterPolygonStyle--;
}

buildUnnamed417() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed417(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed418() {
  var o = new core.List<core.Object>();
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  o.add({'list' : [1, 2, 3], 'bool' : true, 'string' : 'foo'});
  return o;
}

checkUnnamed418(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted4 = (o[0]) as core.Map; unittest.expect(casted4, unittest.hasLength(3)); unittest.expect(casted4["list"], unittest.equals([1, 2, 3])); unittest.expect(casted4["bool"], unittest.equals(true)); unittest.expect(casted4["string"], unittest.equals('foo')); 
  var casted5 = (o[1]) as core.Map; unittest.expect(casted5, unittest.hasLength(3)); unittest.expect(casted5["list"], unittest.equals([1, 2, 3])); unittest.expect(casted5["bool"], unittest.equals(true)); unittest.expect(casted5["string"], unittest.equals('foo')); 
}

buildUnnamed419() {
  var o = new core.List<core.List<core.Object>>();
  o.add(buildUnnamed418());
  o.add(buildUnnamed418());
  return o;
}

checkUnnamed419(core.List<core.List<core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed418(o[0]);
  checkUnnamed418(o[1]);
}

core.int buildCounterSqlresponse = 0;
buildSqlresponse() {
  var o = new api.Sqlresponse();
  buildCounterSqlresponse++;
  if (buildCounterSqlresponse < 3) {
    o.columns = buildUnnamed417();
    o.kind = "foo";
    o.rows = buildUnnamed419();
  }
  buildCounterSqlresponse--;
  return o;
}

checkSqlresponse(api.Sqlresponse o) {
  buildCounterSqlresponse++;
  if (buildCounterSqlresponse < 3) {
    checkUnnamed417(o.columns);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed419(o.rows);
  }
  buildCounterSqlresponse--;
}

buildUnnamed420() {
  var o = new core.List<api.Bucket>();
  o.add(buildBucket());
  o.add(buildBucket());
  return o;
}

checkUnnamed420(core.List<api.Bucket> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBucket(o[0]);
  checkBucket(o[1]);
}

core.int buildCounterStyleFunctionGradientColors = 0;
buildStyleFunctionGradientColors() {
  var o = new api.StyleFunctionGradientColors();
  buildCounterStyleFunctionGradientColors++;
  if (buildCounterStyleFunctionGradientColors < 3) {
    o.color = "foo";
    o.opacity = 42.0;
  }
  buildCounterStyleFunctionGradientColors--;
  return o;
}

checkStyleFunctionGradientColors(api.StyleFunctionGradientColors o) {
  buildCounterStyleFunctionGradientColors++;
  if (buildCounterStyleFunctionGradientColors < 3) {
    unittest.expect(o.color, unittest.equals('foo'));
    unittest.expect(o.opacity, unittest.equals(42.0));
  }
  buildCounterStyleFunctionGradientColors--;
}

buildUnnamed421() {
  var o = new core.List<api.StyleFunctionGradientColors>();
  o.add(buildStyleFunctionGradientColors());
  o.add(buildStyleFunctionGradientColors());
  return o;
}

checkUnnamed421(core.List<api.StyleFunctionGradientColors> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkStyleFunctionGradientColors(o[0]);
  checkStyleFunctionGradientColors(o[1]);
}

core.int buildCounterStyleFunctionGradient = 0;
buildStyleFunctionGradient() {
  var o = new api.StyleFunctionGradient();
  buildCounterStyleFunctionGradient++;
  if (buildCounterStyleFunctionGradient < 3) {
    o.colors = buildUnnamed421();
    o.max = 42.0;
    o.min = 42.0;
  }
  buildCounterStyleFunctionGradient--;
  return o;
}

checkStyleFunctionGradient(api.StyleFunctionGradient o) {
  buildCounterStyleFunctionGradient++;
  if (buildCounterStyleFunctionGradient < 3) {
    checkUnnamed421(o.colors);
    unittest.expect(o.max, unittest.equals(42.0));
    unittest.expect(o.min, unittest.equals(42.0));
  }
  buildCounterStyleFunctionGradient--;
}

core.int buildCounterStyleFunction = 0;
buildStyleFunction() {
  var o = new api.StyleFunction();
  buildCounterStyleFunction++;
  if (buildCounterStyleFunction < 3) {
    o.buckets = buildUnnamed420();
    o.columnName = "foo";
    o.gradient = buildStyleFunctionGradient();
    o.kind = "foo";
  }
  buildCounterStyleFunction--;
  return o;
}

checkStyleFunction(api.StyleFunction o) {
  buildCounterStyleFunction++;
  if (buildCounterStyleFunction < 3) {
    checkUnnamed420(o.buckets);
    unittest.expect(o.columnName, unittest.equals('foo'));
    checkStyleFunctionGradient(o.gradient);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterStyleFunction--;
}

core.int buildCounterStyleSetting = 0;
buildStyleSetting() {
  var o = new api.StyleSetting();
  buildCounterStyleSetting++;
  if (buildCounterStyleSetting < 3) {
    o.kind = "foo";
    o.markerOptions = buildPointStyle();
    o.name = "foo";
    o.polygonOptions = buildPolygonStyle();
    o.polylineOptions = buildLineStyle();
    o.styleId = 42;
    o.tableId = "foo";
  }
  buildCounterStyleSetting--;
  return o;
}

checkStyleSetting(api.StyleSetting o) {
  buildCounterStyleSetting++;
  if (buildCounterStyleSetting < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkPointStyle(o.markerOptions);
    unittest.expect(o.name, unittest.equals('foo'));
    checkPolygonStyle(o.polygonOptions);
    checkLineStyle(o.polylineOptions);
    unittest.expect(o.styleId, unittest.equals(42));
    unittest.expect(o.tableId, unittest.equals('foo'));
  }
  buildCounterStyleSetting--;
}

buildUnnamed422() {
  var o = new core.List<api.StyleSetting>();
  o.add(buildStyleSetting());
  o.add(buildStyleSetting());
  return o;
}

checkUnnamed422(core.List<api.StyleSetting> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkStyleSetting(o[0]);
  checkStyleSetting(o[1]);
}

core.int buildCounterStyleSettingList = 0;
buildStyleSettingList() {
  var o = new api.StyleSettingList();
  buildCounterStyleSettingList++;
  if (buildCounterStyleSettingList < 3) {
    o.items = buildUnnamed422();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.totalItems = 42;
  }
  buildCounterStyleSettingList--;
  return o;
}

checkStyleSettingList(api.StyleSettingList o) {
  buildCounterStyleSettingList++;
  if (buildCounterStyleSettingList < 3) {
    checkUnnamed422(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterStyleSettingList--;
}

buildUnnamed423() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed423(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed424() {
  var o = new core.List<api.Column>();
  o.add(buildColumn());
  o.add(buildColumn());
  return o;
}

checkUnnamed424(core.List<api.Column> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkColumn(o[0]);
  checkColumn(o[1]);
}

core.int buildCounterTable = 0;
buildTable() {
  var o = new api.Table();
  buildCounterTable++;
  if (buildCounterTable < 3) {
    o.attribution = "foo";
    o.attributionLink = "foo";
    o.baseTableIds = buildUnnamed423();
    o.columnPropertiesJsonSchema = "foo";
    o.columns = buildUnnamed424();
    o.description = "foo";
    o.isExportable = true;
    o.kind = "foo";
    o.name = "foo";
    o.sql = "foo";
    o.tableId = "foo";
    o.tablePropertiesJson = "foo";
    o.tablePropertiesJsonSchema = "foo";
  }
  buildCounterTable--;
  return o;
}

checkTable(api.Table o) {
  buildCounterTable++;
  if (buildCounterTable < 3) {
    unittest.expect(o.attribution, unittest.equals('foo'));
    unittest.expect(o.attributionLink, unittest.equals('foo'));
    checkUnnamed423(o.baseTableIds);
    unittest.expect(o.columnPropertiesJsonSchema, unittest.equals('foo'));
    checkUnnamed424(o.columns);
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.isExportable, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.sql, unittest.equals('foo'));
    unittest.expect(o.tableId, unittest.equals('foo'));
    unittest.expect(o.tablePropertiesJson, unittest.equals('foo'));
    unittest.expect(o.tablePropertiesJsonSchema, unittest.equals('foo'));
  }
  buildCounterTable--;
}

buildUnnamed425() {
  var o = new core.List<api.Table>();
  o.add(buildTable());
  o.add(buildTable());
  return o;
}

checkUnnamed425(core.List<api.Table> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTable(o[0]);
  checkTable(o[1]);
}

core.int buildCounterTableList = 0;
buildTableList() {
  var o = new api.TableList();
  buildCounterTableList++;
  if (buildCounterTableList < 3) {
    o.items = buildUnnamed425();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterTableList--;
  return o;
}

checkTableList(api.TableList o) {
  buildCounterTableList++;
  if (buildCounterTableList < 3) {
    checkUnnamed425(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterTableList--;
}

core.int buildCounterTask = 0;
buildTask() {
  var o = new api.Task();
  buildCounterTask++;
  if (buildCounterTask < 3) {
    o.kind = "foo";
    o.progress = "foo";
    o.started = true;
    o.taskId = "foo";
    o.type = "foo";
  }
  buildCounterTask--;
  return o;
}

checkTask(api.Task o) {
  buildCounterTask++;
  if (buildCounterTask < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.progress, unittest.equals('foo'));
    unittest.expect(o.started, unittest.isTrue);
    unittest.expect(o.taskId, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterTask--;
}

buildUnnamed426() {
  var o = new core.List<api.Task>();
  o.add(buildTask());
  o.add(buildTask());
  return o;
}

checkUnnamed426(core.List<api.Task> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTask(o[0]);
  checkTask(o[1]);
}

core.int buildCounterTaskList = 0;
buildTaskList() {
  var o = new api.TaskList();
  buildCounterTaskList++;
  if (buildCounterTaskList < 3) {
    o.items = buildUnnamed426();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.totalItems = 42;
  }
  buildCounterTaskList--;
  return o;
}

checkTaskList(api.TaskList o) {
  buildCounterTaskList++;
  if (buildCounterTaskList < 3) {
    checkUnnamed426(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterTaskList--;
}

buildUnnamed427() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed427(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterTemplate = 0;
buildTemplate() {
  var o = new api.Template();
  buildCounterTemplate++;
  if (buildCounterTemplate < 3) {
    o.automaticColumnNames = buildUnnamed427();
    o.body = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.tableId = "foo";
    o.templateId = 42;
  }
  buildCounterTemplate--;
  return o;
}

checkTemplate(api.Template o) {
  buildCounterTemplate++;
  if (buildCounterTemplate < 3) {
    checkUnnamed427(o.automaticColumnNames);
    unittest.expect(o.body, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.tableId, unittest.equals('foo'));
    unittest.expect(o.templateId, unittest.equals(42));
  }
  buildCounterTemplate--;
}

buildUnnamed428() {
  var o = new core.List<api.Template>();
  o.add(buildTemplate());
  o.add(buildTemplate());
  return o;
}

checkUnnamed428(core.List<api.Template> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTemplate(o[0]);
  checkTemplate(o[1]);
}

core.int buildCounterTemplateList = 0;
buildTemplateList() {
  var o = new api.TemplateList();
  buildCounterTemplateList++;
  if (buildCounterTemplateList < 3) {
    o.items = buildUnnamed428();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.totalItems = 42;
  }
  buildCounterTemplateList--;
  return o;
}

checkTemplateList(api.TemplateList o) {
  buildCounterTemplateList++;
  if (buildCounterTemplateList < 3) {
    checkUnnamed428(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterTemplateList--;
}


main() {
  unittest.group("obj-schema-Bucket", () {
    unittest.test("to-json--from-json", () {
      var o = buildBucket();
      var od = new api.Bucket.fromJson(o.toJson());
      checkBucket(od);
    });
  });


  unittest.group("obj-schema-ColumnBaseColumn", () {
    unittest.test("to-json--from-json", () {
      var o = buildColumnBaseColumn();
      var od = new api.ColumnBaseColumn.fromJson(o.toJson());
      checkColumnBaseColumn(od);
    });
  });


  unittest.group("obj-schema-Column", () {
    unittest.test("to-json--from-json", () {
      var o = buildColumn();
      var od = new api.Column.fromJson(o.toJson());
      checkColumn(od);
    });
  });


  unittest.group("obj-schema-ColumnList", () {
    unittest.test("to-json--from-json", () {
      var o = buildColumnList();
      var od = new api.ColumnList.fromJson(o.toJson());
      checkColumnList(od);
    });
  });


  unittest.group("obj-schema-Geometry", () {
    unittest.test("to-json--from-json", () {
      var o = buildGeometry();
      var od = new api.Geometry.fromJson(o.toJson());
      checkGeometry(od);
    });
  });


  unittest.group("obj-schema-Import", () {
    unittest.test("to-json--from-json", () {
      var o = buildImport();
      var od = new api.Import.fromJson(o.toJson());
      checkImport(od);
    });
  });


  unittest.group("obj-schema-Line", () {
    unittest.test("to-json--from-json", () {
      var o = buildLine();
      var od = new api.Line.fromJson(o.toJson());
      checkLine(od);
    });
  });


  unittest.group("obj-schema-LineStyle", () {
    unittest.test("to-json--from-json", () {
      var o = buildLineStyle();
      var od = new api.LineStyle.fromJson(o.toJson());
      checkLineStyle(od);
    });
  });


  unittest.group("obj-schema-Point", () {
    unittest.test("to-json--from-json", () {
      var o = buildPoint();
      var od = new api.Point.fromJson(o.toJson());
      checkPoint(od);
    });
  });


  unittest.group("obj-schema-PointStyle", () {
    unittest.test("to-json--from-json", () {
      var o = buildPointStyle();
      var od = new api.PointStyle.fromJson(o.toJson());
      checkPointStyle(od);
    });
  });


  unittest.group("obj-schema-Polygon", () {
    unittest.test("to-json--from-json", () {
      var o = buildPolygon();
      var od = new api.Polygon.fromJson(o.toJson());
      checkPolygon(od);
    });
  });


  unittest.group("obj-schema-PolygonStyle", () {
    unittest.test("to-json--from-json", () {
      var o = buildPolygonStyle();
      var od = new api.PolygonStyle.fromJson(o.toJson());
      checkPolygonStyle(od);
    });
  });


  unittest.group("obj-schema-Sqlresponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSqlresponse();
      var od = new api.Sqlresponse.fromJson(o.toJson());
      checkSqlresponse(od);
    });
  });


  unittest.group("obj-schema-StyleFunctionGradientColors", () {
    unittest.test("to-json--from-json", () {
      var o = buildStyleFunctionGradientColors();
      var od = new api.StyleFunctionGradientColors.fromJson(o.toJson());
      checkStyleFunctionGradientColors(od);
    });
  });


  unittest.group("obj-schema-StyleFunctionGradient", () {
    unittest.test("to-json--from-json", () {
      var o = buildStyleFunctionGradient();
      var od = new api.StyleFunctionGradient.fromJson(o.toJson());
      checkStyleFunctionGradient(od);
    });
  });


  unittest.group("obj-schema-StyleFunction", () {
    unittest.test("to-json--from-json", () {
      var o = buildStyleFunction();
      var od = new api.StyleFunction.fromJson(o.toJson());
      checkStyleFunction(od);
    });
  });


  unittest.group("obj-schema-StyleSetting", () {
    unittest.test("to-json--from-json", () {
      var o = buildStyleSetting();
      var od = new api.StyleSetting.fromJson(o.toJson());
      checkStyleSetting(od);
    });
  });


  unittest.group("obj-schema-StyleSettingList", () {
    unittest.test("to-json--from-json", () {
      var o = buildStyleSettingList();
      var od = new api.StyleSettingList.fromJson(o.toJson());
      checkStyleSettingList(od);
    });
  });


  unittest.group("obj-schema-Table", () {
    unittest.test("to-json--from-json", () {
      var o = buildTable();
      var od = new api.Table.fromJson(o.toJson());
      checkTable(od);
    });
  });


  unittest.group("obj-schema-TableList", () {
    unittest.test("to-json--from-json", () {
      var o = buildTableList();
      var od = new api.TableList.fromJson(o.toJson());
      checkTableList(od);
    });
  });


  unittest.group("obj-schema-Task", () {
    unittest.test("to-json--from-json", () {
      var o = buildTask();
      var od = new api.Task.fromJson(o.toJson());
      checkTask(od);
    });
  });


  unittest.group("obj-schema-TaskList", () {
    unittest.test("to-json--from-json", () {
      var o = buildTaskList();
      var od = new api.TaskList.fromJson(o.toJson());
      checkTaskList(od);
    });
  });


  unittest.group("obj-schema-Template", () {
    unittest.test("to-json--from-json", () {
      var o = buildTemplate();
      var od = new api.Template.fromJson(o.toJson());
      checkTemplate(od);
    });
  });


  unittest.group("obj-schema-TemplateList", () {
    unittest.test("to-json--from-json", () {
      var o = buildTemplateList();
      var od = new api.TemplateList.fromJson(o.toJson());
      checkTemplateList(od);
    });
  });


  unittest.group("resource-ColumnResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.ColumnResourceApi res = new api.FusiontablesApi(mock).column;
      var arg_tableId = "foo";
      var arg_columnId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/columns/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/columns/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_columnId"));

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
      res.delete(arg_tableId, arg_columnId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ColumnResourceApi res = new api.FusiontablesApi(mock).column;
      var arg_tableId = "foo";
      var arg_columnId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/columns/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/columns/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_columnId"));

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
        var resp = convert.JSON.encode(buildColumn());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_tableId, arg_columnId).then(unittest.expectAsync(((api.Column response) {
        checkColumn(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.ColumnResourceApi res = new api.FusiontablesApi(mock).column;
      var arg_request = buildColumn();
      var arg_tableId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Column.fromJson(json);
        checkColumn(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/columns", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/columns"));
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
        var resp = convert.JSON.encode(buildColumn());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_tableId).then(unittest.expectAsync(((api.Column response) {
        checkColumn(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ColumnResourceApi res = new api.FusiontablesApi(mock).column;
      var arg_tableId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/columns", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/columns"));
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
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildColumnList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_tableId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.ColumnList response) {
        checkColumnList(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.ColumnResourceApi res = new api.FusiontablesApi(mock).column;
      var arg_request = buildColumn();
      var arg_tableId = "foo";
      var arg_columnId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Column.fromJson(json);
        checkColumn(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/columns/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/columns/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_columnId"));

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
        var resp = convert.JSON.encode(buildColumn());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_tableId, arg_columnId).then(unittest.expectAsync(((api.Column response) {
        checkColumn(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.ColumnResourceApi res = new api.FusiontablesApi(mock).column;
      var arg_request = buildColumn();
      var arg_tableId = "foo";
      var arg_columnId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Column.fromJson(json);
        checkColumn(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/columns/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/columns/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_columnId"));

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
        var resp = convert.JSON.encode(buildColumn());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_tableId, arg_columnId).then(unittest.expectAsync(((api.Column response) {
        checkColumn(response);
      })));
    });

  });


  unittest.group("resource-QueryResourceApi", () {
    unittest.test("method--sql", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.QueryResourceApi res = new api.FusiontablesApi(mock).query;
      var arg_sql_1 = "foo";
      var arg_hdrs = true;
      var arg_typed = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("query"));
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
        unittest.expect(queryMap["sql"].first, unittest.equals(arg_sql_1));
        unittest.expect(queryMap["hdrs"].first, unittest.equals("$arg_hdrs"));
        unittest.expect(queryMap["typed"].first, unittest.equals("$arg_typed"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSqlresponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.sql(arg_sql_1, hdrs: arg_hdrs, typed: arg_typed).then(unittest.expectAsync(((api.Sqlresponse response) {
        checkSqlresponse(response);
      })));
    });

    unittest.test("method--sqlGet", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.QueryResourceApi res = new api.FusiontablesApi(mock).query;
      var arg_sql_1 = "foo";
      var arg_hdrs = true;
      var arg_typed = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("query"));
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
        unittest.expect(queryMap["sql"].first, unittest.equals(arg_sql_1));
        unittest.expect(queryMap["hdrs"].first, unittest.equals("$arg_hdrs"));
        unittest.expect(queryMap["typed"].first, unittest.equals("$arg_typed"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSqlresponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.sqlGet(arg_sql_1, hdrs: arg_hdrs, typed: arg_typed).then(unittest.expectAsync(((api.Sqlresponse response) {
        checkSqlresponse(response);
      })));
    });

  });


  unittest.group("resource-StyleResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.StyleResourceApi res = new api.FusiontablesApi(mock).style;
      var arg_tableId = "foo";
      var arg_styleId = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/styles/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/styles/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_styleId"));

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
      res.delete(arg_tableId, arg_styleId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.StyleResourceApi res = new api.FusiontablesApi(mock).style;
      var arg_tableId = "foo";
      var arg_styleId = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/styles/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/styles/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_styleId"));

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
        var resp = convert.JSON.encode(buildStyleSetting());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_tableId, arg_styleId).then(unittest.expectAsync(((api.StyleSetting response) {
        checkStyleSetting(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.StyleResourceApi res = new api.FusiontablesApi(mock).style;
      var arg_request = buildStyleSetting();
      var arg_tableId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.StyleSetting.fromJson(json);
        checkStyleSetting(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/styles", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/styles"));
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
        var resp = convert.JSON.encode(buildStyleSetting());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_tableId).then(unittest.expectAsync(((api.StyleSetting response) {
        checkStyleSetting(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.StyleResourceApi res = new api.FusiontablesApi(mock).style;
      var arg_tableId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/styles", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/styles"));
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
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildStyleSettingList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_tableId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.StyleSettingList response) {
        checkStyleSettingList(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.StyleResourceApi res = new api.FusiontablesApi(mock).style;
      var arg_request = buildStyleSetting();
      var arg_tableId = "foo";
      var arg_styleId = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.StyleSetting.fromJson(json);
        checkStyleSetting(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/styles/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/styles/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_styleId"));

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
        var resp = convert.JSON.encode(buildStyleSetting());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_tableId, arg_styleId).then(unittest.expectAsync(((api.StyleSetting response) {
        checkStyleSetting(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.StyleResourceApi res = new api.FusiontablesApi(mock).style;
      var arg_request = buildStyleSetting();
      var arg_tableId = "foo";
      var arg_styleId = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.StyleSetting.fromJson(json);
        checkStyleSetting(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/styles/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/styles/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_styleId"));

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
        var resp = convert.JSON.encode(buildStyleSetting());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_tableId, arg_styleId).then(unittest.expectAsync(((api.StyleSetting response) {
        checkStyleSetting(response);
      })));
    });

  });


  unittest.group("resource-TableResourceApi", () {
    unittest.test("method--copy", () {

      var mock = new HttpServerMock();
      api.TableResourceApi res = new api.FusiontablesApi(mock).table;
      var arg_tableId = "foo";
      var arg_copyPresentation = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/copy", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/copy"));
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
        unittest.expect(queryMap["copyPresentation"].first, unittest.equals("$arg_copyPresentation"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTable());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.copy(arg_tableId, copyPresentation: arg_copyPresentation).then(unittest.expectAsync(((api.Table response) {
        checkTable(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.TableResourceApi res = new api.FusiontablesApi(mock).table;
      var arg_tableId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));

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
      res.delete(arg_tableId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.TableResourceApi res = new api.FusiontablesApi(mock).table;
      var arg_tableId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));

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
        var resp = convert.JSON.encode(buildTable());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_tableId).then(unittest.expectAsync(((api.Table response) {
        checkTable(response);
      })));
    });

    unittest.test("method--importRows", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.TableResourceApi res = new api.FusiontablesApi(mock).table;
      var arg_tableId = "foo";
      var arg_delimiter = "foo";
      var arg_encoding = "foo";
      var arg_endLine = 42;
      var arg_isStrict = true;
      var arg_startLine = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/import", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/import"));
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
        unittest.expect(queryMap["delimiter"].first, unittest.equals(arg_delimiter));
        unittest.expect(queryMap["encoding"].first, unittest.equals(arg_encoding));
        unittest.expect(core.int.parse(queryMap["endLine"].first), unittest.equals(arg_endLine));
        unittest.expect(queryMap["isStrict"].first, unittest.equals("$arg_isStrict"));
        unittest.expect(core.int.parse(queryMap["startLine"].first), unittest.equals(arg_startLine));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildImport());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.importRows(arg_tableId, delimiter: arg_delimiter, encoding: arg_encoding, endLine: arg_endLine, isStrict: arg_isStrict, startLine: arg_startLine).then(unittest.expectAsync(((api.Import response) {
        checkImport(response);
      })));
    });

    unittest.test("method--importTable", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.TableResourceApi res = new api.FusiontablesApi(mock).table;
      var arg_name = "foo";
      var arg_delimiter = "foo";
      var arg_encoding = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("tables/import"));
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
        unittest.expect(queryMap["name"].first, unittest.equals(arg_name));
        unittest.expect(queryMap["delimiter"].first, unittest.equals(arg_delimiter));
        unittest.expect(queryMap["encoding"].first, unittest.equals(arg_encoding));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTable());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.importTable(arg_name, delimiter: arg_delimiter, encoding: arg_encoding).then(unittest.expectAsync(((api.Table response) {
        checkTable(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.TableResourceApi res = new api.FusiontablesApi(mock).table;
      var arg_request = buildTable();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Table.fromJson(json);
        checkTable(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("tables"));
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
        var resp = convert.JSON.encode(buildTable());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request).then(unittest.expectAsync(((api.Table response) {
        checkTable(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.TableResourceApi res = new api.FusiontablesApi(mock).table;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("tables"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTableList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.TableList response) {
        checkTableList(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.TableResourceApi res = new api.FusiontablesApi(mock).table;
      var arg_request = buildTable();
      var arg_tableId = "foo";
      var arg_replaceViewDefinition = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Table.fromJson(json);
        checkTable(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));

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
        unittest.expect(queryMap["replaceViewDefinition"].first, unittest.equals("$arg_replaceViewDefinition"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTable());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_tableId, replaceViewDefinition: arg_replaceViewDefinition).then(unittest.expectAsync(((api.Table response) {
        checkTable(response);
      })));
    });

    unittest.test("method--replaceRows", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.TableResourceApi res = new api.FusiontablesApi(mock).table;
      var arg_tableId = "foo";
      var arg_delimiter = "foo";
      var arg_encoding = "foo";
      var arg_endLine = 42;
      var arg_isStrict = true;
      var arg_startLine = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/replace", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/replace"));
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
        unittest.expect(queryMap["delimiter"].first, unittest.equals(arg_delimiter));
        unittest.expect(queryMap["encoding"].first, unittest.equals(arg_encoding));
        unittest.expect(core.int.parse(queryMap["endLine"].first), unittest.equals(arg_endLine));
        unittest.expect(queryMap["isStrict"].first, unittest.equals("$arg_isStrict"));
        unittest.expect(core.int.parse(queryMap["startLine"].first), unittest.equals(arg_startLine));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.replaceRows(arg_tableId, delimiter: arg_delimiter, encoding: arg_encoding, endLine: arg_endLine, isStrict: arg_isStrict, startLine: arg_startLine).then(unittest.expectAsync(((api.Task response) {
        checkTask(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.TableResourceApi res = new api.FusiontablesApi(mock).table;
      var arg_request = buildTable();
      var arg_tableId = "foo";
      var arg_replaceViewDefinition = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Table.fromJson(json);
        checkTable(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));

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
        unittest.expect(queryMap["replaceViewDefinition"].first, unittest.equals("$arg_replaceViewDefinition"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTable());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_tableId, replaceViewDefinition: arg_replaceViewDefinition).then(unittest.expectAsync(((api.Table response) {
        checkTable(response);
      })));
    });

  });


  unittest.group("resource-TaskResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.TaskResourceApi res = new api.FusiontablesApi(mock).task;
      var arg_tableId = "foo";
      var arg_taskId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/tasks/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/tasks/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_taskId"));

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
      res.delete(arg_tableId, arg_taskId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.TaskResourceApi res = new api.FusiontablesApi(mock).task;
      var arg_tableId = "foo";
      var arg_taskId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/tasks/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/tasks/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_taskId"));

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
        var resp = convert.JSON.encode(buildTask());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_tableId, arg_taskId).then(unittest.expectAsync(((api.Task response) {
        checkTask(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.TaskResourceApi res = new api.FusiontablesApi(mock).task;
      var arg_tableId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_startIndex = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/tasks", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/tasks"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["startIndex"].first), unittest.equals(arg_startIndex));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTaskList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_tableId, maxResults: arg_maxResults, pageToken: arg_pageToken, startIndex: arg_startIndex).then(unittest.expectAsync(((api.TaskList response) {
        checkTaskList(response);
      })));
    });

  });


  unittest.group("resource-TemplateResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.TemplateResourceApi res = new api.FusiontablesApi(mock).template;
      var arg_tableId = "foo";
      var arg_templateId = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/templates/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("/templates/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_templateId"));

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
      res.delete(arg_tableId, arg_templateId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.TemplateResourceApi res = new api.FusiontablesApi(mock).template;
      var arg_tableId = "foo";
      var arg_templateId = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/templates/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("/templates/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_templateId"));

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
        var resp = convert.JSON.encode(buildTemplate());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_tableId, arg_templateId).then(unittest.expectAsync(((api.Template response) {
        checkTemplate(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.TemplateResourceApi res = new api.FusiontablesApi(mock).template;
      var arg_request = buildTemplate();
      var arg_tableId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Template.fromJson(json);
        checkTemplate(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/templates", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/templates"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTemplate());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_tableId).then(unittest.expectAsync(((api.Template response) {
        checkTemplate(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.TemplateResourceApi res = new api.FusiontablesApi(mock).template;
      var arg_tableId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/templates", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/templates"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTemplateList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_tableId, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.TemplateList response) {
        checkTemplateList(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.TemplateResourceApi res = new api.FusiontablesApi(mock).template;
      var arg_request = buildTemplate();
      var arg_tableId = "foo";
      var arg_templateId = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Template.fromJson(json);
        checkTemplate(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/templates/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("/templates/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_templateId"));

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
        var resp = convert.JSON.encode(buildTemplate());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_tableId, arg_templateId).then(unittest.expectAsync(((api.Template response) {
        checkTemplate(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.TemplateResourceApi res = new api.FusiontablesApi(mock).template;
      var arg_request = buildTemplate();
      var arg_tableId = "foo";
      var arg_templateId = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Template.fromJson(json);
        checkTemplate(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("fusiontables/v2/"));
        pathOffset += 16;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("tables/"));
        pathOffset += 7;
        index = path.indexOf("/templates/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_tableId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("/templates/"));
        pathOffset += 11;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_templateId"));

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
        var resp = convert.JSON.encode(buildTemplate());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_tableId, arg_templateId).then(unittest.expectAsync(((api.Template response) {
        checkTemplate(response);
      })));
    });

  });


}

