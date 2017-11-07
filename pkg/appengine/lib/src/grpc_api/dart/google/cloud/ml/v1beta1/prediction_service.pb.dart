///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_prediction_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../../api/httpbody.pb.dart' as google$api;

class PredictRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PredictRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<google$api.HttpBody>*/(2, 'httpBody', PbFieldType.OM, google$api.HttpBody.getDefault, google$api.HttpBody.create)
    ..hasRequiredFields = false
  ;

  PredictRequest() : super();
  PredictRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PredictRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PredictRequest clone() => new PredictRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PredictRequest create() => new PredictRequest();
  static PbList<PredictRequest> createRepeated() => new PbList<PredictRequest>();
  static PredictRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPredictRequest();
    return _defaultInstance;
  }
  static PredictRequest _defaultInstance;
  static void $checkItem(PredictRequest v) {
    if (v is !PredictRequest) checkItemFailed(v, 'PredictRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  google$api.HttpBody get httpBody => $_get(1, 2, null);
  void set httpBody(google$api.HttpBody v) { setField(2, v); }
  bool hasHttpBody() => $_has(1, 2);
  void clearHttpBody() => clearField(2);
}

class _ReadonlyPredictRequest extends PredictRequest with ReadonlyMessageMixin {}

class OnlinePredictionServiceApi {
  RpcClient _client;
  OnlinePredictionServiceApi(this._client);

  Future<google$api.HttpBody> predict(ClientContext ctx, PredictRequest request) {
    var emptyResponse = new google$api.HttpBody();
    return _client.invoke(ctx, 'OnlinePredictionService', 'Predict', request, emptyResponse);
  }
}

