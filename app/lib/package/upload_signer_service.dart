// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/utils/http.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/iam/v1.dart' as iam;
import 'package:http/http.dart' as http;

import '../shared/configuration.dart';
import '../shared/utils.dart' show jsonUtf8Encoder;

/// The registered [UploadSignerService] object.
UploadSignerService get uploadSigner =>
    ss.lookup(#_url_signer) as UploadSignerService;

/// Register a new [UploadSignerService] object into the current service
/// scope.
void registerUploadSigner(UploadSignerService uploadSigner) =>
    ss.register(#_url_signer, uploadSigner);

/// Creates an upload signer based on the current environment.
Future<UploadSignerService> createUploadSigner(http.Client authClient) async {
  final email = activeConfiguration.uploadSignerServiceAccount;
  if (email == null) {
    throw AssertionError(
      'Configuration.uploadSignerServiceAccount must be set.',
    );
  }
  return _IamBasedUploadSigner(
    activeConfiguration.projectId,
    email,
    authClient,
  );
}

/// Signs Google Cloud Storage upload URLs.
///
/// Instead of letting the pub client upload package data via the pub server
/// application we will let it upload to Google Cloud Storage directly.
///
/// Since the GCS bucket is not writable by third parties we will make a signed
/// upload URL and give this to the client. The client can then for a given time
/// period use the signed upload URL to upload the data directly to
/// `gs://<bucket>/<object>`. The expiration date, acl, content-length-range are
/// determined by the server.
///
/// See here for a broader explanation:
/// https://cloud.google.com/storage/docs/xml-api/post-object
// TODO(jonasfj): Rename to BucketSignerService.
abstract class UploadSignerService {
  /// The Google Access ID (e.g. service account email) used for signing.
  String get googleAccessId;

  static const int maxUploadSize = 100 * 1024 * 1024;
  static final Uri _uploadUrl = Uri.parse('https://storage.googleapis.com');

  Future<UploadInfo> buildUpload(
    String bucket,
    String object,
    Duration lifetime, {
    String? successRedirectUrl,
    int maxUploadSize = maxUploadSize,
  }) async {
    final now = clock.now().toUtc();
    final expirationString = now.add(lifetime).toIso8601String();

    final key = '$bucket/$object';
    final conditions = [
      {'key': key},
      {'expires': expirationString},
      if (successRedirectUrl != null)
        {'success_action_redirect': successRedirectUrl},
      ['content-length-range', 0, maxUploadSize],
    ];

    final policyMap = {
      'expiration': expirationString,
      'conditions': conditions,
    };

    final policyString = base64.encode(jsonUtf8Encoder.convert(policyMap));
    final SigningResult result = await sign(ascii.encode(policyString));
    final signatureString = base64.encode(result.bytes);

    final fields = {
      'key': key,
      'Expires': expirationString,
      'GoogleAccessId': result.googleAccessId,
      'policy': policyString,
      'signature': signatureString,
      if (successRedirectUrl != null)
        'success_action_redirect': successRedirectUrl,
    };

    return UploadInfo(url: _uploadUrl.toString(), fields: fields);
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

    final canonicalUri = '/$bucket/$object';

    final canonicalRequest = [
      'GET',
      canonicalUri,
      canonicalQueryString,
      'host:storage.googleapis.com\n',
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

/// Uses the [iam.IamApi] to sign Google Cloud Storage upload URLs.
///
/// See [UploadSignerService] for more information.
class _IamBasedUploadSigner extends UploadSignerService {
  final String projectId;
  final String email;
  final http.Client authClient;

  _IamBasedUploadSigner(this.projectId, this.email, this.authClient);

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

class SigningResult {
  final String googleAccessId;
  final List<int> bytes;

  SigningResult(this.googleAccessId, this.bytes);
}
