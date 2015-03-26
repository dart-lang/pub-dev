// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.upload_signer_service;

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:googleapis_auth/src/crypto/rsa_sign.dart';
import 'package:googleapis_auth/src/crypto/pem.dart' as pem;
import 'package:googleapis_auth/src/crypto/rsa.dart' as rsa;

import 'package:gcloud/service_scope.dart' as ss;
import 'package:pub_server/repository.dart';

import 'keys.dart';

/// The registered [UploadSignerService] object.
UploadSignerService get uploadSigner => ss.lookup(#_url_signer);

/// Register a new [UploadSignerService] object into the current service
/// scope.
void registerUploadSigner(UploadSignerService uploadSigner)
    => ss.register(#_url_signer, uploadSigner);

/// Uses the datastore API in the current service scope to retrieve the private
/// Key and creates a new [UploadSignerService].
Future<UploadSignerService>
    uploadSignerServiceViaApiKeyFromDb(String serviceAccountEmail) async {
  String pemFileString = await cloudStorageKeyFromDB();
  return new UploadSignerService(serviceAccountEmail,
                                 pem.keyFromString(pemFileString));
}

/// Used for building cloud storage upload information with signatures.
///
/// See here for a broader explanation:
/// https://cloud.google.com/storage/docs/reference-methods#postobject
class UploadSignerService {
  static const int MAX_UPLOAD_SIZE = 100 * 1024 * 1024;
  static final Uri UploadUrl = Uri.parse('https://storage.googleapis.com');

  final String serviceAccountEmail;
  final RS256Signer _signer;

  UploadSignerService(String serviceAccountEmail,
                      rsa.RSAPrivateKey privateKey)
      : serviceAccountEmail = serviceAccountEmail,
        _signer = new RS256Signer(privateKey);

  AsyncUploadInfo buildUpload(String bucket,
                              String object,
                              Duration lifetime,
                              String successRedirectUrl,
                              {String predefinedAcl: 'project-private',
                               int maxUploadSize: MAX_UPLOAD_SIZE}) {
    var now = new DateTime.now().toUtc();
    var expirationString = now.add(lifetime).toIso8601String();

    object = '$bucket/$object';
    var conditions = [
        {'key' : object},
        {'acl' : predefinedAcl},
        {'expires' : expirationString},
        {'success_action_redirect' : successRedirectUrl},
        ['content-length-range', 0, maxUploadSize],
    ];

    var policyMap = {
        'expiration' : expirationString,
        'conditions' : conditions,
    };

    var policyString =
        CryptoUtils.bytesToBase64(UTF8.encode(JSON.encode(policyMap)));
    var signatureString =
        CryptoUtils.bytesToBase64(_signer.sign(ASCII.encode(policyString)));

    var fields = {
        'key' : object,
        'acl' : predefinedAcl,
        'Expires' : expirationString,
        'GoogleAccessId' : serviceAccountEmail,
        'policy' : policyString,
        'signature' : signatureString,
        'success_action_redirect' : successRedirectUrl,
    };

    return new AsyncUploadInfo(UploadUrl, fields);
  }
}
