///
//  Generated code. Do not modify.
///
library google.genomics.v1_annotations_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'annotations.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'annotations.pbjson.dart';

export 'annotations.pb.dart';

abstract class AnnotationServiceV1ServiceBase extends GeneratedService {
  Future<AnnotationSet> createAnnotationSet(ServerContext ctx, CreateAnnotationSetRequest request);
  Future<AnnotationSet> getAnnotationSet(ServerContext ctx, GetAnnotationSetRequest request);
  Future<AnnotationSet> updateAnnotationSet(ServerContext ctx, UpdateAnnotationSetRequest request);
  Future<google$protobuf.Empty> deleteAnnotationSet(ServerContext ctx, DeleteAnnotationSetRequest request);
  Future<SearchAnnotationSetsResponse> searchAnnotationSets(ServerContext ctx, SearchAnnotationSetsRequest request);
  Future<Annotation> createAnnotation(ServerContext ctx, CreateAnnotationRequest request);
  Future<BatchCreateAnnotationsResponse> batchCreateAnnotations(ServerContext ctx, BatchCreateAnnotationsRequest request);
  Future<Annotation> getAnnotation(ServerContext ctx, GetAnnotationRequest request);
  Future<Annotation> updateAnnotation(ServerContext ctx, UpdateAnnotationRequest request);
  Future<google$protobuf.Empty> deleteAnnotation(ServerContext ctx, DeleteAnnotationRequest request);
  Future<SearchAnnotationsResponse> searchAnnotations(ServerContext ctx, SearchAnnotationsRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'CreateAnnotationSet': return new CreateAnnotationSetRequest();
      case 'GetAnnotationSet': return new GetAnnotationSetRequest();
      case 'UpdateAnnotationSet': return new UpdateAnnotationSetRequest();
      case 'DeleteAnnotationSet': return new DeleteAnnotationSetRequest();
      case 'SearchAnnotationSets': return new SearchAnnotationSetsRequest();
      case 'CreateAnnotation': return new CreateAnnotationRequest();
      case 'BatchCreateAnnotations': return new BatchCreateAnnotationsRequest();
      case 'GetAnnotation': return new GetAnnotationRequest();
      case 'UpdateAnnotation': return new UpdateAnnotationRequest();
      case 'DeleteAnnotation': return new DeleteAnnotationRequest();
      case 'SearchAnnotations': return new SearchAnnotationsRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'CreateAnnotationSet': return this.createAnnotationSet(ctx, request);
      case 'GetAnnotationSet': return this.getAnnotationSet(ctx, request);
      case 'UpdateAnnotationSet': return this.updateAnnotationSet(ctx, request);
      case 'DeleteAnnotationSet': return this.deleteAnnotationSet(ctx, request);
      case 'SearchAnnotationSets': return this.searchAnnotationSets(ctx, request);
      case 'CreateAnnotation': return this.createAnnotation(ctx, request);
      case 'BatchCreateAnnotations': return this.batchCreateAnnotations(ctx, request);
      case 'GetAnnotation': return this.getAnnotation(ctx, request);
      case 'UpdateAnnotation': return this.updateAnnotation(ctx, request);
      case 'DeleteAnnotation': return this.deleteAnnotation(ctx, request);
      case 'SearchAnnotations': return this.searchAnnotations(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => AnnotationServiceV1$json;
  Map<String, dynamic> get $messageJson => AnnotationServiceV1$messageJson;
}

