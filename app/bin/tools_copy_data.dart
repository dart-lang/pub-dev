// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis_auth/auth_io.dart' as auth;

import 'package:appengine/src/grpc_api_impl/auth_utils.dart' as auth_utils;
import 'package:appengine/src/grpc_api_impl/datastore_impl.dart'
    as grpc_datastore_impl;
import 'package:appengine/src/grpc_api_impl/grpc.dart' as grpc;

import 'package:pub_dartlang_org/models.dart';

Future main(List<String> args) async {
  if (args.length != 4) {
    print('Usage: ${Platform.executable} ${Platform.script} '
        '<from-project> <from-service-account-key.json> '
        '<to-project> <to-service-account-key.json>');
    exit(1);
  }

  final fromProject = args[0];
  final fromKey = readKey(args[1]);

  final toProject = args[2];
  final toKey = readKey(args[3]);

  if (toProject == 'dartlang-pub') {
    print('ERROR: We do not support copying data to the production datastore.');
    exit(1);
  }

  await ss.fork(() async {
    final from = await obtainDatastoreService(fromProject, fromKey);
    final to = await obtainDatastoreService(toProject, toKey);
    await migrate(from, to);
  });
  print('--done');
}

Future migrate(db.DatastoreDB from, db.DatastoreDB to) async {
  final List<db.Model> entities = [];

  Future flush({bool force: false}) async {
    if (force || entities.length >= 10) {
      print('Committing ${entities.length} entities.');
      await to.commit(inserts: entities);
      entities.clear();
    }
  }

  // Write [Package]s.
  await for (final Package p in from.query(Package).run()) {
    print('Enquqing package ${p.name}');
    entities.add(p);
    await flush();
  }
  await flush(force: true);

  // Write [PackageVersion]s.
  await for (final PackageVersion pv in from.query(PackageVersion).run()) {
    print('Enquqing package ${pv.key.parent.id} version ${pv.key.id}');
    entities.add(pv);
    await flush();
  }
  await flush(force: true);

  // Write [PrivateKey]s.
  await for (final PrivateKey pk in from.query(PrivateKey).run()) {
    if (pk.key.id == 'singleton') {
      print('Enqueueing key ${pk.key.id}');
      entities.add(pk);
      await flush();
    }
  }
  await flush(force: true);
}

auth.ServiceAccountCredentials readKey(String path) {
  final json = new File(path).readAsStringSync();
  return new auth.ServiceAccountCredentials.fromJson(json);
}

Future<db.DatastoreDB> obtainDatastoreService(
    String projectId, auth.ServiceAccountCredentials serviceAccount) async {
  final grpcClient = await getGrpcClient(serviceAccount,
      'https://datastore.googleapis.com', grpc_datastore_impl.OAuth2Scopes);
  ss.registerScopeExitCallback(grpcClient.close);
  final rawDatastore =
      new grpc_datastore_impl.GrpcDatastoreImpl(grpcClient, projectId);
  return new db.DatastoreDB(rawDatastore, modelDB: new db.ModelDBImpl());
}

Future<grpc.Client> getGrpcClient(auth.ServiceAccountCredentials serviceAccount,
    String url, List<String> scopes) async {
  final accessTokenProvider =
      new auth_utils.ServiceAccountTokenProvider(serviceAccount, scopes);
  ss.registerScopeExitCallback(accessTokenProvider.close);
  final client = await grpc.connectToEndpoint(Uri.parse(url),
      accessTokenProvider: accessTokenProvider, timeout: 20);
  ss.registerScopeExitCallback(client.close);
  return client;
}
