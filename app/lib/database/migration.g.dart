// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migration.dart';

// **************************************************************************
// Generator: _TypedSqlBuilder
// **************************************************************************

/// Extension methods for a [Database] operating on [SchemaMigrationSchema].
extension SchemaMigrationSchemaSchema on Database<SchemaMigrationSchema> {
  static const _$tables = [_$SchemaMigration._$table];

  Table<SchemaMigration> get schemaMigrations =>
      $ForGeneratedCode.declareTable(this, _$SchemaMigration._$table);

  /// Create tables defined in [SchemaMigrationSchema].
  ///
  /// Calling this on an empty database will create the tables
  /// defined in [SchemaMigrationSchema]. In production it's often better to
  /// use [createSchemaMigrationSchemaTables] and manage migrations using
  /// external tools.
  ///
  /// This method is mostly useful for testing.
  ///
  /// > [!WARNING]
  /// > If the database is **not empty** behavior is undefined, most
  /// > likely this operation will fail.
  Future<void> createTables() async =>
      $ForGeneratedCode.createTables(context: this, tables: _$tables);
}

/// Get SQL [DDL statements][1] for tables defined in [SchemaMigrationSchema].
///
/// This returns a SQL script with multiple DDL statements separated by `;`
/// using the specified [dialect].
///
/// Executing these statements in an empty database will create the tables
/// defined in [SchemaMigrationSchema]. In practice, this method is often used for
/// printing the DDL statements, such that migrations can be managed by
/// external tools.
///
/// [1]: https://en.wikipedia.org/wiki/Data_definition_language
String createSchemaMigrationSchemaTables(SqlDialect dialect) =>
    $ForGeneratedCode.createTableSchema(
      dialect: dialect,
      tables: SchemaMigrationSchemaSchema._$tables,
    );

final class _$SchemaMigration extends SchemaMigration {
  _$SchemaMigration._(
    this.migrationsName,
    this.scriptName,
    this.scriptSha256,
    this.executed,
  );

  @override
  final String migrationsName;

  @override
  final String scriptName;

  @override
  final String scriptSha256;

  @override
  final DateTime executed;

  static const _$table = (
    tableName: 'schemaMigrations',
    columns: <String>[
      'migrationsName',
      'scriptName',
      'scriptSha256',
      'executed',
    ],
    columnInfo:
        <
          ({
            ColumnType type,
            bool isNotNull,
            Object? defaultValue,
            bool autoIncrement,
            List<SqlOverride> overrides,
          })
        >[
          (
            type: $ForGeneratedCode.text,
            isNotNull: true,
            defaultValue: null,
            autoIncrement: false,
            overrides: <SqlOverride>[],
          ),
          (
            type: $ForGeneratedCode.text,
            isNotNull: true,
            defaultValue: null,
            autoIncrement: false,
            overrides: <SqlOverride>[],
          ),
          (
            type: $ForGeneratedCode.text,
            isNotNull: true,
            defaultValue: null,
            autoIncrement: false,
            overrides: <SqlOverride>[],
          ),
          (
            type: $ForGeneratedCode.dateTime,
            isNotNull: true,
            defaultValue: null,
            autoIncrement: false,
            overrides: <SqlOverride>[],
          ),
        ],
    primaryKey: <String>['migrationsName', 'scriptName'],
    unique: <List<String>>[],
    foreignKeys:
        <
          ({
            String name,
            List<String> columns,
            String referencedTable,
            List<String> referencedColumns,
          })
        >[],
    readRow: _$SchemaMigration._$fromDatabase,
  );

  static SchemaMigration? _$fromDatabase(RowReader row) {
    final migrationsName = row.readString();
    final scriptName = row.readString();
    final scriptSha256 = row.readString();
    final executed = row.readDateTime();
    if (migrationsName == null &&
        scriptName == null &&
        scriptSha256 == null &&
        executed == null) {
      return null;
    }
    return _$SchemaMigration._(
      migrationsName!,
      scriptName!,
      scriptSha256!,
      executed!,
    );
  }

  @override
  String toString() =>
      'SchemaMigration(migrationsName: "$migrationsName", scriptName: "$scriptName", scriptSha256: "$scriptSha256", executed: "$executed")';
}

/// Extension methods for table defined in [SchemaMigration].
extension TableSchemaMigrationExt on Table<SchemaMigration> {
  /// Insert row into the `schemaMigrations` table.
  ///
  /// Returns a [InsertSingle] statement on which `.execute` must be
  /// called for the row to be inserted.
  InsertSingle<SchemaMigration> insert({
    required Expr<String> migrationsName,
    required Expr<String> scriptName,
    required Expr<String> scriptSha256,
    required Expr<DateTime> executed,
  }) => $ForGeneratedCode.insertInto(
    table: this,
    values: [migrationsName, scriptName, scriptSha256, executed],
  );

  /// Delete a single row from the `schemaMigrations` table, specified by
  /// _primary key_.
  ///
  /// Returns a [DeleteSingle] statement on which `.execute()` must be
  /// called for the row to be deleted.
  ///
  /// To delete multiple rows, using `.where()` to filter which rows
  /// should be deleted. If you wish to delete all rows, use
  /// `.where((_) => toExpr(true)).delete()`.
  DeleteSingle<SchemaMigration> delete(
    String migrationsName,
    String scriptName,
  ) => $ForGeneratedCode.deleteSingle(
    byKey(migrationsName, scriptName),
    _$SchemaMigration._$table,
  );
}

/// Extension methods for building queries against the `schemaMigrations` table.
extension QuerySchemaMigrationExt on Query<(Expr<SchemaMigration>,)> {
  /// Lookup a single row in `schemaMigrations` table using the _primary key_.
  ///
  /// Returns a [QuerySingle] object, which returns at-most one row,
  /// when `.fetch()` is called.
  QuerySingle<(Expr<SchemaMigration>,)> byKey(
    String migrationsName,
    String scriptName,
  ) => where(
    (schemaMigration) =>
        schemaMigration.migrationsName.equalsValue(migrationsName) &
        schemaMigration.scriptName.equalsValue(scriptName),
  ).first;

  /// Update all rows in the `schemaMigrations` table matching this [Query].
  ///
  /// The changes to be applied to each row matching this [Query] are
  /// defined using the [updateBuilder], which is given an [Expr]
  /// representation of the row being updated and a `set` function to
  /// specify which fields should be updated. The result of the `set`
  /// function should always be returned from the `updateBuilder`.
  ///
  /// Returns an [Update] statement on which `.execute()` must be called
  /// for the rows to be updated.
  ///
  /// **Example:** decrementing `1` from the `value` field for each row
  /// where `value > 0`.
  /// ```dart
  /// await db.mytable
  ///   .where((row) => row.value > toExpr(0))
  ///   .update((row, set) => set(
  ///     value: row.value - toExpr(1),
  ///   ))
  ///   .execute();
  /// ```
  ///
  /// > [!WARNING]
  /// > The `updateBuilder` callback does not make the update, it builds
  /// > the expressions for updating the rows. You should **never** invoke
  /// > the `set` function more than once, and the result should always
  /// > be returned immediately.
  Update<SchemaMigration> update(
    UpdateSet<SchemaMigration> Function(
      Expr<SchemaMigration> schemaMigration,
      UpdateSet<SchemaMigration> Function({
        Expr<String> migrationsName,
        Expr<String> scriptName,
        Expr<String> scriptSha256,
        Expr<DateTime> executed,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.update<SchemaMigration>(
    this,
    _$SchemaMigration._$table,
    (schemaMigration) => updateBuilder(
      schemaMigration,
      ({
        Expr<String>? migrationsName,
        Expr<String>? scriptName,
        Expr<String>? scriptSha256,
        Expr<DateTime>? executed,
      }) => $ForGeneratedCode.buildUpdate<SchemaMigration>([
        migrationsName,
        scriptName,
        scriptSha256,
        executed,
      ]),
    ),
  );

  /// Delete all rows in the `schemaMigrations` table matching this [Query].
  ///
  /// Returns a [Delete] statement on which `.execute()` must be called
  /// for the rows to be deleted.
  Delete<SchemaMigration> delete() =>
      $ForGeneratedCode.delete(this, _$SchemaMigration._$table);
}

/// Extension methods for building point queries against the `schemaMigrations` table.
extension QuerySingleSchemaMigrationExt
    on QuerySingle<(Expr<SchemaMigration>,)> {
  /// Update the row (if any) in the `schemaMigrations` table matching this
  /// [QuerySingle].
  ///
  /// The changes to be applied to the row matching this [QuerySingle] are
  /// defined using the [updateBuilder], which is given an [Expr]
  /// representation of the row being updated and a `set` function to
  /// specify which fields should be updated. The result of the `set`
  /// function should always be returned from the `updateBuilder`.
  ///
  /// Returns an [UpdateSingle] statement on which `.execute()` must be
  /// called for the row to be updated. The resulting statement will
  /// **not** fail, if there are no rows matching this query exists.
  ///
  /// **Example:** decrementing `1` from the `value` field the row with
  /// `id = 1`.
  /// ```dart
  /// await db.mytable
  ///   .byKey(1)
  ///   .update((row, set) => set(
  ///     value: row.value - toExpr(1),
  ///   ))
  ///   .execute();
  /// ```
  ///
  /// > [!WARNING]
  /// > The `updateBuilder` callback does not make the update, it builds
  /// > the expressions for updating the rows. You should **never** invoke
  /// > the `set` function more than once, and the result should always
  /// > be returned immediately.
  UpdateSingle<SchemaMigration> update(
    UpdateSet<SchemaMigration> Function(
      Expr<SchemaMigration> schemaMigration,
      UpdateSet<SchemaMigration> Function({
        Expr<String> migrationsName,
        Expr<String> scriptName,
        Expr<String> scriptSha256,
        Expr<DateTime> executed,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.updateSingle<SchemaMigration>(
    this,
    _$SchemaMigration._$table,
    (schemaMigration) => updateBuilder(
      schemaMigration,
      ({
        Expr<String>? migrationsName,
        Expr<String>? scriptName,
        Expr<String>? scriptSha256,
        Expr<DateTime>? executed,
      }) => $ForGeneratedCode.buildUpdate<SchemaMigration>([
        migrationsName,
        scriptName,
        scriptSha256,
        executed,
      ]),
    ),
  );

  /// Delete the row (if any) in the `schemaMigrations` table matching this [QuerySingle].
  ///
  /// Returns a [DeleteSingle] statement on which `.execute()` must be called
  /// for the row to be deleted. The resulting statement will **not**
  /// fail, if there are no rows matching this query exists.
  DeleteSingle<SchemaMigration> delete() =>
      $ForGeneratedCode.deleteSingle(this, _$SchemaMigration._$table);
}

/// Extension methods for expressions on a row in the `schemaMigrations` table.
extension ExpressionSchemaMigrationExt on Expr<SchemaMigration> {
  /// The name of the migrations (or the identifier of a module).
  Expr<String> get migrationsName =>
      $ForGeneratedCode.field(this, 0, $ForGeneratedCode.text);

  /// The name of the script.
  Expr<String> get scriptName =>
      $ForGeneratedCode.field(this, 1, $ForGeneratedCode.text);

  /// The SSH-256 of the script at the time of execution.
  Expr<String> get scriptSha256 =>
      $ForGeneratedCode.field(this, 2, $ForGeneratedCode.text);

  /// The timestamp of the execution.
  Expr<DateTime> get executed =>
      $ForGeneratedCode.field(this, 3, $ForGeneratedCode.dateTime);
}

extension ExpressionNullableSchemaMigrationExt on Expr<SchemaMigration?> {
  /// The name of the migrations (or the identifier of a module).
  Expr<String?> get migrationsName =>
      $ForGeneratedCode.field(this, 0, $ForGeneratedCode.text);

  /// The name of the script.
  Expr<String?> get scriptName =>
      $ForGeneratedCode.field(this, 1, $ForGeneratedCode.text);

  /// The SSH-256 of the script at the time of execution.
  Expr<String?> get scriptSha256 =>
      $ForGeneratedCode.field(this, 2, $ForGeneratedCode.text);

  /// The timestamp of the execution.
  Expr<DateTime?> get executed =>
      $ForGeneratedCode.field(this, 3, $ForGeneratedCode.dateTime);

  /// Check if the row is not `NULL`.
  ///
  /// This will check if _primary key_ fields in this row are `NULL`.
  ///
  /// If this is a reference lookup by subquery it might be more efficient
  /// to check if the referencing field is `NULL`.
  Expr<bool> isNotNull() => migrationsName.isNotNull() & scriptName.isNotNull();

  /// Check if the row is `NULL`.
  ///
  /// This will check if _primary key_ fields in this row are `NULL`.
  ///
  /// If this is a reference lookup by subquery it might be more efficient
  /// to check if the referencing field is `NULL`.
  Expr<bool> isNull() => isNotNull().not();
}
