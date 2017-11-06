///
//  Generated code. Do not modify.
///
library google.cloud.speech.v1beta1_cloud_speech_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'cloud_speech.pb.dart';
import '../../../longrunning/operations.pb.dart' as google$longrunning;
import 'cloud_speech.pbjson.dart';

export 'cloud_speech.pb.dart';

abstract class SpeechServiceBase extends GeneratedService {
  Future<SyncRecognizeResponse> syncRecognize(ServerContext ctx, SyncRecognizeRequest request);
  Future<google$longrunning.Operation> asyncRecognize(ServerContext ctx, AsyncRecognizeRequest request);
  Future<StreamingRecognizeResponse> streamingRecognize(ServerContext ctx, StreamingRecognizeRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'SyncRecognize': return new SyncRecognizeRequest();
      case 'AsyncRecognize': return new AsyncRecognizeRequest();
      case 'StreamingRecognize': return new StreamingRecognizeRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'SyncRecognize': return this.syncRecognize(ctx, request);
      case 'AsyncRecognize': return this.asyncRecognize(ctx, request);
      case 'StreamingRecognize': return this.streamingRecognize(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Speech$json;
  Map<String, dynamic> get $messageJson => Speech$messageJson;
}

