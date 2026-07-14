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
  static final _$tables = [
    _$UserSessionRow._$table,
    _$Task._$table,
    _$TaskDependency._$table,
  ];

  Table<UserSessionRow> get userSessions =>
      $ForGeneratedCode.declareTable(this, _$UserSessionRow._$table);

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

final class _$UserSessionRow extends UserSessionRow {
  _$UserSessionRow._(
    this.sessionId,
    this.userId,
    this.email,
    this.name,
    this.imageUrl,
    this.created,
    this.expires,
    this.authenticatedAt,
    this.csrfToken,
    this.openidNonce,
    this.accessToken,
    this.grantedScopes,
  );

  @override
  final String sessionId;

  @override
  final String? userId;

  @override
  final String? email;

  @override
  final String? name;

  @override
  final String? imageUrl;

  @override
  final DateTime created;

  @override
  final DateTime expires;

  @override
  final DateTime? authenticatedAt;

  @override
  final String? csrfToken;

  @override
  final String? openidNonce;

  @override
  final String? accessToken;

  @override
  final String? grantedScopes;

  static final _$table = $ForGeneratedCode.tableDefinition(
    tableName: 'user_sessions',
    columns: <String>[
      'session_id',
      'user_id',
      'email',
      'name',
      'image_url',
      'created',
      'expires',
      'authenticated_at',
      'csrf_token',
      'openid_nonce',
      'access_token',
      'granted_scopes',
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
        isNotNull: false,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.text,
        isNotNull: false,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.text,
        isNotNull: false,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.text,
        isNotNull: false,
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
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.dateTime,
        isNotNull: true,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.dateTime,
        isNotNull: false,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.text,
        isNotNull: false,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.text,
        isNotNull: false,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.text,
        isNotNull: false,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.text,
        isNotNull: false,
        defaultValue: null,
        autoIncrement: false,
        overrides: [],
      ),
    ],
    primaryKey: <String>['session_id'],
    unique: <List<String>>[],
    foreignKeys: [],
    indexes: [
      $ForGeneratedCode.indexDefinition(
        name: null,
        sqlName: null,
        columns: ['user_id'],
      ),
      $ForGeneratedCode.indexDefinition(
        name: null,
        sqlName: null,
        columns: ['expires'],
      ),
    ],
    readRow: _$UserSessionRow._$fromDatabase,
  );

  static UserSessionRow? _$fromDatabase(RowReader row) {
    final sessionId = row.readString();
    final userId = row.readString();
    final email = row.readString();
    final name = row.readString();
    final imageUrl = row.readString();
    final created = row.readDateTime();
    final expires = row.readDateTime();
    final authenticatedAt = row.readDateTime();
    final csrfToken = row.readString();
    final openidNonce = row.readString();
    final accessToken = row.readString();
    final grantedScopes = row.readString();
    if (sessionId == null &&
        userId == null &&
        email == null &&
        name == null &&
        imageUrl == null &&
        created == null &&
        expires == null &&
        authenticatedAt == null &&
        csrfToken == null &&
        openidNonce == null &&
        accessToken == null &&
        grantedScopes == null) {
      return null;
    }
    return _$UserSessionRow._(
      sessionId!,
      userId,
      email,
      name,
      imageUrl,
      created!,
      expires!,
      authenticatedAt,
      csrfToken,
      openidNonce,
      accessToken,
      grantedScopes,
    );
  }

  @override
  String toString() =>
      'UserSessionRow(sessionId: "$sessionId", userId: "$userId", email: "$email", name: "$name", imageUrl: "$imageUrl", created: "$created", expires: "$expires", authenticatedAt: "$authenticatedAt", csrfToken: "$csrfToken", openidNonce: "$openidNonce", accessToken: "$accessToken", grantedScopes: "$grantedScopes")';
}

/// Extension methods for table defined in [UserSessionRow].
extension TableUserSessionRowExt on Table<UserSessionRow> {
  /// Insert row into the `userSessions` table.
  ///
  /// Returns a [InsertSingle] statement on which `.execute` must be
  /// called for the row to be inserted.
  InsertSingle<UserSessionRow> insert({
    required Expr<String> sessionId,
    Expr<String?>? userId,
    Expr<String?>? email,
    Expr<String?>? name,
    Expr<String?>? imageUrl,
    required Expr<DateTime> created,
    required Expr<DateTime> expires,
    Expr<DateTime?>? authenticatedAt,
    Expr<String?>? csrfToken,
    Expr<String?>? openidNonce,
    Expr<String?>? accessToken,
    Expr<String?>? grantedScopes,
  }) => $ForGeneratedCode.insertInto(
    table: this,
    values: [
      sessionId,
      userId,
      email,
      name,
      imageUrl,
      created,
      expires,
      authenticatedAt,
      csrfToken,
      openidNonce,
      accessToken,
      grantedScopes,
    ],
  );

  /// Insert row into the `userSessions` table.
  ///
  /// Returns a [InsertSingle] statement on which `.execute` must be
  /// called for the row to be inserted.
  InsertSingle<UserSessionRow> insertValue({
    required String sessionId,
    String? userId,
    String? email,
    String? name,
    String? imageUrl,
    required DateTime created,
    required DateTime expires,
    DateTime? authenticatedAt,
    String? csrfToken,
    String? openidNonce,
    String? accessToken,
    String? grantedScopes,
  }) => $ForGeneratedCode.insertInto(
    table: this,
    values: [
      sessionId.asExpr,
      userId.asExpr,
      email.asExpr,
      name.asExpr,
      imageUrl.asExpr,
      created.asExpr,
      expires.asExpr,
      authenticatedAt.asExpr,
      csrfToken.asExpr,
      openidNonce.asExpr,
      accessToken.asExpr,
      grantedScopes.asExpr,
    ],
  );

  /// Bulk insert rows into the `userSessions` table.
  ///
  /// This method takes an `Iterable<T>` and requires that you provide
  /// a _mapping function_ from `T` to each column to be inserted.
  ///
  /// If a mapping function is omitted, the _default value_ will be
  /// inserted, or `NULL` if column is nullable and as no default value.
  /// To explicitely insert `NULL`, use a _mapping function_ that maps
  /// `T` to `null`.
  ///
  /// > [!NOTE]
  /// > This method aims utilize database specific bulk insertion logic
  /// > to ensure good performance. Database adapters may pipeline bulk
  /// > insertions through multiple statements inside a transaction.
  ///
  /// Returns a [Insert] statement on which `.execute` must be
  /// called for the rows to be inserted.
  Insert<UserSessionRow> insertValuesMapped<T>(
    Iterable<T> rows, {
    required String Function(T row) sessionId,
    String? Function(T row)? userId,
    String? Function(T row)? email,
    String? Function(T row)? name,
    String? Function(T row)? imageUrl,
    required DateTime Function(T row) created,
    required DateTime Function(T row) expires,
    DateTime? Function(T row)? authenticatedAt,
    String? Function(T row)? csrfToken,
    String? Function(T row)? openidNonce,
    String? Function(T row)? accessToken,
    String? Function(T row)? grantedScopes,
  }) => $ForGeneratedCode.insertValuesMapped(
    table: this,
    rows: rows,
    mappings: [
      sessionId,
      userId,
      email,
      name,
      imageUrl,
      created,
      expires,
      authenticatedAt,
      csrfToken,
      openidNonce,
      accessToken,
      grantedScopes,
    ],
  );

  /// Delete a single row from the `userSessions` table, specified by
  /// _primary key_.
  ///
  /// Returns a [DeleteSingle] statement on which `.execute()` must be
  /// called for the row to be deleted.
  ///
  /// To delete multiple rows, using `.where()` to filter which rows
  /// should be deleted. If you wish to delete all rows, use
  /// `.where((_) => toExpr(true)).delete()`.
  DeleteSingle<UserSessionRow> delete(String sessionId) => $ForGeneratedCode
      .deleteSingle(byKey(sessionId), _$UserSessionRow._$table);
}

/// Extension methods for building queries against the `userSessions` table.
extension QueryUserSessionRowExt on Query<(Expr<UserSessionRow>,)> {
  /// Lookup a single row in `userSessions` table using the _primary key_.
  ///
  /// Returns a [QuerySingle] object, which returns at-most one row,
  /// when `.fetch()` is called.
  QuerySingle<(Expr<UserSessionRow>,)> byKey(String sessionId) => where(
    (userSessionRow) => userSessionRow.sessionId.equalsValue(sessionId),
  ).first;

  /// Update all rows in the `userSessions` table matching this [Query].
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
  Update<UserSessionRow> update(
    UpdateSet<UserSessionRow> Function(
      Expr<UserSessionRow> userSessionRow,
      UpdateSet<UserSessionRow> Function({
        Expr<String> sessionId,
        Expr<String?> userId,
        Expr<String?> email,
        Expr<String?> name,
        Expr<String?> imageUrl,
        Expr<DateTime> created,
        Expr<DateTime> expires,
        Expr<DateTime?> authenticatedAt,
        Expr<String?> csrfToken,
        Expr<String?> openidNonce,
        Expr<String?> accessToken,
        Expr<String?> grantedScopes,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.update<UserSessionRow>(
    this,
    _$UserSessionRow._$table,
    (userSessionRow) => updateBuilder(
      userSessionRow,
      ({
        Expr<String>? sessionId,
        Expr<String?>? userId,
        Expr<String?>? email,
        Expr<String?>? name,
        Expr<String?>? imageUrl,
        Expr<DateTime>? created,
        Expr<DateTime>? expires,
        Expr<DateTime?>? authenticatedAt,
        Expr<String?>? csrfToken,
        Expr<String?>? openidNonce,
        Expr<String?>? accessToken,
        Expr<String?>? grantedScopes,
      }) => $ForGeneratedCode.buildUpdate<UserSessionRow>([
        sessionId,
        userId,
        email,
        name,
        imageUrl,
        created,
        expires,
        authenticatedAt,
        csrfToken,
        openidNonce,
        accessToken,
        grantedScopes,
      ]),
    ),
  );

  /// Delete all rows in the `userSessions` table matching this [Query].
  ///
  /// Returns a [Delete] statement on which `.execute()` must be called
  /// for the rows to be deleted.
  Delete<UserSessionRow> delete() =>
      $ForGeneratedCode.delete(this, _$UserSessionRow._$table);
}

/// Extension methods for building point queries against the `userSessions` table.
extension QuerySingleUserSessionRowExt on QuerySingle<(Expr<UserSessionRow>,)> {
  /// Update the row (if any) in the `userSessions` table matching this
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
  UpdateSingle<UserSessionRow> update(
    UpdateSet<UserSessionRow> Function(
      Expr<UserSessionRow> userSessionRow,
      UpdateSet<UserSessionRow> Function({
        Expr<String> sessionId,
        Expr<String?> userId,
        Expr<String?> email,
        Expr<String?> name,
        Expr<String?> imageUrl,
        Expr<DateTime> created,
        Expr<DateTime> expires,
        Expr<DateTime?> authenticatedAt,
        Expr<String?> csrfToken,
        Expr<String?> openidNonce,
        Expr<String?> accessToken,
        Expr<String?> grantedScopes,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.updateSingle<UserSessionRow>(
    this,
    _$UserSessionRow._$table,
    (userSessionRow) => updateBuilder(
      userSessionRow,
      ({
        Expr<String>? sessionId,
        Expr<String?>? userId,
        Expr<String?>? email,
        Expr<String?>? name,
        Expr<String?>? imageUrl,
        Expr<DateTime>? created,
        Expr<DateTime>? expires,
        Expr<DateTime?>? authenticatedAt,
        Expr<String?>? csrfToken,
        Expr<String?>? openidNonce,
        Expr<String?>? accessToken,
        Expr<String?>? grantedScopes,
      }) => $ForGeneratedCode.buildUpdate<UserSessionRow>([
        sessionId,
        userId,
        email,
        name,
        imageUrl,
        created,
        expires,
        authenticatedAt,
        csrfToken,
        openidNonce,
        accessToken,
        grantedScopes,
      ]),
    ),
  );

  /// Delete the row (if any) in the `userSessions` table matching this [QuerySingle].
  ///
  /// Returns a [DeleteSingle] statement on which `.execute()` must be called
  /// for the row to be deleted. The resulting statement will **not**
  /// fail, if there are no rows matching this query exists.
  DeleteSingle<UserSessionRow> delete() =>
      $ForGeneratedCode.deleteSingle(this, _$UserSessionRow._$table);
}

/// Extension methods for expressions on a row in the `userSessions` table.
extension ExpressionUserSessionRowExt on Expr<UserSessionRow> {
  /// The session ID, a random UUID String.
  Expr<String> get sessionId =>
      $ForGeneratedCode.field(this, 0, $ForGeneratedCode.text);

  /// The id of the `User` that has this session.
  Expr<String?> get userId =>
      $ForGeneratedCode.field(this, 1, $ForGeneratedCode.text);

  /// The email of the `User` that has this session.
  Expr<String?> get email =>
      $ForGeneratedCode.field(this, 2, $ForGeneratedCode.text);

  /// The name of the `User` - given by the authentication provider.
  Expr<String?> get name =>
      $ForGeneratedCode.field(this, 3, $ForGeneratedCode.text);

  /// The profile image URL of the `User` - given by the authentication provider.
  Expr<String?> get imageUrl =>
      $ForGeneratedCode.field(this, 4, $ForGeneratedCode.text);

  /// The time when the session was created.
  Expr<DateTime> get created =>
      $ForGeneratedCode.field(this, 5, $ForGeneratedCode.dateTime);

  /// The time when the session will expire.
  Expr<DateTime> get expires =>
      $ForGeneratedCode.field(this, 6, $ForGeneratedCode.dateTime);

  /// The time when the session was last authenticated.
  Expr<DateTime?> get authenticatedAt =>
      $ForGeneratedCode.field(this, 7, $ForGeneratedCode.dateTime);

  /// The CSRF token that the session uses.
  Expr<String?> get csrfToken =>
      $ForGeneratedCode.field(this, 8, $ForGeneratedCode.text);

  /// The random value used for OpenID authentication.
  Expr<String?> get openidNonce =>
      $ForGeneratedCode.field(this, 9, $ForGeneratedCode.text);

  /// The access token from the OpenID authentication.
  Expr<String?> get accessToken =>
      $ForGeneratedCode.field(this, 10, $ForGeneratedCode.text);

  /// The granted scopes from the OpenID authentication.
  Expr<String?> get grantedScopes =>
      $ForGeneratedCode.field(this, 11, $ForGeneratedCode.text);
}

extension ExpressionNullableUserSessionRowExt on Expr<UserSessionRow?> {
  /// The session ID, a random UUID String.
  Expr<String?> get sessionId =>
      $ForGeneratedCode.field(this, 0, $ForGeneratedCode.text);

  /// The id of the `User` that has this session.
  Expr<String?> get userId =>
      $ForGeneratedCode.field(this, 1, $ForGeneratedCode.text);

  /// The email of the `User` that has this session.
  Expr<String?> get email =>
      $ForGeneratedCode.field(this, 2, $ForGeneratedCode.text);

  /// The name of the `User` - given by the authentication provider.
  Expr<String?> get name =>
      $ForGeneratedCode.field(this, 3, $ForGeneratedCode.text);

  /// The profile image URL of the `User` - given by the authentication provider.
  Expr<String?> get imageUrl =>
      $ForGeneratedCode.field(this, 4, $ForGeneratedCode.text);

  /// The time when the session was created.
  Expr<DateTime?> get created =>
      $ForGeneratedCode.field(this, 5, $ForGeneratedCode.dateTime);

  /// The time when the session will expire.
  Expr<DateTime?> get expires =>
      $ForGeneratedCode.field(this, 6, $ForGeneratedCode.dateTime);

  /// The time when the session was last authenticated.
  Expr<DateTime?> get authenticatedAt =>
      $ForGeneratedCode.field(this, 7, $ForGeneratedCode.dateTime);

  /// The CSRF token that the session uses.
  Expr<String?> get csrfToken =>
      $ForGeneratedCode.field(this, 8, $ForGeneratedCode.text);

  /// The random value used for OpenID authentication.
  Expr<String?> get openidNonce =>
      $ForGeneratedCode.field(this, 9, $ForGeneratedCode.text);

  /// The access token from the OpenID authentication.
  Expr<String?> get accessToken =>
      $ForGeneratedCode.field(this, 10, $ForGeneratedCode.text);

  /// The granted scopes from the OpenID authentication.
  Expr<String?> get grantedScopes =>
      $ForGeneratedCode.field(this, 11, $ForGeneratedCode.text);

  /// Check if the row is not `NULL`.
  ///
  /// This will check if _primary key_ fields in this row are `NULL`.
  ///
  /// If this is a reference lookup by subquery it might be more efficient
  /// to check if the referencing field is `NULL`.
  Expr<bool> isNotNull() => sessionId.isNotNull();

  /// Check if the row is `NULL`.
  ///
  /// This will check if _primary key_ fields in this row are `NULL`.
  ///
  /// If this is a reference lookup by subquery it might be more efficient
  /// to check if the referencing field is `NULL`.
  Expr<bool> isNull() => isNotNull().not();
}

/// `Table<UserSessionRow>` conflict targets for use with `.onConflict`.
enum UserSessionRowConflict {
  /// Conflict with an existing row that has a matching primary key.
  ///
  /// Thus, the other row has matching values for:
  /// `sessionId`.
  primaryKey(['session_id']);

  const UserSessionRowConflict(this._fields);

  final List<String> _fields;
}

extension InsertUserSessionRowExt on Insert<UserSessionRow> {
  /// Build an `INSERT` statement with an `ON CONFLICT` clause.
  ///
  /// The [target] argument specifies the _conflict target_ to be
  /// handled. The _conflict target_ is always a `UNIQUE` constraint or
  /// `PRIMARY KEY` constraint.
  ///
  /// If a row to be inserted violates the _conflict target_ constraint,
  /// then the conflict action is triggered:
  /// * `.doNothing()` to skip insertion of the new row, and,
  /// * `.update((userSessionRow, excluded, set) => set(...))` to
  ///   update the conflicting row.
  ///
  /// If a row to be inserted violates a constraint other than the one
  /// specified in _conflict target_ then the entire `INSERT` statement
  /// will fail.
  ///
  /// This is equivalent to `INSERT ... ON CONFLICT (...)` in SQL.
  InsertOnConflict<UserSessionRow> onConflict(UserSessionRowConflict target) =>
      $ForGeneratedCode.insertOnConflict(this, target._fields);
}

extension InsertOnConflictUserSessionRowExt
    on InsertOnConflict<UserSessionRow> {
  /// Build an `INSERT` statement an [upsert-clause][1].
  ///
  /// When a row to be inserted violates the `UNIQUE` or `PRIMARY KEY`
  /// constraint previously specified as _conflict target_, the existing
  /// row is updated using the expressions defined with the
  /// [updateBuilder]. The [updateBuilder] is given 3 parameters:
  ///   * `userSessionRow` an [Expr] representing the existing row in
  ///     the database,
  ///   * `excluded` an [Expr] representing the row to be inserted in the
  ///     database, and,
  ///   * `set` a function to specify which fields should be updated and
  ///     build the [UpdateSet].
  ///
  /// The result of the `set` function should always be immediately
  /// returned from the [updateBuilder].
  ///
  /// **Example:** Insert a counter with `count = 2` or increment the
  /// existing row, if a `PRIMARY KEY` conflict occurs.
  /// ```dart
  /// await db.counters.insertValue(
  ///     name: 'my-counter', // primary key
  ///     count: 2,
  ///   )
  ///   .onConflict(.primaryKey)
  ///   .update((counter, excluded, set) => set(
  ///     count: counter.count + excluded.count,
  ///   ))
  ///   .execute();
  /// ```
  ///
  /// This is equivalent to
  /// `INSERT ... ON CONFLICT (...) UPDATE SET ...` in SQL.
  ///
  /// > [!WARNING]
  /// > The `updateBuilder` callback does not make the update, it builds
  /// > the expressions for updating the rows. You should **never** invoke
  /// > the `set` function more than once, and the result should always
  /// > be returned immediately.
  ///
  /// [1]: https://www.sqlite.org/lang_upsert.html
  Upsert<UserSessionRow> update(
    UpdateSet<UserSessionRow> Function(
      Expr<UserSessionRow> userSessionRow,
      Expr<UserSessionRow> excluded,
      UpdateSet<UserSessionRow> Function({
        Expr<String> sessionId,
        Expr<String?> userId,
        Expr<String?> email,
        Expr<String?> name,
        Expr<String?> imageUrl,
        Expr<DateTime> created,
        Expr<DateTime> expires,
        Expr<DateTime?> authenticatedAt,
        Expr<String?> csrfToken,
        Expr<String?> openidNonce,
        Expr<String?> accessToken,
        Expr<String?> grantedScopes,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.updateOnConflict<UserSessionRow>(
    this,
    (userSessionRow, excluded) => updateBuilder(
      userSessionRow,
      excluded,
      ({
        Expr<String>? sessionId,
        Expr<String?>? userId,
        Expr<String?>? email,
        Expr<String?>? name,
        Expr<String?>? imageUrl,
        Expr<DateTime>? created,
        Expr<DateTime>? expires,
        Expr<DateTime?>? authenticatedAt,
        Expr<String?>? csrfToken,
        Expr<String?>? openidNonce,
        Expr<String?>? accessToken,
        Expr<String?>? grantedScopes,
      }) => $ForGeneratedCode.buildUpdate<UserSessionRow>([
        sessionId,
        userId,
        email,
        name,
        imageUrl,
        created,
        expires,
        authenticatedAt,
        csrfToken,
        openidNonce,
        accessToken,
        grantedScopes,
      ]),
    ),
  );
}

extension InsertSingleUserSessionRowExt on InsertSingle<UserSessionRow> {
  /// Build an `INSERT` statement with an `ON CONFLICT` clause.
  ///
  /// The [target] argument specifies the _conflict target_ to be
  /// handled. The _conflict target_ is always a `UNIQUE` constraint or
  /// `PRIMARY KEY` constraint.
  ///
  /// If a row to be inserted violates the _conflict target_ constraint,
  /// then the conflict action is triggered:
  /// * `.doNothing()` to skip insertion of the new row, and,
  /// * `.update((userSessionRow, excluded, set) => set(...))` to
  ///   update the conflicting row.
  ///
  /// If a row to be inserted violates a constraint other than the one
  /// specified in _conflict target_ then the entire `INSERT` statement
  /// will fail.
  ///
  /// This is equivalent to `INSERT ... ON CONFLICT (...)` in SQL.
  InsertOnConflictSingle<UserSessionRow> onConflict(
    UserSessionRowConflict target,
  ) => $ForGeneratedCode.insertOnConflictSingle(this, target._fields);
}

extension InsertOnConflictSingleUserSessionRowExt
    on InsertOnConflictSingle<UserSessionRow> {
  /// Build an `INSERT` statement an [upsert-clause][1].
  ///
  /// When a row to be inserted violates the `UNIQUE` or `PRIMARY KEY`
  /// constraint previously specified as _conflict target_, the existing
  /// row is updated using the expressions defined with the
  /// [updateBuilder]. The [updateBuilder] is given 3 parameters:
  ///   * `userSessionRow` an [Expr] representing the existing row in
  ///     the database,
  ///   * `excluded` an [Expr] representing the row to be inserted in the
  ///     database, and,
  ///   * `set` a function to specify which fields should be updated and
  ///     build the [UpdateSet].
  ///
  /// The result of the `set` function should always be immediately
  /// returned from the [updateBuilder].
  ///
  /// **Example:** Insert a counter with `count = 2` or increment the
  /// existing row, if a `PRIMARY KEY` conflict occurs.
  /// ```dart
  /// await db.counters.insertValue(
  ///     name: 'my-counter', // primary key
  ///     count: 2,
  ///   )
  ///   .onConflict(.primaryKey)
  ///   .update((counter, excluded, set) => set(
  ///     count: counter.count + excluded.count,
  ///   ))
  ///   .execute();
  /// ```
  ///
  /// This is equivalent to
  /// `INSERT ... ON CONFLICT (...) UPDATE SET ...` in SQL.
  ///
  /// > [!WARNING]
  /// > The `updateBuilder` callback does not make the update, it builds
  /// > the expressions for updating the rows. You should **never** invoke
  /// > the `set` function more than once, and the result should always
  /// > be returned immediately.
  ///
  /// [1]: https://www.sqlite.org/lang_upsert.html
  UpsertSingle<UserSessionRow> update(
    UpdateSet<UserSessionRow> Function(
      Expr<UserSessionRow> userSessionRow,
      Expr<UserSessionRow> excluded,
      UpdateSet<UserSessionRow> Function({
        Expr<String> sessionId,
        Expr<String?> userId,
        Expr<String?> email,
        Expr<String?> name,
        Expr<String?> imageUrl,
        Expr<DateTime> created,
        Expr<DateTime> expires,
        Expr<DateTime?> authenticatedAt,
        Expr<String?> csrfToken,
        Expr<String?> openidNonce,
        Expr<String?> accessToken,
        Expr<String?> grantedScopes,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.updateOnConflictSingle<UserSessionRow>(
    this,
    (userSessionRow, excluded) => updateBuilder(
      userSessionRow,
      excluded,
      ({
        Expr<String>? sessionId,
        Expr<String?>? userId,
        Expr<String?>? email,
        Expr<String?>? name,
        Expr<String?>? imageUrl,
        Expr<DateTime>? created,
        Expr<DateTime>? expires,
        Expr<DateTime?>? authenticatedAt,
        Expr<String?>? csrfToken,
        Expr<String?>? openidNonce,
        Expr<String?>? accessToken,
        Expr<String?>? grantedScopes,
      }) => $ForGeneratedCode.buildUpdate<UserSessionRow>([
        sessionId,
        userId,
        email,
        name,
        imageUrl,
        created,
        expires,
        authenticatedAt,
        csrfToken,
        openidNonce,
        accessToken,
        grantedScopes,
      ]),
    ),
  );
}

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

  static final _$table = $ForGeneratedCode.tableDefinition(
    tableName: 'tasks',
    columns: <String>[
      'runtime_version',
      'package',
      'state',
      'pending_at',
      'last_dependency_changed',
      'finished',
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
        type: $ForGeneratedCode.jsonValue,
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
      $ForGeneratedCode.columnDefinition(
        type: $ForGeneratedCode.dateTime,
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
    primaryKey: <String>['runtime_version', 'package'],
    unique: <List<String>>[],
    foreignKeys: [],
    indexes: [
      $ForGeneratedCode.indexDefinition(
        name: 'currentFinished',
        sqlName: 'current_finished',
        columns: ['runtime_version', 'finished'],
      ),
      $ForGeneratedCode.indexDefinition(
        name: 'currentPendingAt',
        sqlName: 'current_pending_at',
        columns: ['runtime_version', 'pending_at'],
      ),
      $ForGeneratedCode.indexDefinition(
        name: 'currentDependencyChanged',
        sqlName: 'current_dependency_changed',
        columns: ['runtime_version', 'last_dependency_changed'],
      ),
    ],
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

  /// Insert row into the `tasks` table.
  ///
  /// Returns a [InsertSingle] statement on which `.execute` must be
  /// called for the row to be inserted.
  InsertSingle<Task> insertValue({
    required String runtimeVersion,
    required String package,
    required TaskState state,
    required DateTime pendingAt,
    required DateTime lastDependencyChanged,
    required DateTime finished,
  }) => $ForGeneratedCode.insertInto(
    table: this,
    values: [
      runtimeVersion.asExpr,
      package.asExpr,
      state.asExpr,
      pendingAt.asExpr,
      lastDependencyChanged.asExpr,
      finished.asExpr,
    ],
  );

  /// Bulk insert rows into the `tasks` table.
  ///
  /// This method takes an `Iterable<T>` and requires that you provide
  /// a _mapping function_ from `T` to each column to be inserted.
  ///
  /// If a mapping function is omitted, the _default value_ will be
  /// inserted, or `NULL` if column is nullable and as no default value.
  /// To explicitely insert `NULL`, use a _mapping function_ that maps
  /// `T` to `null`.
  ///
  /// > [!NOTE]
  /// > This method aims utilize database specific bulk insertion logic
  /// > to ensure good performance. Database adapters may pipeline bulk
  /// > insertions through multiple statements inside a transaction.
  ///
  /// Returns a [Insert] statement on which `.execute` must be
  /// called for the rows to be inserted.
  Insert<Task> insertValuesMapped<T>(
    Iterable<T> rows, {
    required String Function(T row) runtimeVersion,
    required String Function(T row) package,
    required TaskState Function(T row) state,
    required DateTime Function(T row) pendingAt,
    required DateTime Function(T row) lastDependencyChanged,
    required DateTime Function(T row) finished,
  }) => $ForGeneratedCode.insertValuesMapped(
    table: this,
    rows: rows,
    mappings: [
      runtimeVersion,
      package,
      (T v) => state(v).toDatabase(),
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
            r.runtimeVersion.equalsUnlessNull(runtimeVersion) &
            r.package.equalsUnlessNull(package),
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
            r.runtimeVersion.equalsUnlessNull(runtimeVersion) &
            r.package.equalsUnlessNull(package),
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
        a.runtimeVersion.equalsUnlessNull(b.runtimeVersion) &
        a.package.equalsUnlessNull(b.package),
  );
}

extension LeftJoinTaskTaskDependencyExt
    on LeftJoin<(Expr<Task>,), (Expr<TaskDependency>,)> {
  /// Join using the `task` _foreign key_.
  ///
  /// This will match rows where [Task.runtimeVersion] = [TaskDependency.runtimeVersion] and [Task.package] = [TaskDependency.package].
  Query<(Expr<Task>, Expr<TaskDependency?>)> usingTask() => on(
    (a, b) =>
        a.runtimeVersion.equalsUnlessNull(b.runtimeVersion) &
        a.package.equalsUnlessNull(b.package),
  );
}

extension RightJoinTaskTaskDependencyExt
    on RightJoin<(Expr<Task>,), (Expr<TaskDependency>,)> {
  /// Join using the `task` _foreign key_.
  ///
  /// This will match rows where [Task.runtimeVersion] = [TaskDependency.runtimeVersion] and [Task.package] = [TaskDependency.package].
  Query<(Expr<Task?>, Expr<TaskDependency>)> usingTask() => on(
    (a, b) =>
        a.runtimeVersion.equalsUnlessNull(b.runtimeVersion) &
        a.package.equalsUnlessNull(b.package),
  );
}

/// `Table<Task>` conflict targets for use with `.onConflict`.
enum TaskConflict {
  /// Conflict with an existing row that has a matching primary key.
  ///
  /// Thus, the other row has matching values for:
  /// `runtimeVersion`, `package`.
  primaryKey(['runtime_version', 'package']);

  const TaskConflict(this._fields);

  final List<String> _fields;
}

extension InsertTaskExt on Insert<Task> {
  /// Build an `INSERT` statement with an `ON CONFLICT` clause.
  ///
  /// The [target] argument specifies the _conflict target_ to be
  /// handled. The _conflict target_ is always a `UNIQUE` constraint or
  /// `PRIMARY KEY` constraint.
  ///
  /// If a row to be inserted violates the _conflict target_ constraint,
  /// then the conflict action is triggered:
  /// * `.doNothing()` to skip insertion of the new row, and,
  /// * `.update((task, excluded, set) => set(...))` to
  ///   update the conflicting row.
  ///
  /// If a row to be inserted violates a constraint other than the one
  /// specified in _conflict target_ then the entire `INSERT` statement
  /// will fail.
  ///
  /// This is equivalent to `INSERT ... ON CONFLICT (...)` in SQL.
  InsertOnConflict<Task> onConflict(TaskConflict target) =>
      $ForGeneratedCode.insertOnConflict(this, target._fields);
}

extension InsertOnConflictTaskExt on InsertOnConflict<Task> {
  /// Build an `INSERT` statement an [upsert-clause][1].
  ///
  /// When a row to be inserted violates the `UNIQUE` or `PRIMARY KEY`
  /// constraint previously specified as _conflict target_, the existing
  /// row is updated using the expressions defined with the
  /// [updateBuilder]. The [updateBuilder] is given 3 parameters:
  ///   * `task` an [Expr] representing the existing row in
  ///     the database,
  ///   * `excluded` an [Expr] representing the row to be inserted in the
  ///     database, and,
  ///   * `set` a function to specify which fields should be updated and
  ///     build the [UpdateSet].
  ///
  /// The result of the `set` function should always be immediately
  /// returned from the [updateBuilder].
  ///
  /// **Example:** Insert a counter with `count = 2` or increment the
  /// existing row, if a `PRIMARY KEY` conflict occurs.
  /// ```dart
  /// await db.counters.insertValue(
  ///     name: 'my-counter', // primary key
  ///     count: 2,
  ///   )
  ///   .onConflict(.primaryKey)
  ///   .update((counter, excluded, set) => set(
  ///     count: counter.count + excluded.count,
  ///   ))
  ///   .execute();
  /// ```
  ///
  /// This is equivalent to
  /// `INSERT ... ON CONFLICT (...) UPDATE SET ...` in SQL.
  ///
  /// > [!WARNING]
  /// > The `updateBuilder` callback does not make the update, it builds
  /// > the expressions for updating the rows. You should **never** invoke
  /// > the `set` function more than once, and the result should always
  /// > be returned immediately.
  ///
  /// [1]: https://www.sqlite.org/lang_upsert.html
  Upsert<Task> update(
    UpdateSet<Task> Function(
      Expr<Task> task,
      Expr<Task> excluded,
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
  ) => $ForGeneratedCode.updateOnConflict<Task>(
    this,
    (task, excluded) => updateBuilder(
      task,
      excluded,
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
}

extension InsertSingleTaskExt on InsertSingle<Task> {
  /// Build an `INSERT` statement with an `ON CONFLICT` clause.
  ///
  /// The [target] argument specifies the _conflict target_ to be
  /// handled. The _conflict target_ is always a `UNIQUE` constraint or
  /// `PRIMARY KEY` constraint.
  ///
  /// If a row to be inserted violates the _conflict target_ constraint,
  /// then the conflict action is triggered:
  /// * `.doNothing()` to skip insertion of the new row, and,
  /// * `.update((task, excluded, set) => set(...))` to
  ///   update the conflicting row.
  ///
  /// If a row to be inserted violates a constraint other than the one
  /// specified in _conflict target_ then the entire `INSERT` statement
  /// will fail.
  ///
  /// This is equivalent to `INSERT ... ON CONFLICT (...)` in SQL.
  InsertOnConflictSingle<Task> onConflict(TaskConflict target) =>
      $ForGeneratedCode.insertOnConflictSingle(this, target._fields);
}

extension InsertOnConflictSingleTaskExt on InsertOnConflictSingle<Task> {
  /// Build an `INSERT` statement an [upsert-clause][1].
  ///
  /// When a row to be inserted violates the `UNIQUE` or `PRIMARY KEY`
  /// constraint previously specified as _conflict target_, the existing
  /// row is updated using the expressions defined with the
  /// [updateBuilder]. The [updateBuilder] is given 3 parameters:
  ///   * `task` an [Expr] representing the existing row in
  ///     the database,
  ///   * `excluded` an [Expr] representing the row to be inserted in the
  ///     database, and,
  ///   * `set` a function to specify which fields should be updated and
  ///     build the [UpdateSet].
  ///
  /// The result of the `set` function should always be immediately
  /// returned from the [updateBuilder].
  ///
  /// **Example:** Insert a counter with `count = 2` or increment the
  /// existing row, if a `PRIMARY KEY` conflict occurs.
  /// ```dart
  /// await db.counters.insertValue(
  ///     name: 'my-counter', // primary key
  ///     count: 2,
  ///   )
  ///   .onConflict(.primaryKey)
  ///   .update((counter, excluded, set) => set(
  ///     count: counter.count + excluded.count,
  ///   ))
  ///   .execute();
  /// ```
  ///
  /// This is equivalent to
  /// `INSERT ... ON CONFLICT (...) UPDATE SET ...` in SQL.
  ///
  /// > [!WARNING]
  /// > The `updateBuilder` callback does not make the update, it builds
  /// > the expressions for updating the rows. You should **never** invoke
  /// > the `set` function more than once, and the result should always
  /// > be returned immediately.
  ///
  /// [1]: https://www.sqlite.org/lang_upsert.html
  UpsertSingle<Task> update(
    UpdateSet<Task> Function(
      Expr<Task> task,
      Expr<Task> excluded,
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
  ) => $ForGeneratedCode.updateOnConflictSingle<Task>(
    this,
    (task, excluded) => updateBuilder(
      task,
      excluded,
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
}

final class _$TaskDependency extends TaskDependency {
  _$TaskDependency._(this.runtimeVersion, this.package, this.dependency);

  @override
  final String runtimeVersion;

  @override
  final String package;

  @override
  final String dependency;

  static final _$table = $ForGeneratedCode.tableDefinition(
    tableName: 'task_dependencies',
    columns: <String>['runtime_version', 'package', 'dependency'],
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
    ],
    primaryKey: <String>['runtime_version', 'package', 'dependency'],
    unique: <List<String>>[],
    foreignKeys: [
      $ForGeneratedCode.foreignKeyDefinition(
        name: 'task',
        columns: ['runtime_version', 'package'],
        referencedTable: 'tasks',
        referencedColumns: ['runtime_version', 'package'],
        onDelete: .cascade,
        onUpdate: .cascade,
      ),
    ],
    indexes: [
      $ForGeneratedCode.indexDefinition(
        name: 'currentDependency',
        sqlName: 'current_dependency',
        columns: ['runtime_version', 'dependency'],
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

  /// Insert row into the `taskDependencies` table.
  ///
  /// Returns a [InsertSingle] statement on which `.execute` must be
  /// called for the row to be inserted.
  InsertSingle<TaskDependency> insertValue({
    required String runtimeVersion,
    required String package,
    required String dependency,
  }) => $ForGeneratedCode.insertInto(
    table: this,
    values: [runtimeVersion.asExpr, package.asExpr, dependency.asExpr],
  );

  /// Bulk insert rows into the `taskDependencies` table.
  ///
  /// This method takes an `Iterable<T>` and requires that you provide
  /// a _mapping function_ from `T` to each column to be inserted.
  ///
  /// If a mapping function is omitted, the _default value_ will be
  /// inserted, or `NULL` if column is nullable and as no default value.
  /// To explicitely insert `NULL`, use a _mapping function_ that maps
  /// `T` to `null`.
  ///
  /// > [!NOTE]
  /// > This method aims utilize database specific bulk insertion logic
  /// > to ensure good performance. Database adapters may pipeline bulk
  /// > insertions through multiple statements inside a transaction.
  ///
  /// Returns a [Insert] statement on which `.execute` must be
  /// called for the rows to be inserted.
  Insert<TaskDependency> insertValuesMapped<T>(
    Iterable<T> rows, {
    required String Function(T row) runtimeVersion,
    required String Function(T row) package,
    required String Function(T row) dependency,
  }) => $ForGeneratedCode.insertValuesMapped(
    table: this,
    rows: rows,
    mappings: [runtimeVersion, package, dependency],
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
            r.runtimeVersion.equalsUnlessNull(runtimeVersion) &
            r.package.equalsUnlessNull(package),
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
            r.runtimeVersion.equalsUnlessNull(runtimeVersion) &
            r.package.equalsUnlessNull(package),
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
        b.runtimeVersion.equalsUnlessNull(a.runtimeVersion) &
        b.package.equalsUnlessNull(a.package),
  );
}

extension LeftJoinTaskDependencyTaskExt
    on LeftJoin<(Expr<TaskDependency>,), (Expr<Task>,)> {
  /// Join using the `task` _foreign key_.
  ///
  /// This will match rows where [TaskDependency.runtimeVersion] = [Task.runtimeVersion] and [TaskDependency.package] = [Task.package].
  Query<(Expr<TaskDependency>, Expr<Task?>)> usingTask() => on(
    (a, b) =>
        b.runtimeVersion.equalsUnlessNull(a.runtimeVersion) &
        b.package.equalsUnlessNull(a.package),
  );
}

extension RightJoinTaskDependencyTaskExt
    on RightJoin<(Expr<TaskDependency>,), (Expr<Task>,)> {
  /// Join using the `task` _foreign key_.
  ///
  /// This will match rows where [TaskDependency.runtimeVersion] = [Task.runtimeVersion] and [TaskDependency.package] = [Task.package].
  Query<(Expr<TaskDependency?>, Expr<Task>)> usingTask() => on(
    (a, b) =>
        b.runtimeVersion.equalsUnlessNull(a.runtimeVersion) &
        b.package.equalsUnlessNull(a.package),
  );
}

/// `Table<TaskDependency>` conflict targets for use with `.onConflict`.
enum TaskDependencyConflict {
  /// Conflict with an existing row that has a matching primary key.
  ///
  /// Thus, the other row has matching values for:
  /// `runtimeVersion`, `package`, `dependency`.
  primaryKey(['runtime_version', 'package', 'dependency']);

  const TaskDependencyConflict(this._fields);

  final List<String> _fields;
}

extension InsertTaskDependencyExt on Insert<TaskDependency> {
  /// Build an `INSERT` statement with an `ON CONFLICT` clause.
  ///
  /// The [target] argument specifies the _conflict target_ to be
  /// handled. The _conflict target_ is always a `UNIQUE` constraint or
  /// `PRIMARY KEY` constraint.
  ///
  /// If a row to be inserted violates the _conflict target_ constraint,
  /// then the conflict action is triggered:
  /// * `.doNothing()` to skip insertion of the new row, and,
  /// * `.update((taskDependency, excluded, set) => set(...))` to
  ///   update the conflicting row.
  ///
  /// If a row to be inserted violates a constraint other than the one
  /// specified in _conflict target_ then the entire `INSERT` statement
  /// will fail.
  ///
  /// This is equivalent to `INSERT ... ON CONFLICT (...)` in SQL.
  InsertOnConflict<TaskDependency> onConflict(TaskDependencyConflict target) =>
      $ForGeneratedCode.insertOnConflict(this, target._fields);
}

extension InsertOnConflictTaskDependencyExt
    on InsertOnConflict<TaskDependency> {
  /// Build an `INSERT` statement an [upsert-clause][1].
  ///
  /// When a row to be inserted violates the `UNIQUE` or `PRIMARY KEY`
  /// constraint previously specified as _conflict target_, the existing
  /// row is updated using the expressions defined with the
  /// [updateBuilder]. The [updateBuilder] is given 3 parameters:
  ///   * `taskDependency` an [Expr] representing the existing row in
  ///     the database,
  ///   * `excluded` an [Expr] representing the row to be inserted in the
  ///     database, and,
  ///   * `set` a function to specify which fields should be updated and
  ///     build the [UpdateSet].
  ///
  /// The result of the `set` function should always be immediately
  /// returned from the [updateBuilder].
  ///
  /// **Example:** Insert a counter with `count = 2` or increment the
  /// existing row, if a `PRIMARY KEY` conflict occurs.
  /// ```dart
  /// await db.counters.insertValue(
  ///     name: 'my-counter', // primary key
  ///     count: 2,
  ///   )
  ///   .onConflict(.primaryKey)
  ///   .update((counter, excluded, set) => set(
  ///     count: counter.count + excluded.count,
  ///   ))
  ///   .execute();
  /// ```
  ///
  /// This is equivalent to
  /// `INSERT ... ON CONFLICT (...) UPDATE SET ...` in SQL.
  ///
  /// > [!WARNING]
  /// > The `updateBuilder` callback does not make the update, it builds
  /// > the expressions for updating the rows. You should **never** invoke
  /// > the `set` function more than once, and the result should always
  /// > be returned immediately.
  ///
  /// [1]: https://www.sqlite.org/lang_upsert.html
  Upsert<TaskDependency> update(
    UpdateSet<TaskDependency> Function(
      Expr<TaskDependency> taskDependency,
      Expr<TaskDependency> excluded,
      UpdateSet<TaskDependency> Function({
        Expr<String> runtimeVersion,
        Expr<String> package,
        Expr<String> dependency,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.updateOnConflict<TaskDependency>(
    this,
    (taskDependency, excluded) => updateBuilder(
      taskDependency,
      excluded,
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
}

extension InsertSingleTaskDependencyExt on InsertSingle<TaskDependency> {
  /// Build an `INSERT` statement with an `ON CONFLICT` clause.
  ///
  /// The [target] argument specifies the _conflict target_ to be
  /// handled. The _conflict target_ is always a `UNIQUE` constraint or
  /// `PRIMARY KEY` constraint.
  ///
  /// If a row to be inserted violates the _conflict target_ constraint,
  /// then the conflict action is triggered:
  /// * `.doNothing()` to skip insertion of the new row, and,
  /// * `.update((taskDependency, excluded, set) => set(...))` to
  ///   update the conflicting row.
  ///
  /// If a row to be inserted violates a constraint other than the one
  /// specified in _conflict target_ then the entire `INSERT` statement
  /// will fail.
  ///
  /// This is equivalent to `INSERT ... ON CONFLICT (...)` in SQL.
  InsertOnConflictSingle<TaskDependency> onConflict(
    TaskDependencyConflict target,
  ) => $ForGeneratedCode.insertOnConflictSingle(this, target._fields);
}

extension InsertOnConflictSingleTaskDependencyExt
    on InsertOnConflictSingle<TaskDependency> {
  /// Build an `INSERT` statement an [upsert-clause][1].
  ///
  /// When a row to be inserted violates the `UNIQUE` or `PRIMARY KEY`
  /// constraint previously specified as _conflict target_, the existing
  /// row is updated using the expressions defined with the
  /// [updateBuilder]. The [updateBuilder] is given 3 parameters:
  ///   * `taskDependency` an [Expr] representing the existing row in
  ///     the database,
  ///   * `excluded` an [Expr] representing the row to be inserted in the
  ///     database, and,
  ///   * `set` a function to specify which fields should be updated and
  ///     build the [UpdateSet].
  ///
  /// The result of the `set` function should always be immediately
  /// returned from the [updateBuilder].
  ///
  /// **Example:** Insert a counter with `count = 2` or increment the
  /// existing row, if a `PRIMARY KEY` conflict occurs.
  /// ```dart
  /// await db.counters.insertValue(
  ///     name: 'my-counter', // primary key
  ///     count: 2,
  ///   )
  ///   .onConflict(.primaryKey)
  ///   .update((counter, excluded, set) => set(
  ///     count: counter.count + excluded.count,
  ///   ))
  ///   .execute();
  /// ```
  ///
  /// This is equivalent to
  /// `INSERT ... ON CONFLICT (...) UPDATE SET ...` in SQL.
  ///
  /// > [!WARNING]
  /// > The `updateBuilder` callback does not make the update, it builds
  /// > the expressions for updating the rows. You should **never** invoke
  /// > the `set` function more than once, and the result should always
  /// > be returned immediately.
  ///
  /// [1]: https://www.sqlite.org/lang_upsert.html
  UpsertSingle<TaskDependency> update(
    UpdateSet<TaskDependency> Function(
      Expr<TaskDependency> taskDependency,
      Expr<TaskDependency> excluded,
      UpdateSet<TaskDependency> Function({
        Expr<String> runtimeVersion,
        Expr<String> package,
        Expr<String> dependency,
      })
      set,
    )
    updateBuilder,
  ) => $ForGeneratedCode.updateOnConflictSingle<TaskDependency>(
    this,
    (taskDependency, excluded) => updateBuilder(
      taskDependency,
      excluded,
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
    Expr<bool?> Function(({Expr<A> content, Expr<B> name}) expr)
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
  ///
  /// Using [asExpr] will inject this value as an SQL parameter,
  /// use [asExprLiteral] if you wish to inject as SQL literal instead.
  Expr<TaskState> get asExpr =>
      $ForGeneratedCode.customDataTypeAsExpr(this, _exprType).asNotNull();

  /// Wrap this [TaskState] as [Expr<TaskState>] for use queries with
  /// `package:typed_sql`.
  ///
  /// Using [asExprLiteral] will inject this value as an SQL literal,
  /// use [asExpr] if you wish to inject as SQL parameter instead.
  Expr<TaskState> get asExprLiteral => $ForGeneratedCode
      .customDataTypeAsExprLiteral(this, _exprType)
      .asNotNull();
}

/// Wrap this [TaskState] as [Expr<TaskState>] for use queries with
/// `package:typed_sql`.
extension TaskStateNullableExt on TaskState? {
  /// Wrap this [TaskState] as [Expr<TaskState?>] for use queries with
  /// `package:typed_sql`.
  ///
  /// Using [asExpr] will inject this value as an SQL parameter,
  /// use [asExprLiteral] if you wish to inject as SQL literal instead.
  Expr<TaskState?> get asExpr =>
      $ForGeneratedCode.customDataTypeAsExpr(this, TaskStateExt._exprType);

  /// Wrap this [TaskState] as [Expr<TaskState?>] for use queries with
  /// `package:typed_sql`.
  ///
  /// Using [asExprLiteral] will inject this value as an SQL literal,
  /// use [asExpr] if you wish to inject as SQL parameter instead.
  Expr<TaskState?> get asExprLiteral => $ForGeneratedCode
      .customDataTypeAsExprLiteral(this, TaskStateExt._exprType);
}
