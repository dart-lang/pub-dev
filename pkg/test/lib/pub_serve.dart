// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:barback/barback.dart';
import 'package:path/path.dart' as p;

/// A transformer that injects bootstrapping code used by the test runner to run
/// tests against a "pub serve" instance.
///
/// This doesn't modify existing code at all, it just adds wrapper files that
/// can be used to load isolates or iframes.
class PubServeTransformer extends Transformer implements DeclaringTransformer {
  final allowedExtensions = ".dart";

  PubServeTransformer.asPlugin();

  void declareOutputs(DeclaringTransform transform) {
    var id = transform.primaryId;
    transform.declareOutput(id.addExtension('.vm_test.dart'));
    transform.declareOutput(id.addExtension('.browser_test.dart'));
    transform.declareOutput(id.addExtension('.node_test.dart'));
  }

  Future apply(Transform transform) async {
    var id = transform.primaryInput.id;

    transform
        .addOutput(new Asset.fromString(id.addExtension('.vm_test.dart'), '''
          import "dart:isolate";

          import "package:test/src/bootstrap/vm.dart";

          import "${p.url.basename(id.path)}" as test;

          void main(_, SendPort message) {
            internalBootstrapVmTest(() => test.main, message);
          }
        '''));

    transform.addOutput(
        new Asset.fromString(id.addExtension('.browser_test.dart'), '''
          import "package:test/src/bootstrap/browser.dart";

          import "${p.url.basename(id.path)}" as test;

          void main() {
            internalBootstrapBrowserTest(() => test.main);
          }
        '''));

    transform
        .addOutput(new Asset.fromString(id.addExtension('.node_test.dart'), '''
          import "package:test/src/bootstrap/node.dart";

          import "${p.url.basename(id.path)}" as test;

          void main() {
            internalBootstrapNodeTest(() => test.main);
          }
        '''));

    // If the user has their own HTML file for the test, let that take
    // precedence. Otherwise, create our own basic file.
    var htmlId = id.changeExtension('.html');
    if (await transform.hasInput(htmlId)) return;

    transform.addOutput(new Asset.fromString(htmlId, '''
          <!DOCTYPE html>
          <html>
          <head>
            <title>${HTML_ESCAPE.convert(id.path)} Test</title>
            <link rel="x-dart-test"
                  href="${HTML_ESCAPE.convert(p.url.basename(id.path))}">
            <script src="packages/test/dart.js"></script>
          </head>
          </html>
        '''));
  }
}
