//
//  Generated code. Do not modify.
//  source: google/datastore/v1/datastore.proto
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

import 'datastore.pb.dart' as $21;

export 'datastore.pb.dart';

@$pb.GrpcServiceName('google.datastore.v1.Datastore')
class DatastoreClient extends $grpc.Client {
  static final _$lookup =
      $grpc.ClientMethod<$21.LookupRequest, $21.LookupResponse>(
          '/google.datastore.v1.Datastore/Lookup',
          ($21.LookupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.LookupResponse.fromBuffer(value));
  static final _$runQuery =
      $grpc.ClientMethod<$21.RunQueryRequest, $21.RunQueryResponse>(
          '/google.datastore.v1.Datastore/RunQuery',
          ($21.RunQueryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.RunQueryResponse.fromBuffer(value));
  static final _$runAggregationQuery = $grpc.ClientMethod<
          $21.RunAggregationQueryRequest, $21.RunAggregationQueryResponse>(
      '/google.datastore.v1.Datastore/RunAggregationQuery',
      ($21.RunAggregationQueryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.RunAggregationQueryResponse.fromBuffer(value));
  static final _$beginTransaction = $grpc.ClientMethod<
          $21.BeginTransactionRequest, $21.BeginTransactionResponse>(
      '/google.datastore.v1.Datastore/BeginTransaction',
      ($21.BeginTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.BeginTransactionResponse.fromBuffer(value));
  static final _$commit =
      $grpc.ClientMethod<$21.CommitRequest, $21.CommitResponse>(
          '/google.datastore.v1.Datastore/Commit',
          ($21.CommitRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.CommitResponse.fromBuffer(value));
  static final _$rollback =
      $grpc.ClientMethod<$21.RollbackRequest, $21.RollbackResponse>(
          '/google.datastore.v1.Datastore/Rollback',
          ($21.RollbackRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.RollbackResponse.fromBuffer(value));
  static final _$allocateIds =
      $grpc.ClientMethod<$21.AllocateIdsRequest, $21.AllocateIdsResponse>(
          '/google.datastore.v1.Datastore/AllocateIds',
          ($21.AllocateIdsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.AllocateIdsResponse.fromBuffer(value));
  static final _$reserveIds =
      $grpc.ClientMethod<$21.ReserveIdsRequest, $21.ReserveIdsResponse>(
          '/google.datastore.v1.Datastore/ReserveIds',
          ($21.ReserveIdsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.ReserveIdsResponse.fromBuffer(value));

  DatastoreClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$21.LookupResponse> lookup($21.LookupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookup, request, options: options);
  }

  $grpc.ResponseFuture<$21.RunQueryResponse> runQuery(
      $21.RunQueryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$runQuery, request, options: options);
  }

  $grpc.ResponseFuture<$21.RunAggregationQueryResponse> runAggregationQuery(
      $21.RunAggregationQueryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$runAggregationQuery, request, options: options);
  }

  $grpc.ResponseFuture<$21.BeginTransactionResponse> beginTransaction(
      $21.BeginTransactionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$beginTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$21.CommitResponse> commit($21.CommitRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$commit, request, options: options);
  }

  $grpc.ResponseFuture<$21.RollbackResponse> rollback(
      $21.RollbackRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$rollback, request, options: options);
  }

  $grpc.ResponseFuture<$21.AllocateIdsResponse> allocateIds(
      $21.AllocateIdsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$allocateIds, request, options: options);
  }

  $grpc.ResponseFuture<$21.ReserveIdsResponse> reserveIds(
      $21.ReserveIdsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reserveIds, request, options: options);
  }
}

@$pb.GrpcServiceName('google.datastore.v1.Datastore')
abstract class DatastoreServiceBase extends $grpc.Service {
  $core.String get $name => 'google.datastore.v1.Datastore';

  DatastoreServiceBase() {
    $addMethod($grpc.ServiceMethod<$21.LookupRequest, $21.LookupResponse>(
        'Lookup',
        lookup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.LookupRequest.fromBuffer(value),
        ($21.LookupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.RunQueryRequest, $21.RunQueryResponse>(
        'RunQuery',
        runQuery_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.RunQueryRequest.fromBuffer(value),
        ($21.RunQueryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.RunAggregationQueryRequest,
            $21.RunAggregationQueryResponse>(
        'RunAggregationQuery',
        runAggregationQuery_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.RunAggregationQueryRequest.fromBuffer(value),
        ($21.RunAggregationQueryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.BeginTransactionRequest,
            $21.BeginTransactionResponse>(
        'BeginTransaction',
        beginTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.BeginTransactionRequest.fromBuffer(value),
        ($21.BeginTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.CommitRequest, $21.CommitResponse>(
        'Commit',
        commit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.CommitRequest.fromBuffer(value),
        ($21.CommitResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.RollbackRequest, $21.RollbackResponse>(
        'Rollback',
        rollback_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $21.RollbackRequest.fromBuffer(value),
        ($21.RollbackResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$21.AllocateIdsRequest, $21.AllocateIdsResponse>(
            'AllocateIds',
            allocateIds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.AllocateIdsRequest.fromBuffer(value),
            ($21.AllocateIdsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$21.ReserveIdsRequest, $21.ReserveIdsResponse>(
            'ReserveIds',
            reserveIds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $21.ReserveIdsRequest.fromBuffer(value),
            ($21.ReserveIdsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$21.LookupResponse> lookup_Pre(
      $grpc.ServiceCall call, $async.Future<$21.LookupRequest> request) async {
    return lookup(call, await request);
  }

  $async.Future<$21.RunQueryResponse> runQuery_Pre($grpc.ServiceCall call,
      $async.Future<$21.RunQueryRequest> request) async {
    return runQuery(call, await request);
  }

  $async.Future<$21.RunAggregationQueryResponse> runAggregationQuery_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.RunAggregationQueryRequest> request) async {
    return runAggregationQuery(call, await request);
  }

  $async.Future<$21.BeginTransactionResponse> beginTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.BeginTransactionRequest> request) async {
    return beginTransaction(call, await request);
  }

  $async.Future<$21.CommitResponse> commit_Pre(
      $grpc.ServiceCall call, $async.Future<$21.CommitRequest> request) async {
    return commit(call, await request);
  }

  $async.Future<$21.RollbackResponse> rollback_Pre($grpc.ServiceCall call,
      $async.Future<$21.RollbackRequest> request) async {
    return rollback(call, await request);
  }

  $async.Future<$21.AllocateIdsResponse> allocateIds_Pre($grpc.ServiceCall call,
      $async.Future<$21.AllocateIdsRequest> request) async {
    return allocateIds(call, await request);
  }

  $async.Future<$21.ReserveIdsResponse> reserveIds_Pre($grpc.ServiceCall call,
      $async.Future<$21.ReserveIdsRequest> request) async {
    return reserveIds(call, await request);
  }

  $async.Future<$21.LookupResponse> lookup(
      $grpc.ServiceCall call, $21.LookupRequest request);
  $async.Future<$21.RunQueryResponse> runQuery(
      $grpc.ServiceCall call, $21.RunQueryRequest request);
  $async.Future<$21.RunAggregationQueryResponse> runAggregationQuery(
      $grpc.ServiceCall call, $21.RunAggregationQueryRequest request);
  $async.Future<$21.BeginTransactionResponse> beginTransaction(
      $grpc.ServiceCall call, $21.BeginTransactionRequest request);
  $async.Future<$21.CommitResponse> commit(
      $grpc.ServiceCall call, $21.CommitRequest request);
  $async.Future<$21.RollbackResponse> rollback(
      $grpc.ServiceCall call, $21.RollbackRequest request);
  $async.Future<$21.AllocateIdsResponse> allocateIds(
      $grpc.ServiceCall call, $21.AllocateIdsRequest request);
  $async.Future<$21.ReserveIdsResponse> reserveIds(
      $grpc.ServiceCall call, $21.ReserveIdsRequest request);
}
