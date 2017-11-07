///
//  Generated code. Do not modify.
///
library google.cloud.vision.v1_image_annotator_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'image_annotator.pb.dart';
import 'image_annotator.pbjson.dart';

export 'image_annotator.pb.dart';

abstract class ImageAnnotatorServiceBase extends GeneratedService {
  Future<BatchAnnotateImagesResponse> batchAnnotateImages(ServerContext ctx, BatchAnnotateImagesRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'BatchAnnotateImages': return new BatchAnnotateImagesRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'BatchAnnotateImages': return this.batchAnnotateImages(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => ImageAnnotator$json;
  Map<String, dynamic> get $messageJson => ImageAnnotator$messageJson;
}

