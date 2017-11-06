library googleapis_beta.language.v1beta1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis_beta/language/v1beta1.dart' as api;

class HttpServerMock extends http.BaseClient {
  core.Function _callback;
  core.bool _expectJson;

  void register(core.Function callback, core.bool expectJson) {
    _callback = callback;
    _expectJson = expectJson;
  }

  async.Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (_expectJson) {
      return request
          .finalize()
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

http.StreamedResponse stringResponse(core.int status,
    core.Map<core.String, core.String> headers, core.String body) {
  var stream = new async.Stream.fromIterable([convert.UTF8.encode(body)]);
  return new http.StreamedResponse(stream, status, headers: headers);
}

core.int buildCounterAnalyzeEntitiesRequest = 0;
buildAnalyzeEntitiesRequest() {
  var o = new api.AnalyzeEntitiesRequest();
  buildCounterAnalyzeEntitiesRequest++;
  if (buildCounterAnalyzeEntitiesRequest < 3) {
    o.document = buildDocument();
    o.encodingType = "foo";
  }
  buildCounterAnalyzeEntitiesRequest--;
  return o;
}

checkAnalyzeEntitiesRequest(api.AnalyzeEntitiesRequest o) {
  buildCounterAnalyzeEntitiesRequest++;
  if (buildCounterAnalyzeEntitiesRequest < 3) {
    checkDocument(o.document);
    unittest.expect(o.encodingType, unittest.equals('foo'));
  }
  buildCounterAnalyzeEntitiesRequest--;
}

buildUnnamed3203() {
  var o = new core.List<api.Entity>();
  o.add(buildEntity());
  o.add(buildEntity());
  return o;
}

checkUnnamed3203(core.List<api.Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntity(o[0]);
  checkEntity(o[1]);
}

core.int buildCounterAnalyzeEntitiesResponse = 0;
buildAnalyzeEntitiesResponse() {
  var o = new api.AnalyzeEntitiesResponse();
  buildCounterAnalyzeEntitiesResponse++;
  if (buildCounterAnalyzeEntitiesResponse < 3) {
    o.entities = buildUnnamed3203();
    o.language = "foo";
  }
  buildCounterAnalyzeEntitiesResponse--;
  return o;
}

checkAnalyzeEntitiesResponse(api.AnalyzeEntitiesResponse o) {
  buildCounterAnalyzeEntitiesResponse++;
  if (buildCounterAnalyzeEntitiesResponse < 3) {
    checkUnnamed3203(o.entities);
    unittest.expect(o.language, unittest.equals('foo'));
  }
  buildCounterAnalyzeEntitiesResponse--;
}

core.int buildCounterAnalyzeSentimentRequest = 0;
buildAnalyzeSentimentRequest() {
  var o = new api.AnalyzeSentimentRequest();
  buildCounterAnalyzeSentimentRequest++;
  if (buildCounterAnalyzeSentimentRequest < 3) {
    o.document = buildDocument();
    o.encodingType = "foo";
  }
  buildCounterAnalyzeSentimentRequest--;
  return o;
}

checkAnalyzeSentimentRequest(api.AnalyzeSentimentRequest o) {
  buildCounterAnalyzeSentimentRequest++;
  if (buildCounterAnalyzeSentimentRequest < 3) {
    checkDocument(o.document);
    unittest.expect(o.encodingType, unittest.equals('foo'));
  }
  buildCounterAnalyzeSentimentRequest--;
}

buildUnnamed3204() {
  var o = new core.List<api.Sentence>();
  o.add(buildSentence());
  o.add(buildSentence());
  return o;
}

checkUnnamed3204(core.List<api.Sentence> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSentence(o[0]);
  checkSentence(o[1]);
}

core.int buildCounterAnalyzeSentimentResponse = 0;
buildAnalyzeSentimentResponse() {
  var o = new api.AnalyzeSentimentResponse();
  buildCounterAnalyzeSentimentResponse++;
  if (buildCounterAnalyzeSentimentResponse < 3) {
    o.documentSentiment = buildSentiment();
    o.language = "foo";
    o.sentences = buildUnnamed3204();
  }
  buildCounterAnalyzeSentimentResponse--;
  return o;
}

checkAnalyzeSentimentResponse(api.AnalyzeSentimentResponse o) {
  buildCounterAnalyzeSentimentResponse++;
  if (buildCounterAnalyzeSentimentResponse < 3) {
    checkSentiment(o.documentSentiment);
    unittest.expect(o.language, unittest.equals('foo'));
    checkUnnamed3204(o.sentences);
  }
  buildCounterAnalyzeSentimentResponse--;
}

core.int buildCounterAnalyzeSyntaxRequest = 0;
buildAnalyzeSyntaxRequest() {
  var o = new api.AnalyzeSyntaxRequest();
  buildCounterAnalyzeSyntaxRequest++;
  if (buildCounterAnalyzeSyntaxRequest < 3) {
    o.document = buildDocument();
    o.encodingType = "foo";
  }
  buildCounterAnalyzeSyntaxRequest--;
  return o;
}

checkAnalyzeSyntaxRequest(api.AnalyzeSyntaxRequest o) {
  buildCounterAnalyzeSyntaxRequest++;
  if (buildCounterAnalyzeSyntaxRequest < 3) {
    checkDocument(o.document);
    unittest.expect(o.encodingType, unittest.equals('foo'));
  }
  buildCounterAnalyzeSyntaxRequest--;
}

buildUnnamed3205() {
  var o = new core.List<api.Sentence>();
  o.add(buildSentence());
  o.add(buildSentence());
  return o;
}

checkUnnamed3205(core.List<api.Sentence> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSentence(o[0]);
  checkSentence(o[1]);
}

buildUnnamed3206() {
  var o = new core.List<api.Token>();
  o.add(buildToken());
  o.add(buildToken());
  return o;
}

checkUnnamed3206(core.List<api.Token> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkToken(o[0]);
  checkToken(o[1]);
}

core.int buildCounterAnalyzeSyntaxResponse = 0;
buildAnalyzeSyntaxResponse() {
  var o = new api.AnalyzeSyntaxResponse();
  buildCounterAnalyzeSyntaxResponse++;
  if (buildCounterAnalyzeSyntaxResponse < 3) {
    o.language = "foo";
    o.sentences = buildUnnamed3205();
    o.tokens = buildUnnamed3206();
  }
  buildCounterAnalyzeSyntaxResponse--;
  return o;
}

checkAnalyzeSyntaxResponse(api.AnalyzeSyntaxResponse o) {
  buildCounterAnalyzeSyntaxResponse++;
  if (buildCounterAnalyzeSyntaxResponse < 3) {
    unittest.expect(o.language, unittest.equals('foo'));
    checkUnnamed3205(o.sentences);
    checkUnnamed3206(o.tokens);
  }
  buildCounterAnalyzeSyntaxResponse--;
}

core.int buildCounterAnnotateTextRequest = 0;
buildAnnotateTextRequest() {
  var o = new api.AnnotateTextRequest();
  buildCounterAnnotateTextRequest++;
  if (buildCounterAnnotateTextRequest < 3) {
    o.document = buildDocument();
    o.encodingType = "foo";
    o.features = buildFeatures();
  }
  buildCounterAnnotateTextRequest--;
  return o;
}

checkAnnotateTextRequest(api.AnnotateTextRequest o) {
  buildCounterAnnotateTextRequest++;
  if (buildCounterAnnotateTextRequest < 3) {
    checkDocument(o.document);
    unittest.expect(o.encodingType, unittest.equals('foo'));
    checkFeatures(o.features);
  }
  buildCounterAnnotateTextRequest--;
}

buildUnnamed3207() {
  var o = new core.List<api.Entity>();
  o.add(buildEntity());
  o.add(buildEntity());
  return o;
}

checkUnnamed3207(core.List<api.Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntity(o[0]);
  checkEntity(o[1]);
}

buildUnnamed3208() {
  var o = new core.List<api.Sentence>();
  o.add(buildSentence());
  o.add(buildSentence());
  return o;
}

checkUnnamed3208(core.List<api.Sentence> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSentence(o[0]);
  checkSentence(o[1]);
}

buildUnnamed3209() {
  var o = new core.List<api.Token>();
  o.add(buildToken());
  o.add(buildToken());
  return o;
}

checkUnnamed3209(core.List<api.Token> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkToken(o[0]);
  checkToken(o[1]);
}

core.int buildCounterAnnotateTextResponse = 0;
buildAnnotateTextResponse() {
  var o = new api.AnnotateTextResponse();
  buildCounterAnnotateTextResponse++;
  if (buildCounterAnnotateTextResponse < 3) {
    o.documentSentiment = buildSentiment();
    o.entities = buildUnnamed3207();
    o.language = "foo";
    o.sentences = buildUnnamed3208();
    o.tokens = buildUnnamed3209();
  }
  buildCounterAnnotateTextResponse--;
  return o;
}

checkAnnotateTextResponse(api.AnnotateTextResponse o) {
  buildCounterAnnotateTextResponse++;
  if (buildCounterAnnotateTextResponse < 3) {
    checkSentiment(o.documentSentiment);
    checkUnnamed3207(o.entities);
    unittest.expect(o.language, unittest.equals('foo'));
    checkUnnamed3208(o.sentences);
    checkUnnamed3209(o.tokens);
  }
  buildCounterAnnotateTextResponse--;
}

core.int buildCounterDependencyEdge = 0;
buildDependencyEdge() {
  var o = new api.DependencyEdge();
  buildCounterDependencyEdge++;
  if (buildCounterDependencyEdge < 3) {
    o.headTokenIndex = 42;
    o.label = "foo";
  }
  buildCounterDependencyEdge--;
  return o;
}

checkDependencyEdge(api.DependencyEdge o) {
  buildCounterDependencyEdge++;
  if (buildCounterDependencyEdge < 3) {
    unittest.expect(o.headTokenIndex, unittest.equals(42));
    unittest.expect(o.label, unittest.equals('foo'));
  }
  buildCounterDependencyEdge--;
}

core.int buildCounterDocument = 0;
buildDocument() {
  var o = new api.Document();
  buildCounterDocument++;
  if (buildCounterDocument < 3) {
    o.content = "foo";
    o.gcsContentUri = "foo";
    o.language = "foo";
    o.type = "foo";
  }
  buildCounterDocument--;
  return o;
}

checkDocument(api.Document o) {
  buildCounterDocument++;
  if (buildCounterDocument < 3) {
    unittest.expect(o.content, unittest.equals('foo'));
    unittest.expect(o.gcsContentUri, unittest.equals('foo'));
    unittest.expect(o.language, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterDocument--;
}

buildUnnamed3210() {
  var o = new core.List<api.EntityMention>();
  o.add(buildEntityMention());
  o.add(buildEntityMention());
  return o;
}

checkUnnamed3210(core.List<api.EntityMention> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntityMention(o[0]);
  checkEntityMention(o[1]);
}

buildUnnamed3211() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed3211(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterEntity = 0;
buildEntity() {
  var o = new api.Entity();
  buildCounterEntity++;
  if (buildCounterEntity < 3) {
    o.mentions = buildUnnamed3210();
    o.metadata = buildUnnamed3211();
    o.name = "foo";
    o.salience = 42.0;
    o.type = "foo";
  }
  buildCounterEntity--;
  return o;
}

checkEntity(api.Entity o) {
  buildCounterEntity++;
  if (buildCounterEntity < 3) {
    checkUnnamed3210(o.mentions);
    checkUnnamed3211(o.metadata);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.salience, unittest.equals(42.0));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterEntity--;
}

core.int buildCounterEntityMention = 0;
buildEntityMention() {
  var o = new api.EntityMention();
  buildCounterEntityMention++;
  if (buildCounterEntityMention < 3) {
    o.text = buildTextSpan();
    o.type = "foo";
  }
  buildCounterEntityMention--;
  return o;
}

checkEntityMention(api.EntityMention o) {
  buildCounterEntityMention++;
  if (buildCounterEntityMention < 3) {
    checkTextSpan(o.text);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterEntityMention--;
}

core.int buildCounterFeatures = 0;
buildFeatures() {
  var o = new api.Features();
  buildCounterFeatures++;
  if (buildCounterFeatures < 3) {
    o.extractDocumentSentiment = true;
    o.extractEntities = true;
    o.extractSyntax = true;
  }
  buildCounterFeatures--;
  return o;
}

checkFeatures(api.Features o) {
  buildCounterFeatures++;
  if (buildCounterFeatures < 3) {
    unittest.expect(o.extractDocumentSentiment, unittest.isTrue);
    unittest.expect(o.extractEntities, unittest.isTrue);
    unittest.expect(o.extractSyntax, unittest.isTrue);
  }
  buildCounterFeatures--;
}

core.int buildCounterPartOfSpeech = 0;
buildPartOfSpeech() {
  var o = new api.PartOfSpeech();
  buildCounterPartOfSpeech++;
  if (buildCounterPartOfSpeech < 3) {
    o.aspect = "foo";
    o.case_ = "foo";
    o.form = "foo";
    o.gender = "foo";
    o.mood = "foo";
    o.number = "foo";
    o.person = "foo";
    o.proper = "foo";
    o.reciprocity = "foo";
    o.tag = "foo";
    o.tense = "foo";
    o.voice = "foo";
  }
  buildCounterPartOfSpeech--;
  return o;
}

checkPartOfSpeech(api.PartOfSpeech o) {
  buildCounterPartOfSpeech++;
  if (buildCounterPartOfSpeech < 3) {
    unittest.expect(o.aspect, unittest.equals('foo'));
    unittest.expect(o.case_, unittest.equals('foo'));
    unittest.expect(o.form, unittest.equals('foo'));
    unittest.expect(o.gender, unittest.equals('foo'));
    unittest.expect(o.mood, unittest.equals('foo'));
    unittest.expect(o.number, unittest.equals('foo'));
    unittest.expect(o.person, unittest.equals('foo'));
    unittest.expect(o.proper, unittest.equals('foo'));
    unittest.expect(o.reciprocity, unittest.equals('foo'));
    unittest.expect(o.tag, unittest.equals('foo'));
    unittest.expect(o.tense, unittest.equals('foo'));
    unittest.expect(o.voice, unittest.equals('foo'));
  }
  buildCounterPartOfSpeech--;
}

core.int buildCounterSentence = 0;
buildSentence() {
  var o = new api.Sentence();
  buildCounterSentence++;
  if (buildCounterSentence < 3) {
    o.sentiment = buildSentiment();
    o.text = buildTextSpan();
  }
  buildCounterSentence--;
  return o;
}

checkSentence(api.Sentence o) {
  buildCounterSentence++;
  if (buildCounterSentence < 3) {
    checkSentiment(o.sentiment);
    checkTextSpan(o.text);
  }
  buildCounterSentence--;
}

core.int buildCounterSentiment = 0;
buildSentiment() {
  var o = new api.Sentiment();
  buildCounterSentiment++;
  if (buildCounterSentiment < 3) {
    o.magnitude = 42.0;
    o.polarity = 42.0;
    o.score = 42.0;
  }
  buildCounterSentiment--;
  return o;
}

checkSentiment(api.Sentiment o) {
  buildCounterSentiment++;
  if (buildCounterSentiment < 3) {
    unittest.expect(o.magnitude, unittest.equals(42.0));
    unittest.expect(o.polarity, unittest.equals(42.0));
    unittest.expect(o.score, unittest.equals(42.0));
  }
  buildCounterSentiment--;
}

buildUnnamed3212() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  o["y"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  return o;
}

checkUnnamed3212(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o["x"]) as core.Map;
  unittest.expect(casted1, unittest.hasLength(3));
  unittest.expect(casted1["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted1["bool"], unittest.equals(true));
  unittest.expect(casted1["string"], unittest.equals('foo'));
  var casted2 = (o["y"]) as core.Map;
  unittest.expect(casted2, unittest.hasLength(3));
  unittest.expect(casted2["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted2["bool"], unittest.equals(true));
  unittest.expect(casted2["string"], unittest.equals('foo'));
}

buildUnnamed3213() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed3212());
  o.add(buildUnnamed3212());
  return o;
}

checkUnnamed3213(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed3212(o[0]);
  checkUnnamed3212(o[1]);
}

core.int buildCounterStatus = 0;
buildStatus() {
  var o = new api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed3213();
    o.message = "foo";
  }
  buildCounterStatus--;
  return o;
}

checkStatus(api.Status o) {
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed3213(o.details);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterStatus--;
}

core.int buildCounterTextSpan = 0;
buildTextSpan() {
  var o = new api.TextSpan();
  buildCounterTextSpan++;
  if (buildCounterTextSpan < 3) {
    o.beginOffset = 42;
    o.content = "foo";
  }
  buildCounterTextSpan--;
  return o;
}

checkTextSpan(api.TextSpan o) {
  buildCounterTextSpan++;
  if (buildCounterTextSpan < 3) {
    unittest.expect(o.beginOffset, unittest.equals(42));
    unittest.expect(o.content, unittest.equals('foo'));
  }
  buildCounterTextSpan--;
}

core.int buildCounterToken = 0;
buildToken() {
  var o = new api.Token();
  buildCounterToken++;
  if (buildCounterToken < 3) {
    o.dependencyEdge = buildDependencyEdge();
    o.lemma = "foo";
    o.partOfSpeech = buildPartOfSpeech();
    o.text = buildTextSpan();
  }
  buildCounterToken--;
  return o;
}

checkToken(api.Token o) {
  buildCounterToken++;
  if (buildCounterToken < 3) {
    checkDependencyEdge(o.dependencyEdge);
    unittest.expect(o.lemma, unittest.equals('foo'));
    checkPartOfSpeech(o.partOfSpeech);
    checkTextSpan(o.text);
  }
  buildCounterToken--;
}

main() {
  unittest.group("obj-schema-AnalyzeEntitiesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeEntitiesRequest();
      var od = new api.AnalyzeEntitiesRequest.fromJson(o.toJson());
      checkAnalyzeEntitiesRequest(od);
    });
  });

  unittest.group("obj-schema-AnalyzeEntitiesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeEntitiesResponse();
      var od = new api.AnalyzeEntitiesResponse.fromJson(o.toJson());
      checkAnalyzeEntitiesResponse(od);
    });
  });

  unittest.group("obj-schema-AnalyzeSentimentRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeSentimentRequest();
      var od = new api.AnalyzeSentimentRequest.fromJson(o.toJson());
      checkAnalyzeSentimentRequest(od);
    });
  });

  unittest.group("obj-schema-AnalyzeSentimentResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeSentimentResponse();
      var od = new api.AnalyzeSentimentResponse.fromJson(o.toJson());
      checkAnalyzeSentimentResponse(od);
    });
  });

  unittest.group("obj-schema-AnalyzeSyntaxRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeSyntaxRequest();
      var od = new api.AnalyzeSyntaxRequest.fromJson(o.toJson());
      checkAnalyzeSyntaxRequest(od);
    });
  });

  unittest.group("obj-schema-AnalyzeSyntaxResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnalyzeSyntaxResponse();
      var od = new api.AnalyzeSyntaxResponse.fromJson(o.toJson());
      checkAnalyzeSyntaxResponse(od);
    });
  });

  unittest.group("obj-schema-AnnotateTextRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotateTextRequest();
      var od = new api.AnnotateTextRequest.fromJson(o.toJson());
      checkAnnotateTextRequest(od);
    });
  });

  unittest.group("obj-schema-AnnotateTextResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnnotateTextResponse();
      var od = new api.AnnotateTextResponse.fromJson(o.toJson());
      checkAnnotateTextResponse(od);
    });
  });

  unittest.group("obj-schema-DependencyEdge", () {
    unittest.test("to-json--from-json", () {
      var o = buildDependencyEdge();
      var od = new api.DependencyEdge.fromJson(o.toJson());
      checkDependencyEdge(od);
    });
  });

  unittest.group("obj-schema-Document", () {
    unittest.test("to-json--from-json", () {
      var o = buildDocument();
      var od = new api.Document.fromJson(o.toJson());
      checkDocument(od);
    });
  });

  unittest.group("obj-schema-Entity", () {
    unittest.test("to-json--from-json", () {
      var o = buildEntity();
      var od = new api.Entity.fromJson(o.toJson());
      checkEntity(od);
    });
  });

  unittest.group("obj-schema-EntityMention", () {
    unittest.test("to-json--from-json", () {
      var o = buildEntityMention();
      var od = new api.EntityMention.fromJson(o.toJson());
      checkEntityMention(od);
    });
  });

  unittest.group("obj-schema-Features", () {
    unittest.test("to-json--from-json", () {
      var o = buildFeatures();
      var od = new api.Features.fromJson(o.toJson());
      checkFeatures(od);
    });
  });

  unittest.group("obj-schema-PartOfSpeech", () {
    unittest.test("to-json--from-json", () {
      var o = buildPartOfSpeech();
      var od = new api.PartOfSpeech.fromJson(o.toJson());
      checkPartOfSpeech(od);
    });
  });

  unittest.group("obj-schema-Sentence", () {
    unittest.test("to-json--from-json", () {
      var o = buildSentence();
      var od = new api.Sentence.fromJson(o.toJson());
      checkSentence(od);
    });
  });

  unittest.group("obj-schema-Sentiment", () {
    unittest.test("to-json--from-json", () {
      var o = buildSentiment();
      var od = new api.Sentiment.fromJson(o.toJson());
      checkSentiment(od);
    });
  });

  unittest.group("obj-schema-Status", () {
    unittest.test("to-json--from-json", () {
      var o = buildStatus();
      var od = new api.Status.fromJson(o.toJson());
      checkStatus(od);
    });
  });

  unittest.group("obj-schema-TextSpan", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextSpan();
      var od = new api.TextSpan.fromJson(o.toJson());
      checkTextSpan(od);
    });
  });

  unittest.group("obj-schema-Token", () {
    unittest.test("to-json--from-json", () {
      var o = buildToken();
      var od = new api.Token.fromJson(o.toJson());
      checkToken(od);
    });
  });

  unittest.group("resource-DocumentsResourceApi", () {
    unittest.test("method--analyzeEntities", () {
      var mock = new HttpServerMock();
      api.DocumentsResourceApi res = new api.LanguageApi(mock).documents;
      var arg_request = buildAnalyzeEntitiesRequest();
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.AnalyzeEntitiesRequest.fromJson(json);
        checkAnalyzeEntitiesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 33),
            unittest.equals("v1beta1/documents:analyzeEntities"));
        pathOffset += 33;

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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAnalyzeEntitiesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .analyzeEntities(arg_request)
          .then(unittest.expectAsync1(((api.AnalyzeEntitiesResponse response) {
        checkAnalyzeEntitiesResponse(response);
      })));
    });

    unittest.test("method--analyzeSentiment", () {
      var mock = new HttpServerMock();
      api.DocumentsResourceApi res = new api.LanguageApi(mock).documents;
      var arg_request = buildAnalyzeSentimentRequest();
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.AnalyzeSentimentRequest.fromJson(json);
        checkAnalyzeSentimentRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 34),
            unittest.equals("v1beta1/documents:analyzeSentiment"));
        pathOffset += 34;

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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAnalyzeSentimentResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .analyzeSentiment(arg_request)
          .then(unittest.expectAsync1(((api.AnalyzeSentimentResponse response) {
        checkAnalyzeSentimentResponse(response);
      })));
    });

    unittest.test("method--analyzeSyntax", () {
      var mock = new HttpServerMock();
      api.DocumentsResourceApi res = new api.LanguageApi(mock).documents;
      var arg_request = buildAnalyzeSyntaxRequest();
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.AnalyzeSyntaxRequest.fromJson(json);
        checkAnalyzeSyntaxRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 31),
            unittest.equals("v1beta1/documents:analyzeSyntax"));
        pathOffset += 31;

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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAnalyzeSyntaxResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .analyzeSyntax(arg_request)
          .then(unittest.expectAsync1(((api.AnalyzeSyntaxResponse response) {
        checkAnalyzeSyntaxResponse(response);
      })));
    });

    unittest.test("method--annotateText", () {
      var mock = new HttpServerMock();
      api.DocumentsResourceApi res = new api.LanguageApi(mock).documents;
      var arg_request = buildAnnotateTextRequest();
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.AnnotateTextRequest.fromJson(json);
        checkAnnotateTextRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 30),
            unittest.equals("v1beta1/documents:annotateText"));
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
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAnnotateTextResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .annotateText(arg_request)
          .then(unittest.expectAsync1(((api.AnnotateTextResponse response) {
        checkAnnotateTextResponse(response);
      })));
    });
  });
}
