// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

import '../shared/datastore.dart' as db;
part 'models.g.dart';

/// Status values for [DartdocRun].
abstract class DartdocRunStatus {
  static const uploading = 'uploading';
  static const ready = 'ready';
  static const deleting = 'deleting';
}

@db.Kind(name: 'DartdocRun', idType: db.IdType.String)
class DartdocRun extends db.ExpandoModel<String> {
  /// Unique identifier that identifies a specific execution of dartdoc.
  String? get runId => id;

  @db.DateTimeProperty(required: true)
  DateTime? created;

  /// Indicates the status of the run, e.g. if the content is still uploading.
  /// Values are described in [DartdocRunStatus].
  @db.StringProperty(required: true, indexed: true)
  String? status;

  @db.StringProperty(required: true, indexed: true)
  String? package;

  @db.StringProperty(required: true, indexed: false)
  String? version;

  /// The package and version encoded as `<package>/<version>`.
  @db.StringProperty(required: true, indexed: true)
  String? packageVersion;

  @db.StringProperty(required: true, indexed: true)
  String? runtimeVersion;

  /// The package, version and runtime encoded as
  /// `<package>/<version>/<runtimeVersion>`.
  @db.StringProperty(required: true, indexed: true)
  String? packageVersionRuntime;

  /// Indicates whether at the time of running dartdoc the version was
  /// considered the latest stable version of the package.
  @db.BoolProperty(required: true, indexed: false)
  bool? wasLatestStable;

  /// The time spent generating the content (in seconds).
  @db.IntProperty(required: true, indexed: false)
  int? runDurationInSeconds;

  /// Indicates whether the run has a valid content and can be served.
  /// The content directory may contain the log.txt file even if there was an
  /// error while running dartdoc.
  @db.BoolProperty(required: true, indexed: false)
  bool? hasValidContent;

  /// Contains user-friendly message describing the reason if there is
  /// no content. (E.g. may be too old, dartdoc failed)
  @db.StringProperty(indexed: false)
  String? errorMessage;

  /// The size of the archive file.
  @db.IntProperty(required: true, indexed: false)
  int? archiveSize;

  /// The directory path inside the storage bucket where the content lives.
  @db.StringProperty(required: true, indexed: false)
  String? contentPath;

  /// The total size of the generated content.
  @db.IntProperty(required: true, indexed: false)
  int? contentSize;

  /// DartdocEntry encoded as JSON string.
  @db.StringProperty(required: true, indexed: false)
  String? entryJson;

  /// Indicates whether the content has been expired and replaced by a newer
  /// [DartdocRun] in the current runtime.
  @db.BoolProperty(required: true, indexed: true)
  bool? isExpired;
}

/// Describes the resolved version and the URL redirect info.
@JsonSerializable()
class ResolvedDocUrlVersion {
  /// The version to use to display the documentation.
  final String version;

  /// The URL segment that should be used to display the version.
  final String segment;

  ResolvedDocUrlVersion({
    required this.version,
    required this.segment,
  });

  factory ResolvedDocUrlVersion.fromJson(Map<String, dynamic> json) =>
      _$ResolvedDocUrlVersionFromJson(json);

  Map<String, dynamic> toJson() => _$ResolvedDocUrlVersionToJson(this);

  bool get isEmpty => version.isEmpty || segment.isEmpty;
}
