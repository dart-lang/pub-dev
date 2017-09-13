// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:gcloud/db.dart' as db;

import '../shared/search_service.dart' show PackageDocument;

/// Data to index about a package.
@db.Kind(name: 'PackageSearch', idType: db.IdType.String)
class PackageSearch extends db.ExpandoModel {
  String get packageName => id;

  @db.DateTimeProperty()
  DateTime lastAnalyzed;

  @db.BlobProperty()
  List<int> documentJsonGz;

  PackageSearch();

  PackageSearch.fromDocument(PackageDocument document) {
    id = document.package;
    lastAnalyzed = document.timestamp;
    document = document;
  }

  PackageDocument get document {
    if (documentJsonGz == null) return null;
    return new PackageDocument.fromJson(
        JSON.decode(UTF8.decode(_gzipCodec.decode(documentJsonGz))));
  }

  set document(PackageDocument doc) {
    if (doc == null) {
      documentJsonGz = null;
    } else {
      documentJsonGz =
          _gzipCodec.encode(UTF8.encode(JSON.encode(doc.toJson())));
    }
  }
}

final GZipCodec _gzipCodec = new GZipCodec();
