// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:unittest/unittest.dart';

import 'package:appengine/api/errors.dart';
import 'package:appengine/src/api_impl/modules_impl.dart';
import 'package:appengine/src/protobuf_api/rpc/rpc_service.dart';
import 'package:appengine/src/appengine_context.dart';
import 'package:appengine/src/protobuf_api/internal/'
       'modules_service.pb.dart' as pb;

import 'utils/mock_rpc.dart';
import 'utils/error_matchers.dart';

main() {
  const INVALID_PROTOBUF = const [1, 2, 3, 4, 5];

  group('modules', () {
    test('current', () {
      var mock = new MockRPCService('modules');
      var context = new AppengineContext(
          'dev', 'application', 'version', 'module', 'instance', null);
      var modules = new ModulesRpcImpl(mock, context, '');
      expect(modules.currentModule, 'module');
      expect(modules.currentVersion, 'version');
      expect(modules.currentInstance, 'instance');
    });

    test('default-version', () {
      var mock = new MockRPCService('modules');
      var context = new AppengineContext(
          'dev', 'application', 'version', null, null, null);
      var modules = new ModulesRpcImpl(mock, context, '');

      // Tests NetworkError.
      mock.register('GetDefaultVersion',
                    pb.GetDefaultVersionRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(modules.defaultVersion('module'), throwsA(isNetworkError));

      // Tests ProtocolError.
      mock.register('GetDefaultVersion',
                    pb.GetDefaultVersionRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(modules.defaultVersion('module'), throwsA(isProtocolError));

      // Tests ApplicationError.
      mock.register('GetDefaultVersion',
                    pb.GetDefaultVersionRequest, expectAsync((request) {
        return new Future.error(new RpcApplicationError(
            pb.ModulesServiceError_ErrorCode.INVALID_MODULE.value, 'foobar'));
      }));
      expect(modules.defaultVersion('module'),
             throwsA(isAppEngineApplicationError));

      mock.register('GetDefaultVersion',
                    pb.GetDefaultVersionRequest, expectAsync((request) {
        expect(request.module, 'module');
        var response = new pb.GetDefaultVersionResponse();
        response.version = 'default';
        return new Future.value(response.writeToBuffer());
      }));
      expect(modules.defaultVersion('module'), completion('default'));
    });

    test('modules', () {
      var mock = new MockRPCService('modules');
      var context = new AppengineContext(
          'dev', 'application', 'version', null, null, null);
      var modules = new ModulesRpcImpl(mock, context, '');

      // Tests NetworkError.
      mock.register('GetModules',
                    pb.GetDefaultVersionRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(modules.modules(), throwsA(isNetworkError));

      // Tests ProtocolError.
      mock.register('GetModules',
                    pb.GetDefaultVersionRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(modules.modules(), throwsA(isProtocolError));

      // Tests ApplicationError.
      mock.register('GetModules',
                    pb.GetDefaultVersionRequest, expectAsync((request) {
        return new Future.error(new RpcApplicationError(
            pb.ModulesServiceError_ErrorCode.INVALID_MODULE.value, 'foobar'));
      }));
      expect(modules.modules(), throwsA(isAppEngineApplicationError));

      mock.register('GetModules', pb.GetModulesRequest, expectAsync((request) {
        var response = new pb.GetModulesResponse();
        response.module.add('module1');
        response.module.add('module2');
        return new Future.value(response.writeToBuffer());
      }));
      expect(modules.modules(), completion(['module1', 'module2']));
    });

    test('versions', () {
      var mock = new MockRPCService('modules');
      var context = new AppengineContext(
          'dev', 'application', 'version', null, null, null);
      var modules = new ModulesRpcImpl(mock, context, '');

      // Tests NetworkError.
      mock.register('GetVersions',
                    pb.GetVersionsRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(modules.versions('module'), throwsA(isNetworkError));

      // Tests ProtocolError.
      mock.register('GetVersions',
                    pb.GetVersionsRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(modules.versions('module'), throwsA(isProtocolError));

      // Tests ApplicationError.
      mock.register('GetVersions',
                    pb.GetDefaultVersionRequest, expectAsync((request) {
        return new Future.error(new RpcApplicationError(
            pb.ModulesServiceError_ErrorCode.INVALID_MODULE.value, 'foobar'));
      }));
      expect(modules.versions('module'), throwsA(isAppEngineApplicationError));

      mock.register('GetVersions',
                    pb.GetVersionsRequest, expectAsync((request) {
        expect(request.module, 'module');
        var response = new pb.GetVersionsResponse();
        response.version.add('version1');
        response.version.add('version2');
        return new Future.value(response.writeToBuffer());
      }));
      expect(modules.versions('module'), completion(['version1', 'version2']));
    });

    test('hostname', () {
      var mock = new MockRPCService('modules');
      var context = new AppengineContext(
          'dev', 'application', 'version', null, null, null);
      var modules = new ModulesRpcImpl(mock, context, '');

      // Tests NetworkError.
      mock.register('GetHostname',
                    pb.GetHostnameRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(modules.hostname(), throwsA(isNetworkError));

      // Tests ProtocolError.
      mock.register('GetHostname',
                    pb.GetHostnameRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(modules.hostname(), throwsA(isProtocolError));

      // Tests ApplicationError.
      mock.register('GetHostname',
                    pb.GetDefaultVersionRequest, expectAsync((request) {
        return new Future.error(new RpcApplicationError(
            pb.ModulesServiceError_ErrorCode.INVALID_MODULE.value, 'foobar'));
      }));
      expect(modules.hostname(), throwsA(isAppEngineApplicationError));

      var count = 0;
      mock.register('GetHostname',
                    pb.GetHostnameRequest, expectAsync((request) {
        switch (count++) {
          case 0:
            expect(request.hasModule(), isFalse);
            expect(request.hasVersion(), isFalse);
            expect(request.hasInstance(), isFalse);
            break;
          case 1:
            expect(request.module, 'module');
            expect(request.hasVersion(), isFalse);
            expect(request.hasInstance(), isFalse);
            break;
          case 2:
            expect(request.module, 'module');
            expect(request.version, 'version');
            expect(request.hasInstance(), isFalse);
            break;
          case 3:
            expect(request.module, 'module');
            expect(request.version, 'version');
            expect(request.instance, 'instance');
            break;
          default:
            throw new UnsupportedError('Unreachable');
        }
        var response = new pb.GetHostnameResponse();
        response.hostname = 'hostname';
        return new Future.value(response.writeToBuffer());
      }, count: 4));
      expect(modules.hostname(), completion('hostname'));
      expect(modules.hostname('module'), completion('hostname'));
      expect(modules.hostname('module', 'version'), completion('hostname'));
      expect(modules.hostname('module', 'version', 'instance'),
             completion('hostname'));

      count = 0;
      var hostnames = [
          'project.appspot.com',
          'version.project.appspot.com',
          'version.module.project.appspot.com',
          'instance.version.module.project.appspot.com'
      ];

      var mappedHostnames = [
          'project.appspot.com',
          'version-dot-project.appspot.com',
          'version-dot-module-dot-project.appspot.com',
          'instance-dot-version-dot-module-dot-project.appspot.com'
      ];

      mock.register('GetHostname',
                    pb.GetHostnameRequest, expectAsync((request) {
        var response = new pb.GetHostnameResponse();
        response.hostname = hostnames[count++];
        print(response.hostname);
        return new Future.value(response.writeToBuffer());
      }, count: hostnames.length));
      Future.forEach(mappedHostnames, expectAsync((expected) {
        return modules.hostname().then((hostname) {
          expect(hostname, expected);
        });
      }, count: mappedHostnames.length));
    });
  });
}
