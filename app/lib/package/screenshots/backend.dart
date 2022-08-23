// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:mime/mime.dart';
import 'package:pub_dev/shared/storage.dart';

final Logger _logger = Logger('pub.cloud_repository');

/// Sets the active image storage.
void registerImageStorage(ImageStorage ims) =>
    ss.register(#_image_storage, ims);

/// The active image storage.
ImageStorage get imageStorage => ss.lookup(#_image_storage) as ImageStorage;

/// Helper utility class for interfacing with Cloud Storage for storing
/// images.
class ImageStorage {
  final Bucket bucket;
  ImageStorage(this.bucket);

  final _supportedMIMETypes = [
    'image/apng',
    'image/avif',
    'image/gif',
    'image/jpeg',
    'image/png',
    'image/svg+xml',
    'image/webp'
  ];

  /// Uploads an image to image storage, at
  /// '<package>/<version>/<path/to/image-file>'.
  ///
  /// Throws an [ArgumentError] if the provided image file is not one of
  /// the following supported MIME types : image/apng, image/avif, image/gif,
  /// image/jpeg, image/png, image/svg+xml, image/webp.
  Future<void> upload(
      String package,
      String version,
      Stream<List<int>> Function() openStream,
      String imageFilePath,
      int length) async {
    final String? mimeType = lookupMimeType(imageFilePath);
    if (mimeType == null || !isAllowedContentType(imageFilePath)) {
      _logger.info(
          'Image upload of $imageFilePath for package $package failed. '
          'The file $imageFilePath is not one of the following supported MIME '
          'types: ${_supportedMIMETypes.join(', ')}.');
      throw ArgumentError(
          'Failed to upload image file: Unsupported MIME type.');
    }

    return bucket.uploadPublic([package, version, imageFilePath].join('/'),
        length, openStream, mimeType);
  }

  /// Validates whether the given image at [imageFilePath] is one of the
  /// supported MIME types.
  bool isAllowedContentType(String imageFilePath) {
    final String? mimeType = lookupMimeType(imageFilePath);
    return _supportedMIMETypes.contains(mimeType);
  }

  // TODO(zarah) add functionality to garbage collect bucket entries.

  String getImageUrl(String package, String version, String imageFilePath) {
    return bucket.objectUrl([package, version, imageFilePath].join('/'));
  }
}
