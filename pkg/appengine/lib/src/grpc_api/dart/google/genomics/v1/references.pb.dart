///
//  Generated code. Do not modify.
///
library google.genomics.v1_references;

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class Reference extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Reference')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'length', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(3, 'md5checksum', PbFieldType.OS)
    ..a/*<String>*/(4, 'name', PbFieldType.OS)
    ..a/*<String>*/(5, 'sourceUri', PbFieldType.OS)
    ..p/*<String>*/(6, 'sourceAccessions', PbFieldType.PS)
    ..a/*<int>*/(7, 'ncbiTaxonId', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Reference() : super();
  Reference.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Reference.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Reference clone() => new Reference()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Reference create() => new Reference();
  static PbList<Reference> createRepeated() => new PbList<Reference>();
  static Reference getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReference();
    return _defaultInstance;
  }
  static Reference _defaultInstance;
  static void $checkItem(Reference v) {
    if (v is !Reference) checkItemFailed(v, 'Reference');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  Int64 get length => $_get(1, 2, null);
  void set length(Int64 v) { $_setInt64(1, 2, v); }
  bool hasLength() => $_has(1, 2);
  void clearLength() => clearField(2);

  String get md5checksum => $_get(2, 3, '');
  void set md5checksum(String v) { $_setString(2, 3, v); }
  bool hasMd5checksum() => $_has(2, 3);
  void clearMd5checksum() => clearField(3);

  String get name => $_get(3, 4, '');
  void set name(String v) { $_setString(3, 4, v); }
  bool hasName() => $_has(3, 4);
  void clearName() => clearField(4);

  String get sourceUri => $_get(4, 5, '');
  void set sourceUri(String v) { $_setString(4, 5, v); }
  bool hasSourceUri() => $_has(4, 5);
  void clearSourceUri() => clearField(5);

  List<String> get sourceAccessions => $_get(5, 6, null);

  int get ncbiTaxonId => $_get(6, 7, 0);
  void set ncbiTaxonId(int v) { $_setUnsignedInt32(6, 7, v); }
  bool hasNcbiTaxonId() => $_has(6, 7);
  void clearNcbiTaxonId() => clearField(7);
}

class _ReadonlyReference extends Reference with ReadonlyMessageMixin {}

class ReferenceSet extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReferenceSet')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..p/*<String>*/(2, 'referenceIds', PbFieldType.PS)
    ..a/*<String>*/(3, 'md5checksum', PbFieldType.OS)
    ..a/*<int>*/(4, 'ncbiTaxonId', PbFieldType.O3)
    ..a/*<String>*/(5, 'description', PbFieldType.OS)
    ..a/*<String>*/(6, 'assemblyId', PbFieldType.OS)
    ..a/*<String>*/(7, 'sourceUri', PbFieldType.OS)
    ..p/*<String>*/(8, 'sourceAccessions', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  ReferenceSet() : super();
  ReferenceSet.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReferenceSet.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReferenceSet clone() => new ReferenceSet()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReferenceSet create() => new ReferenceSet();
  static PbList<ReferenceSet> createRepeated() => new PbList<ReferenceSet>();
  static ReferenceSet getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReferenceSet();
    return _defaultInstance;
  }
  static ReferenceSet _defaultInstance;
  static void $checkItem(ReferenceSet v) {
    if (v is !ReferenceSet) checkItemFailed(v, 'ReferenceSet');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  List<String> get referenceIds => $_get(1, 2, null);

  String get md5checksum => $_get(2, 3, '');
  void set md5checksum(String v) { $_setString(2, 3, v); }
  bool hasMd5checksum() => $_has(2, 3);
  void clearMd5checksum() => clearField(3);

  int get ncbiTaxonId => $_get(3, 4, 0);
  void set ncbiTaxonId(int v) { $_setUnsignedInt32(3, 4, v); }
  bool hasNcbiTaxonId() => $_has(3, 4);
  void clearNcbiTaxonId() => clearField(4);

  String get description => $_get(4, 5, '');
  void set description(String v) { $_setString(4, 5, v); }
  bool hasDescription() => $_has(4, 5);
  void clearDescription() => clearField(5);

  String get assemblyId => $_get(5, 6, '');
  void set assemblyId(String v) { $_setString(5, 6, v); }
  bool hasAssemblyId() => $_has(5, 6);
  void clearAssemblyId() => clearField(6);

  String get sourceUri => $_get(6, 7, '');
  void set sourceUri(String v) { $_setString(6, 7, v); }
  bool hasSourceUri() => $_has(6, 7);
  void clearSourceUri() => clearField(7);

  List<String> get sourceAccessions => $_get(7, 8, null);
}

class _ReadonlyReferenceSet extends ReferenceSet with ReadonlyMessageMixin {}

class SearchReferenceSetsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SearchReferenceSetsRequest')
    ..p/*<String>*/(1, 'md5checksums', PbFieldType.PS)
    ..p/*<String>*/(2, 'accessions', PbFieldType.PS)
    ..a/*<String>*/(3, 'assemblyId', PbFieldType.OS)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..a/*<int>*/(5, 'pageSize', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SearchReferenceSetsRequest() : super();
  SearchReferenceSetsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SearchReferenceSetsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SearchReferenceSetsRequest clone() => new SearchReferenceSetsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SearchReferenceSetsRequest create() => new SearchReferenceSetsRequest();
  static PbList<SearchReferenceSetsRequest> createRepeated() => new PbList<SearchReferenceSetsRequest>();
  static SearchReferenceSetsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySearchReferenceSetsRequest();
    return _defaultInstance;
  }
  static SearchReferenceSetsRequest _defaultInstance;
  static void $checkItem(SearchReferenceSetsRequest v) {
    if (v is !SearchReferenceSetsRequest) checkItemFailed(v, 'SearchReferenceSetsRequest');
  }

  List<String> get md5checksums => $_get(0, 1, null);

  List<String> get accessions => $_get(1, 2, null);

  String get assemblyId => $_get(2, 3, '');
  void set assemblyId(String v) { $_setString(2, 3, v); }
  bool hasAssemblyId() => $_has(2, 3);
  void clearAssemblyId() => clearField(3);

  String get pageToken => $_get(3, 4, '');
  void set pageToken(String v) { $_setString(3, 4, v); }
  bool hasPageToken() => $_has(3, 4);
  void clearPageToken() => clearField(4);

  int get pageSize => $_get(4, 5, 0);
  void set pageSize(int v) { $_setUnsignedInt32(4, 5, v); }
  bool hasPageSize() => $_has(4, 5);
  void clearPageSize() => clearField(5);
}

class _ReadonlySearchReferenceSetsRequest extends SearchReferenceSetsRequest with ReadonlyMessageMixin {}

class SearchReferenceSetsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SearchReferenceSetsResponse')
    ..pp/*<ReferenceSet>*/(1, 'referenceSets', PbFieldType.PM, ReferenceSet.$checkItem, ReferenceSet.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SearchReferenceSetsResponse() : super();
  SearchReferenceSetsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SearchReferenceSetsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SearchReferenceSetsResponse clone() => new SearchReferenceSetsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SearchReferenceSetsResponse create() => new SearchReferenceSetsResponse();
  static PbList<SearchReferenceSetsResponse> createRepeated() => new PbList<SearchReferenceSetsResponse>();
  static SearchReferenceSetsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySearchReferenceSetsResponse();
    return _defaultInstance;
  }
  static SearchReferenceSetsResponse _defaultInstance;
  static void $checkItem(SearchReferenceSetsResponse v) {
    if (v is !SearchReferenceSetsResponse) checkItemFailed(v, 'SearchReferenceSetsResponse');
  }

  List<ReferenceSet> get referenceSets => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlySearchReferenceSetsResponse extends SearchReferenceSetsResponse with ReadonlyMessageMixin {}

class GetReferenceSetRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetReferenceSetRequest')
    ..a/*<String>*/(1, 'referenceSetId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetReferenceSetRequest() : super();
  GetReferenceSetRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetReferenceSetRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetReferenceSetRequest clone() => new GetReferenceSetRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetReferenceSetRequest create() => new GetReferenceSetRequest();
  static PbList<GetReferenceSetRequest> createRepeated() => new PbList<GetReferenceSetRequest>();
  static GetReferenceSetRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetReferenceSetRequest();
    return _defaultInstance;
  }
  static GetReferenceSetRequest _defaultInstance;
  static void $checkItem(GetReferenceSetRequest v) {
    if (v is !GetReferenceSetRequest) checkItemFailed(v, 'GetReferenceSetRequest');
  }

  String get referenceSetId => $_get(0, 1, '');
  void set referenceSetId(String v) { $_setString(0, 1, v); }
  bool hasReferenceSetId() => $_has(0, 1);
  void clearReferenceSetId() => clearField(1);
}

class _ReadonlyGetReferenceSetRequest extends GetReferenceSetRequest with ReadonlyMessageMixin {}

class SearchReferencesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SearchReferencesRequest')
    ..p/*<String>*/(1, 'md5checksums', PbFieldType.PS)
    ..p/*<String>*/(2, 'accessions', PbFieldType.PS)
    ..a/*<String>*/(3, 'referenceSetId', PbFieldType.OS)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..a/*<int>*/(5, 'pageSize', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SearchReferencesRequest() : super();
  SearchReferencesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SearchReferencesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SearchReferencesRequest clone() => new SearchReferencesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SearchReferencesRequest create() => new SearchReferencesRequest();
  static PbList<SearchReferencesRequest> createRepeated() => new PbList<SearchReferencesRequest>();
  static SearchReferencesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySearchReferencesRequest();
    return _defaultInstance;
  }
  static SearchReferencesRequest _defaultInstance;
  static void $checkItem(SearchReferencesRequest v) {
    if (v is !SearchReferencesRequest) checkItemFailed(v, 'SearchReferencesRequest');
  }

  List<String> get md5checksums => $_get(0, 1, null);

  List<String> get accessions => $_get(1, 2, null);

  String get referenceSetId => $_get(2, 3, '');
  void set referenceSetId(String v) { $_setString(2, 3, v); }
  bool hasReferenceSetId() => $_has(2, 3);
  void clearReferenceSetId() => clearField(3);

  String get pageToken => $_get(3, 4, '');
  void set pageToken(String v) { $_setString(3, 4, v); }
  bool hasPageToken() => $_has(3, 4);
  void clearPageToken() => clearField(4);

  int get pageSize => $_get(4, 5, 0);
  void set pageSize(int v) { $_setUnsignedInt32(4, 5, v); }
  bool hasPageSize() => $_has(4, 5);
  void clearPageSize() => clearField(5);
}

class _ReadonlySearchReferencesRequest extends SearchReferencesRequest with ReadonlyMessageMixin {}

class SearchReferencesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SearchReferencesResponse')
    ..pp/*<Reference>*/(1, 'references', PbFieldType.PM, Reference.$checkItem, Reference.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SearchReferencesResponse() : super();
  SearchReferencesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SearchReferencesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SearchReferencesResponse clone() => new SearchReferencesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SearchReferencesResponse create() => new SearchReferencesResponse();
  static PbList<SearchReferencesResponse> createRepeated() => new PbList<SearchReferencesResponse>();
  static SearchReferencesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySearchReferencesResponse();
    return _defaultInstance;
  }
  static SearchReferencesResponse _defaultInstance;
  static void $checkItem(SearchReferencesResponse v) {
    if (v is !SearchReferencesResponse) checkItemFailed(v, 'SearchReferencesResponse');
  }

  List<Reference> get references => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlySearchReferencesResponse extends SearchReferencesResponse with ReadonlyMessageMixin {}

class GetReferenceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetReferenceRequest')
    ..a/*<String>*/(1, 'referenceId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetReferenceRequest() : super();
  GetReferenceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetReferenceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetReferenceRequest clone() => new GetReferenceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetReferenceRequest create() => new GetReferenceRequest();
  static PbList<GetReferenceRequest> createRepeated() => new PbList<GetReferenceRequest>();
  static GetReferenceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetReferenceRequest();
    return _defaultInstance;
  }
  static GetReferenceRequest _defaultInstance;
  static void $checkItem(GetReferenceRequest v) {
    if (v is !GetReferenceRequest) checkItemFailed(v, 'GetReferenceRequest');
  }

  String get referenceId => $_get(0, 1, '');
  void set referenceId(String v) { $_setString(0, 1, v); }
  bool hasReferenceId() => $_has(0, 1);
  void clearReferenceId() => clearField(1);
}

class _ReadonlyGetReferenceRequest extends GetReferenceRequest with ReadonlyMessageMixin {}

class ListBasesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBasesRequest')
    ..a/*<String>*/(1, 'referenceId', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'start', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(3, 'end', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..a/*<int>*/(5, 'pageSize', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListBasesRequest() : super();
  ListBasesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBasesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBasesRequest clone() => new ListBasesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBasesRequest create() => new ListBasesRequest();
  static PbList<ListBasesRequest> createRepeated() => new PbList<ListBasesRequest>();
  static ListBasesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBasesRequest();
    return _defaultInstance;
  }
  static ListBasesRequest _defaultInstance;
  static void $checkItem(ListBasesRequest v) {
    if (v is !ListBasesRequest) checkItemFailed(v, 'ListBasesRequest');
  }

  String get referenceId => $_get(0, 1, '');
  void set referenceId(String v) { $_setString(0, 1, v); }
  bool hasReferenceId() => $_has(0, 1);
  void clearReferenceId() => clearField(1);

  Int64 get start => $_get(1, 2, null);
  void set start(Int64 v) { $_setInt64(1, 2, v); }
  bool hasStart() => $_has(1, 2);
  void clearStart() => clearField(2);

  Int64 get end => $_get(2, 3, null);
  void set end(Int64 v) { $_setInt64(2, 3, v); }
  bool hasEnd() => $_has(2, 3);
  void clearEnd() => clearField(3);

  String get pageToken => $_get(3, 4, '');
  void set pageToken(String v) { $_setString(3, 4, v); }
  bool hasPageToken() => $_has(3, 4);
  void clearPageToken() => clearField(4);

  int get pageSize => $_get(4, 5, 0);
  void set pageSize(int v) { $_setUnsignedInt32(4, 5, v); }
  bool hasPageSize() => $_has(4, 5);
  void clearPageSize() => clearField(5);
}

class _ReadonlyListBasesRequest extends ListBasesRequest with ReadonlyMessageMixin {}

class ListBasesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBasesResponse')
    ..a/*<Int64>*/(1, 'offset', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(2, 'sequence', PbFieldType.OS)
    ..a/*<String>*/(3, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListBasesResponse() : super();
  ListBasesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBasesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBasesResponse clone() => new ListBasesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBasesResponse create() => new ListBasesResponse();
  static PbList<ListBasesResponse> createRepeated() => new PbList<ListBasesResponse>();
  static ListBasesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBasesResponse();
    return _defaultInstance;
  }
  static ListBasesResponse _defaultInstance;
  static void $checkItem(ListBasesResponse v) {
    if (v is !ListBasesResponse) checkItemFailed(v, 'ListBasesResponse');
  }

  Int64 get offset => $_get(0, 1, null);
  void set offset(Int64 v) { $_setInt64(0, 1, v); }
  bool hasOffset() => $_has(0, 1);
  void clearOffset() => clearField(1);

  String get sequence => $_get(1, 2, '');
  void set sequence(String v) { $_setString(1, 2, v); }
  bool hasSequence() => $_has(1, 2);
  void clearSequence() => clearField(2);

  String get nextPageToken => $_get(2, 3, '');
  void set nextPageToken(String v) { $_setString(2, 3, v); }
  bool hasNextPageToken() => $_has(2, 3);
  void clearNextPageToken() => clearField(3);
}

class _ReadonlyListBasesResponse extends ListBasesResponse with ReadonlyMessageMixin {}

class ReferenceServiceV1Api {
  RpcClient _client;
  ReferenceServiceV1Api(this._client);

  Future<SearchReferenceSetsResponse> searchReferenceSets(ClientContext ctx, SearchReferenceSetsRequest request) {
    var emptyResponse = new SearchReferenceSetsResponse();
    return _client.invoke(ctx, 'ReferenceServiceV1', 'SearchReferenceSets', request, emptyResponse);
  }
  Future<ReferenceSet> getReferenceSet(ClientContext ctx, GetReferenceSetRequest request) {
    var emptyResponse = new ReferenceSet();
    return _client.invoke(ctx, 'ReferenceServiceV1', 'GetReferenceSet', request, emptyResponse);
  }
  Future<SearchReferencesResponse> searchReferences(ClientContext ctx, SearchReferencesRequest request) {
    var emptyResponse = new SearchReferencesResponse();
    return _client.invoke(ctx, 'ReferenceServiceV1', 'SearchReferences', request, emptyResponse);
  }
  Future<Reference> getReference(ClientContext ctx, GetReferenceRequest request) {
    var emptyResponse = new Reference();
    return _client.invoke(ctx, 'ReferenceServiceV1', 'GetReference', request, emptyResponse);
  }
  Future<ListBasesResponse> listBases(ClientContext ctx, ListBasesRequest request) {
    var emptyResponse = new ListBasesResponse();
    return _client.invoke(ctx, 'ReferenceServiceV1', 'ListBases', request, emptyResponse);
  }
}

