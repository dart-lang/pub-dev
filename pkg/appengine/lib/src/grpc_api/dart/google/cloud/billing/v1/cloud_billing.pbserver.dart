///
//  Generated code. Do not modify.
///
library google.cloud.billing.v1_cloud_billing_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'cloud_billing.pb.dart';
import 'cloud_billing.pbjson.dart';

export 'cloud_billing.pb.dart';

abstract class CloudBillingServiceBase extends GeneratedService {
  Future<BillingAccount> getBillingAccount(ServerContext ctx, GetBillingAccountRequest request);
  Future<ListBillingAccountsResponse> listBillingAccounts(ServerContext ctx, ListBillingAccountsRequest request);
  Future<ListProjectBillingInfoResponse> listProjectBillingInfo(ServerContext ctx, ListProjectBillingInfoRequest request);
  Future<ProjectBillingInfo> getProjectBillingInfo(ServerContext ctx, GetProjectBillingInfoRequest request);
  Future<ProjectBillingInfo> updateProjectBillingInfo(ServerContext ctx, UpdateProjectBillingInfoRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'GetBillingAccount': return new GetBillingAccountRequest();
      case 'ListBillingAccounts': return new ListBillingAccountsRequest();
      case 'ListProjectBillingInfo': return new ListProjectBillingInfoRequest();
      case 'GetProjectBillingInfo': return new GetProjectBillingInfoRequest();
      case 'UpdateProjectBillingInfo': return new UpdateProjectBillingInfoRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'GetBillingAccount': return this.getBillingAccount(ctx, request);
      case 'ListBillingAccounts': return this.listBillingAccounts(ctx, request);
      case 'ListProjectBillingInfo': return this.listProjectBillingInfo(ctx, request);
      case 'GetProjectBillingInfo': return this.getProjectBillingInfo(ctx, request);
      case 'UpdateProjectBillingInfo': return this.updateProjectBillingInfo(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => CloudBilling$json;
  Map<String, dynamic> get $messageJson => CloudBilling$messageJson;
}

