// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart';
import 'package:pub_dev/frontend/handlers/experimental.dart';
import 'package:pub_dev/frontend/request_context.dart';
import 'package:pub_dev/service/image_proxy/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/markdown.dart';
import 'package:test/test.dart';

void main() {
  test('images are proxied when experiment is enabled', () async {
    final config = Configuration.test(
      primarySiteUri: Uri.parse('https://pub.dev/'),
      imageProxyServiceBaseUrl: 'https://proxy.pub.dev',
    );

    await fork(() async {
      registerActiveConfiguration(config);
      registerRequestContext(
        RequestContext(experimentalFlags: ExperimentalFlags({'image-proxy'})),
      );
      registerImageProxyBackend(_FakeImageProxyBackend());

      final html = markdownToHtml('![text](https://example.com/image.png)');
      expect(
        html,
        contains(
          'src="https://proxy.pub.dev/proxied/https%3A%2F%2Fexample.com%2Fimage.png"',
        ),
      );
    });
  });

  test('images on known properties are NOT proxied', () async {
    final config = Configuration.test(
      primarySiteUri: Uri.parse('https://pub.dev/'),
      imageProxyServiceBaseUrl: 'https://proxy.pub.dev',
    );

    await fork(() async {
      registerActiveConfiguration(config);
      registerRequestContext(
        RequestContext(experimentalFlags: ExperimentalFlags({'image-proxy'})),
      );
      registerImageProxyBackend(_FakeImageProxyBackend());

      for (final host in [
        'api.dart.dev',
        'api.flutter.dev',
        'dart.dev',
        'flutter.dev',
        'pub.dev',
      ]) {
        final url = 'https://$host/image.png';
        final html = markdownToHtml('![text]($url)');
        expect(html, contains('src="$url"'));
        expect(html, isNot(contains('https://proxy.pub.dev/proxied/')));
      }
    });
  });

  test('images are NOT proxied when experiment is disabled', () async {
    final config = Configuration.test(
      primarySiteUri: Uri.parse('https://pub.dev/'),
      imageProxyServiceBaseUrl: 'https://proxy.pub.dev',
    );

    await fork(() async {
      registerActiveConfiguration(config);
      registerRequestContext(
        RequestContext(experimentalFlags: ExperimentalFlags.empty),
      );
      registerImageProxyBackend(_FakeImageProxyBackend());

      final html = markdownToHtml('![text](https://example.com/image.png)');
      expect(html, contains('src="https://example.com/image.png"'));
    });
  });

  test('image tag is removed if proxying fails', () async {
    final config = Configuration.test(
      primarySiteUri: Uri.parse('https://pub.dev/'),
      imageProxyServiceBaseUrl: 'https://proxy.pub.dev',
    );

    await fork(() async {
      registerActiveConfiguration(config);
      registerRequestContext(
        RequestContext(experimentalFlags: ExperimentalFlags({'image-proxy'})),
      );
      registerImageProxyBackend(_NullImageProxyBackend());

      final html = markdownToHtml('![text](https://example.com/image.png)');
      expect(html, isNot(contains('<img')));
      expect(html, isNot(contains('https://example.com/image.png')));
    });
  });

  test('image tag is removed if it has an invalid URL', () async {
    final config = Configuration.test(
      primarySiteUri: Uri.parse('https://pub.dev/'),
      imageProxyServiceBaseUrl: 'https://proxy.pub.dev',
    );

    await fork(() async {
      registerActiveConfiguration(config);
      registerRequestContext(
        RequestContext(experimentalFlags: ExperimentalFlags({'image-proxy'})),
      );
      registerImageProxyBackend(_FakeImageProxyBackend());

      final html = markdownToHtml('![text](ftp://example.com/image.png)');
      expect(html, isNot(contains('<img')));
      expect(html, isNot(contains('ftp://example.com/image.png')));
    });
  });
}

class _FakeImageProxyBackend implements ImageProxyBackend {
  @override
  String? imageProxyUrl(Uri originalUrl) {
    return 'https://proxy.pub.dev/proxied/${Uri.encodeComponent(originalUrl.toString())}';
  }
}

class _NullImageProxyBackend implements ImageProxyBackend {
  @override
  String? imageProxyUrl(Uri originalUrl) => null;
}
