// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/database/schema.dart';
import 'package:typed_sql/typed_sql.dart';

/// Prints the DDL statements required for the desired database state.
void main() {
  // Prints the schema defined via `typed_sql`
  print(createPrimarySchemaTables(SqlDialect.postgres()));
  // Note: add further print statements if needed.
}
