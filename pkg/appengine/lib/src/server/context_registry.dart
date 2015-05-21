// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.context_registry;

import 'dart:async';

import 'package:memcache/memcache.dart' as memcache;
import 'package:memcache/src/memcache_impl.dart' as memcache_impl;
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/storage.dart' as storage;

import 'http_wrapper.dart';
import 'assets.dart';

import '../../appengine.dart';
import '../appengine_context.dart';
import '../protobuf_api/rpc/rpc_service.dart';
import '../api_impl/logging_impl.dart' as logging_impl;
import '../api_impl/modules_impl.dart' as modules_impl;
import '../api_impl/raw_memcache_impl.dart' as raw_memcache_impl;
import '../api_impl/remote_api_impl.dart' as remote_api_impl;
import '../api_impl/raw_datastore_v3_impl.dart' as raw_datastore_v3_impl;
import '../api_impl/users_impl.dart' as users_impl;

class ContextRegistry {
  static const HTTP_HEADER_APPENGINE_TICKET = 'x-appengine-api-ticket';
  static const HTTP_HEADER_DEVAPPSERVER_REQUEST_ID =
      'x-appengine-dev-request-id';

  final RPCService _rpcService;
  final storage.Storage _storage;
  final AppengineContext _appengineContext;
  final Map<AppengineHttpRequest, ClientContext> _request2context = {};
  db.ModelDB _modelDB;

  ContextRegistry(this._rpcService, this._storage, this._appengineContext) {
    // TODO: We should provide an API to allow users providing us with either a
    // different [ModelDB] object or specify a list of libraries to scan for
    // models.
    _modelDB = new db.ModelDBImpl();
  }

  ClientContext add(AppengineHttpRequest request) {
    var ticket = request.headers.value(HTTP_HEADER_APPENGINE_TICKET);
    if (ticket == null) {
      ticket = request.headers.value(HTTP_HEADER_DEVAPPSERVER_REQUEST_ID);
      if (ticket == null) {
        ticket = 'invalid-ticket';
      }
    }
    var services = _getServices(ticket, request);
    var assets = new AssetsImpl(request, _appengineContext);
    var context =
        new _ClientContextImpl(
            services, assets, _appengineContext.isDevelopmentEnvironment);
    _request2context[request] = context;

    request.response.registerHook(
        () => services.logging.flush().catchError((_) {}));

    return context;
  }

  ClientContext lookup(AppengineHttpRequest request) {
    return _request2context[request];
  }

  Future remove(AppengineHttpRequest request) {
    _request2context.remove(request);
    return new Future.value();
  }

  Services newBackgroundServices()
      => _getServices(_appengineContext.backgroundTicket, null);

  Services _getServices(String ticket, AppengineHttpRequest request) {
    var raw_memcache =
        new raw_memcache_impl.RawMemcacheRpcImpl(_rpcService, ticket);
    var serviceMap = {
      // Create a new logging instance for every request, but use the background
      // ticket, so we can flush logs at the end of the request.
      'logging': new logging_impl.LoggingRpcImpl(_rpcService, ticket),
      'raw_memcache': raw_memcache,
      'raw_datastore_v3' : new raw_datastore_v3_impl.DatastoreV3RpcImpl(
          _rpcService, _appengineContext, ticket),
      'remote_api' : new remote_api_impl.RemoteApiImpl(
          _rpcService, _appengineContext, ticket),
      'modules' : new modules_impl.ModulesRpcImpl(
          _rpcService, _appengineContext, ticket),
    };
    if (request != null) {
      serviceMap['users'] =
          new users_impl.UserRpcImpl(_rpcService, ticket, request);
    }
    serviceMap['memcache'] =
        new memcache_impl.MemCacheImpl(serviceMap['raw_memcache']);
    serviceMap['db'] =
        new db.DatastoreDB(serviceMap['raw_datastore_v3'], modelDB: _modelDB);
    serviceMap['storage'] = _storage;
    return new _ServicesImpl(serviceMap);
  }
}

class _ClientContextImpl implements ClientContext {
  final Services services;
  final Assets assets;
  final bool _isDevelopmentEnvironment;

  _ClientContextImpl(
      this.services, this.assets, this._isDevelopmentEnvironment);

  bool get isDevelopmentEnvironment => _isDevelopmentEnvironment;
  bool get isProductionEnvironment => !_isDevelopmentEnvironment;
}

class _ServicesImpl extends Services {
  // TODO:
  // - consider removing the map
  // - consider building the services on demand
  final Map<String, dynamic> _serviceMap;

  _ServicesImpl(this._serviceMap);

  db.DatastoreDB get db => _serviceMap['db'];

  storage.Storage get storage => _serviceMap['storage'];

  Logging get logging => _serviceMap['logging'];

  memcache.Memcache get memcache => _serviceMap['memcache'];

  ModulesService get modules => _serviceMap['modules'];

  RemoteApi get remoteApi => _serviceMap['remote_api'];

  UserService get users => _serviceMap['users'];
}
