// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/dartdoc/dartdoc_page.dart';
import 'package:pub_dev/frontend/handlers/experimental.dart';
import 'package:pub_dev/frontend/request_context.dart';
import 'package:pub_dev/service/image_proxy/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';

import '../shared/utils.dart';

void main() {
  scopedTest('dartdoc images are proxied with imageProxyNonce', () async {
    final config = Configuration.test(
      primarySiteUri: Uri.parse('https://pub.dev/'),
      imageProxyServiceBaseUrl: 'https://proxy.pub.dev',
    );

    registerActiveConfiguration(config);
    registerRequestContext(
      RequestContext(experimentalFlags: ExperimentalFlags({'image-proxy'})),
    );
    registerImageProxyBackend(_FakeImageProxyBackend());

    final imageProxyNonce = '1234567890abcdef1234567890abcdef';
    final sidebar = DartDocSidebar(
      content:
          '<img src="https://pub.dev/img/image-proxy-placeholder.png#{{$imageProxyNonce:https%3A%2F%2Fexample.com%2Fimage.png}}">',
      imageProxyNonce: imageProxyNonce,
    );
    final rendered = sidebar.render();
    expect(
      rendered,
      contains(
        'src="https://proxy.pub.dev/proxied/https%3A%2F%2Fexample.com%2Fimage.png"',
      ),
    );
  });

  scopedTest('normal double curlies are preserved', () async {
    registerActiveConfiguration(Configuration.test());
    registerRequestContext(
      RequestContext(experimentalFlags: ExperimentalFlags.empty),
    );

    final sidebar = DartDocSidebar(
      content: '<p>Some text with {{marker}} and }} and {{.</p>',
      imageProxyNonce: 'imageProxyNonce',
    );
    expect(sidebar.render(), contains('{{marker}} and }} and {{'));
  });

  scopedTest('dartdoc images use original URL if proxy is disabled', () async {
    final config = Configuration.test(
      primarySiteUri: Uri.parse('https://pub.dev/'),
      imageProxyServiceBaseUrl: 'https://proxy.pub.dev',
    );

    registerActiveConfiguration(config);
    registerRequestContext(
      RequestContext(experimentalFlags: ExperimentalFlags.empty),
    );
    registerImageProxyBackend(_FakeImageProxyBackend());

    final imageProxyNonce = 'imageProxyNonce';
    final sidebar = DartDocSidebar(
      content:
          '<img src="https://pub.dev/img/image-proxy-placeholder.png#{{$imageProxyNonce:https%3A%2F%2Fexample.com%2Fimage.png}}">',
      imageProxyNonce: imageProxyNonce,
    );
    final rendered = sidebar.render();
    expect(rendered, contains('src="https://example.com/image.png"'));
  });
}

class _FakeImageProxyBackend implements ImageProxyBackend {
  @override
  String? imageProxyUrl(Uri originalUrl) {
    return 'https://proxy.pub.dev/proxied/${Uri.encodeComponent(originalUrl.toString())}';
  }

  @override
  Future<void> close() async {}
}
