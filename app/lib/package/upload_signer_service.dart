// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.upload_signer_service;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/iam/v1.dart' as iam;
import 'package:googleapis_auth/auth_io.dart' as auth;
// ignore: implementation_imports
import 'package:googleapis_auth/src/crypto/rsa_sign.dart';
import 'package:http/http.dart' as http;

import 'package:client_data/package_api.dart';

import '../shared/configuration.dart';

/// The registered [UploadSignerService] object.
UploadSignerService get uploadSigner =>
    ss.lookup(#_url_signer) as UploadSignerService;

/// Register a new [UploadSignerService] object into the current service
/// scope.
void registerUploadSigner(UploadSignerService uploadSigner) =>
    ss.register(#_url_signer, uploadSigner);

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

  Future<UploadInfo> buildUpload(String bucket, String object,
      Duration lifetime, String successRedirectUrl,
      {String predefinedAcl = 'project-private',
      int maxUploadSize = maxUploadSize}) async {
    final now = DateTime.now().toUtc();
    final expirationString = now.add(lifetime).toIso8601String();

    object = '$bucket/$object';
    final conditions = [
      {'key': object},
      {'acl': predefinedAcl},
      {'expires': expirationString},
      {'success_action_redirect': successRedirectUrl},
      ['content-length-range', 0, maxUploadSize],
    ];

    final policyMap = {
      'expiration': expirationString,
      'conditions': conditions,
    };

    final policyString = base64.encode(utf8.encode(json.encode(policyMap)));
    final SigningResult result = await sign(ascii.encode(policyString));
    final signatureString = base64.encode(result.bytes);

    final fields = {
      'key': object,
      'acl': predefinedAcl,
      'Expires': expirationString,
      'GoogleAccessId': result.googleAccessId,
      'policy': policyString,
      'signature': signatureString,
      'success_action_redirect': successRedirectUrl,
    };

    return UploadInfo(url: _uploadUrl.toString(), fields: fields);
  }

  Future<SigningResult> sign(List<int> bytes);
}

/// Uses [auth.ServiceAccountCredentials] to sign Google Cloud Storage upload
/// URLs. Connection parameters are inferred from the GCLOUD_PROJECT and the
/// GCLOUD_KEY environment variables.
///
/// See [UploadSignerService] for more information.
class ServiceAccountBasedUploadSigner extends UploadSignerService {
  final String googleAccessId;
  final RS256Signer signer;

  ServiceAccountBasedUploadSigner._(this.googleAccessId, this.signer);

  factory ServiceAccountBasedUploadSigner() {
    if (envConfig.gcloudKey == null) {
      throw Exception('Missing GCLOUD_* environments for package:appengine');
    }
    final path = envConfig.gcloudKey;
    final content = File(path).readAsStringSync();
    final account = auth.ServiceAccountCredentials.fromJson(content);
    return ServiceAccountBasedUploadSigner._(
        account.email, RS256Signer(account.privateRSAKey));
  }

  @override
  Future<SigningResult> sign(List<int> bytes) async {
    return SigningResult(googleAccessId, signer.sign(bytes));
  }
}

/// Uses the [iam.IamApi] to sign Google Cloud Storage upload URLs.
///
/// See [UploadSignerService] for more information.
class IamBasedUploadSigner extends UploadSignerService {
  final String projectId;
  final String email;
  final iam.IamApi iamApi;

  IamBasedUploadSigner(this.projectId, this.email, http.Client client)
      : iamApi = iam.IamApi(client);

  @override
  Future<SigningResult> sign(List<int> bytes) async {
    final request = iam.SignBlobRequest()..bytesToSignAsBytes = bytes;
    final name = 'projects/$projectId/serviceAccounts/$email';
    final iam.SignBlobResponse response =
        await iamApi.projects.serviceAccounts.signBlob(request, name);
    return SigningResult(email, response.signatureAsBytes);
  }
}

class SigningResult {
  final String googleAccessId;
  final List<int> bytes;

  SigningResult(this.googleAccessId, this.bytes);
}
