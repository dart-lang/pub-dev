// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:_pub_shared/utils/http.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/iam/v1.dart' as iam;
import 'package:http/http.dart' as http;

import '../shared/configuration.dart';
import 'upload_signer_service.dart' show SigningResult;

/// The registered [DownloadSignerService] object.
DownloadSignerService get downloadSigner =>
    ss.lookup(#_download_url_signer) as DownloadSignerService;

/// Register a new [DownloadSignerService] object into the current service
/// scope.
void registerDownloadSigner(DownloadSignerService downloadSigner) =>
    ss.register(#_download_url_signer, downloadSigner);

/// Creates an download signer based on the current environment.
Future<DownloadSignerService> createDownloadSigner(
  http.Client authClient,
) async {
  final email = activeConfiguration.downloadSignerServiceAccount;
  return _IamBasedDownloadSigner(
    activeConfiguration.projectId,
    email,
    authClient,
  );
}

/// Signs Google Cloud Storage URLs for downloading objects securely.
abstract base class DownloadSignerService {
  /// The Google Access ID (e.g. service account email) used for signing.
  String get googleAccessId;

  /// Google Cloud Storage V4 signatures require strict RFC 3986 encoding.
  /// Dart's Uri.encodeComponent does not encode !, ', (, ), or *.
  /// https://cloud.google.com/storage/docs/authentication/canonical-requests#about-resource-path
  String _uriEncode(String input) {
    return Uri.encodeComponent(input)
        .replaceAll('!', '%21')
        .replaceAll("'", '%27')
        .replaceAll('(', '%28')
        .replaceAll(')', '%29')
        .replaceAll('*', '%2A');
  }

  /// Builds a V4 signed URL for downloading a Google Cloud Storage object.
  Future<Uri> buildDownloadUrl(
    String bucket,
    String object,
    Duration lifetime,
  ) async {
    final now = clock.now().toUtc();
    final datetime = now
        .toIso8601String()
        .replaceAll('-', '')
        .replaceAll(':', '')
        .replaceAll(RegExp(r'\.\d+'), '');
    final date = datetime.split('T').first;
    final scope = '$date/auto/storage/goog4_request';

    final canonicalQueryParameters = {
      'X-Goog-Algorithm': 'GOOG4-RSA-SHA256',
      'X-Goog-Credential': '$googleAccessId/$scope',
      'X-Goog-Date': datetime,
      'X-Goog-Expires': '${lifetime.inSeconds}',
      'X-Goog-SignedHeaders': 'host',
    };

    final canonicalQueryString = canonicalQueryParameters.entries
        .sortedBy((e) => e.key)
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');

    final canonicalUri =
        '/$bucket/${object.split('/').map(_uriEncode).join('/')}';

    final canonicalRequest = [
      'GET',
      canonicalUri,
      canonicalQueryString,
      'host:storage.googleapis.com',
      '', // empty line separates headers and signed headers
      'host',
      'UNSIGNED-PAYLOAD', // 'GET' request has no payload
    ].join('\n');

    final canonicalRequestHash = hex.encode(
      sha256.convert(utf8.encode(canonicalRequest)).bytes,
    );

    final stringToSign = [
      'GOOG4-RSA-SHA256',
      datetime,
      scope,
      canonicalRequestHash,
    ].join('\n');

    final result = await sign(utf8.encode(stringToSign));

    return Uri(
      scheme: 'https',
      host: 'storage.googleapis.com',
      path: canonicalUri,
      queryParameters: {
        ...canonicalQueryParameters,
        'X-Goog-Signature': hex.encode(result.bytes),
      },
    );
  }

  Future<SigningResult> sign(List<int> bytes);
}

/// Uses the [iam.IamApi] to sign Google Cloud Storage download URLs.
final class _IamBasedDownloadSigner extends DownloadSignerService {
  final String projectId;
  final String email;
  final http.Client authClient;

  _IamBasedDownloadSigner(this.projectId, this.email, this.authClient);

  @override
  String get googleAccessId => email;

  @override
  Future<SigningResult> sign(List<int> bytes) async {
    final request = iam.SignBlobRequest()..bytesToSignAsBytes = bytes;
    final name = 'projects/$projectId/serviceAccounts/$email';
    return await withRetryHttpClient(client: authClient, (client) async {
      final iamApi = iam.IamApi(client);
      final response =
          // TODO: figure out what new API we should use.
          // ignore: deprecated_member_use
          await iamApi.projects.serviceAccounts.signBlob(request, name);
      return SigningResult(email, response.signatureAsBytes);
    });
  }
}
