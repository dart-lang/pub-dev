///
//  Generated code. Do not modify.
///
library google.monitoring.v3_group_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'group.pb.dart';
import 'common.pb.dart';
import '../../api/monitored_resource.pb.dart' as google$api;
import '../../protobuf/empty.pb.dart' as google$protobuf;

class ListGroupsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListGroupsRequest')
    ..a/*<String>*/(2, 'childrenOfGroup', PbFieldType.OS)
    ..a/*<String>*/(3, 'ancestorsOfGroup', PbFieldType.OS)
    ..a/*<String>*/(4, 'descendantsOfGroup', PbFieldType.OS)
    ..a/*<int>*/(5, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(6, 'pageToken', PbFieldType.OS)
    ..a/*<String>*/(7, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListGroupsRequest() : super();
  ListGroupsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListGroupsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListGroupsRequest clone() => new ListGroupsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListGroupsRequest create() => new ListGroupsRequest();
  static PbList<ListGroupsRequest> createRepeated() => new PbList<ListGroupsRequest>();
  static ListGroupsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListGroupsRequest();
    return _defaultInstance;
  }
  static ListGroupsRequest _defaultInstance;
  static void $checkItem(ListGroupsRequest v) {
    if (v is !ListGroupsRequest) checkItemFailed(v, 'ListGroupsRequest');
  }

  String get childrenOfGroup => $_get(0, 2, '');
  void set childrenOfGroup(String v) { $_setString(0, 2, v); }
  bool hasChildrenOfGroup() => $_has(0, 2);
  void clearChildrenOfGroup() => clearField(2);

  String get ancestorsOfGroup => $_get(1, 3, '');
  void set ancestorsOfGroup(String v) { $_setString(1, 3, v); }
  bool hasAncestorsOfGroup() => $_has(1, 3);
  void clearAncestorsOfGroup() => clearField(3);

  String get descendantsOfGroup => $_get(2, 4, '');
  void set descendantsOfGroup(String v) { $_setString(2, 4, v); }
  bool hasDescendantsOfGroup() => $_has(2, 4);
  void clearDescendantsOfGroup() => clearField(4);

  int get pageSize => $_get(3, 5, 0);
  void set pageSize(int v) { $_setUnsignedInt32(3, 5, v); }
  bool hasPageSize() => $_has(3, 5);
  void clearPageSize() => clearField(5);

  String get pageToken => $_get(4, 6, '');
  void set pageToken(String v) { $_setString(4, 6, v); }
  bool hasPageToken() => $_has(4, 6);
  void clearPageToken() => clearField(6);

  String get name => $_get(5, 7, '');
  void set name(String v) { $_setString(5, 7, v); }
  bool hasName() => $_has(5, 7);
  void clearName() => clearField(7);
}

class _ReadonlyListGroupsRequest extends ListGroupsRequest with ReadonlyMessageMixin {}

class ListGroupsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListGroupsResponse')
    ..pp/*<Group>*/(1, 'group', PbFieldType.PM, Group.$checkItem, Group.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListGroupsResponse() : super();
  ListGroupsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListGroupsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListGroupsResponse clone() => new ListGroupsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListGroupsResponse create() => new ListGroupsResponse();
  static PbList<ListGroupsResponse> createRepeated() => new PbList<ListGroupsResponse>();
  static ListGroupsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListGroupsResponse();
    return _defaultInstance;
  }
  static ListGroupsResponse _defaultInstance;
  static void $checkItem(ListGroupsResponse v) {
    if (v is !ListGroupsResponse) checkItemFailed(v, 'ListGroupsResponse');
  }

  List<Group> get group => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListGroupsResponse extends ListGroupsResponse with ReadonlyMessageMixin {}

class GetGroupRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetGroupRequest')
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetGroupRequest() : super();
  GetGroupRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetGroupRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetGroupRequest clone() => new GetGroupRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetGroupRequest create() => new GetGroupRequest();
  static PbList<GetGroupRequest> createRepeated() => new PbList<GetGroupRequest>();
  static GetGroupRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetGroupRequest();
    return _defaultInstance;
  }
  static GetGroupRequest _defaultInstance;
  static void $checkItem(GetGroupRequest v) {
    if (v is !GetGroupRequest) checkItemFailed(v, 'GetGroupRequest');
  }

  String get name => $_get(0, 3, '');
  void set name(String v) { $_setString(0, 3, v); }
  bool hasName() => $_has(0, 3);
  void clearName() => clearField(3);
}

class _ReadonlyGetGroupRequest extends GetGroupRequest with ReadonlyMessageMixin {}

class CreateGroupRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateGroupRequest')
    ..a/*<Group>*/(2, 'group', PbFieldType.OM, Group.getDefault, Group.create)
    ..a/*<bool>*/(3, 'validateOnly', PbFieldType.OB)
    ..a/*<String>*/(4, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CreateGroupRequest() : super();
  CreateGroupRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateGroupRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateGroupRequest clone() => new CreateGroupRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateGroupRequest create() => new CreateGroupRequest();
  static PbList<CreateGroupRequest> createRepeated() => new PbList<CreateGroupRequest>();
  static CreateGroupRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateGroupRequest();
    return _defaultInstance;
  }
  static CreateGroupRequest _defaultInstance;
  static void $checkItem(CreateGroupRequest v) {
    if (v is !CreateGroupRequest) checkItemFailed(v, 'CreateGroupRequest');
  }

  Group get group => $_get(0, 2, null);
  void set group(Group v) { setField(2, v); }
  bool hasGroup() => $_has(0, 2);
  void clearGroup() => clearField(2);

  bool get validateOnly => $_get(1, 3, false);
  void set validateOnly(bool v) { $_setBool(1, 3, v); }
  bool hasValidateOnly() => $_has(1, 3);
  void clearValidateOnly() => clearField(3);

  String get name => $_get(2, 4, '');
  void set name(String v) { $_setString(2, 4, v); }
  bool hasName() => $_has(2, 4);
  void clearName() => clearField(4);
}

class _ReadonlyCreateGroupRequest extends CreateGroupRequest with ReadonlyMessageMixin {}

class UpdateGroupRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateGroupRequest')
    ..a/*<Group>*/(2, 'group', PbFieldType.OM, Group.getDefault, Group.create)
    ..a/*<bool>*/(3, 'validateOnly', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  UpdateGroupRequest() : super();
  UpdateGroupRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateGroupRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateGroupRequest clone() => new UpdateGroupRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateGroupRequest create() => new UpdateGroupRequest();
  static PbList<UpdateGroupRequest> createRepeated() => new PbList<UpdateGroupRequest>();
  static UpdateGroupRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateGroupRequest();
    return _defaultInstance;
  }
  static UpdateGroupRequest _defaultInstance;
  static void $checkItem(UpdateGroupRequest v) {
    if (v is !UpdateGroupRequest) checkItemFailed(v, 'UpdateGroupRequest');
  }

  Group get group => $_get(0, 2, null);
  void set group(Group v) { setField(2, v); }
  bool hasGroup() => $_has(0, 2);
  void clearGroup() => clearField(2);

  bool get validateOnly => $_get(1, 3, false);
  void set validateOnly(bool v) { $_setBool(1, 3, v); }
  bool hasValidateOnly() => $_has(1, 3);
  void clearValidateOnly() => clearField(3);
}

class _ReadonlyUpdateGroupRequest extends UpdateGroupRequest with ReadonlyMessageMixin {}

class DeleteGroupRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteGroupRequest')
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteGroupRequest() : super();
  DeleteGroupRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteGroupRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteGroupRequest clone() => new DeleteGroupRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteGroupRequest create() => new DeleteGroupRequest();
  static PbList<DeleteGroupRequest> createRepeated() => new PbList<DeleteGroupRequest>();
  static DeleteGroupRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteGroupRequest();
    return _defaultInstance;
  }
  static DeleteGroupRequest _defaultInstance;
  static void $checkItem(DeleteGroupRequest v) {
    if (v is !DeleteGroupRequest) checkItemFailed(v, 'DeleteGroupRequest');
  }

  String get name => $_get(0, 3, '');
  void set name(String v) { $_setString(0, 3, v); }
  bool hasName() => $_has(0, 3);
  void clearName() => clearField(3);
}

class _ReadonlyDeleteGroupRequest extends DeleteGroupRequest with ReadonlyMessageMixin {}

class ListGroupMembersRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListGroupMembersRequest')
    ..a/*<int>*/(3, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..a/*<String>*/(5, 'filter', PbFieldType.OS)
    ..a/*<TimeInterval>*/(6, 'interval', PbFieldType.OM, TimeInterval.getDefault, TimeInterval.create)
    ..a/*<String>*/(7, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListGroupMembersRequest() : super();
  ListGroupMembersRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListGroupMembersRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListGroupMembersRequest clone() => new ListGroupMembersRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListGroupMembersRequest create() => new ListGroupMembersRequest();
  static PbList<ListGroupMembersRequest> createRepeated() => new PbList<ListGroupMembersRequest>();
  static ListGroupMembersRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListGroupMembersRequest();
    return _defaultInstance;
  }
  static ListGroupMembersRequest _defaultInstance;
  static void $checkItem(ListGroupMembersRequest v) {
    if (v is !ListGroupMembersRequest) checkItemFailed(v, 'ListGroupMembersRequest');
  }

  int get pageSize => $_get(0, 3, 0);
  void set pageSize(int v) { $_setUnsignedInt32(0, 3, v); }
  bool hasPageSize() => $_has(0, 3);
  void clearPageSize() => clearField(3);

  String get pageToken => $_get(1, 4, '');
  void set pageToken(String v) { $_setString(1, 4, v); }
  bool hasPageToken() => $_has(1, 4);
  void clearPageToken() => clearField(4);

  String get filter => $_get(2, 5, '');
  void set filter(String v) { $_setString(2, 5, v); }
  bool hasFilter() => $_has(2, 5);
  void clearFilter() => clearField(5);

  TimeInterval get interval => $_get(3, 6, null);
  void set interval(TimeInterval v) { setField(6, v); }
  bool hasInterval() => $_has(3, 6);
  void clearInterval() => clearField(6);

  String get name => $_get(4, 7, '');
  void set name(String v) { $_setString(4, 7, v); }
  bool hasName() => $_has(4, 7);
  void clearName() => clearField(7);
}

class _ReadonlyListGroupMembersRequest extends ListGroupMembersRequest with ReadonlyMessageMixin {}

class ListGroupMembersResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListGroupMembersResponse')
    ..pp/*<google$api.MonitoredResource>*/(1, 'members', PbFieldType.PM, google$api.MonitoredResource.$checkItem, google$api.MonitoredResource.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..a/*<int>*/(3, 'totalSize', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListGroupMembersResponse() : super();
  ListGroupMembersResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListGroupMembersResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListGroupMembersResponse clone() => new ListGroupMembersResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListGroupMembersResponse create() => new ListGroupMembersResponse();
  static PbList<ListGroupMembersResponse> createRepeated() => new PbList<ListGroupMembersResponse>();
  static ListGroupMembersResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListGroupMembersResponse();
    return _defaultInstance;
  }
  static ListGroupMembersResponse _defaultInstance;
  static void $checkItem(ListGroupMembersResponse v) {
    if (v is !ListGroupMembersResponse) checkItemFailed(v, 'ListGroupMembersResponse');
  }

  List<google$api.MonitoredResource> get members => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);

  int get totalSize => $_get(2, 3, 0);
  void set totalSize(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasTotalSize() => $_has(2, 3);
  void clearTotalSize() => clearField(3);
}

class _ReadonlyListGroupMembersResponse extends ListGroupMembersResponse with ReadonlyMessageMixin {}

class GroupServiceApi {
  RpcClient _client;
  GroupServiceApi(this._client);

  Future<ListGroupsResponse> listGroups(ClientContext ctx, ListGroupsRequest request) {
    var emptyResponse = new ListGroupsResponse();
    return _client.invoke(ctx, 'GroupService', 'ListGroups', request, emptyResponse);
  }
  Future<Group> getGroup(ClientContext ctx, GetGroupRequest request) {
    var emptyResponse = new Group();
    return _client.invoke(ctx, 'GroupService', 'GetGroup', request, emptyResponse);
  }
  Future<Group> createGroup(ClientContext ctx, CreateGroupRequest request) {
    var emptyResponse = new Group();
    return _client.invoke(ctx, 'GroupService', 'CreateGroup', request, emptyResponse);
  }
  Future<Group> updateGroup(ClientContext ctx, UpdateGroupRequest request) {
    var emptyResponse = new Group();
    return _client.invoke(ctx, 'GroupService', 'UpdateGroup', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteGroup(ClientContext ctx, DeleteGroupRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'GroupService', 'DeleteGroup', request, emptyResponse);
  }
  Future<ListGroupMembersResponse> listGroupMembers(ClientContext ctx, ListGroupMembersRequest request) {
    var emptyResponse = new ListGroupMembersResponse();
    return _client.invoke(ctx, 'GroupService', 'ListGroupMembers', request, emptyResponse);
  }
}

