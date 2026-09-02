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

const _sampleBundleJson =
    r'''{"mediaType": "application/vnd.dev.sigstore.bundle+json;version=0.3", "verificationMaterial": {"certificate": {"rawBytes": "MIIIMTCCB7egAwIBAgIUaL/tsmQTHk21mt1Uuk+w7avDBz4wCgYIKoZIzj0EAwMwNzEVMBMGA1UEChMMc2lnc3RvcmUuZGV2MR4wHAYDVQQDExVzaWdzdG9yZS1pbnRlcm1lZGlhdGUwHhcNMjQwMzE5MTcyNjI2WhcNMjQwMzE5MTczNjI2WjAAMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE22S1j/NkEXzBPQAuamHXLpwx+RPnnzZQl/pkEZ8xorvKnzujCS1mVTBo9kBxmYWo2DHtyVyfgnuOqVTzLYmho6OCBtYwggbSMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQUFv1SCziEKN2rRyrjeVlFbSLg1/QwHwYDVR0jBBgwFoAU39Ppz1YkEZb5qNjpKFWixi4YZD8wgaUGA1UdEQEB/wSBmjCBl4aBlGh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbi8uZ2l0aHViL3dvcmtmbG93cy9leHRyZW1lbHktZGFuZ2Vyb3VzLW9pZGMtYmVhY29uLnltbEByZWZzL2hlYWRzL21haW4wOQYKKwYBBAGDvzABAQQraHR0cHM6Ly90b2tlbi5hY3Rpb25zLmdpdGh1YnVzZXJjb250ZW50LmNvbTAfBgorBgEEAYO/MAECBBF3b3JrZmxvd19kaXNwYXRjaDA2BgorBgEEAYO/MAEDBChjN2IzZGZiMzM1ZjA1MWUxYzg2YmRhNGM3MTZmYWM5N2RmNjJhZDgxMC0GCisGAQQBg78wAQQEH0V4dHJlbWVseSBkYW5nZXJvdXMgT0lEQyBiZWFjb24wSQYKKwYBBAGDvzABBQQ7c2lnc3RvcmUtY29uZm9ybWFuY2UvZXh0cmVtZWx5LWRhbmdlcm91cy1wdWJsaWMtb2lkYy1iZWFjb24wHQYKKwYBBAGDvzABBgQPcmVmcy9oZWFkcy9tYWluMDsGCisGAQQBg78wAQgELQwraHR0cHM6Ly90b2tlbi5hY3Rpb25zLmdpdGh1YnVzZXJjb250ZW50LmNvbTCBpgYKKwYBBAGDvzABCQSBlwyBlGh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbi8uZ2l0aHViL3dvcmtmbG93cy9leHRyZW1lbHktZGFuZ2Vyb3VzLW9pZGMtYmVhY29uLnltbEByZWZzL2hlYWRzL21haW4wOAYKKwYBBAGDvzABCgQqDChjN2IzZGZiMzM1ZjA1MWUxYzg2YmRhNGM3MTZmYWM5N2RmNjJhZDgxMB0GCisGAQQBg78wAQsEDwwNZ2l0aHViLWhvc3RlZDBeBgorBgEEAYO/MAEMBFAMTmh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbjA4BgorBgEEAYO/MAENBCoMKGM3YjNkZmIzMzVmMDUxZTFjODZiZGE0YzcxNmZhYzk3ZGY2MmFkODEwHwYKKwYBBAGDvzABDgQRDA9yZWZzL2hlYWRzL21haW4wGQYKKwYBBAGDvzABDwQLDAk2MzI1OTY4OTcwNwYKKwYBBAGDvzABEAQpDCdodHRwczovL2dpdGh1Yi5jb20vc2lnc3RvcmUtY29uZm9ybWFuY2UwGQYKKwYBBAGDvzABEQQLDAkxMzE4MDQ1NjMwgaYGCisGAQQBg78wARIEgZcMgZRodHRwczovL2dpdGh1Yi5jb20vc2lnc3RvcmUtY29uZm9ybWFuY2UvZXh0cmVtZWx5LWRhbmdlcm91cy1wdWJsaWMtb2lkYy1iZWFjb24vLmdpdGh1Yi93b3JrZmxvd3MvZXh0cmVtZWx5LWRhbmdlcm91cy1vaWRjLWJlYWNvbi55bWxAcmVmcy9oZWFkcy9tYWluMDgGCisGAQQBg78wARMEKgwoYzdiM2RmYjMzNWYwNTFlMWM4NmJkYTRjNzE2ZmFjOTdkZjYyYWQ4MTAhBgorBgEEAYO/MAEUBBMMEXdvcmtmbG93X2Rpc3BhdGNoMIGBBgorBgEEAYO/MAEVBHMMcWh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbi9hY3Rpb25zL3J1bnMvODM0NzQ4MTYyOC9hdHRlbXB0cy8xMBYGCisGAQQBg78wARYECAwGcHVibGljMIGKBgorBgEEAdZ5AgQCBHwEegB4AHYA3T0wasbHETJjGR4cmWc3AqJKXrjePK3/h4pygC8p7o4AAAGOV8AHpgAABAMARzBFAiBFeMbpFarlPwb0naTr4mjWDvXApOd9ORqOk36Brt9SmwIhAJJvjor+DXUXr7S3Vm9jVFT3CL0BxcKGj86m5mYzQvubMAoGCCqGSM49BAMDA2gAMGUCMA8lTixdS4iN9mAUduObcSJmhZLyvK7zaX05DLEDCgPWxDHk+JBZUKYRIuHHgwFnOwIxALMamo9dfENMzRgNCzYfp/y+rSOhVjXXE9mCn6BuJETlpRDfGvxUg/5LF9f4lYqozA=="}, "tlogEntries": [{"logIndex": "79571823", "logId": {"keyId": "wNI9atQGlz+VWfO6LRygH4QUfY/8W4RFwiT5i5WRgB0="}, "kindVersion": {"kind": "hashedrekord", "version": "0.0.1"}, "integratedTime": "1710869186", "inclusionPromise": {"signedEntryTimestamp": "MEYCIQDMNM49CNrcrpuvB9G3likdSse0miAkY0ILCqzRGP5ZJQIhAKnSS9GUSFVCar1+Sq3qoRtJIJ8x9tqRnQ8kuS1ojtTH"}, "inclusionProof": {"logIndex": "75408392", "rootHash": "Fnnj13Uu1jdksPc4HZLapKX329dVlD5+MGNsiqBq1XM=", "treeSize": "75408393", "hashes": ["1J7hRIEGvYdAyzEs+GhAE9L+38oHye3BhalgoQRZoo4=", "W/OUCkh/lqDDwbBkZgP7eTV/wx4WifD1wtfRLbavfxI=", "9wya2BEhfLGDfDRVN46OU2RXkozWCM1Z4qMu6SPiWoY=", "ZRs3lKAIlu0t0GtLupAcOu1y20nOaOshSKosWAqFO+w=", "BGqH+LzVuhuqCLiUvBJaB2hlsvtu2a15qq1WGw6mG44=", "OeS7D4kPES7ChE7kWSEmhbAMqBcKVj/z8/afMK4Y3pI=", "JtjqvAqFyXXYjWlZfDzElHpEzdBjsz1LmGFJuYx0kTU=", "s/ZIVcfcD4/nuZwUtQf4ydGsIAkGTPTzk3b0zhUC95k=", "YU1jZY/fp5tJdGF/i+/7ez8107O4/lOUp7acMPFEaOA=", "7Z18YLBAvejEV4nJHIKoks/xlijnhR005qTW2w4QtHg=", "98enzMaC+x5oCMvIZQA5z8vu2apDMCFvE/935NfuPw8="], "checkpoint": {"envelope": "rekor.sigstore.dev - 2605736670972794746\n75408393\nFnnj13Uu1jdksPc4HZLapKX329dVlD5+MGNsiqBq1XM=\n\n— rekor.sigstore.dev wNI9ajBFAiBTyiBM9WtyOTgohje6QZ5rFGJUdMq7Wk3A6oThE98SUgIhAMvxDwa7FyqRqg+YV3rdPPrfS23w19iK+piMSGVOmP5w\n"}}, "canonicalizedBody": "eyJhcGlWZXJzaW9uIjoiMC4wLjEiLCJraW5kIjoiaGFzaGVkcmVrb3JkIiwic3BlYyI6eyJkYXRhIjp7Imhhc2giOnsiYWxnb3JpdGhtIjoic2hhMjU2IiwidmFsdWUiOiJhMGNmYzcxMjcxZDZlMjc4ZTU3Y2QzMzJmZjk1N2MzZjcwNDNmZGRhMzU0YzRjYmIxOTBhMzBkNTZlZmEwMWJmIn19LCJzaWduYXR1cmUiOnsiY29udGVudCI6Ik1FVUNJQ1lGcS80YlRFZGx1cmdxVnVObXdDY0lXdTNOS09DZ3ZlV0FKQmllekowdUFpRUEyaTdVMTgrYVJwRnhMWWtzcjVIS0JRUXkwOHpFMDUwV0ljMFJ6S3VuRElBPSIsInB1YmxpY0tleSI6eyJjb250ZW50IjoiTFMwdExTMUNSVWRKVGlCRFJWSlVTVVpKUTBGVVJTMHRMUzB0Q2sxSlNVbE5WRU5EUWpkbFowRjNTVUpCWjBsVllVd3ZkSE50VVZSSWF6SXhiWFF4VlhWckszYzNZWFpFUW5vMGQwTm5XVWxMYjFwSmVtb3dSVUYzVFhjS1RucEZWazFDVFVkQk1WVkZRMmhOVFdNeWJHNWpNMUoyWTIxVmRWcEhWakpOVWpSM1NFRlpSRlpSVVVSRmVGWjZZVmRrZW1SSE9YbGFVekZ3WW01U2JBcGpiVEZzV2tkc2FHUkhWWGRJYUdOT1RXcFJkMDE2UlRWTlZHTjVUbXBKTWxkb1kwNU5hbEYzVFhwRk5VMVVZM3BPYWtreVYycEJRVTFHYTNkRmQxbElDa3R2V2tsNmFqQkRRVkZaU1V0dldrbDZhakJFUVZGalJGRm5RVVV5TWxNeGFpOU9hMFZZZWtKUVVVRjFZVzFJV0V4d2QzZ3JVbEJ1Ym5wYVVXd3ZjR3NLUlZvNGVHOXlka3R1ZW5WcVExTXhiVlpVUW04NWEwSjRiVmxYYnpKRVNIUjVWbmxtWjI1MVQzRldWSHBNV1cxb2J6WlBRMEowV1hkbloySlRUVUUwUndwQk1WVmtSSGRGUWk5M1VVVkJkMGxJWjBSQlZFSm5UbFpJVTFWRlJFUkJTMEpuWjNKQ1owVkdRbEZqUkVGNlFXUkNaMDVXU0ZFMFJVWm5VVlZHZGpGVENrTjZhVVZMVGpKeVVubHlhbVZXYkVaaVUweG5NUzlSZDBoM1dVUldVakJxUWtKbmQwWnZRVlV6T1ZCd2VqRlphMFZhWWpWeFRtcHdTMFpYYVhocE5Ga0tXa1E0ZDJkaFZVZEJNVlZrUlZGRlFpOTNVMEp0YWtOQ2JEUmhRbXhIYURCa1NFSjZUMms0ZGxveWJEQmhTRlpwVEcxT2RtSlRPWHBoVjJSNlpFYzVlUXBhVXpGcVlqSTFiV0l6U25SWlZ6VnFXbE01YkdWSVVubGFWekZzWWtocmRGcEhSblZhTWxaNVlqTldla3hZUWpGWmJYaHdXWGt4ZG1GWFVtcE1WMHBzQ2xsWFRuWmlhVGgxV2pKc01HRklWbWxNTTJSMlkyMTBiV0pIT1ROamVUbHNaVWhTZVZwWE1XeGlTR3QwV2tkR2RWb3lWbmxpTTFaNlRGYzVjRnBIVFhRS1dXMVdhRmt5T1hWTWJteDBZa1ZDZVZwWFducE1NbWhzV1ZkU2Vrd3lNV2hoVnpSM1QxRlpTMHQzV1VKQ1FVZEVkbnBCUWtGUlVYSmhTRkl3WTBoTk5ncE1lVGt3WWpKMGJHSnBOV2haTTFKd1lqSTFla3h0WkhCa1IyZ3hXVzVXZWxwWVNtcGlNalV3V2xjMU1FeHRUblppVkVGbVFtZHZja0puUlVWQldVOHZDazFCUlVOQ1FrWXpZak5LY2xwdGVIWmtNVGxyWVZoT2QxbFlVbXBoUkVFeVFtZHZja0puUlVWQldVOHZUVUZGUkVKRGFHcE9Na2w2V2tkYWFVMTZUVEVLV21wQk1VMVhWWGhaZW1jeVdXMVNhRTVIVFROTlZGcHRXVmROTlU0eVVtMU9ha3BvV2tSbmVFMURNRWREYVhOSFFWRlJRbWMzT0hkQlVWRkZTREJXTkFwa1NFcHNZbGRXYzJWVFFtdFpWelZ1V2xoS2RtUllUV2RVTUd4RlVYbENhVnBYUm1waU1qUjNVMUZaUzB0M1dVSkNRVWRFZG5wQlFrSlJVVGRqTW14dUNtTXpVblpqYlZWMFdUSTVkVnB0T1hsaVYwWjFXVEpWZGxwWWFEQmpiVlowV2xkNE5VeFhVbWhpYldSc1kyMDVNV041TVhaaFYxSnFURmRLYkZsWFRuWmlhVFUxWWxkNFFXTnRWbTFqZVRsdkNscFhSbXRqZVRsMFdWZHNkVTFFWjBkRGFYTkhRVkZSUW1jM09IZEJVazFGUzJkM2IxbDZaR2xOTWxKdFdXcE5lazVYV1hkT1ZFWnNUVmROTkU1dFNtc0tXVlJTYWs1NlJUSmFiVVpxVDFSa2ExcHFXWGxaVjFFMFRWUkJhRUpuYjNKQ1owVkZRVmxQTDAxQlJWVkNRazFOUlZoa2RtTnRkRzFpUnpreldESlNjQXBqTTBKb1pFZE9iMDFKUjBKQ1oyOXlRbWRGUlVGWlR5OU5RVVZXUWtoTlRXTlhhREJrU0VKNlQyazRkbG95YkRCaFNGWnBURzFPZG1KVE9YcGhWMlI2Q21SSE9YbGFVekZxWWpJMWJXSXpTblJaVnpWcVdsTTViR1ZJVW5sYVZ6RnNZa2hyZEZwSFJuVmFNbFo1WWpOV2VreFlRakZaYlhod1dYa3hkbUZYVW1vS1RGZEtiRmxYVG5aaWFUbG9XVE5TY0dJeU5YcE1NMG94WW01TmRrOUVUVEJPZWxFMFRWUlplVTlET1doa1NGSnNZbGhDTUdONU9IaE5RbGxIUTJselJ3cEJVVkZDWnpjNGQwRlNXVVZEUVhkSFkwaFdhV0pIYkdwTlNVZExRbWR2Y2tKblJVVkJaRm8xUVdkUlEwSklkMFZsWjBJMFFVaFpRVE5VTUhkaGMySklDa1ZVU21wSFVqUmpiVmRqTTBGeFNrdFljbXBsVUVzekwyZzBjSGxuUXpod04yODBRVUZCUjA5V09FRkljR2RCUVVKQlRVRlNla0pHUVdsQ1JtVk5ZbkFLUm1GeWJGQjNZakJ1WVZSeU5HMXFWMFIyV0VGd1QyUTVUMUp4VDJzek5rSnlkRGxUYlhkSmFFRktTblpxYjNJclJGaFZXSEkzVXpOV2JUbHFWa1pVTXdwRFREQkNlR05MUjJvNE5tMDFiVmw2VVhaMVlrMUJiMGREUTNGSFUwMDBPVUpCVFVSQk1tZEJUVWRWUTAxQk9HeFVhWGhrVXpScFRqbHRRVlZrZFU5aUNtTlRTbTFvV2t4NWRrczNlbUZZTURWRVRFVkVRMmRRVjNoRVNHc3JTa0phVlV0WlVrbDFTRWhuZDBadVQzZEplRUZNVFdGdGJ6bGtaa1ZPVFhwU1owNEtRM3BaWm5BdmVTdHlVMDlvVm1wWVdFVTViVU51TmtKMVNrVlViSEJTUkdaSGRuaFZaeTgxVEVZNVpqUnNXWEZ2ZWtFOVBRb3RMUzB0TFVWT1JDQkRSVkpVU1VaSlEwRlVSUzB0TFMwdENnPT0ifX19fQ=="}]}, "messageSignature": {"messageDigest": {"algorithm": "SHA2_256", "digest": "oM/HEnHW4njlfNMy/5V8P3BD/do1TEy7GQow1W76Ab8="}, "signature": "MEUCICYFq/4bTEdlurgqVuNmwCcIWu3NKOCgveWAJBiezJ0uAiEA2i7U18+aRpFxLYksr5HKBQQy08zE050WIc0RzKunDIA="}}''';

PackagePageData _createMockData({int? slsaLevel, String? attestationJson}) {
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
    ..slsaLevel = slsaLevel;

  final package = Package.fromVersion(version);

  final versionInfo = PackageVersionInfo()
    ..initFromKey(QualifiedVersionKey(package: 'test_pkg', version: '1.0.0'))
    ..versionCreated = DateTime.utc(2026, 1, 1)
    ..assets = [
      AssetKind.pubspec,
      AssetKind.readme,
      if (attestationJson != null) AssetKind.attestation,
    ];

  final asset = attestationJson != null
      ? (PackageVersionAsset.init(
          package: 'test_pkg',
          version: '1.0.0',
          kind: AssetKind.attestation,
          versionCreated: DateTime.utc(2026, 1, 1),
          path: 'test_pkg-1.0.0.sigstore.json',
          textContent: attestationJson,
        ))
      : null;

  return PackagePageData(
    package: package,
    version: version,
    versionInfo: versionInfo,
    asset: asset,
    scoreCard: ScoreCardData(),
    isAdmin: false,
    isLiked: false,
    weeklyDownloadCounts: null,
  );
}

void main() {
  group('AttestationDetails parsing', () {
    test('parses Sigstore bundle with certificate and Rekor log', () {
      final data = _createMockData(
        slsaLevel: 2,
        attestationJson: _sampleBundleJson,
      );
      final details = AttestationDetails.parse(
        data: data,
        rawBundleJson: _sampleBundleJson,
      );

      expect(details, isNotNull);
      expect(details!.slsaLevel, 2);
      expect(details.rekorLogIndex, '79571823');
      expect(
        details.rekorUrl,
        'https://search.sigstore.dev/?logIndex=79571823',
      );
      expect(details.rekorTimestamp, isNotNull);
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

    test('returns null when no attestation and slsaLevel is null', () {
      final data = _createMockData(slsaLevel: null);
      final details = AttestationDetails.parse(data: data, rawBundleJson: null);
      expect(details, isNull);
    });
  });

  group('securityTabNode UI rendering', () {
    test('renders full Level AAA provenance details when attestation exists', () {
      final data = _createMockData(
        slsaLevel: 2,
        attestationJson: _sampleBundleJson,
      );
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
        contains(
          'title="https://search.sigstore.dev/?logIndex=79571823"',
        ),
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
