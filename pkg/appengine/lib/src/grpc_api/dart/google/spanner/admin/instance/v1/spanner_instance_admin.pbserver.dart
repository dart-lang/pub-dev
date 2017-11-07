///
//  Generated code. Do not modify.
///
library google.spanner.admin.instance.v1_spanner_instance_admin_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'spanner_instance_admin.pb.dart';
import '../../../../longrunning/operations.pb.dart' as google$longrunning;
import '../../../../protobuf/empty.pb.dart' as google$protobuf;
import '../../../../iam/v1/iam_policy.pb.dart' as google$iam$v1;
import '../../../../iam/v1/policy.pb.dart' as google$iam$v1;
import 'spanner_instance_admin.pbjson.dart';

export 'spanner_instance_admin.pb.dart';

abstract class InstanceAdminServiceBase extends GeneratedService {
  Future<ListInstanceConfigsResponse> listInstanceConfigs(ServerContext ctx, ListInstanceConfigsRequest request);
  Future<InstanceConfig> getInstanceConfig(ServerContext ctx, GetInstanceConfigRequest request);
  Future<ListInstancesResponse> listInstances(ServerContext ctx, ListInstancesRequest request);
  Future<Instance> getInstance(ServerContext ctx, GetInstanceRequest request);
  Future<google$longrunning.Operation> createInstance(ServerContext ctx, CreateInstanceRequest request);
  Future<google$longrunning.Operation> updateInstance(ServerContext ctx, UpdateInstanceRequest request);
  Future<google$protobuf.Empty> deleteInstance(ServerContext ctx, DeleteInstanceRequest request);
  Future<google$iam$v1.Policy> setIamPolicy(ServerContext ctx, google$iam$v1.SetIamPolicyRequest request);
  Future<google$iam$v1.Policy> getIamPolicy(ServerContext ctx, google$iam$v1.GetIamPolicyRequest request);
  Future<google$iam$v1.TestIamPermissionsResponse> testIamPermissions(ServerContext ctx, google$iam$v1.TestIamPermissionsRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListInstanceConfigs': return new ListInstanceConfigsRequest();
      case 'GetInstanceConfig': return new GetInstanceConfigRequest();
      case 'ListInstances': return new ListInstancesRequest();
      case 'GetInstance': return new GetInstanceRequest();
      case 'CreateInstance': return new CreateInstanceRequest();
      case 'UpdateInstance': return new UpdateInstanceRequest();
      case 'DeleteInstance': return new DeleteInstanceRequest();
      case 'SetIamPolicy': return new google$iam$v1.SetIamPolicyRequest();
      case 'GetIamPolicy': return new google$iam$v1.GetIamPolicyRequest();
      case 'TestIamPermissions': return new google$iam$v1.TestIamPermissionsRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListInstanceConfigs': return this.listInstanceConfigs(ctx, request);
      case 'GetInstanceConfig': return this.getInstanceConfig(ctx, request);
      case 'ListInstances': return this.listInstances(ctx, request);
      case 'GetInstance': return this.getInstance(ctx, request);
      case 'CreateInstance': return this.createInstance(ctx, request);
      case 'UpdateInstance': return this.updateInstance(ctx, request);
      case 'DeleteInstance': return this.deleteInstance(ctx, request);
      case 'SetIamPolicy': return this.setIamPolicy(ctx, request);
      case 'GetIamPolicy': return this.getIamPolicy(ctx, request);
      case 'TestIamPermissions': return this.testIamPermissions(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => InstanceAdmin$json;
  Map<String, dynamic> get $messageJson => InstanceAdmin$messageJson;
}

