import 'dart:io';

import 'package:_pub_shared/validation/html/html_validation.dart';
import 'package:collection/collection.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show HtmlParser;
import 'package:pub_dev/fake/backend/fake_pub_worker.dart';
import 'package:pub_dev/frontend/handlers/experimental.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../shared/test_services.dart';
import '../shared/utils.dart';

const String goldenDir = 'test/task/testdata/goldens';

// TODO: generalize golden testing, use env var for regenerating all goldens.
final _regenerateGoldens = false;

// We use a small test profile without flutter packages, because we have to
// run pana+dartdoc for all these package versions, naturally this is slow.
// But we get great end-to-end test coverage.
//
// Using flutter packages will require us to have all packages that flutter
// depends on, so that would be huge set and that want to avoid.
final _testProfile = TestProfile(
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
  testWithProfile('output of oxygen', testProfile: _testProfile, fn: () async {
    await processTasksLocallyWithPubWorker();
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

    // Traverse all package pages and generated documentation,
    // create golden files and check for dead links and assets
    await _traverseLinksUnderPath(
      seed: [
        '/packages/oxygen',
        '/documentation/oxygen/latest/',
        '/documentation/oxygen/1.0.0/'
      ],
      roots: {
        '/packages/oxygen',
        '/documentation/',
      },
    );

    // Check if the documentation package.tar.gz exists.
    final packageRs =
        await issueGet('/documentation/oxygen/latest/package.tar.gz');
    expect(packageRs.statusCode, 200);
  }, timeout: Timeout(Duration(minutes: 15)));
}

// Cookie for enable experiments, remove this when not needed anymore
final _headers = {
  'Cookie': Cookie(
    experimentalCookieName,
    ExperimentalFlags({'experiment-name'}).encodedAsCookie(),
  ).toString(),
};

Future<String> _fetchHtml(String requestPath) async {
  // TODO: Would be really nice if we knew the URL to which the request was
  //       redirected, so we could test redirects here too.
  //       Probably we should make a real HTTP request, rather than going
  //       through [issueGet], which is a fake request.
  return await expectHtmlResponse(await issueGet(
    requestPath,
    headers: _headers,
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

Future<void> _traverseLinksUnderPath({
  required Iterable<String> seed,
  required Set<String> roots,
}) async {
  // Normalize href, returns null if doesn't parse as link to same host
  final normalize = (String? href, Uri relativeTo) {
    if (href == null) return null;
    final u = Uri.tryParse(href);
    if (u == null || u.hasAuthority) return null;
    final r = relativeTo.resolveUri(u);
    return r.path;
  };
  final isUnderRoots =
      (String path) => roots.any((root) => path.startsWith(root));

  final visited = <String>{};
  // HTML pages to visit
  final htmlQueue = <String>[...seed];
  // Non-HTML pages to visit, we just assert that these provide a response.
  // Thus, checking that embedded resources are not dead-links.
  final assetQueue = <String>[];

  while (htmlQueue.isNotEmpty) {
    final next = htmlQueue.removeLast();
    visited.add(next);
    final target = Uri.parse(next);

    // TODO: Consider making a real HTTP request
    final res = await issueGet(target.toString(), headers: _headers);
    if (res.statusCode == 303) {
      htmlQueue.addAll([normalize(res.headers['location']!, target)]
          .nonNulls
          .whereNot(visited.contains)
          .whereNot(htmlQueue.contains)
          .whereNot(assetQueue.contains));
      continue;
    }

    final html = await expectHtmlResponse(res);
    expectGoldenFile(html, target.toString());

    final document = HtmlParser(
      html,
      generateSpans: true,
      strict: true,
      sourceUrl: target.toString(),
    ).parse();

    final links = [
      ...document
          .querySelectorAll('a')
          .map((a) => normalize(a.attributes['href'], target))
          .nonNulls
          .where(isUnderRoots) // only look at html under root
    ];

    final assets = [
      ...document
          .querySelectorAll('link')
          .map((e) => normalize(e.attributes['href'], target))
          .nonNulls,
      ...document
          .querySelectorAll('script')
          .map((e) => normalize(e.attributes['src'], target))
          .nonNulls,
      ...document
          .querySelectorAll('img')
          .map((e) => normalize(e.attributes['src'], target))
          .nonNulls
    ];

    htmlQueue.addAll(links
        .whereNot((l) => l.endsWith('.tar.gz'))
        .whereNot((l) => l.endsWith('.txt'))
        .whereNot(visited.contains)
        .whereNot(htmlQueue.contains)
        .whereNot(assetQueue.contains));

    assetQueue.addAll(assets
        .whereNot(visited.contains)
        .whereNot(htmlQueue.contains)
        .whereNot(assetQueue.contains));
  }

  // Check that we don't link to dead assets
  while (assetQueue.isNotEmpty) {
    final next = assetQueue.removeLast();
    visited.add(next);
    final target = Uri.parse(next);
    final res = await issueGet(target.toString(), headers: _headers);
    expect(res.statusCode, 200);
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
  _goldenReplacements.forEach((key, value) {
    replacedContent = replacedContent.replaceAll(key, value);
  });

  final xmlContent = prettyPrintHtml(replacedContent);

  if (fileName.endsWith('/')) {
    fileName += 'index.html';
  }
  if (!fileName.endsWith('.html')) {
    fileName += '.html';
  }

  final file = File('$goldenDir/$fileName');
  if (_regenerateGoldens) {
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(xmlContent);
    markTestSkipped('Set `_regenerateGoldens` to `false` to run tests.');
  }
  final golden = file.readAsStringSync();
  expect(xmlContent.split('\n'), golden.split('\n'), reason: 'in $fileName');
}

final _sdkVersionsToReplace = [
  runtimeSdkVersion,
  toolStableDartSdkVersion,
  Platform.version.split(' ').first,
];

final _goldenReplacements = <Pattern, String>{
  'Pana <code>$panaVersion</code>,': 'Pana <code>%%pana-version%%</code>,',
  for (final sdkVersion in _sdkVersionsToReplace)
    'api.dart.dev/stable/$sdkVersion/':
        'api.dart.dev/stable/%%stable-dart-version%%/',
  for (final sdkVersion in _sdkVersionsToReplace)
    'Dart <code>$sdkVersion</code>':
        'Dart <code>%%stable-dart-version%%</code>',
  '/static/hash-${staticFileCache.etag}/': '/static/hash-%%etag%%/',
  _timestampPattern: '%%timestamp%%',
  _escapedTimestampPattern: '%%escaped-timestamp%%',
  _timeAgoPattern: '%%time-ago%%',
  _xagoMillisPattern: 'data-timestamp="%%time-ago-millis%%"',
  _shortDatePattern: '%%short-dateformat%%',
  '<wbr>': '<wbr/>',
};

final _timestampPattern =
    RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{6}Z');
final _escapedTimestampPattern =
    RegExp(_timestampPattern.pattern.replaceAll(':', r'\\u003a'));
final _timeAgoPattern = RegExp(
  r'(?:\d+ (?:years|months|days|hours|hour) ago)|(?:in the last hour)',
);
final _xagoMillisPattern = RegExp(r'data-timestamp="\d+"');

final _shortDatePattern = RegExp(
  r'(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{1,2}, \d{4}',
);
