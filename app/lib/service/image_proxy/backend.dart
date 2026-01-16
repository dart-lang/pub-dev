// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/cloudkms/v1.dart' as kms;
import 'package:googleapis_auth/auth_io.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:retry/retry.dart';

import '../../shared/cached_value.dart';

final Logger logger = Logger('pub.image_proxy.backend');

/// Sets the Image proxy backend service.
void registerImageProxyBackend(ImageProxyBackend backend) =>
    ss.register(#_imageProxyBackend, backend);

/// The active Youtube backend service.
ImageProxyBackend get imageProxyBackend =>
    ss.lookup(#_imageProxyBackend) as ImageProxyBackend;

/// Represents the backend for the Youtube handling and related utilities.
class ImageProxyBackend {
  ImageProxyBackend._();

  static Future<ImageProxyBackend> create() async {
    final instance = ImageProxyBackend._();
    await instance._dailySecret.update();
    return instance;
  }

  static Future<List<int>> _getDailySecret(
    DateTime day,
    AuthClient client,
  ) async {
    return await retry(() async {
      final api = kms.CloudKMSApi(client);
      final response = await api
          .projects
          .locations
          .keyRings
          .cryptoKeys
          .cryptoKeyVersions
          .macSign(
            kms.MacSignRequest()
              ..dataAsBytes = utf8.encode(
                DateTime(
                  day.year,
                  day.month,
                  day.day,
                ).toUtc().toIso8601String(),
              ),
            activeConfiguration.imageProxyHmacKeyVersion!,
          );
      return response.macAsBytes;
    });
  }

  final _dailySecret = CachedValue(
    name: 'image-proxy-daily-secret',
    interval: Duration(minutes: 15),
    maxAge: Duration(hours: 12),
    timeout: Duration(hours: 12),
    updateFn: () async {
      final now = DateTime.now().toUtc();
      final today = DateTime(now.year, now.month, now.day);
      return (
        today,
        await _getDailySecret(
          today,
          await clientViaApplicationDefaultCredentials(
            scopes: [kms.CloudKMSApi.cloudPlatformScope],
          ),
        ),
      );
    },
  );

  String imageProxyUrl(Uri originalUrl) {
    final dailySecret = _dailySecret.value;
    // TODO handle the null case more gracefully.
    if (dailySecret == null) {
      throw StateError('Image proxy HMAC secret is not available.');
    }
    final (today, secret) = dailySecret;
    final hmac = Hmac(
      sha256,
      secret,
    ).convert(utf8.encode(originalUrl.toString())).bytes;
    activeConfiguration.imageProxyServiceBaseUrl;

    logger.info('Generating image proxy url for $originalUrl $secret $hmac');
    return '${activeConfiguration.imageProxyServiceBaseUrl}/${Uri.encodeComponent(base64Encode(hmac))}/${today.millisecondsSinceEpoch}/${Uri.encodeComponent(originalUrl.toString())}';
  }
}
