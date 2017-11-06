///
//  Generated code. Do not modify.
///
library google.genomics.v1_datasets_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'datasets.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;
import '../../iam/v1/iam_policy.pb.dart' as google$iam$v1;
import '../../iam/v1/policy.pb.dart' as google$iam$v1;
import 'datasets.pbjson.dart';

export 'datasets.pb.dart';

abstract class DatasetServiceV1ServiceBase extends GeneratedService {
  Future<ListDatasetsResponse> listDatasets(ServerContext ctx, ListDatasetsRequest request);
  Future<Dataset> createDataset(ServerContext ctx, CreateDatasetRequest request);
  Future<Dataset> getDataset(ServerContext ctx, GetDatasetRequest request);
  Future<Dataset> updateDataset(ServerContext ctx, UpdateDatasetRequest request);
  Future<google$protobuf.Empty> deleteDataset(ServerContext ctx, DeleteDatasetRequest request);
  Future<Dataset> undeleteDataset(ServerContext ctx, UndeleteDatasetRequest request);
  Future<google$iam$v1.Policy> setIamPolicy(ServerContext ctx, google$iam$v1.SetIamPolicyRequest request);
  Future<google$iam$v1.Policy> getIamPolicy(ServerContext ctx, google$iam$v1.GetIamPolicyRequest request);
  Future<google$iam$v1.TestIamPermissionsResponse> testIamPermissions(ServerContext ctx, google$iam$v1.TestIamPermissionsRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListDatasets': return new ListDatasetsRequest();
      case 'CreateDataset': return new CreateDatasetRequest();
      case 'GetDataset': return new GetDatasetRequest();
      case 'UpdateDataset': return new UpdateDatasetRequest();
      case 'DeleteDataset': return new DeleteDatasetRequest();
      case 'UndeleteDataset': return new UndeleteDatasetRequest();
      case 'SetIamPolicy': return new google$iam$v1.SetIamPolicyRequest();
      case 'GetIamPolicy': return new google$iam$v1.GetIamPolicyRequest();
      case 'TestIamPermissions': return new google$iam$v1.TestIamPermissionsRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListDatasets': return this.listDatasets(ctx, request);
      case 'CreateDataset': return this.createDataset(ctx, request);
      case 'GetDataset': return this.getDataset(ctx, request);
      case 'UpdateDataset': return this.updateDataset(ctx, request);
      case 'DeleteDataset': return this.deleteDataset(ctx, request);
      case 'UndeleteDataset': return this.undeleteDataset(ctx, request);
      case 'SetIamPolicy': return this.setIamPolicy(ctx, request);
      case 'GetIamPolicy': return this.getIamPolicy(ctx, request);
      case 'TestIamPermissions': return this.testIamPermissions(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => DatasetServiceV1$json;
  Map<String, dynamic> get $messageJson => DatasetServiceV1$messageJson;
}

