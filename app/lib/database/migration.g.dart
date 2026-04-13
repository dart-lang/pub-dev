// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migration.dart';

// **************************************************************************
// Generator: _TypedSqlBuilder
// **************************************************************************

/// Extension methods for a [Database] operating on [SchemaMigrationSchema].
extension SchemaMigrationSchemaSchema on Database<SchemaMigrationSchema> {
  static final _$tables = [_$SchemaMigration._$table];

  Table<SchemaMigration> get schema_migrations =>
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
    this.schema_name,
    this.script_name,
    this.script_sha256,
    this.executed_at,
  );

  @override
  final String schema_name;

  @override
  final String script_name;

  @override
  final String script_sha256;

  @override
  final DateTime executed_at;

  static final _$table = $ForGeneratedCode.tableDefinition(
    tableName: 'schema_migrations',
    columns: <String>[
      'schema_name',
      'script_name',
      'script_sha256',
      'executed_at',
    ],
    columnInfo: [
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.text,
        isNotNull: true,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.text,
        isNotNull: true,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.text,
        isNotNull: true,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.dateTime,
        isNotNull: true,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
    ],
    primaryKey: <String>['schema_name', 'script_name'],
    unique: <List<String>>[],
    foreignKeys: [],
    readRow: _$SchemaMigration._$fromDatabase,
  );

  static SchemaMigration? _$fromDatabase(RowReader row) {
    final schema_name = row.readString();
    final script_name = row.readString();
    final script_sha256 = row.readString();
    final executed_at = row.readDateTime();
    if (schema_name == null &&
        script_name == null &&
        script_sha256 == null &&
        executed_at == null) {
      return null;
    }
    return _$SchemaMigration._(
      schema_name!,
      script_name!,
      script_sha256!,
      executed_at!,
    );
  }

  @override
  String toString() =>
      'SchemaMigration(schema_name: "$schema_name", script_name: "$script_name", script_sha256: "$script_sha256", executed_at: "$executed_at")';
}

/// Extension methods for table defined in [SchemaMigration].
extension TableSchemaMigrationExt on Table<SchemaMigration> {
  /// Insert row into the `schema_migrations` table.
  ///
  /// Returns a [InsertSingle] statement on which `.execute` must be
  /// called for the row to be inserted.
  InsertSingle<SchemaMigration> insert({
    required Expr<String> schema_name,
    required Expr<String> script_name,
    required Expr<String> script_sha256,
    required Expr<DateTime> executed_at,
  }) => $ForGeneratedCode.insertInto(
    table: this,
    values: [schema_name, script_name, script_sha256, executed_at],
  );

  /// Delete a single row from the `schema_migrations` table, specified by
  /// _primary key_.
  ///
  /// Returns a [DeleteSingle] statement on which `.execute()` must be
  /// called for the row to be deleted.
  ///
  /// To delete multiple rows, using `.where()` to filter which rows
  /// should be deleted. If you wish to delete all rows, use
  /// `.where((_) => toExpr(true)).delete()`.
  DeleteSingle<SchemaMigration> delete(
    String schema_name,
    String script_name,
  ) => $ForGeneratedCode.deleteSingle(
    byKey(schema_name, script_name),
    _$SchemaMigration._$table,
  );
}

/// Extension methods for building queries against the `schema_migrations` table.
extension QuerySchemaMigrationExt on Query<(Expr<SchemaMigration>,)> {
  /// Lookup a single row in `schema_migrations` table using the _primary key_.
  ///
  /// Returns a [QuerySingle] object, which returns at-most one row,
  /// when `.fetch()` is called.
  QuerySingle<(Expr<SchemaMigration>,)> byKey(
    String schema_name,
    String script_name,
  ) => where(
    (schemaMigration) =>
        schemaMigration.schema_name.equalsValue(schema_name) &
        schemaMigration.script_name.equalsValue(script_name),
  ).first;

  /// Update all rows in the `schema_migrations` table matching this [Query].
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
        Expr<String> schema_name,
        Expr<String> script_name,
        Expr<String> script_sha256,
        Expr<DateTime> executed_at,
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
        Expr<String>? schema_name,
        Expr<String>? script_name,
        Expr<String>? script_sha256,
        Expr<DateTime>? executed_at,
      }) => $ForGeneratedCode.buildUpdate<SchemaMigration>([
        schema_name,
        script_name,
        script_sha256,
        executed_at,
      ]),
    ),
  );

  /// Delete all rows in the `schema_migrations` table matching this [Query].
  ///
  /// Returns a [Delete] statement on which `.execute()` must be called
  /// for the rows to be deleted.
  Delete<SchemaMigration> delete() =>
      $ForGeneratedCode.delete(this, _$SchemaMigration._$table);
}

/// Extension methods for building point queries against the `schema_migrations` table.
extension QuerySingleSchemaMigrationExt
    on QuerySingle<(Expr<SchemaMigration>,)> {
  /// Update the row (if any) in the `schema_migrations` table matching this
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
        Expr<String> schema_name,
        Expr<String> script_name,
        Expr<String> script_sha256,
        Expr<DateTime> executed_at,
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
        Expr<String>? schema_name,
        Expr<String>? script_name,
        Expr<String>? script_sha256,
        Expr<DateTime>? executed_at,
      }) => $ForGeneratedCode.buildUpdate<SchemaMigration>([
        schema_name,
        script_name,
        script_sha256,
        executed_at,
      ]),
    ),
  );

  /// Delete the row (if any) in the `schema_migrations` table matching this [QuerySingle].
  ///
  /// Returns a [DeleteSingle] statement on which `.execute()` must be called
  /// for the row to be deleted. The resulting statement will **not**
  /// fail, if there are no rows matching this query exists.
  DeleteSingle<SchemaMigration> delete() =>
      $ForGeneratedCode.deleteSingle(this, _$SchemaMigration._$table);
}

/// Extension methods for expressions on a row in the `schema_migrations` table.
extension ExpressionSchemaMigrationExt on Expr<SchemaMigration> {
  /// The name of the schema (major group, e.g. `main`, `accounts`...).
  Expr<String> get schema_name =>
      $ForGeneratedCode.field(this, 0, $ForGeneratedCode.text);

  /// The name of the script.
  Expr<String> get script_name =>
      $ForGeneratedCode.field(this, 1, $ForGeneratedCode.text);

  /// The SHA-256 of the script at the time of execution.
  Expr<String> get script_sha256 =>
      $ForGeneratedCode.field(this, 2, $ForGeneratedCode.text);

  /// The timestamp of the execution.
  Expr<DateTime> get executed_at =>
      $ForGeneratedCode.field(this, 3, $ForGeneratedCode.dateTime);
}

extension ExpressionNullableSchemaMigrationExt on Expr<SchemaMigration?> {
  /// The name of the schema (major group, e.g. `main`, `accounts`...).
  Expr<String?> get schema_name =>
      $ForGeneratedCode.field(this, 0, $ForGeneratedCode.text);

  /// The name of the script.
  Expr<String?> get script_name =>
      $ForGeneratedCode.field(this, 1, $ForGeneratedCode.text);

  /// The SHA-256 of the script at the time of execution.
  Expr<String?> get script_sha256 =>
      $ForGeneratedCode.field(this, 2, $ForGeneratedCode.text);

  /// The timestamp of the execution.
  Expr<DateTime?> get executed_at =>
      $ForGeneratedCode.field(this, 3, $ForGeneratedCode.dateTime);

  /// Check if the row is not `NULL`.
  ///
  /// This will check if _primary key_ fields in this row are `NULL`.
  ///
  /// If this is a reference lookup by subquery it might be more efficient
  /// to check if the referencing field is `NULL`.
  Expr<bool> isNotNull() => schema_name.isNotNull() & script_name.isNotNull();

  /// Check if the row is `NULL`.
  ///
  /// This will check if _primary key_ fields in this row are `NULL`.
  ///
  /// If this is a reference lookup by subquery it might be more efficient
  /// to check if the referencing field is `NULL`.
  Expr<bool> isNull() => isNotNull().not();
}

/// Extension methods for building queries projected to a named record.
extension QueryContentNameNamed<A, B>
    on Query<({Expr<A> content, Expr<B> name})> {
  Query<(Expr<A>, Expr<B>)> get _asPositionalQuery =>
      $ForGeneratedCode.renamedRecord(this, (e) => (e.content, e.name));

  static Query<({Expr<A> content, Expr<B> name})> _fromPositionalQuery<A, B>(
    Query<(Expr<A>, Expr<B>)> query,
  ) => $ForGeneratedCode.renamedRecord(
    query,
    (e) => (content: e.$1, name: e.$2),
  );

  static T Function(Expr<A> a, Expr<B> b) _wrapBuilder<T, A, B>(
    T Function(({Expr<A> content, Expr<B> name}) e) builder,
  ) =>
      (a, b) => builder((content: a, name: b));

  /// Query the database for rows in this [Query] as a [Stream].
  Stream<({A content, B name})> stream() async* {
    yield* _asPositionalQuery.stream().map((e) => (content: e.$1, name: e.$2));
  }

  /// Query the database for rows in this [Query] as a [List].
  Future<List<({A content, B name})>> fetch() async => await stream().toList();

  /// Offset [Query] using `OFFSET` clause.
  ///
  /// The resulting [Query] will skip the first [offset] rows.
  Query<({Expr<A> content, Expr<B> name})> offset(int offset) =>
      _fromPositionalQuery(_asPositionalQuery.offset(offset));

  /// Limit [Query] using `LIMIT` clause.
  ///
  /// The resulting [Query] will only return the first [limit] rows.
  Query<({Expr<A> content, Expr<B> name})> limit(int limit) =>
      _fromPositionalQuery(_asPositionalQuery.limit(limit));

  /// Create a projection of this [Query] using `SELECT` clause.
  ///
  /// The [projectionBuilder] **must** return a [Record] where all the
  /// values are [Expr] objects. If something else is returned you will
  /// get a [Query] object which doesn't have any methods!
  ///
  /// All methods and properties on [Query<T>] are extension methods and
  /// they are only defined for records `T` where all the values are
  /// [Expr] objects.
  Query<T> select<T extends Record>(
    T Function(({Expr<A> content, Expr<B> name}) expr) projectionBuilder,
  ) => _asPositionalQuery.select(_wrapBuilder(projectionBuilder));

  /// Filter [Query] using `WHERE` clause.
  ///
  /// Returns a [Query] retaining rows from this [Query] where the expression
  /// returned by [conditionBuilder] evaluates to `true`.
  Query<({Expr<A> content, Expr<B> name})> where(
    Expr<bool> Function(({Expr<A> content, Expr<B> name}) expr)
    conditionBuilder,
  ) => _fromPositionalQuery(
    _asPositionalQuery.where(_wrapBuilder(conditionBuilder)),
  );
}
