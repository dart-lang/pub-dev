///
//  Generated code. Do not modify.
///
library google.genomics.v1_references_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'references.pb.dart';
import 'references.pbjson.dart';

export 'references.pb.dart';

abstract class ReferenceServiceV1ServiceBase extends GeneratedService {
  Future<SearchReferenceSetsResponse> searchReferenceSets(ServerContext ctx, SearchReferenceSetsRequest request);
  Future<ReferenceSet> getReferenceSet(ServerContext ctx, GetReferenceSetRequest request);
  Future<SearchReferencesResponse> searchReferences(ServerContext ctx, SearchReferencesRequest request);
  Future<Reference> getReference(ServerContext ctx, GetReferenceRequest request);
  Future<ListBasesResponse> listBases(ServerContext ctx, ListBasesRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'SearchReferenceSets': return new SearchReferenceSetsRequest();
      case 'GetReferenceSet': return new GetReferenceSetRequest();
      case 'SearchReferences': return new SearchReferencesRequest();
      case 'GetReference': return new GetReferenceRequest();
      case 'ListBases': return new ListBasesRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'SearchReferenceSets': return this.searchReferenceSets(ctx, request);
      case 'GetReferenceSet': return this.getReferenceSet(ctx, request);
      case 'SearchReferences': return this.searchReferences(ctx, request);
      case 'GetReference': return this.getReference(ctx, request);
      case 'ListBases': return this.listBases(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => ReferenceServiceV1$json;
  Map<String, dynamic> get $messageJson => ReferenceServiceV1$messageJson;
}

