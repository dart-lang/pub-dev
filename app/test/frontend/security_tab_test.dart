// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart' as db;
import 'package:pub_dev/frontend/dom/dom.dart' as d;
import 'package:pub_dev/frontend/templates/views/pkg/badge.dart';
import 'package:pub_dev/frontend/templates/views/pkg/info_box.dart';
import 'package:pub_dev/frontend/templates/views/pkg/security_tab.dart';
import 'package:pub_dev/package/model_properties.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/scorecard/models.dart';
import 'package:pub_dev/shared/urls.dart' as urls;
import 'package:test/test.dart';

/// The provenance facts of the sample attestation, as persisted at upload.
final _sampleProvenance = VersionProvenance(
  repository: 'sigstore-conformance/extremely-dangerous-public-oidc-beacon',
  repositoryId: '632596897',
  repositoryOwnerId: '131804563',
  workflowPath: '.github/workflows/extremely-dangerous-oidc-beacon.yml',
  ref: 'refs/heads/main',
  commitSha: 'c7b3dfb335f051e1c86bda4c716fac97df62ad81',
  runUrl:
      'https://github.com/sigstore-conformance/extremely-dangerous-public-oidc-beacon/actions/runs/8347481628/attempts/1',
  signer:
      'https://github.com/sigstore-conformance/extremely-dangerous-public-oidc-beacon/.github/workflows/extremely-dangerous-oidc-beacon.yml@refs/heads/main',
  issuer: 'https://token.actions.githubusercontent.com',
  transparencyLogIndex: 79571823,
  transparencyLogIntegratedTime: DateTime.utc(2024, 3, 19, 17, 26, 26),
);

final _sampleSha256 = List<int>.generate(
  32,
  (i) => int.parse(
    'a0cfc71271d6e278e57cd332ff957c3f7043fdda354c4cbb190a30d56efa01bf'
        .substring(i * 2, i * 2 + 2),
    radix: 16,
  ),
);

PackagePageData _createMockData({
  int? slsaLevel,
  VersionProvenance? provenance,
}) {
  final pubspec = Pubspec.fromYaml('''
name: test_pkg
version: 1.0.0
description: A package for testing.
repository: https://github.com/example/test_pkg
''');

  final partition = db.Partition(null);
  final rootKey = db.Key.emptyKey(partition);
  final packageKey = rootKey.append(Package, id: 'test_pkg');

  final version = PackageVersion.init()
    ..id = '1.0.0'
    ..version = '1.0.0'
    ..parentKey = packageKey
    ..packageKey = packageKey
    ..created = DateTime.utc(2026, 1, 1)
    ..pubspec = pubspec
    ..uploader = 'test@example.com'
    ..sha256 = _sampleSha256
    ..slsaLevel = slsaLevel
    ..provenance = provenance;

  final package = Package.fromVersion(version);

  return PackagePageData(
    package: package,
    version: version,
    assets: [AssetKind.pubspec, AssetKind.readme],
    asset: null,
    scoreCard: ScoreCardData(),
    isAdmin: false,
    isLiked: false,
    weeklyDownloadCounts: null,
  );
}

void main() {
  group('AttestationDetails', () {
    test('is built from the persisted provenance facts', () {
      final data = _createMockData(slsaLevel: 2, provenance: _sampleProvenance);
      final details = AttestationDetails.fromPageData(data);

      expect(details, isNotNull);
      expect(details!.slsaLevel, 2);
      expect(details.rekorLogIndex, '79571823');
      expect(
        details.rekorUrl,
        'https://search.sigstore.dev/?logIndex=79571823',
      );
      expect(details.rekorTimestamp, DateTime.utc(2024, 3, 19, 17, 26, 26));
      expect(
        details.archiveSha256,
        'a0cfc71271d6e278e57cd332ff957c3f7043fdda354c4cbb190a30d56efa01bf',
      );
      expect(
        details.repository,
        'https://github.com/sigstore-conformance/extremely-dangerous-public-oidc-beacon',
      );
      expect(
        details.workflow,
        '.github/workflows/extremely-dangerous-oidc-beacon.yml',
      );
      expect(details.ref, 'refs/heads/main');
      expect(details.commit, 'c7b3dfb335f051e1c86bda4c716fac97df62ad81');
      expect(
        details.runUrl,
        'https://github.com/sigstore-conformance/extremely-dangerous-public-oidc-beacon/actions/runs/8347481628/attempts/1',
      );
      expect(
        details.signerIdentity,
        'https://github.com/sigstore-conformance/extremely-dangerous-public-oidc-beacon/.github/workflows/extremely-dangerous-oidc-beacon.yml@refs/heads/main',
      );
      expect(details.oidcIssuer, 'https://token.actions.githubusercontent.com');
    });

    test('falls back to the package links without persisted facts', () {
      final data = _createMockData(slsaLevel: 2);
      final details = AttestationDetails.fromPageData(data);
      expect(details, isNotNull);
      expect(details!.slsaLevel, 2);
      expect(details.repository, 'https://github.com/example/test_pkg');
      expect(details.signerIdentity, isNull);
      expect(
        details.archiveSha256,
        'a0cfc71271d6e278e57cd332ff957c3f7043fdda354c4cbb190a30d56efa01bf',
      );
    });

    test('returns null when the version is not attested', () {
      final data = _createMockData(slsaLevel: null);
      expect(AttestationDetails.fromPageData(data), isNull);
    });
  });

  group('securityTabNode UI rendering', () {
    test('renders full Level AAA provenance details when attestation exists', () {
      final data = _createMockData(slsaLevel: 2, provenance: _sampleProvenance);
      final node = securityTabNode(data);
      final html = node.toString();

      // Heading and summary
      expect(html, contains('<h2>Build Provenance</h2>'));
      expect(html, contains('Build confirmed'));
      expect(html, contains('SLSA 2'));
      expect(html, contains('package-badge-slsa'));

      // Source card
      expect(html, contains('Source</h3>'));
      expect(
        html,
        contains(
          'github.com&#47;sigstore-conformance&#47;extremely-dangerous-public-oidc-beacon',
        ),
      );
      expect(html, contains('c7b3dfb'));
      expect(html, contains('refs&#47;heads&#47;main'));

      // Build card
      expect(html, contains('Build</h3>'));
      expect(html, contains('GitHub Actions'));
      expect(
        html,
        contains(
          '.github&#47;workflows&#47;extremely-dangerous-oidc-beacon.yml',
        ),
      );
      expect(html, contains('actions/runs/8347481628'));

      // Attestation card
      expect(html, contains('Attestation &amp; Transparency Log</h3>'));
      expect(html, contains('token.actions.githubusercontent.com'));
      expect(html, contains('https://search.sigstore.dev/?logIndex=79571823'));
      expect(html, contains('Sigstore (Fulcio)'));

      // Integrity card
      expect(html, contains('Package Integrity</h3>'));
      expect(html, contains('test_pkg-1.0.0.tar.gz'));
      expect(
        html,
        contains(
          'a0cfc71271d6e278e57cd332ff957c3f7043fdda354c4cbb190a30d56efa01bf',
        ),
      );

      // Download section
      expect(html, contains('Download attestation bundle (.sigstore.json)'));
      expect(
        html,
        contains('/api/packages/test_pkg/versions/1.0.0/attestation'),
      );

      // Disclaimer and accessibility tooltips
      expect(
        html,
        contains(
          'does not guarantee that the code is free of bugs, security vulnerabilities, or malicious behavior',
        ),
      );
      expect(
        html,
        contains('title="https://search.sigstore.dev/?logIndex=79571823"'),
      );
      expect(
        html,
        contains(
          'title="https://github.com/sigstore-conformance/extremely-dangerous-public-oidc-beacon/actions/runs/8347481628/attempts/1"',
        ),
      );
    });

    test('renders educational empty state when no attestation exists', () {
      final data = _createMockData(slsaLevel: null);
      final node = securityTabNode(data);
      final html = node.toString();

      expect(html, contains('<h2>Build Provenance</h2>'));
      expect(html, contains('No build provenance attestation available'));
      expect(html, contains('https://dart.dev/tools/pub/automated-publishing'));
      expect(html, contains('test_pkg-1.0.0.tar.gz'));
    });
  });

  group('slsaShieldBadgeNode', () {
    test('renders span when href is null', () {
      final node = slsaShieldBadgeNode(2);
      final html = node.toString();
      expect(
        html,
        startsWith('<span class="package-badge package-badge-slsa"'),
      );
      expect(html, contains('SLSA 2'));
    });

    test('renders link when href is provided', () {
      final node = slsaShieldBadgeNode(
        2,
        href: urls.pkgSecurityUrl('test_pkg', version: '1.0.0'),
      );
      final html = node.toString();
      expect(html, startsWith('<a '));
      expect(
        html,
        contains('href="/packages/test_pkg/versions/1.0.0/security"'),
      );
      expect(html, contains('class="package-badge package-badge-slsa"'));
      expect(html, contains('SLSA 2'));
    });
  });

  group('packageInfoBoxNode', () {
    test('renders provenance link when slsaLevel is present', () {
      final data = _createMockData(slsaLevel: 2);
      final node = packageInfoBoxNode(
        data: data,
        metaLinks: [],
        docLinks: [],
        fundingLinks: [],
        labeledScores: d.div(),
      );
      final html = node.toString();
      expect(html, contains('Provenance</h3>'));
      expect(html, contains('SLSA 2'));
      expect(html, contains('href="/packages/test_pkg/security"'));
      expect(html, contains('View details'));
    });

    test('does not render provenance link when slsaLevel is null', () {
      final data = _createMockData(slsaLevel: null);
      final node = packageInfoBoxNode(
        data: data,
        metaLinks: [],
        docLinks: [],
        fundingLinks: [],
        labeledScores: d.div(),
      );
      final html = node.toString();
      expect(html.contains('Provenance</h3>'), isFalse);
    });
  });
}
