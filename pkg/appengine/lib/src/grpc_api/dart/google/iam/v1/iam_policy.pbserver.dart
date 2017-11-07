///
//  Generated code. Do not modify.
///
library google.iam.v1_iam_policy_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'iam_policy.pb.dart';
import 'policy.pb.dart';
import 'iam_policy.pbjson.dart';

export 'iam_policy.pb.dart';

abstract class IAMPolicyServiceBase extends GeneratedService {
  Future<Policy> setIamPolicy(ServerContext ctx, SetIamPolicyRequest request);
  Future<Policy> getIamPolicy(ServerContext ctx, GetIamPolicyRequest request);
  Future<TestIamPermissionsResponse> testIamPermissions(ServerContext ctx, TestIamPermissionsRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'SetIamPolicy': return new SetIamPolicyRequest();
      case 'GetIamPolicy': return new GetIamPolicyRequest();
      case 'TestIamPermissions': return new TestIamPermissionsRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'SetIamPolicy': return this.setIamPolicy(ctx, request);
      case 'GetIamPolicy': return this.getIamPolicy(ctx, request);
      case 'TestIamPermissions': return this.testIamPermissions(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => IAMPolicy$json;
  Map<String, dynamic> get $messageJson => IAMPolicy$messageJson;
}

