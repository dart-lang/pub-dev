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

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:pubserver/repository.dart';

import 'models.dart';

/// The registered [UploadSignerService] object.
UploadSignerService get uploadSigner => ss.lookup(#_url_signer);

/// Register a new [UploadSignerService] object into the current service
/// scope.
void registerUploadSigner(UploadSignerService uploadSigner)
    => ss.register(#_url_signer, uploadSigner);

/// Uses the datastore API in the current service scope to retrieve the private
/// Key and creates a new [UploadSignerService].
///
/// If the private key cannot be retrieved from datastore this method will
/// complete with `null`.
Future<UploadSignerService>
    uploadSignerServiceViaApiKeyFromDb(String serviceAccountEmail) async {
  var db = dbService;

  var privateKeyKey = db.emptyKey.append(PrivateKey, id: 'singleton');
  PrivateKey apiKey = (await db.lookup([privateKeyKey])).first;
  if (apiKey == null) return null;

  return new UploadSignerService(serviceAccountEmail,
                                 pem.keyFromString(apiKey.value));
}

/// Used for building cloud storage upload information with signatures.
///
/// See here for a broader explanation:
/// https://cloud.google.com/storage/docs/reference-methods#postobject
class UploadSignerService {
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
                               int maxUploadSize: 10 * 1024 * 1024}) {
    var now = new DateTime.now().toUtc();
    var expirationString = now.add(lifetime).toIso8601String();

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
