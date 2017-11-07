///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_job_service_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'job_service.pb.dart';
import '../../../protobuf/empty.pb.dart' as google$protobuf;
import 'job_service.pbjson.dart';

export 'job_service.pb.dart';

abstract class JobServiceBase extends GeneratedService {
  Future<Job> createJob(ServerContext ctx, CreateJobRequest request);
  Future<ListJobsResponse> listJobs(ServerContext ctx, ListJobsRequest request);
  Future<Job> getJob(ServerContext ctx, GetJobRequest request);
  Future<google$protobuf.Empty> cancelJob(ServerContext ctx, CancelJobRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'CreateJob': return new CreateJobRequest();
      case 'ListJobs': return new ListJobsRequest();
      case 'GetJob': return new GetJobRequest();
      case 'CancelJob': return new CancelJobRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'CreateJob': return this.createJob(ctx, request);
      case 'ListJobs': return this.listJobs(ctx, request);
      case 'GetJob': return this.getJob(ctx, request);
      case 'CancelJob': return this.cancelJob(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => JobService$json;
  Map<String, dynamic> get $messageJson => JobService$messageJson;
}

