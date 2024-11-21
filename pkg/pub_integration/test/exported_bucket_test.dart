// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:test/test.dart';

void main() {
  group(
    'exported bucket works with pub get',
    () {
      late final TestContextProvider fakeTestScenario;
      final httpClient = http.Client();
      late final Directory temp;
      late final HttpServer proxy;

      setUpAll(() async {
        fakeTestScenario = await TestContextProvider.start();
        temp = await Directory.systemTemp.createTemp('exported-bucket');

        final pubUri = Uri.parse(fakeTestScenario.pubHostedUrl);
        final storageUri = pubUri.replace(
            port: pubUri.port + 1, path: '/fake-exported-apis/latest');

        // read-only proxy server with minimal content rewrite
        proxy = await shelf_io.serve((rq) async {
          try {
            // the proxy url with the appropriate path prefix
            final proxyUri = storageUri.replace(pathSegments: [
              ...storageUri.pathSegments,
              ...rq.requestedUri.pathSegments
            ]);

            // archive files are served from the storage bucket directly
            if (rq.requestedUri.path.endsWith('tar.gz')) {
              return shelf.Response.seeOther(proxyUri);
            }

            // other requests are proxied
            final rs = await http.get(proxyUri);

            Map<String, String> copyHeaders(List<String> keys) {
              return Map.fromEntries(
                  rs.headers.entries.where((e) => keys.contains(e.key)));
            }

            // package listing requests need content rewrite (+ keeping the condition broad for future JSON APIs)
            if (rs.statusCode == 200 &&
                rq.requestedUri.toString().contains('/api/packages/')) {
              return shelf.Response(
                rs.statusCode,
                body: rs.body.replaceAll(
                    pubUri.toString(), 'http://localhost:${proxy.port}'),
                headers: copyHeaders(['content-type']),
              );
            }

            // otherwise return the result as-is
            return shelf.Response(
              rs.statusCode,
              body: rs.bodyBytes,
              headers: copyHeaders(['content-type', 'content-encoding']),
            );
          } catch (e, st) {
            print(e);
            print(st);
            return shelf.Response.internalServerError();
          }
        }, InternetAddress.loopbackIPv4, 0);
      });

      tearDownAll(() async {
        await proxy.close();
        await temp.delete(recursive: true);
        await fakeTestScenario.close();
        httpClient.close();
      });

      test('bulk tests', () async {
        final origin = fakeTestScenario.pubHostedUrl;
        // init server data
        await httpClient.post(
          Uri.parse('$origin/fake-test-profile'),
          body: json.encode(
            {
              'testProfile': {
                'defaultUser': 'admin@pub.dev',
                'packages': [
                  {
                    'name': 'exported_api_pkg',
                    'versions': [
                      {'version': '1.0.0'},
                      {'version': '1.0.2-dev+2'},
                    ],
                  },
                ],
              },
            },
          ),
        );

        // create a local project with dependency on exported_api_pkg:1.0.2-dev+2
        final pubspec = File(p.join(temp.path, 'pubspec.yaml'));
        await pubspec.writeAsString(json.encode({
          'name': 'test_pkg',
          'environment': {
            'sdk': '>=3.0.0 <4.0.0',
          },
          'dependencies': {
            'exported_api_pkg': '^1.0.1',
          },
        }));

        // run pub get and verify its success
        final pr = await Process.run(
          'dart',
          ['pub', 'get', '-v'],
          environment: {'PUB_HOSTED_URL': 'http://localhost:${proxy.port}'},
          workingDirectory: temp.path,
        );
        expect(pr.exitCode, 0, reason: [pr.stdout, pr.stderr].join('\n'));

        final resolvedFile =
            File(p.join(temp.path, '.dart_tool', 'package_config.json'));
        expect(resolvedFile.existsSync(), true);
      });
    },
    timeout: Timeout.factor(testTimeoutFactor),
  );
}
