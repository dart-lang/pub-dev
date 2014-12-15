// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library modules_impl;

import 'dart:async';

import 'package:appengine/api/modules.dart';

import '../appengine_context.dart';

import '../../api/errors.dart' as errors;
import '../protobuf_api/modules_service.dart';
import '../protobuf_api/rpc/rpc_service.dart';
import '../protobuf_api/internal/modules_service.pb.dart' as pb;

class ModulesRpcImpl extends ModulesService {
  final ModulesServiceClientRPCStub _clientRPCStub;
  final AppengineContext _appengineContext;

  buildModulesException(RpcApplicationError error) {
    var errorCode = pb.ModulesServiceError_ErrorCode.valueOf(error.code);
    switch (errorCode) {
      case pb.ModulesServiceError_ErrorCode.INVALID_MODULE:
        return new errors.ApplicationError(
            "Modules error: Invalid module.");
      case pb.ModulesServiceError_ErrorCode.INVALID_VERSION:
        return new errors.ApplicationError(
            "Modules error: Invalid version.");
      case pb.ModulesServiceError_ErrorCode.INVALID_INSTANCES:
        return new errors.ApplicationError(
            "Modules error: Invalid instance.");
      case pb.ModulesServiceError_ErrorCode.TRANSIENT_ERROR:
        return new errors.ApplicationError(
            "Modules error: Transient error.");
      case pb.ModulesServiceError_ErrorCode.UNEXPECTED_STATE:
        return new errors.ApplicationError(
            "Modules error: Unexpected state.");
      default:
        return error;
    }
  }

  ModulesRpcImpl(RPCService rpcService,
                 AppengineContext this._appengineContext,
                 String ticket)
      : _clientRPCStub = new ModulesServiceClientRPCStub(rpcService, ticket) {
  }

  String get currentModule {
    return _appengineContext.module;
  }

  String get currentVersion {
    return _appengineContext.version;
  }

  String get currentInstance {
    return _appengineContext.instance;
  }

  Future<String> defaultVersion(String module) {
    var request = new pb.GetDefaultVersionRequest();
    request..module = module;
    return _clientRPCStub.GetDefaultVersion(request)
        .then((response) => response.version)
        .catchError((RpcApplicationError error) {
          throw buildModulesException(error);
        }, test: (error) => error is RpcApplicationError);
  }

  Future<List<String>> modules() {
    var request = new pb.GetModulesRequest();
    return _clientRPCStub.GetModules(request)
        .then((response) => response.module)
        .catchError((RpcApplicationError error) {
          throw buildModulesException(error);
        }, test: (error) => error is RpcApplicationError);
  }

  Future<List<String>> versions(String module) {
    var request = new pb.GetVersionsRequest();
    request.module = module;
    return _clientRPCStub.GetVersions(request)
        .then((response) => response.version)
        .catchError((RpcApplicationError error) {
          throw buildModulesException(error);
        }, test: (error) => error is RpcApplicationError);
  }

  Future<String> hostname([String module, String version, String instance]) {
    // Maps double-wildcard domains hosted at appspot.com as Google is
    // issuing certificates for SSL certificates for double-wildcard
    // domains hosted at appspot.com (i.e. *.*.appspot.com).
    //
    // It performs mapping like this:
    //
    //   project.appspot.com -> project.appspot.com
    //   version.project.appspot.com -> version-dot-project.appspot.com
    //   version.module.project.appspot.com ->
    //       version-dot-module-dot-project.appspot.com
    String mapHostname(String hostname) {
      const appSpotDotCom = '.appspot.com';
      if (hostname.endsWith(appSpotDotCom)) {
        var lastDotindex = hostname.length - appSpotDotCom.length;
        if (hostname.indexOf('.') < lastDotindex) {
          return hostname.substring(0, lastDotindex)
              .split('.')
              .join('-dot-')
              + appSpotDotCom;
        }
      }
      return hostname;
    }
    var request = new pb.GetHostnameRequest();
    if (module != null) {
      request.module = module;
    }
    if (version != null) {
      request.version = version;
    }
    if (instance != null) {
      request.instance = instance;
    }
    return _clientRPCStub.GetHostname(request)
        .then((response) => mapHostname(response.hostname))
        .catchError((RpcApplicationError error) {
          throw buildModulesException(error);
        }, test: (error) => error is RpcApplicationError);
  }
}
