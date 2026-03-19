// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskState _$TaskStateFromJson(Map<String, dynamic> json) => TaskState(
  versions: (json['versions'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      PackageVersionStateInfo.fromJson(e as Map<String, dynamic>),
    ),
  ),
  abortedTokens: (json['abortedTokens'] as List<dynamic>)
      .map((e) => AbortedTokenInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TaskStateToJson(TaskState instance) => <String, dynamic>{
  'versions': instance.versions,
  'abortedTokens': instance.abortedTokens,
};

// **************************************************************************
// Generator: _TypedSqlBuilder
// **************************************************************************

/// Extension methods for a [Database] operating on [PrimarySchema].
extension PrimarySchemaSchema on Database<PrimarySchema> {
  static const _$tables = [_$Task._$table, _$TaskDependency._$table];

  Table<Task> get tasks => $ForGeneratedCode.declareTable(this, _$Task._$table);

  Table<TaskDependency> get taskDependencies =>
      $ForGeneratedCode.declareTable(this, _$TaskDependency._$table);

  /// Create tables defined in [PrimarySchema].
  ///
  /// Calling this on an empty database will create the tables
  /// defined in [PrimarySchema]. In production it's often better to
  /// use [createPrimarySchemaTables] and manage migrations using
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

/// Get SQL [DDL statements][1] for tables defined in [PrimarySchema].
///
/// This returns a SQL script with multiple DDL statements separated by `;`
/// using the specified [dialect].
///
/// Executing these statements in an empty database will create the tables
/// defined in [PrimarySchema]. In practice, this method is often used for
/// printing the DDL statements, such that migrations can be managed by
/// external tools.
///
/// [1]: https://en.wikipedia.org/wiki/Data_definition_language
String createPrimarySchemaTables(SqlDialect dialect) => $ForGeneratedCode
    .createTableSchema(dialect: dialect, tables: PrimarySchemaSchema._$tables);

final class _$Task extends Task {
  _$Task._(
    this.runtimeVersion,
    this.package,
    this.state,
    this.pendingAt,
    this.lastDependencyChanged,
    this.finished,
  );

  @override
  final String runtimeVersion;

  @override
  final String package;

  @override
  final TaskState state;

  @override
  final DateTime pendingAt;

  @override
  final DateTime lastDependencyChanged;

  @override
  final DateTime finished;

  static const _$table = (
    tableName: 'tasks',
    columns: <String>[
      'runtimeVersion',
      'package',
      'state',
      'pendingAt',
      'lastDependencyChanged',
      'finished',
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
            type: $ForGeneratedCode.jsonValue,
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
          (
            type: $ForGeneratedCode.dateTime,
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
    primaryKey: <String>['runtimeVersion', 'package'],
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
    readRow: _$Task._$fromDatabase,
  );

  static Task? _$fromDatabase(RowReader row) {
    final runtimeVersion = row.readString();
    final package = row.readString();
    final state = $ForGeneratedCode.customDataTypeOrNull(
      row.readJsonValue(),
      TaskState.fromDatabase,
    );
    final pendingAt = row.readDateTime();
    final lastDependencyChanged = row.readDateTime();
    final finished = row.readDateTime();
    if (runtimeVersion == null &&
        package == null &&
        state == null &&
        pendingAt == null &&
        lastDependencyChanged == null &&
        finished == null) {
      return null;
    }
    return _$Task._(
      runtimeVersion!,
      package!,
      state!,
      pendingAt!,
      lastDependencyChanged!,
      finished!,
    );
  }

  @override
  String toString() =>
      'Task(runtimeVersion: "$runtimeVersion", package: "$package", state: "$state", pendingAt: "$pendingAt", lastDependencyChanged: "$lastDependencyChanged", finished: "$finished")';
}

/// Extension methods for table defined in [Task].
extension TableTaskExt on Table<Task> {
  /// Insert row into the `tasks` table.
  ///
  /// Returns a [InsertSingle] statement on which `.execute` must be
  /// called for the row to be inserted.
  InsertSingle<Task> insert({
    required Expr<String> runtimeVersion,
    required Expr<String> package,
    required Expr<TaskState> state,
    required Expr<DateTime> pendingAt,
    required Expr<DateTime> lastDependencyChanged,
    required Expr<DateTime> finished,
  }) => $ForGeneratedCode.insertInto(
    table: this,
    values: [
      runtimeVersion,
      package,
      state,
      pendingAt,
      lastDependencyChanged,
      finished,
    ],
  );

  /// Delete a single row from the `tasks` table, specified by
  /// _primary key_.
  ///
  /// Returns a [DeleteSingle] statement on which `.execute()` must be
  /// called for the row to be deleted.
  ///
  /// To delete multiple rows, using `.where()` to filter which rows
  /// should be deleted. If you wish to delete all rows, use
  /// `.where((_) => toExpr(true)).delete()`.
  DeleteSingle<Task> delete(String runtimeVersion, String package) =>
      $ForGeneratedCode.deleteSingle(
        byKey(runtimeVersion, package),
        _$Task._$table,
      );
}

/// Extension methods for building queries against the `tasks` table.
extension QueryTaskExt on Query<(Expr<Task>,)> {
  /// Lookup a single row in `tasks` table using the _primary key_.
  ///
  /// Returns a [QuerySingle] object, which returns at-most one row,
  /// when `.fetch()` is called.
  QuerySingle<(Expr<Task>,)> byKey(String runtimeVersion, String package) =>
      where(
        (task) =>
            task.runtimeVersion.equalsValue(runtimeVersion) &
            task.package.equalsValue(package),
      ).first;

  /// Update all rows in the `tasks` table matching this [Query].
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
  Update<Task> update(
    UpdateSet<Task> Function(
      Expr<Task> task,
      UpdateSet<Task> Function({
        Expr<String> runtimeVersion,
        Expr<String> package,
        Expr<TaskState> state,
        Expr<DateTime> pendingAt,
        Expr<DateTime> lastDependencyChanged,
        Expr<DateTime> finished,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.update<Task>(
    this,
    _$Task._$table,
    (task) => updateBuilder(
      task,
      ({
        Expr<String>? runtimeVersion,
        Expr<String>? package,
        Expr<TaskState>? state,
        Expr<DateTime>? pendingAt,
        Expr<DateTime>? lastDependencyChanged,
        Expr<DateTime>? finished,
      }) => $ForGeneratedCode.buildUpdate<Task>([
        runtimeVersion,
        package,
        state,
        pendingAt,
        lastDependencyChanged,
        finished,
      ]),
    ),
  );

  /// Delete all rows in the `tasks` table matching this [Query].
  ///
  /// Returns a [Delete] statement on which `.execute()` must be called
  /// for the rows to be deleted.
  Delete<Task> delete() => $ForGeneratedCode.delete(this, _$Task._$table);
}

/// Extension methods for building point queries against the `tasks` table.
extension QuerySingleTaskExt on QuerySingle<(Expr<Task>,)> {
  /// Update the row (if any) in the `tasks` table matching this
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
  UpdateSingle<Task> update(
    UpdateSet<Task> Function(
      Expr<Task> task,
      UpdateSet<Task> Function({
        Expr<String> runtimeVersion,
        Expr<String> package,
        Expr<TaskState> state,
        Expr<DateTime> pendingAt,
        Expr<DateTime> lastDependencyChanged,
        Expr<DateTime> finished,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.updateSingle<Task>(
    this,
    _$Task._$table,
    (task) => updateBuilder(
      task,
      ({
        Expr<String>? runtimeVersion,
        Expr<String>? package,
        Expr<TaskState>? state,
        Expr<DateTime>? pendingAt,
        Expr<DateTime>? lastDependencyChanged,
        Expr<DateTime>? finished,
      }) => $ForGeneratedCode.buildUpdate<Task>([
        runtimeVersion,
        package,
        state,
        pendingAt,
        lastDependencyChanged,
        finished,
      ]),
    ),
  );

  /// Delete the row (if any) in the `tasks` table matching this [QuerySingle].
  ///
  /// Returns a [DeleteSingle] statement on which `.execute()` must be called
  /// for the row to be deleted. The resulting statement will **not**
  /// fail, if there are no rows matching this query exists.
  DeleteSingle<Task> delete() =>
      $ForGeneratedCode.deleteSingle(this, _$Task._$table);
}

/// Extension methods for expressions on a row in the `tasks` table.
extension ExpressionTaskExt on Expr<Task> {
  /// Runtime version this [Task] belongs to.
  Expr<String> get runtimeVersion =>
      $ForGeneratedCode.field(this, 0, $ForGeneratedCode.text);

  Expr<String> get package =>
      $ForGeneratedCode.field(this, 1, $ForGeneratedCode.text);

  Expr<TaskState> get state =>
      $ForGeneratedCode.field(this, 2, TaskStateExt._exprType);

  /// Next [DateTime] at which point some package version becomes pending.
  Expr<DateTime> get pendingAt =>
      $ForGeneratedCode.field(this, 3, $ForGeneratedCode.dateTime);

  /// Last [DateTime] a dependency was updated.
  Expr<DateTime> get lastDependencyChanged =>
      $ForGeneratedCode.field(this, 4, $ForGeneratedCode.dateTime);

  /// The last time the a worker completed with a failure or success.
  Expr<DateTime> get finished =>
      $ForGeneratedCode.field(this, 5, $ForGeneratedCode.dateTime);

  /// Get [SubQuery] of rows from the `taskDependencies` table which
  /// reference this row.
  ///
  /// This returns a [SubQuery] of [TaskDependency] rows,
  /// where [TaskDependency.runtimeVersion], [TaskDependency.package]
  /// references [Task.runtimeVersion], [Task.package]
  /// in this row.
  SubQuery<(Expr<TaskDependency>,)> get dependencies => $ForGeneratedCode
      .subqueryTable(_$TaskDependency._$table)
      .where(
        (r) =>
            r.runtimeVersion.equals(runtimeVersion) & r.package.equals(package),
      );
}

extension ExpressionNullableTaskExt on Expr<Task?> {
  /// Runtime version this [Task] belongs to.
  Expr<String?> get runtimeVersion =>
      $ForGeneratedCode.field(this, 0, $ForGeneratedCode.text);

  Expr<String?> get package =>
      $ForGeneratedCode.field(this, 1, $ForGeneratedCode.text);

  Expr<TaskState?> get state =>
      $ForGeneratedCode.field(this, 2, TaskStateExt._exprType);

  /// Next [DateTime] at which point some package version becomes pending.
  Expr<DateTime?> get pendingAt =>
      $ForGeneratedCode.field(this, 3, $ForGeneratedCode.dateTime);

  /// Last [DateTime] a dependency was updated.
  Expr<DateTime?> get lastDependencyChanged =>
      $ForGeneratedCode.field(this, 4, $ForGeneratedCode.dateTime);

  /// The last time the a worker completed with a failure or success.
  Expr<DateTime?> get finished =>
      $ForGeneratedCode.field(this, 5, $ForGeneratedCode.dateTime);

  /// Get [SubQuery] of rows from the `taskDependencies` table which
  /// reference this row.
  ///
  /// This returns a [SubQuery] of [TaskDependency] rows,
  /// where [TaskDependency.runtimeVersion], [TaskDependency.package]
  /// references [Task.runtimeVersion], [Task.package]
  /// in this row, if any.
  ///
  /// If this row is `NULL` the subquery is always be empty.
  SubQuery<(Expr<TaskDependency>,)> get dependencies => $ForGeneratedCode
      .subqueryTable(_$TaskDependency._$table)
      .where(
        (r) =>
            r.runtimeVersion.equalsUnlessNull(runtimeVersion).asNotNull() &
            r.package.equalsUnlessNull(package).asNotNull(),
      );

  /// Check if the row is not `NULL`.
  ///
  /// This will check if _primary key_ fields in this row are `NULL`.
  ///
  /// If this is a reference lookup by subquery it might be more efficient
  /// to check if the referencing field is `NULL`.
  Expr<bool> isNotNull() => runtimeVersion.isNotNull() & package.isNotNull();

  /// Check if the row is `NULL`.
  ///
  /// This will check if _primary key_ fields in this row are `NULL`.
  ///
  /// If this is a reference lookup by subquery it might be more efficient
  /// to check if the referencing field is `NULL`.
  Expr<bool> isNull() => isNotNull().not();
}

extension InnerJoinTaskTaskDependencyExt
    on InnerJoin<(Expr<Task>,), (Expr<TaskDependency>,)> {
  /// Join using the `task` _foreign key_.
  ///
  /// This will match rows where [Task.runtimeVersion] = [TaskDependency.runtimeVersion] and [Task.package] = [TaskDependency.package].
  Query<(Expr<Task>, Expr<TaskDependency>)> usingTask() => on(
    (a, b) =>
        a.runtimeVersion.equals(b.runtimeVersion) & a.package.equals(b.package),
  );
}

extension LeftJoinTaskTaskDependencyExt
    on LeftJoin<(Expr<Task>,), (Expr<TaskDependency>,)> {
  /// Join using the `task` _foreign key_.
  ///
  /// This will match rows where [Task.runtimeVersion] = [TaskDependency.runtimeVersion] and [Task.package] = [TaskDependency.package].
  Query<(Expr<Task>, Expr<TaskDependency?>)> usingTask() => on(
    (a, b) =>
        a.runtimeVersion.equals(b.runtimeVersion) & a.package.equals(b.package),
  );
}

extension RightJoinTaskTaskDependencyExt
    on RightJoin<(Expr<Task>,), (Expr<TaskDependency>,)> {
  /// Join using the `task` _foreign key_.
  ///
  /// This will match rows where [Task.runtimeVersion] = [TaskDependency.runtimeVersion] and [Task.package] = [TaskDependency.package].
  Query<(Expr<Task?>, Expr<TaskDependency>)> usingTask() => on(
    (a, b) =>
        a.runtimeVersion.equals(b.runtimeVersion) & a.package.equals(b.package),
  );
}

final class _$TaskDependency extends TaskDependency {
  _$TaskDependency._(this.runtimeVersion, this.package, this.dependency);

  @override
  final String runtimeVersion;

  @override
  final String package;

  @override
  final String dependency;

  static const _$table = (
    tableName: 'taskDependencies',
    columns: <String>['runtimeVersion', 'package', 'dependency'],
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
        ],
    primaryKey: <String>['runtimeVersion', 'package', 'dependency'],
    unique: <List<String>>[],
    foreignKeys:
        <
          ({
            String name,
            List<String> columns,
            String referencedTable,
            List<String> referencedColumns,
          })
        >[
          (
            name: 'task',
            columns: ['runtimeVersion', 'package'],
            referencedTable: 'tasks',
            referencedColumns: ['runtimeVersion', 'package'],
          ),
        ],
    readRow: _$TaskDependency._$fromDatabase,
  );

  static TaskDependency? _$fromDatabase(RowReader row) {
    final runtimeVersion = row.readString();
    final package = row.readString();
    final dependency = row.readString();
    if (runtimeVersion == null && package == null && dependency == null) {
      return null;
    }
    return _$TaskDependency._(runtimeVersion!, package!, dependency!);
  }

  @override
  String toString() =>
      'TaskDependency(runtimeVersion: "$runtimeVersion", package: "$package", dependency: "$dependency")';
}

/// Extension methods for table defined in [TaskDependency].
extension TableTaskDependencyExt on Table<TaskDependency> {
  /// Insert row into the `taskDependencies` table.
  ///
  /// Returns a [InsertSingle] statement on which `.execute` must be
  /// called for the row to be inserted.
  InsertSingle<TaskDependency> insert({
    required Expr<String> runtimeVersion,
    required Expr<String> package,
    required Expr<String> dependency,
  }) => $ForGeneratedCode.insertInto(
    table: this,
    values: [runtimeVersion, package, dependency],
  );

  /// Delete a single row from the `taskDependencies` table, specified by
  /// _primary key_.
  ///
  /// Returns a [DeleteSingle] statement on which `.execute()` must be
  /// called for the row to be deleted.
  ///
  /// To delete multiple rows, using `.where()` to filter which rows
  /// should be deleted. If you wish to delete all rows, use
  /// `.where((_) => toExpr(true)).delete()`.
  DeleteSingle<TaskDependency> delete(
    String runtimeVersion,
    String package,
    String dependency,
  ) => $ForGeneratedCode.deleteSingle(
    byKey(runtimeVersion, package, dependency),
    _$TaskDependency._$table,
  );
}

/// Extension methods for building queries against the `taskDependencies` table.
extension QueryTaskDependencyExt on Query<(Expr<TaskDependency>,)> {
  /// Lookup a single row in `taskDependencies` table using the _primary key_.
  ///
  /// Returns a [QuerySingle] object, which returns at-most one row,
  /// when `.fetch()` is called.
  QuerySingle<(Expr<TaskDependency>,)> byKey(
    String runtimeVersion,
    String package,
    String dependency,
  ) => where(
    (taskDependency) =>
        taskDependency.runtimeVersion.equalsValue(runtimeVersion) &
        taskDependency.package.equalsValue(package) &
        taskDependency.dependency.equalsValue(dependency),
  ).first;

  /// Update all rows in the `taskDependencies` table matching this [Query].
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
  Update<TaskDependency> update(
    UpdateSet<TaskDependency> Function(
      Expr<TaskDependency> taskDependency,
      UpdateSet<TaskDependency> Function({
        Expr<String> runtimeVersion,
        Expr<String> package,
        Expr<String> dependency,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.update<TaskDependency>(
    this,
    _$TaskDependency._$table,
    (taskDependency) => updateBuilder(
      taskDependency,
      ({
        Expr<String>? runtimeVersion,
        Expr<String>? package,
        Expr<String>? dependency,
      }) => $ForGeneratedCode.buildUpdate<TaskDependency>([
        runtimeVersion,
        package,
        dependency,
      ]),
    ),
  );

  /// Delete all rows in the `taskDependencies` table matching this [Query].
  ///
  /// Returns a [Delete] statement on which `.execute()` must be called
  /// for the rows to be deleted.
  Delete<TaskDependency> delete() =>
      $ForGeneratedCode.delete(this, _$TaskDependency._$table);
}

/// Extension methods for building point queries against the `taskDependencies` table.
extension QuerySingleTaskDependencyExt on QuerySingle<(Expr<TaskDependency>,)> {
  /// Update the row (if any) in the `taskDependencies` table matching this
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
  UpdateSingle<TaskDependency> update(
    UpdateSet<TaskDependency> Function(
      Expr<TaskDependency> taskDependency,
      UpdateSet<TaskDependency> Function({
        Expr<String> runtimeVersion,
        Expr<String> package,
        Expr<String> dependency,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.updateSingle<TaskDependency>(
    this,
    _$TaskDependency._$table,
    (taskDependency) => updateBuilder(
      taskDependency,
      ({
        Expr<String>? runtimeVersion,
        Expr<String>? package,
        Expr<String>? dependency,
      }) => $ForGeneratedCode.buildUpdate<TaskDependency>([
        runtimeVersion,
        package,
        dependency,
      ]),
    ),
  );

  /// Delete the row (if any) in the `taskDependencies` table matching this [QuerySingle].
  ///
  /// Returns a [DeleteSingle] statement on which `.execute()` must be called
  /// for the row to be deleted. The resulting statement will **not**
  /// fail, if there are no rows matching this query exists.
  DeleteSingle<TaskDependency> delete() =>
      $ForGeneratedCode.deleteSingle(this, _$TaskDependency._$table);
}

/// Extension methods for expressions on a row in the `taskDependencies` table.
extension ExpressionTaskDependencyExt on Expr<TaskDependency> {
  Expr<String> get runtimeVersion =>
      $ForGeneratedCode.field(this, 0, $ForGeneratedCode.text);

  Expr<String> get package =>
      $ForGeneratedCode.field(this, 1, $ForGeneratedCode.text);

  /// Name of a package that is either a direct or transitive dependency of
  /// [package].
  Expr<String> get dependency =>
      $ForGeneratedCode.field(this, 2, $ForGeneratedCode.text);

  /// Do a subquery lookup of the row from table
  /// `tasks` referenced in
  /// [runtimeVersion], [package].
  ///
  /// The gets the row from table `tasks` where
  /// [Task.runtimeVersion], [Task.package]
  /// is equal to [runtimeVersion], [package].
  Expr<Task> get task => $ForGeneratedCode
      .subqueryTable(_$Task._$table)
      .where(
        (r) =>
            r.runtimeVersion.equals(runtimeVersion) & r.package.equals(package),
      )
      .first
      .asNotNull();
}

extension ExpressionNullableTaskDependencyExt on Expr<TaskDependency?> {
  Expr<String?> get runtimeVersion =>
      $ForGeneratedCode.field(this, 0, $ForGeneratedCode.text);

  Expr<String?> get package =>
      $ForGeneratedCode.field(this, 1, $ForGeneratedCode.text);

  /// Name of a package that is either a direct or transitive dependency of
  /// [package].
  Expr<String?> get dependency =>
      $ForGeneratedCode.field(this, 2, $ForGeneratedCode.text);

  /// Do a subquery lookup of the row from table
  /// `tasks` referenced in
  /// [runtimeVersion], [package].
  ///
  /// The gets the row from table `tasks` where
  /// [Task.runtimeVersion], [Task.package]
  /// is equal to [runtimeVersion], [package], if any.
  ///
  /// If this row is `NULL` the subquery is always return `NULL`.
  Expr<Task?> get task => $ForGeneratedCode
      .subqueryTable(_$Task._$table)
      .where(
        (r) =>
            r.runtimeVersion.equalsUnlessNull(runtimeVersion).asNotNull() &
            r.package.equalsUnlessNull(package).asNotNull(),
      )
      .first;

  /// Check if the row is not `NULL`.
  ///
  /// This will check if _primary key_ fields in this row are `NULL`.
  ///
  /// If this is a reference lookup by subquery it might be more efficient
  /// to check if the referencing field is `NULL`.
  Expr<bool> isNotNull() =>
      runtimeVersion.isNotNull() & package.isNotNull() & dependency.isNotNull();

  /// Check if the row is `NULL`.
  ///
  /// This will check if _primary key_ fields in this row are `NULL`.
  ///
  /// If this is a reference lookup by subquery it might be more efficient
  /// to check if the referencing field is `NULL`.
  Expr<bool> isNull() => isNotNull().not();
}

extension InnerJoinTaskDependencyTaskExt
    on InnerJoin<(Expr<TaskDependency>,), (Expr<Task>,)> {
  /// Join using the `task` _foreign key_.
  ///
  /// This will match rows where [TaskDependency.runtimeVersion] = [Task.runtimeVersion] and [TaskDependency.package] = [Task.package].
  Query<(Expr<TaskDependency>, Expr<Task>)> usingTask() => on(
    (a, b) =>
        b.runtimeVersion.equals(a.runtimeVersion) & b.package.equals(a.package),
  );
}

extension LeftJoinTaskDependencyTaskExt
    on LeftJoin<(Expr<TaskDependency>,), (Expr<Task>,)> {
  /// Join using the `task` _foreign key_.
  ///
  /// This will match rows where [TaskDependency.runtimeVersion] = [Task.runtimeVersion] and [TaskDependency.package] = [Task.package].
  Query<(Expr<TaskDependency>, Expr<Task?>)> usingTask() => on(
    (a, b) =>
        b.runtimeVersion.equals(a.runtimeVersion) & b.package.equals(a.package),
  );
}

extension RightJoinTaskDependencyTaskExt
    on RightJoin<(Expr<TaskDependency>,), (Expr<Task>,)> {
  /// Join using the `task` _foreign key_.
  ///
  /// This will match rows where [TaskDependency.runtimeVersion] = [Task.runtimeVersion] and [TaskDependency.package] = [Task.package].
  Query<(Expr<TaskDependency?>, Expr<Task>)> usingTask() => on(
    (a, b) =>
        b.runtimeVersion.equals(a.runtimeVersion) & b.package.equals(a.package),
  );
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

/// Wrap this [TaskState] as [Expr<TaskState>] for use queries with
/// `package:typed_sql`.
extension TaskStateExt on TaskState {
  static final _exprType = $ForGeneratedCode.customDataType(
    $ForGeneratedCode.jsonValue,
    TaskState.fromDatabase,
  );

  /// Wrap this [TaskState] as [Expr<TaskState>] for use queries with
  /// `package:typed_sql`.
  Expr<TaskState> get asExpr =>
      $ForGeneratedCode.literalCustomDataType(this, _exprType).asNotNull();
}

/// Wrap this [TaskState] as [Expr<TaskState>] for use queries with
/// `package:typed_sql`.
extension TaskStateNullableExt on TaskState? {
  /// Wrap this [TaskState] as [Expr<TaskState?>] for use queries with
  /// `package:typed_sql`.
  Expr<TaskState?> get asExpr =>
      $ForGeneratedCode.literalCustomDataType(this, TaskStateExt._exprType);
}
