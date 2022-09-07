// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package_api.dart' show UploadInfo;

part 'task_api.g.dart';

/// Response with signed URLs for uploading task results.
///
/// It is important that files are uploaded in the order specified in
/// documentation. The big files [dartdocBlob] and [panaLog] will be uploaded
/// to unique filenames containing a unique identifier. This identifier should
/// be embedded in the [dartdocIndex] and [panaReport] files, these files are
/// much smaller and uploaded to well-known locations.
///
/// This gives us some atomicity when uploading results, until the dartdoc index
/// file is uploaded, we will keep using the old dartdoc blob file.
@JsonSerializable()
class UploadTaskResultResponse {
  /// Identifier for the [dartdocBlob] file which should be written into the
  /// [dartdocIndex] file.
  final String dartdocBlobId;

  /// Identifier for the [panaLog] file which should be written into the
  /// [panaReport] file.
  final String panaLogId;

  /// [UploadInfo] for uploading the dartdoc blob file.
  final UploadInfo dartdocBlob;

  /// [UploadInfo] for uploading the dartdoc index file.
  ///
  /// This should be uploaded after successful upload of the dartdoc blob.
  /// This file should embed the [dartdocBlobId].
  final UploadInfo dartdocIndex;

  /// [UploadInfo] for uploading the analysis log.
  final UploadInfo panaLog;

  /// [UploadInfo] for uploading the pana report file.
  ///
  /// This should be uploaded after successful upload of the pana log.
  /// This file should embed the [panaLogId].
  final UploadInfo panaReport;

  // json_serializable boiler-plate
  UploadTaskResultResponse({
    required this.dartdocBlobId,
    required this.panaLogId,
    required this.dartdocBlob,
    required this.dartdocIndex,
    required this.panaLog,
    required this.panaReport,
  });
  factory UploadTaskResultResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadTaskResultResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UploadTaskResultResponseToJson(this);
}
