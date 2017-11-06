///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_prediction_service_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'prediction_service.pb.dart';
import '../../../api/httpbody.pb.dart' as google$api;
import 'prediction_service.pbjson.dart';

export 'prediction_service.pb.dart';

abstract class OnlinePredictionServiceBase extends GeneratedService {
  Future<google$api.HttpBody> predict(ServerContext ctx, PredictRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'Predict': return new PredictRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'Predict': return this.predict(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => OnlinePredictionService$json;
  Map<String, dynamic> get $messageJson => OnlinePredictionService$messageJson;
}

