// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../shared/datastore.dart' as db;

@db.Kind(name: 'History', idType: db.IdType.String)
@deprecated
class History extends db.ExpandoModel<String> {}
