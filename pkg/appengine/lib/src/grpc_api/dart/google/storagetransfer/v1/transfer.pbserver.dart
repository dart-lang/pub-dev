///
//  Generated code. Do not modify.
///
library google.storagetransfer.v1_transfer_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'transfer.pb.dart';
import 'transfer_types.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'transfer.pbjson.dart';

export 'transfer.pb.dart';

abstract class StorageTransferServiceBase extends GeneratedService {
  Future<GoogleServiceAccount> getGoogleServiceAccount(ServerContext ctx, GetGoogleServiceAccountRequest request);
  Future<TransferJob> createTransferJob(ServerContext ctx, CreateTransferJobRequest request);
  Future<TransferJob> updateTransferJob(ServerContext ctx, UpdateTransferJobRequest request);
  Future<TransferJob> getTransferJob(ServerContext ctx, GetTransferJobRequest request);
  Future<ListTransferJobsResponse> listTransferJobs(ServerContext ctx, ListTransferJobsRequest request);
  Future<google$protobuf.Empty> pauseTransferOperation(ServerContext ctx, PauseTransferOperationRequest request);
  Future<google$protobuf.Empty> resumeTransferOperation(ServerContext ctx, ResumeTransferOperationRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'GetGoogleServiceAccount': return new GetGoogleServiceAccountRequest();
      case 'CreateTransferJob': return new CreateTransferJobRequest();
      case 'UpdateTransferJob': return new UpdateTransferJobRequest();
      case 'GetTransferJob': return new GetTransferJobRequest();
      case 'ListTransferJobs': return new ListTransferJobsRequest();
      case 'PauseTransferOperation': return new PauseTransferOperationRequest();
      case 'ResumeTransferOperation': return new ResumeTransferOperationRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'GetGoogleServiceAccount': return this.getGoogleServiceAccount(ctx, request);
      case 'CreateTransferJob': return this.createTransferJob(ctx, request);
      case 'UpdateTransferJob': return this.updateTransferJob(ctx, request);
      case 'GetTransferJob': return this.getTransferJob(ctx, request);
      case 'ListTransferJobs': return this.listTransferJobs(ctx, request);
      case 'PauseTransferOperation': return this.pauseTransferOperation(ctx, request);
      case 'ResumeTransferOperation': return this.resumeTransferOperation(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => StorageTransferService$json;
  Map<String, dynamic> get $messageJson => StorageTransferService$messageJson;
}

