///
//  Generated code. Do not modify.
///
library google.monitoring.v3_group_service_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'group_service.pb.dart';
import 'group.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'group_service.pbjson.dart';

export 'group_service.pb.dart';

abstract class GroupServiceBase extends GeneratedService {
  Future<ListGroupsResponse> listGroups(ServerContext ctx, ListGroupsRequest request);
  Future<Group> getGroup(ServerContext ctx, GetGroupRequest request);
  Future<Group> createGroup(ServerContext ctx, CreateGroupRequest request);
  Future<Group> updateGroup(ServerContext ctx, UpdateGroupRequest request);
  Future<google$protobuf.Empty> deleteGroup(ServerContext ctx, DeleteGroupRequest request);
  Future<ListGroupMembersResponse> listGroupMembers(ServerContext ctx, ListGroupMembersRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListGroups': return new ListGroupsRequest();
      case 'GetGroup': return new GetGroupRequest();
      case 'CreateGroup': return new CreateGroupRequest();
      case 'UpdateGroup': return new UpdateGroupRequest();
      case 'DeleteGroup': return new DeleteGroupRequest();
      case 'ListGroupMembers': return new ListGroupMembersRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListGroups': return this.listGroups(ctx, request);
      case 'GetGroup': return this.getGroup(ctx, request);
      case 'CreateGroup': return this.createGroup(ctx, request);
      case 'UpdateGroup': return this.updateGroup(ctx, request);
      case 'DeleteGroup': return this.deleteGroup(ctx, request);
      case 'ListGroupMembers': return this.listGroupMembers(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => GroupService$json;
  Map<String, dynamic> get $messageJson => GroupService$messageJson;
}

