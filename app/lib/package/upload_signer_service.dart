// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.upload_signer_service;

import 'dart:async';
import 'dart:convert';

import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
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
        'Configuration.uploadSignerServiceAccount must be set.');
  }
  return _IamBasedUploadSigner(
      activeConfiguration.projectId, email, authClient);
}

/// Signs Google Cloud Storage upload URLs.
///
/// Instead of letting the pub client upload package data via the pub server
/// application we will let it upload to Google Cloud Storage directly.
///
/// Since the GCS bucket is not writable by third parties we will make a signed
/// upload URL and give this to the client. The client can then for a given time
/// period use the signed upload URL to upload the data directly to
/// gs://<bucket>/<object>. The expiration date, acl, content-length-range are
/// determined by the server.
///
/// See here for a broader explanation:
/// https://cloud.google.com/storage/docs/xml-api/post-object
abstract class UploadSignerService {
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

  Future<SigningResult> sign(List<int> bytes);
}

/// Uses the [iam.IamApi] to sign Google Cloud Storage upload URLs.
///
/// See [UploadSignerService] for more information.
class _IamBasedUploadSigner extends UploadSignerService {
  final String projectId;
  final String email;
  final iam.IamApi iamApi;

  _IamBasedUploadSigner(this.projectId, this.email, http.Client client)
      : iamApi = iam.IamApi(client);

  @override
  Future<SigningResult> sign(List<int> bytes) async {
    final request = iam.SignBlobRequest()..bytesToSignAsBytes = bytes;
    final name = 'projects/$projectId/serviceAccounts/$email';
    final iam.SignBlobResponse response =
        // TODO: figure out what new API we should use.
        // ignore: deprecated_member_use
        await iamApi.projects.serviceAccounts.signBlob(request, name);
    return SigningResult(email, response.signatureAsBytes);
  }
}

class SigningResult {
  final String googleAccessId;
  final List<int> bytes;

  SigningResult(this.googleAccessId, this.bytes);
}
