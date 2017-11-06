///
//  Generated code. Do not modify.
///
library google.spanner.v1_spanner_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'spanner.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'result_set.pb.dart';
import 'transaction.pb.dart';
import 'spanner.pbjson.dart';

export 'spanner.pb.dart';

abstract class SpannerServiceBase extends GeneratedService {
  Future<Session> createSession(ServerContext ctx, CreateSessionRequest request);
  Future<Session> getSession(ServerContext ctx, GetSessionRequest request);
  Future<google$protobuf.Empty> deleteSession(ServerContext ctx, DeleteSessionRequest request);
  Future<ResultSet> executeSql(ServerContext ctx, ExecuteSqlRequest request);
  Future<PartialResultSet> executeStreamingSql(ServerContext ctx, ExecuteSqlRequest request);
  Future<ResultSet> read(ServerContext ctx, ReadRequest request);
  Future<PartialResultSet> streamingRead(ServerContext ctx, ReadRequest request);
  Future<Transaction> beginTransaction(ServerContext ctx, BeginTransactionRequest request);
  Future<CommitResponse> commit(ServerContext ctx, CommitRequest request);
  Future<google$protobuf.Empty> rollback(ServerContext ctx, RollbackRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'CreateSession': return new CreateSessionRequest();
      case 'GetSession': return new GetSessionRequest();
      case 'DeleteSession': return new DeleteSessionRequest();
      case 'ExecuteSql': return new ExecuteSqlRequest();
      case 'ExecuteStreamingSql': return new ExecuteSqlRequest();
      case 'Read': return new ReadRequest();
      case 'StreamingRead': return new ReadRequest();
      case 'BeginTransaction': return new BeginTransactionRequest();
      case 'Commit': return new CommitRequest();
      case 'Rollback': return new RollbackRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'CreateSession': return this.createSession(ctx, request);
      case 'GetSession': return this.getSession(ctx, request);
      case 'DeleteSession': return this.deleteSession(ctx, request);
      case 'ExecuteSql': return this.executeSql(ctx, request);
      case 'ExecuteStreamingSql': return this.executeStreamingSql(ctx, request);
      case 'Read': return this.read(ctx, request);
      case 'StreamingRead': return this.streamingRead(ctx, request);
      case 'BeginTransaction': return this.beginTransaction(ctx, request);
      case 'Commit': return this.commit(ctx, request);
      case 'Rollback': return this.rollback(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Spanner$json;
  Map<String, dynamic> get $messageJson => Spanner$messageJson;
}

