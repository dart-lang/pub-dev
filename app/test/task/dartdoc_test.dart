import 'dart:io';

import 'package:_pub_shared/validation/html/html_validation.dart';
import 'package:collection/collection.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show HtmlParser;
import 'package:pub_dev/frontend/handlers/experimental.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/cloudcompute/fakecloudcompute.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart' as xml;

import '../frontend/handlers/_utils.dart';
import '../shared/test_services.dart';

const String goldenDir = 'test/task/testdata/goldens';

// TODO: generalize golden testing, use env var for regenerating all goldens.
final _regenerateGoldens = false;

/// Get hold of the [FakeCloudCompute]
FakeCloudCompute get cloud => taskWorkerCloudCompute as FakeCloudCompute;

// We use a small test profile without flutter packages, because we have to
// run pana+dartdoc for all these package versions, naturally this is slow.
// But we get great end-to-end test coverage.
//
// Using flutter packages will require us to have all packages that flutter
// depends on, so that would be huge set and that want to avoid.
final _dartdocTestProfile = TestProfile(
  defaultUser: 'admin@pub.dev',
  packages: [
    TestPackage(
      name: 'oxygen',
      versions: [
        TestVersion(version: '1.0.0'),
        TestVersion(version: '2.0.0'),
      ],
    ),
  ],
  users: [TestUser(email: 'admin@pub.dev', likes: [])],
);

void main() {
  testWithProfile('dartdoc for oxygen', testProfile: _dartdocTestProfile,
      fn: () async {
    // Backfill tracking state
    await taskBackend.backfillTrackingState();

    /// Start instance execution
    cloud.startInstanceExecution();

    // Start listening for instances, before we create any. This avoids any
    // race conditions.
    final instancesCreated = cloud.onCreated.take(1).toList();
    final instancesDeleted = cloud.onDeleted.take(1).toList();

    // Start the taskbackend, this will scheduled instances and track state
    // driving scheduling.
    await taskBackend.start();

    // Wait for instances to be created.
    await instancesCreated;

    // Wait for instances to be deleted, this indicates that they are done
    // doing whatever work they planned to do.
    await instancesDeleted;

    // Make assertions about generated documentation
    final doc = await _fetchHtmlDocument(
      '/documentation/oxygen/latest/oxygen/oxygen-library.html',
    );
    // Check that .self-crumb made it through
    expect(doc.querySelector('.self-crumb')!.text, contains('oxygen'));
    // Check that we don't have noindex on /latest/
    expect(
      doc.querySelectorAll('meta').where((m) =>
          m.attributes['name'] == 'robots' &&
          m.attributes['content'] == 'noindex'),
      isEmpty,
    );

    // Travese all generated documentation and create golden files
    await _traveseLinksUnderPath(
      seed: ['/documentation/oxygen/latest/', '/documentation/oxygen/1.0.0/'],
      path: '/documentation/',
    );

    // Stop the task backend, and instance execution
    await Future.wait([
      taskBackend.stop(),
      cloud.stopInstanceExecution(),
    ]);
  }, timeout: Timeout(Duration(minutes: 15)));
}

Future<String> _fetchHtml(String requestPath) async {
  // Cookie for enable experiments, remove this when not needed anymore
  final headers = {
    'Cookie': Cookie(
      'experimental',
      ExperimentalFlags.all().encodedAsCookie(),
    ).toString(),
  };

  // TODO: Would be really nice if we knew the URL to which the request was
  //       redirected, so we could test redirects here too.
  //       Probably we should make a real HTTP request, rather than going
  //       through [issueGet], which is a fake request.

  return await expectHtmlResponse(await issueGet(
    requestPath,
    headers: headers,
  ));
}

Future<dom.Document> _fetchHtmlDocument(String requestPath) async {
  final html = await _fetchHtml(requestPath);
  return HtmlParser(
    html,
    generateSpans: true,
    strict: true,
    sourceUrl: requestPath,
  ).parse();
}

Future<void> _traveseLinksUnderPath({
  required Iterable<String> seed,
  required String path,
}) async {
  final visited = <String>{};
  final queue = <String>[...seed];

  while (queue.isNotEmpty) {
    final next = queue.removeLast();
    visited.add(next);
    final target = Uri.parse(next);

    final html = await _fetchHtml(target.toString());
    expectGoldenFile(html, path + target.toString().substring(path.length));

    final document = HtmlParser(
      html,
      generateSpans: true,
      strict: true,
      sourceUrl: target.toString(),
    ).parse();

    queue.addAll(
      document
          .querySelectorAll('a')
          .map((a) {
            final href = a.attributes['href'];
            if (href == null) {
              return null;
            }
            var u = Uri.tryParse(href);
            if (u == null || u.hasAuthority || u.hasAbsolutePath) {
              return null;
            }
            u = target.resolveUri(u);
            if (!u.path.startsWith(path)) {
              return null;
            }
            return u.path;
          })
          .whereNotNull()
          .whereNot(visited.contains)
          .whereNot(queue.contains),
    );
  }
}

void expectGoldenFile(
  String content,
  String fileName,
) {
  // Making sure it is valid HTML
  final htmlParser = HtmlParser(content, strict: true);

  final root = htmlParser.parse();
  validateHtml(root);

  var replacedContent = content;
  replacedContent = replacedContent
      .replaceAll('Pana <code>$panaVersion</code>,',
          'Pana <code>%%pana-version%%</code>,')
      .replaceAll('Dart <code>$toolStableDartSdkVersion</code>',
          'Dart <code>%%stable-dart-version%%</code>')
      .replaceAll(
          '/static/hash-${staticFileCache.etag}/', '/static/hash-%%etag%%/');

  // Pretty printing output using XML parser and formatter.
  final xmlDoc = xml.XmlDocument.parse(
    replacedContent,
    entityMapping: xml.XmlDefaultEntityMapping.html5(),
  );
  final xmlContent = xmlDoc.toXmlString(
        pretty: true,
        indent: '  ',
        entityMapping: xml.XmlDefaultEntityMapping.html5(),
      ) +
      '\n';

  if (fileName.endsWith('/')) {
    fileName += 'index.html';
  }

  final file = File('$goldenDir/$fileName');
  if (_regenerateGoldens) {
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(xmlContent);
    markTestSkipped('Set `_regenerateGoldens` to `false` to run tests.');
  }
  final golden = file.readAsStringSync();
  expect(xmlContent.split('\n'), golden.split('\n'));
}
