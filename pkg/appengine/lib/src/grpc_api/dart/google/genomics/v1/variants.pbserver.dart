///
//  Generated code. Do not modify.
///
library google.genomics.v1_variants_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'variants.pb.dart';
import '../../longrunning/operations.pb.dart' as google$longrunning;
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'variants.pbjson.dart';

export 'variants.pb.dart';

abstract class StreamingVariantServiceBase extends GeneratedService {
  Future<StreamVariantsResponse> streamVariants(ServerContext ctx, StreamVariantsRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'StreamVariants': return new StreamVariantsRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'StreamVariants': return this.streamVariants(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => StreamingVariantService$json;
  Map<String, dynamic> get $messageJson => StreamingVariantService$messageJson;
}

abstract class VariantServiceV1ServiceBase extends GeneratedService {
  Future<google$longrunning.Operation> importVariants(ServerContext ctx, ImportVariantsRequest request);
  Future<VariantSet> createVariantSet(ServerContext ctx, CreateVariantSetRequest request);
  Future<google$longrunning.Operation> exportVariantSet(ServerContext ctx, ExportVariantSetRequest request);
  Future<VariantSet> getVariantSet(ServerContext ctx, GetVariantSetRequest request);
  Future<SearchVariantSetsResponse> searchVariantSets(ServerContext ctx, SearchVariantSetsRequest request);
  Future<google$protobuf.Empty> deleteVariantSet(ServerContext ctx, DeleteVariantSetRequest request);
  Future<VariantSet> updateVariantSet(ServerContext ctx, UpdateVariantSetRequest request);
  Future<SearchVariantsResponse> searchVariants(ServerContext ctx, SearchVariantsRequest request);
  Future<Variant> createVariant(ServerContext ctx, CreateVariantRequest request);
  Future<Variant> updateVariant(ServerContext ctx, UpdateVariantRequest request);
  Future<google$protobuf.Empty> deleteVariant(ServerContext ctx, DeleteVariantRequest request);
  Future<Variant> getVariant(ServerContext ctx, GetVariantRequest request);
  Future<google$protobuf.Empty> mergeVariants(ServerContext ctx, MergeVariantsRequest request);
  Future<SearchCallSetsResponse> searchCallSets(ServerContext ctx, SearchCallSetsRequest request);
  Future<CallSet> createCallSet(ServerContext ctx, CreateCallSetRequest request);
  Future<CallSet> updateCallSet(ServerContext ctx, UpdateCallSetRequest request);
  Future<google$protobuf.Empty> deleteCallSet(ServerContext ctx, DeleteCallSetRequest request);
  Future<CallSet> getCallSet(ServerContext ctx, GetCallSetRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ImportVariants': return new ImportVariantsRequest();
      case 'CreateVariantSet': return new CreateVariantSetRequest();
      case 'ExportVariantSet': return new ExportVariantSetRequest();
      case 'GetVariantSet': return new GetVariantSetRequest();
      case 'SearchVariantSets': return new SearchVariantSetsRequest();
      case 'DeleteVariantSet': return new DeleteVariantSetRequest();
      case 'UpdateVariantSet': return new UpdateVariantSetRequest();
      case 'SearchVariants': return new SearchVariantsRequest();
      case 'CreateVariant': return new CreateVariantRequest();
      case 'UpdateVariant': return new UpdateVariantRequest();
      case 'DeleteVariant': return new DeleteVariantRequest();
      case 'GetVariant': return new GetVariantRequest();
      case 'MergeVariants': return new MergeVariantsRequest();
      case 'SearchCallSets': return new SearchCallSetsRequest();
      case 'CreateCallSet': return new CreateCallSetRequest();
      case 'UpdateCallSet': return new UpdateCallSetRequest();
      case 'DeleteCallSet': return new DeleteCallSetRequest();
      case 'GetCallSet': return new GetCallSetRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ImportVariants': return this.importVariants(ctx, request);
      case 'CreateVariantSet': return this.createVariantSet(ctx, request);
      case 'ExportVariantSet': return this.exportVariantSet(ctx, request);
      case 'GetVariantSet': return this.getVariantSet(ctx, request);
      case 'SearchVariantSets': return this.searchVariantSets(ctx, request);
      case 'DeleteVariantSet': return this.deleteVariantSet(ctx, request);
      case 'UpdateVariantSet': return this.updateVariantSet(ctx, request);
      case 'SearchVariants': return this.searchVariants(ctx, request);
      case 'CreateVariant': return this.createVariant(ctx, request);
      case 'UpdateVariant': return this.updateVariant(ctx, request);
      case 'DeleteVariant': return this.deleteVariant(ctx, request);
      case 'GetVariant': return this.getVariant(ctx, request);
      case 'MergeVariants': return this.mergeVariants(ctx, request);
      case 'SearchCallSets': return this.searchCallSets(ctx, request);
      case 'CreateCallSet': return this.createCallSet(ctx, request);
      case 'UpdateCallSet': return this.updateCallSet(ctx, request);
      case 'DeleteCallSet': return this.deleteCallSet(ctx, request);
      case 'GetCallSet': return this.getCallSet(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => VariantServiceV1$json;
  Map<String, dynamic> get $messageJson => VariantServiceV1$messageJson;
}

