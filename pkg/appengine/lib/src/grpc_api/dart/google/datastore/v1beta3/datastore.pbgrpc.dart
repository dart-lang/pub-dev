//
//  Generated code. Do not modify.
//  source: google/datastore/v1beta3/datastore.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'datastore.pb.dart' as $22;

export 'datastore.pb.dart';

@$pb.GrpcServiceName('google.datastore.v1beta3.Datastore')
class DatastoreClient extends $grpc.Client {
  static final _$lookup =
      $grpc.ClientMethod<$22.LookupRequest, $22.LookupResponse>(
          '/google.datastore.v1beta3.Datastore/Lookup',
          ($22.LookupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.LookupResponse.fromBuffer(value));
  static final _$runQuery =
      $grpc.ClientMethod<$22.RunQueryRequest, $22.RunQueryResponse>(
          '/google.datastore.v1beta3.Datastore/RunQuery',
          ($22.RunQueryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.RunQueryResponse.fromBuffer(value));
  static final _$beginTransaction = $grpc.ClientMethod<
          $22.BeginTransactionRequest, $22.BeginTransactionResponse>(
      '/google.datastore.v1beta3.Datastore/BeginTransaction',
      ($22.BeginTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.BeginTransactionResponse.fromBuffer(value));
  static final _$commit =
      $grpc.ClientMethod<$22.CommitRequest, $22.CommitResponse>(
          '/google.datastore.v1beta3.Datastore/Commit',
          ($22.CommitRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.CommitResponse.fromBuffer(value));
  static final _$rollback =
      $grpc.ClientMethod<$22.RollbackRequest, $22.RollbackResponse>(
          '/google.datastore.v1beta3.Datastore/Rollback',
          ($22.RollbackRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.RollbackResponse.fromBuffer(value));
  static final _$allocateIds =
      $grpc.ClientMethod<$22.AllocateIdsRequest, $22.AllocateIdsResponse>(
          '/google.datastore.v1beta3.Datastore/AllocateIds',
          ($22.AllocateIdsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.AllocateIdsResponse.fromBuffer(value));
  static final _$reserveIds =
      $grpc.ClientMethod<$22.ReserveIdsRequest, $22.ReserveIdsResponse>(
          '/google.datastore.v1beta3.Datastore/ReserveIds',
          ($22.ReserveIdsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.ReserveIdsResponse.fromBuffer(value));

  DatastoreClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$22.LookupResponse> lookup($22.LookupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookup, request, options: options);
  }

  $grpc.ResponseFuture<$22.RunQueryResponse> runQuery(
      $22.RunQueryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$runQuery, request, options: options);
  }

  $grpc.ResponseFuture<$22.BeginTransactionResponse> beginTransaction(
      $22.BeginTransactionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$beginTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$22.CommitResponse> commit($22.CommitRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$commit, request, options: options);
  }

  $grpc.ResponseFuture<$22.RollbackResponse> rollback(
      $22.RollbackRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$rollback, request, options: options);
  }

  $grpc.ResponseFuture<$22.AllocateIdsResponse> allocateIds(
      $22.AllocateIdsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$allocateIds, request, options: options);
  }

  $grpc.ResponseFuture<$22.ReserveIdsResponse> reserveIds(
      $22.ReserveIdsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reserveIds, request, options: options);
  }
}

@$pb.GrpcServiceName('google.datastore.v1beta3.Datastore')
abstract class DatastoreServiceBase extends $grpc.Service {
  $core.String get $name => 'google.datastore.v1beta3.Datastore';

  DatastoreServiceBase() {
    $addMethod($grpc.ServiceMethod<$22.LookupRequest, $22.LookupResponse>(
        'Lookup',
        lookup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.LookupRequest.fromBuffer(value),
        ($22.LookupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.RunQueryRequest, $22.RunQueryResponse>(
        'RunQuery',
        runQuery_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.RunQueryRequest.fromBuffer(value),
        ($22.RunQueryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.BeginTransactionRequest,
            $22.BeginTransactionResponse>(
        'BeginTransaction',
        beginTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.BeginTransactionRequest.fromBuffer(value),
        ($22.BeginTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.CommitRequest, $22.CommitResponse>(
        'Commit',
        commit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.CommitRequest.fromBuffer(value),
        ($22.CommitResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.RollbackRequest, $22.RollbackResponse>(
        'Rollback',
        rollback_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.RollbackRequest.fromBuffer(value),
        ($22.RollbackResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.AllocateIdsRequest, $22.AllocateIdsResponse>(
            'AllocateIds',
            allocateIds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.AllocateIdsRequest.fromBuffer(value),
            ($22.AllocateIdsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.ReserveIdsRequest, $22.ReserveIdsResponse>(
            'ReserveIds',
            reserveIds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.ReserveIdsRequest.fromBuffer(value),
            ($22.ReserveIdsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$22.LookupResponse> lookup_Pre(
      $grpc.ServiceCall call, $async.Future<$22.LookupRequest> request) async {
    return lookup(call, await request);
  }

  $async.Future<$22.RunQueryResponse> runQuery_Pre($grpc.ServiceCall call,
      $async.Future<$22.RunQueryRequest> request) async {
    return runQuery(call, await request);
  }

  $async.Future<$22.BeginTransactionResponse> beginTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.BeginTransactionRequest> request) async {
    return beginTransaction(call, await request);
  }

  $async.Future<$22.CommitResponse> commit_Pre(
      $grpc.ServiceCall call, $async.Future<$22.CommitRequest> request) async {
    return commit(call, await request);
  }

  $async.Future<$22.RollbackResponse> rollback_Pre($grpc.ServiceCall call,
      $async.Future<$22.RollbackRequest> request) async {
    return rollback(call, await request);
  }

  $async.Future<$22.AllocateIdsResponse> allocateIds_Pre($grpc.ServiceCall call,
      $async.Future<$22.AllocateIdsRequest> request) async {
    return allocateIds(call, await request);
  }

  $async.Future<$22.ReserveIdsResponse> reserveIds_Pre($grpc.ServiceCall call,
      $async.Future<$22.ReserveIdsRequest> request) async {
    return reserveIds(call, await request);
  }

  $async.Future<$22.LookupResponse> lookup(
      $grpc.ServiceCall call, $22.LookupRequest request);
  $async.Future<$22.RunQueryResponse> runQuery(
      $grpc.ServiceCall call, $22.RunQueryRequest request);
  $async.Future<$22.BeginTransactionResponse> beginTransaction(
      $grpc.ServiceCall call, $22.BeginTransactionRequest request);
  $async.Future<$22.CommitResponse> commit(
      $grpc.ServiceCall call, $22.CommitRequest request);
  $async.Future<$22.RollbackResponse> rollback(
      $grpc.ServiceCall call, $22.RollbackRequest request);
  $async.Future<$22.AllocateIdsResponse> allocateIds(
      $grpc.ServiceCall call, $22.AllocateIdsRequest request);
  $async.Future<$22.ReserveIdsResponse> reserveIds(
      $grpc.ServiceCall call, $22.ReserveIdsRequest request);
}
