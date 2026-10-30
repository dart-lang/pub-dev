// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../shared/datastore.dart' as db;

/// Legacy Datastore entity: the download counts have moved to SQL, only the
/// id remains so that the leftover entities can be deleted.
@db.Kind(name: 'DownloadCounts', idType: db.IdType.String)
class DownloadCounts extends db.ExpandoModel<String> {
  String get package => id!;
}
