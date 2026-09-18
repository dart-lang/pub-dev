// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/shared/datastore.dart' as db;

/// `GlobalLock` claims are now stored in SQL, this entity is only kept
/// around to delete leftover entities from Datastore.
@db.Kind(name: 'GlobalLockState', idType: db.IdType.String)
@Deprecated('No longer in use.')
class GlobalLockState extends db.ExpandoModel<String> {}
