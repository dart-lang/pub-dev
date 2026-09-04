// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import '../../../../package/models.dart';
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import 'badge.dart';

/// Parsed provenance attestation information.
class AttestationDetails {
  final int slsaLevel;
  final String? repository;
  final String? commit;
  final String? ref;
  final String? workflow;
  final String? runUrl;
  final String? signerIdentity;
  final String? oidcIssuer;
  final String? rekorLogIndex;
  final String? rekorUrl;
  final DateTime? rekorTimestamp;
  final String? archiveSha256;

  AttestationDetails({
    required this.slsaLevel,
    this.repository,
    this.commit,
    this.ref,
    this.workflow,
    this.runUrl,
    this.signerIdentity,
    this.oidcIssuer,
    this.rekorLogIndex,
    this.rekorUrl,
    this.rekorTimestamp,
    this.archiveSha256,
  });

  static AttestationDetails? parse({
    required PackagePageData data,
    String? rawBundleJson,
  }) {
    final slsaLevel = data.version.slsaLevel ?? 2;
    if (rawBundleJson == null || rawBundleJson.trim().isEmpty) {
      if (data.version.slsaLevel != null) {
        return AttestationDetails(
          slsaLevel: slsaLevel,
          repository: data.packageLinks.repositoryUrl,
        );
      }
      return null;
    }

    try {
      final bundle = jsonDecode(rawBundleJson) as Map<String, dynamic>;

      String? rekorLogIndex;
      String? rekorUrl;
      DateTime? rekorTimestamp;
      String? archiveSha256;
      String? repository;
      String? commit;
      String? ref;
      String? workflow;
      String? runUrl;
      String? signerIdentity;
      String? oidcIssuer;

      // 1. Transparency log (Rekor) entries
      final vm = bundle['verificationMaterial'] as Map<String, dynamic>?;
      if (vm != null) {
        final tlogEntries = vm['tlogEntries'] as List<dynamic>?;
        if (tlogEntries != null && tlogEntries.isNotEmpty) {
          final first = tlogEntries.first as Map<String, dynamic>;
          final indexVal = first['logIndex'];
          if (indexVal != null) {
            rekorLogIndex = indexVal.toString();
            rekorUrl = 'https://search.sigstore.dev/?logIndex=$rekorLogIndex';
          }
          final timeVal = first['integratedTime'];
          if (timeVal != null) {
            final seconds = int.tryParse(timeVal.toString());
            if (seconds != null) {
              rekorTimestamp = DateTime.fromMillisecondsSinceEpoch(
                seconds * 1000,
                isUtc: true,
              );
            }
          }
          if (first['canonicalizedBody'] != null) {
            try {
              final bodyBytes = base64Decode(
                first['canonicalizedBody'] as String,
              );
              final bodyJson =
                  jsonDecode(utf8.decode(bodyBytes)) as Map<String, dynamic>;
              final spec = bodyJson['spec'] as Map<String, dynamic>?;
              final hashVal = spec?['data']?['hash']?['value'] as String?;
              if (hashVal != null && hashVal.isNotEmpty) {
                archiveSha256 = hashVal;
              }
            } catch (_) {}
          }
        }

        // 2. Certificate parsing (ASN.1 DER strings)
        final cert = vm['certificate'] as Map<String, dynamic>?;
        if (cert != null && cert['rawBytes'] is String) {
          try {
            final certBytes = base64Decode(cert['rawBytes'] as String);
            final strings = _extractAsn1Strings(certBytes);
            for (final s in strings) {
              if (s.contains('github.com/') &&
                  s.contains('/.github/workflows/')) {
                signerIdentity ??= s;
                final atIdx = s.lastIndexOf('@');
                final baseUri = atIdx != -1 ? s.substring(0, atIdx) : s;
                if (atIdx != -1 && ref == null) {
                  final refPart = s.substring(atIdx + 1);
                  if (refPart.startsWith('refs/')) {
                    ref = refPart;
                  }
                }
                final wfIdx = baseUri.indexOf('/.github/workflows/');
                if (wfIdx != -1) {
                  repository ??= baseUri.substring(0, wfIdx);
                  workflow ??= baseUri.substring(wfIdx + 1);
                }
              } else if (commit == null &&
                  s.length == 40 &&
                  RegExp(r'^[0-9a-fA-F]{40}$').hasMatch(s)) {
                commit = s;
              } else if (runUrl == null &&
                  s.contains('github.com/') &&
                  s.contains('/actions/runs/')) {
                runUrl = s;
              } else if (oidcIssuer == null &&
                  s.contains('token.actions.githubusercontent.com')) {
                oidcIssuer = s;
              } else if (ref == null && s.startsWith('refs/')) {
                ref = s;
              }
            }
          } catch (_) {}
        }
      }

      // 3. Message signature digest
      final msgSig = bundle['messageSignature'] as Map<String, dynamic>?;
      if (msgSig != null && archiveSha256 == null) {
        final digest = msgSig['messageDigest']?['digest'] as String?;
        if (digest != null) {
          try {
            final bytes = base64Decode(digest);
            archiveSha256 = bytes
                .map((b) => b.toRadixString(16).padLeft(2, '0'))
                .join();
          } catch (_) {}
        }
      }

      // 4. DSSE envelope (in-toto statement)
      final dsse = bundle['dsseEnvelope'] as Map<String, dynamic>?;
      if (dsse != null) {
        final payloadStr = dsse['payload'] as String?;
        if (payloadStr != null) {
          try {
            final payloadBytes = base64Decode(payloadStr);
            final statement =
                jsonDecode(utf8.decode(payloadBytes)) as Map<String, dynamic>;
            final subjects = statement['subject'] as List<dynamic>?;
            if (archiveSha256 == null &&
                subjects != null &&
                subjects.isNotEmpty) {
              final firstSub = subjects.first as Map<String, dynamic>;
              archiveSha256 = firstSub['digest']?['sha256'] as String?;
            }
            final predicate = statement['predicate'] as Map<String, dynamic>?;
            final buildDef =
                predicate?['buildDefinition'] as Map<String, dynamic>?;
            final extParams =
                buildDef?['externalParameters'] as Map<String, dynamic>?;
            final wfObj = extParams?['workflow'] as Map<String, dynamic>?;
            if (wfObj != null) {
              repository ??= wfObj['repository'] as String?;
              workflow ??= wfObj['path'] as String?;
              ref ??= wfObj['ref'] as String?;
            }
            final runDetails =
                predicate?['runDetails'] as Map<String, dynamic>?;
            runUrl ??= runDetails?['metadata']?['invocationId'] as String?;
          } catch (_) {}
        }
      }

      // Fallbacks
      repository ??= data.packageLinks.repositoryUrl;
      oidcIssuer ??= 'https://token.actions.githubusercontent.com';

      return AttestationDetails(
        slsaLevel: slsaLevel,
        repository: repository,
        commit: commit,
        ref: ref,
        workflow: workflow,
        runUrl: runUrl,
        signerIdentity: signerIdentity,
        oidcIssuer: oidcIssuer,
        rekorLogIndex: rekorLogIndex,
        rekorUrl: rekorUrl,
        rekorTimestamp: rekorTimestamp,
        archiveSha256: archiveSha256,
      );
    } catch (_) {
      return AttestationDetails(
        slsaLevel: slsaLevel,
        repository: data.packageLinks.repositoryUrl,
      );
    }
  }

  static List<String> _extractAsn1Strings(List<int> bytes) {
    final strings = <String>[];
    var i = 0;
    while (i < bytes.length - 2) {
      final tag = bytes[i];
      if (tag == 0x0c || tag == 0x13 || tag == 0x16 || tag == 0x86) {
        final lenByte = bytes[i + 1];
        int len;
        int offset;
        if ((lenByte & 0x80) == 0) {
          len = lenByte;
          offset = i + 2;
        } else {
          final numBytes = lenByte & 0x7f;
          if (numBytes > 0 &&
              numBytes <= 4 &&
              i + 2 + numBytes <= bytes.length) {
            len = 0;
            for (var j = 0; j < numBytes; j++) {
              len = (len << 8) | bytes[i + 2 + j];
            }
            offset = i + 2 + numBytes;
          } else {
            i++;
            continue;
          }
        }
        if (len > 0 && offset + len <= bytes.length) {
          try {
            final str = utf8.decode(bytes.sublist(offset, offset + len));
            if (str.codeUnits.every((c) => c >= 32 && c < 127) &&
                str.length >= 3) {
              strings.add(str);
            }
          } catch (_) {}
        }
      }
      i++;
    }
    return strings;
  }
}

/// Renders the Security tab content conforming to OpenSSF Level AAA style guide.
d.Node securityTabNode(PackagePageData data) {
  final attestation = AttestationDetails.parse(
    data: data,
    rawBundleJson: data.asset?.kind == AssetKind.attestation
        ? data.asset?.textContent
        : null,
  );

  if (attestation != null) {
    return _renderAttestedSecurityTab(data, attestation);
  } else {
    return _renderUnattestedSecurityTab(data);
  }
}

d.Node _renderAttestedSecurityTab(
  PackagePageData data,
  AttestationDetails attestation,
) {
  final package = data.package.name ?? data.version.package;
  final version = data.version.version ?? data.version.id!;
  final archiveUrl = urls.pkgArchiveDownloadUrl(package, version);
  final attestationUrl = urls.pkgAttestationDownloadUrl(package, version);

  return d.div(
    classes: ['security-tab'],
    children: [
      d.h2(text: 'Build Provenance'),
      _renderStatusCard(attestation),
      d.div(
        classes: ['security-cards-grid'],
        children: [
          _renderSourceCard(attestation),
          _renderBuildCard(attestation),
          _renderAttestationCard(attestation),
          _renderIntegrityCard(package, version, attestation, archiveUrl),
        ],
      ),
      d.div(
        classes: ['security-download-section'],
        children: [
          d.div(
            children: [
              d.a(
                classes: ['button', 'button-primary'],
                href: attestationUrl,
                attributes: {'download': '$package-$version.sigstore.json'},
                children: [
                  d.unsafeRawHtml(
                    '<svg viewBox="0 0 24 24" width="16" height="16" style="vertical-align: -3px; margin-right: 6px;" fill="currentColor"><path d="M19.35 10.04C18.67 6.59 15.64 4 12 4 9.11 4 6.6 5.64 5.35 8.04 2.34 8.36 0 10.91 0 14c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96zM17 13l-5 5-5-5h3V9h4v4h3z"/></svg>',
                  ),
                  d.text('Download attestation bundle (.sigstore.json)'),
                ],
              ),
            ],
          ),
          d.p(
            classes: ['-metadata'],
            children: [
              d.text('Learn more about '),
              d.a(
                href: 'https://slsa.dev',
                target: '_blank',
                rel: 'noopener noreferrer',
                text: 'SLSA specifications',
              ),
              d.text(' and '),
              d.a(
                href: 'https://dart.dev/tools/pub/automated-publishing',
                target: '_blank',
                rel: 'noopener noreferrer',
                text: 'automated package publishing',
              ),
              d.text('.'),
            ],
          ),
        ],
      ),
    ],
  );
}

d.Node _renderStatusCard(AttestationDetails attestation) {
  return d.div(
    classes: ['security-status-card'],
    children: [
      d.div(
        classes: ['security-status-icon'],
        child: d.unsafeRawHtml(
          '<svg viewBox="0 0 24 24" width="24" height="24" fill="#2e7d32"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-2 16l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z"/></svg>',
        ),
      ),
      d.div(
        classes: ['security-status-content'],
        children: [
          d.h3(
            children: [
              d.text('Build confirmed'),
              d.text(' '),
              slsaShieldBadgeNode(attestation.slsaLevel),
            ],
          ),
          d.p(
            text:
                'This package version was built and published with automated build provenance verified via Sigstore. '
                'This cryptographically confirms that the package artifact was produced by the source repository\'s automated CI/CD workflow. '
                'Provenance verifies where and how this package was built, but does not guarantee that the code is free of bugs, security vulnerabilities, or malicious behavior.',
          ),
        ],
      ),
    ],
  );
}

d.Node _renderSourceCard(AttestationDetails attestation) {
  final repo = attestation.repository;
  final commit = attestation.commit;
  final ref = attestation.ref;

  final repoUri = repo != null ? urls.parseValidUrl(repo) : null;
  final isGithub = repoUri != null && repoUri.host == 'github.com';

  final commitUrl = (isGithub && commit != null)
      ? '$repo/commit/$commit'
      : null;

  return d.div(
    classes: ['security-card'],
    children: [
      d.div(
        classes: ['security-card-header'],
        children: [
          d.unsafeRawHtml(
            '<svg class="security-card-icon" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M9.4 16.6L4.8 12l4.6-4.6L8 6l-6 6 6 6 1.4-1.4zm5.2 0l4.6-4.6-4.6-4.6L16 6l6 6-6 6-1.4-1.4z"/></svg>',
          ),
          d.h3(text: 'Source'),
        ],
      ),
      d.div(
        classes: ['security-card-row'],
        children: [
          d.div(classes: ['security-card-label'], text: 'Repository'),
          d.div(
            classes: ['security-card-value'],
            child: repo != null
                ? d.a(
                    href: repo,
                    text: repo.replaceFirst(RegExp(r'^https?:\/\/'), ''),
                    target: '_blank',
                    rel: 'noopener noreferrer ugc',
                  )
                : d.text('Not specified'),
          ),
        ],
      ),
      if (commit != null)
        d.div(
          classes: ['security-card-row'],
          children: [
            d.div(classes: ['security-card-label'], text: 'Commit'),
            d.div(
              classes: ['security-card-value'],
              child: commitUrl != null
                  ? d.a(
                      href: commitUrl,
                      child: d.code(text: commit.substring(0, 7)),
                      target: '_blank',
                      rel: 'noopener noreferrer ugc',
                      attributes: {'title': commit},
                    )
                  : d.code(text: commit.substring(0, 7)),
            ),
          ],
        ),
      if (ref != null)
        d.div(
          classes: ['security-card-row'],
          children: [
            d.div(classes: ['security-card-label'], text: 'Branch / Tag'),
            d.div(
              classes: ['security-card-value'],
              child: d.code(text: ref),
            ),
          ],
        ),
    ],
  );
}

d.Node _renderBuildCard(AttestationDetails attestation) {
  final repo = attestation.repository;
  final workflow = attestation.workflow;
  final runUrl = attestation.runUrl;

  final repoUri = repo != null ? urls.parseValidUrl(repo) : null;
  final isGithub = repoUri != null && repoUri.host == 'github.com';

  final workflowUrl = (isGithub && workflow != null)
      ? '$repo/blob/${attestation.commit ?? attestation.ref ?? "HEAD"}/$workflow'
      : null;

  return d.div(
    classes: ['security-card'],
    children: [
      d.div(
        classes: ['security-card-header'],
        children: [
          d.unsafeRawHtml(
            '<svg class="security-card-icon" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M22 18V3H2v15h2v3h16v-3h2zm-4 1H6v-2h12v2zm2-4H4V5h16v10z"/></svg>',
          ),
          d.h3(text: 'Build'),
        ],
      ),
      d.div(
        classes: ['security-card-row'],
        children: [
          d.div(classes: ['security-card-label'], text: 'Platform'),
          d.div(classes: ['security-card-value'], text: 'GitHub Actions'),
        ],
      ),
      if (workflow != null)
        d.div(
          classes: ['security-card-row'],
          children: [
            d.div(classes: ['security-card-label'], text: 'Workflow'),
            d.div(
              classes: ['security-card-value'],
              child: workflowUrl != null
                  ? d.a(
                      href: workflowUrl,
                      child: d.code(text: workflow),
                      target: '_blank',
                      rel: 'noopener noreferrer ugc',
                    )
                  : d.code(text: workflow),
            ),
          ],
        ),
      if (runUrl != null)
        d.div(
          classes: ['security-card-row'],
          children: [
            d.div(classes: ['security-card-label'], text: 'Workflow Run'),
            d.div(
              classes: ['security-card-value'],
              child: d.a(
                href: runUrl,
                text: 'View build execution on GitHub',
                target: '_blank',
                rel: 'noopener noreferrer ugc',
                attributes: {'title': runUrl},
              ),
            ),
          ],
        ),
    ],
  );
}

d.Node _renderAttestationCard(AttestationDetails attestation) {
  final identity = attestation.signerIdentity;
  final issuer = attestation.oidcIssuer;
  final logIndex = attestation.rekorLogIndex;
  final rekorUrl = attestation.rekorUrl;

  return d.div(
    classes: ['security-card', 'security-card-full-width'],
    children: [
      d.div(
        classes: ['security-card-header'],
        children: [
          d.unsafeRawHtml(
            '<svg class="security-card-icon" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg>',
          ),
          d.h3(text: 'Attestation & Transparency Log'),
        ],
      ),
      if (identity != null)
        d.div(
          classes: ['security-card-row'],
          children: [
            d.div(
              classes: ['security-card-label'],
              text: 'Signer Workload Identity',
            ),
            d.div(
              classes: ['security-card-value'],
              child: d.code(text: identity),
            ),
          ],
        ),
      if (issuer != null)
        d.div(
          classes: ['security-card-row'],
          children: [
            d.div(
              classes: ['security-card-label'],
              text: 'Identity Provider (OIDC)',
            ),
            d.div(
              classes: ['security-card-value'],
              child: d.code(text: issuer),
            ),
          ],
        ),
      d.div(
        classes: ['security-card-row'],
        children: [
          d.div(
            classes: ['security-card-label'],
            text: 'Transparency Log (Rekor)',
          ),
          d.div(
            classes: ['security-card-value'],
            child: rekorUrl != null
                ? d.fragment([
                    d.a(
                      href: rekorUrl,
                      text: 'Entry #$logIndex',
                      target: '_blank',
                      rel: 'noopener noreferrer',
                      attributes: {'title': rekorUrl},
                    ),
                    if (attestation.rekorTimestamp != null) ...[
                      d.text(' (recorded '),
                      d.xAgoTimestamp(attestation.rekorTimestamp!),
                      d.text(')'),
                    ],
                  ])
                : d.text('Recorded in Sigstore public transparency log'),
          ),
        ],
      ),
      d.div(
        classes: ['security-card-row'],
        children: [
          d.div(
            classes: ['security-card-label'],
            text: 'Certificate Authority',
          ),
          d.div(classes: ['security-card-value'], text: 'Sigstore (Fulcio)'),
        ],
      ),
    ],
  );
}

d.Node _renderIntegrityCard(
  String package,
  String version,
  AttestationDetails attestation,
  String archiveUrl,
) {
  final sha256 = attestation.archiveSha256;

  return d.div(
    classes: ['security-card', 'security-card-full-width'],
    children: [
      d.div(
        classes: ['security-card-header'],
        children: [
          d.unsafeRawHtml(
            '<svg class="security-card-icon" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm7 10c0 4.52-2.98 8.69-7 9.93-4.02-1.24-7-5.41-7-9.93V6.3l7-3.11 7 3.11V11zm-11.59.59L6 13l4 4 8-8-1.41-1.42L10 14.17z"/></svg>',
          ),
          d.h3(text: 'Package Integrity'),
        ],
      ),
      d.div(
        classes: ['security-card-row'],
        children: [
          d.div(classes: ['security-card-label'], text: 'Archive File'),
          d.div(
            classes: ['security-card-value'],
            child: d.a(href: archiveUrl, text: '$package-$version.tar.gz'),
          ),
        ],
      ),
      if (sha256 != null)
        d.div(
          classes: ['security-card-row'],
          children: [
            d.div(classes: ['security-card-label'], text: 'SHA-256 Checksum'),
            d.div(
              classes: ['security-card-value'],
              child: d.codeSnippet(
                language: 'plaintext',
                textToCopy: sha256,
                text: sha256,
              ),
            ),
          ],
        ),
    ],
  );
}

d.Node _renderUnattestedSecurityTab(PackagePageData data) {
  final package = data.package.name ?? data.version.package;
  final version = data.version.version ?? data.version.id!;
  final archiveUrl = urls.pkgArchiveDownloadUrl(package, version);

  return d.div(
    classes: ['security-tab'],
    children: [
      d.h2(text: 'Build Provenance'),
      d.div(
        classes: ['markdown-alert', 'markdown-alert-note'],
        children: [
          d.p(
            classes: ['markdown-alert-title'],
            text: 'No build provenance attestation available',
          ),
          d.p(
            text:
                'This version was published without cryptographic build provenance. '
                'Build provenance provides verifiable proof connecting a package artifact directly to its source repository and automated build workflow.',
          ),
          d.p(
            children: [
              d.text(
                'Package publishers can establish build provenance by publishing through automated CI/CD workflows. ',
              ),
              d.a(
                href: 'https://dart.dev/tools/pub/automated-publishing',
                target: '_blank',
                rel: 'noopener noreferrer',
                text:
                    'Learn how to automate publishing with provenance on dart.dev.',
              ),
            ],
          ),
        ],
      ),
      d.div(
        classes: ['security-cards-grid'],
        children: [
          d.div(
            classes: ['security-card', 'security-card-full-width'],
            children: [
              d.div(
                classes: ['security-card-header'],
                children: [
                  d.unsafeRawHtml(
                    '<svg class="security-card-icon" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm7 10c0 4.52-2.98 8.69-7 9.93-4.02-1.24-7-5.41-7-9.93V6.3l7-3.11 7 3.11V11z"/></svg>',
                  ),
                  d.h3(text: 'Package Archive'),
                ],
              ),
              d.div(
                classes: ['security-card-row'],
                children: [
                  d.div(classes: ['security-card-label'], text: 'Archive File'),
                  d.div(
                    classes: ['security-card-value'],
                    child: d.a(
                      href: archiveUrl,
                      text: '$package-$version.tar.gz',
                    ),
                  ),
                ],
              ),
              if (data.packageLinks.repositoryUrl != null)
                d.div(
                  classes: ['security-card-row'],
                  children: [
                    d.div(classes: ['security-card-label'], text: 'Repository'),
                    d.div(
                      classes: ['security-card-value'],
                      child: d.a(
                        href: data.packageLinks.repositoryUrl!,
                        text: data.packageLinks.repositoryUrl!,
                        target: '_blank',
                        rel: 'noopener noreferrer ugc',
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    ],
  );
}
