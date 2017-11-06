// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library db_impl_test;

/// NOTE: In order to run these tests, the following datastore indices must
/// exist:
/// $ cat index.yaml
/// indexes:
/// - kind: User
///   ancestor: no
///   properties:
///   - name: name
///     direction: asc
///   - name: nickname
///     direction: desc
///
/// - kind: User
///   ancestor: no
///   properties:
///   - name: name
///     direction: desc
///   - name: nickname
///     direction: desc
///
/// - kind: User
///   ancestor: no
///   properties:
///   - name: name
///     direction: desc
///   - name: nickname
///     direction: asc
///
/// - kind: User
///   ancestor: no
///   properties:
///   - name: language
///     direction: asc
///   - name: name
///     direction: asc
///
/// $ gcloud preview datastore create-indexes .
/// 02:19 PM Host: appengine.google.com
/// 02:19 PM Uploading index definitions.

import 'dart:async';

import 'package:test/test.dart';

import 'package:gcloud/db.dart' as db;

@db.Kind()
class Person extends db.Model {
  @db.StringProperty()
  String name;

  @db.IntProperty()
  int age;

  @db.ModelKeyProperty(propertyName: 'mangledWife')
  db.Key wife;

  operator==(Object other) => sameAs(other);

  sameAs(Object other) {
    return other is Person &&
        id == other.id &&
        parentKey == other.parentKey &&
        name == other.name &&
        age == other.age &&
        wife == other.wife;
  }

  String toString() => 'Person(id: $id, name: $name, age: $age)';
}

bool areStringListsEqual(List<String> a, List<String> b) {
  if (a == null) {
    if (b == null) return true;
    return false;
  }

  if (a.length != b?.length)  return false;

  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }

  return true;
}


@db.Kind()
class User extends Person {
  @db.StringProperty()
  String nickname;

  @db.StringListProperty(propertyName: 'language')
  List<String> languages = const [];

  @db.StringListProperty(indexed: false)
  List<String> hobbies = const [];

  sameAs(Object other) {
    if (!(super.sameAs(other) && other is User && nickname == other.nickname))
      return false;

    User user = other;
    return areStringListsEqual(languages, user?.languages) &&
           areStringListsEqual(hobbies, user?.hobbies);
  }

  String toString() =>
      'User(${super.toString()}, '
      'nickname: $nickname, '
      'languages: $languages, '
      'hobbies: $hobbies)';
}


@db.Kind()
class ExpandoPerson extends db.ExpandoModel {
  @db.StringProperty()
  String name;

  @db.StringProperty(propertyName: 'NN')
  String nickname;

  operator==(Object other) {
    if (other is ExpandoPerson && id == other.id && name == other.name) {
      if (additionalProperties.length != other.additionalProperties.length) {
        return false;
      }
      for (var key in additionalProperties.keys) {
        if (additionalProperties[key] != other.additionalProperties[key]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}


Future sleep(Duration duration) => new Future.delayed(duration);

runTests(db.DatastoreDB store, String namespace) {
  var partition = store.newPartition(namespace);

  void compareModels(List<db.Model> expectedModels,
                     List<db.Model> models,
                     {bool anyOrder: false}) {
    expect(models.length, equals(expectedModels.length));
    if (anyOrder) {
      // Do expensive O(n^2) search.
      for (var searchModel in expectedModels) {
        bool found = false;
        for (var m in models) {
          if (m == searchModel) {
            found = true;
            break;
          }
        }
        expect(found, isTrue);
      }
    } else {
      for (var i = 0; i < expectedModels.length; i++) {
        expect(models[i], equals(expectedModels[i]));
      }
    }
  }

  Future testInsertLookupDelete(
      List<db.Model> objects, {bool transactional: false}) {
    var keys = objects.map((db.Model obj) => obj.key).toList();

    if (transactional) {
      return store.withTransaction((db.Transaction commitTransaction) {
        commitTransaction.queueMutations(inserts: objects);
        return commitTransaction.commit();
      }).then((_) {
        return store.withTransaction((db.Transaction deleteTransaction) {
          return deleteTransaction.lookup(keys).then((List<db.Model> models) {
            compareModels(objects, models);
            deleteTransaction.queueMutations(deletes: keys);
            return deleteTransaction.commit();
          });
        });
      });
    } else {
      return store.commit(inserts: objects).then(expectAsync1((_) {
        return store.lookup(keys).then(expectAsync1((List<db.Model> models) {
          compareModels(objects, models);
          return store.commit(deletes: keys).then(expectAsync1((_) {
            return store.lookup(keys)
                .then(expectAsync1((List<db.Model> models) {
              for (var i = 0; i < models.length; i++) {
                expect(models[i], isNull);
              }
            }));
          }));
        }));
      }));
    }
  }

  group('key', () {
    test('equal_and_hashcode', () {
      var k1 = store.emptyKey.append(User, id: 10).append(Person, id: 12);
      var k2 = store.newPartition(null)
          .emptyKey.append(User, id: 10).append(Person, id: 12);
      expect(k1, equals(k2));
      expect(k1.hashCode, equals(k2.hashCode));
    });
  });

  group('e2e_db', () {
    group('insert_lookup_delete', () {
      test('persons', () {
        var root = partition.emptyKey;
        var persons = [];
        for (var i = 1; i <= 10; i++) {
          persons.add(new Person()
              ..id = i
              ..parentKey = root
              ..age = 42 + i
              ..name = 'user$i');
        }
        persons.first.wife = persons.last.key;
        return testInsertLookupDelete(persons);
      });
      test('users', () {
        var root = partition.emptyKey;
        var users = [];
        for (var i = 1; i <= 10; i++) {
          users.add(new User()
              ..id = i
              ..parentKey = root
              ..age = 42 + i
              ..name = 'user$i'
              ..nickname = 'nickname${i%3}');
        }
        return testInsertLookupDelete(users);
      });
      test('expando_insert', () {
        var root = partition.emptyKey;
        var expandoPersons = [];
        for (var i = 1; i <= 10; i++) {
          var expandoPerson = new ExpandoPerson()
              ..parentKey = root
              ..id = i
              ..name = 'user$i';
          expandoPerson.foo = 'foo$i';
          expandoPerson.bar = i;
          expect(expandoPerson.additionalProperties['foo'], equals('foo$i'));
          expect(expandoPerson.additionalProperties['bar'], equals(i));
          expandoPersons.add(expandoPerson);
        }
        return testInsertLookupDelete(expandoPersons);
      });
      test('transactional_insert', () {
        var root = partition.emptyKey;
        var models = [];

        models.add(new Person()
            ..id = 1
            ..parentKey = root
            ..age = 1
            ..name = 'user1');
        models.add(new User()
            ..id = 2
            ..parentKey = root
            ..age = 2
            ..name = 'user2'
            ..nickname = 'nickname2');
        var expandoPerson = new ExpandoPerson()
            ..parentKey = root
            ..id = 3
            ..name = 'user1';
        expandoPerson.foo = 'foo1';
        expandoPerson.bar = 2;

        return testInsertLookupDelete(models, transactional: true);
      });

      test('parent_key', () {
        var root = partition.emptyKey;
        var users = <db.Model>[];
        for (var i = 333; i <= 334; i++) {
          users.add(new User()
              ..id = i
              ..parentKey = root
              ..age = 42 + i
              ..name = 'user$i'
              ..nickname = 'nickname${i%3}');
        }
        var persons = <db.Model>[];
        for (var i = 335; i <= 336; i++) {
          persons.add(new Person()
              ..id = i
              ..parentKey = root
              ..age = 42 + i
              ..name = 'person$i');
        }

        // We test that we can insert + lookup
        // users[0], (persons[0] + users[0] as parent)
        // persons[1], (users[1] + persons[0] as parent)
        persons[0].parentKey = users[0].key;
        users[1].parentKey = persons[1].key;

        return testInsertLookupDelete([]..addAll(users)..addAll(persons));
      });

      test('auto_ids', () {
        var root = partition.emptyKey;
        var persons = [];
        persons.add(new Person()
            ..id = 42
            ..parentKey = root
            ..age = 80
            ..name = 'user80');
        // Auto id person with parentKey
        persons.add(new Person()
            ..parentKey = root
            ..age = 81
            ..name = 'user81');
        // Auto id person with non-root parentKey
        var fatherKey = persons.first.parentKey;
        persons.add(new Person()
            ..parentKey = fatherKey
            ..age = 82
            ..name = 'user82');
        persons.add(new Person()
            ..id = 43
            ..parentKey = root
            ..age = 83
            ..name = 'user83');
        return store.commit(inserts: persons).then(expectAsync1((_) {
          // At this point, autoIds are allocated and are reflected in the
          // models (as well as parentKey if it was empty).

          var keys = persons.map((db.Model obj) => obj.key).toList();

          for (var i = 0; i < persons.length; i++) {
            expect(persons[i].age, equals(80 + i));
            expect(persons[i].name, equals('user${80 + i}'));
          }

          expect(persons[0].id, equals(42));
          expect(persons[0].parentKey, equals(root));

          expect(persons[1].id, isNotNull);
          expect(persons[1].id is int, isTrue);
          expect(persons[1].parentKey, equals(root));

          expect(persons[2].id, isNotNull);
          expect(persons[2].id is int, isTrue);
          expect(persons[2].parentKey, equals(fatherKey));

          expect(persons[3].id, equals(43));
          expect(persons[3].parentKey, equals(root));

          expect(persons[1].id != persons[2].id, isTrue);
          // NOTE: We can't make assumptions about the id of persons[3],
          // because an id doesn't need to be globally unique, only under
          // entities with the same parent.

          return store.lookup(keys).then(expectAsync1((List<db.Model> models) {
            // Since the id/parentKey fields are set after commit and a lookup
            // returns new model instances, we can do full model comparison
            // here.
            compareModels(persons, models);
            return store.commit(deletes: keys).then(expectAsync1((_) {
              return store.lookup(keys).then(expectAsync1((List models) {
                for (var i = 0; i < models.length; i++) {
                  expect(models[i], isNull);
                }
              }));
            }));
          }));
        }));
      });
    });

    test('query', () {
      var root = partition.emptyKey;
      var users = [];
      for (var i = 1; i <= 10; i++) {
        var languages = [];
        var hobbies = ['running', 'swimming'];
        if (i == 9) {
          languages = ['foo'];
        } else if (i == 10) {
          languages = ['foo', 'bar'];
        }
        users.add(new User()
            ..id = i
            ..parentKey = root
            ..wife = root.append(User, id: 42 + i)
            ..age = 42 + i
            ..name = 'user$i'
            ..nickname = 'nickname${i%3}'
            ..languages = languages
            ..hobbies = hobbies);
      }

      var expandoPersons = [];
      for (var i = 1; i <= 3; i++) {
        var expandoPerson = new ExpandoPerson()
            ..parentKey = root
            ..id = i
            ..name = 'user$i'
            ..nickname = 'nickuser$i';
        expandoPerson.foo = 'foo$i';
        expandoPerson.bar = i;
        expect(expandoPerson.additionalProperties['foo'], equals('foo$i'));
        expect(expandoPerson.additionalProperties['bar'], equals(i));
        expandoPersons.add(expandoPerson);
      }

      var LOWER_BOUND = 'user2';

      var usersSortedNameDescNicknameAsc = new List.from(users);
      usersSortedNameDescNicknameAsc.sort((User a, User b) {
        var result = b.name.compareTo(a.name);
        if (result == 0) return a.nickname.compareTo(b.nickname);
        return result;
      });

      var usersSortedNameDescNicknameDesc = new List.from(users);
      usersSortedNameDescNicknameDesc.sort((User a, User b) {
        var result = b.name.compareTo(a.name);
        if (result == 0) return b.nickname.compareTo(a.nickname);
        return result;
      });

      var usersSortedAndFilteredNameDescNicknameAsc =
          usersSortedNameDescNicknameAsc.where((User u) {
        return LOWER_BOUND.compareTo(u.name) <= 0;
      }).toList();

      var usersSortedAndFilteredNameDescNicknameDesc =
          usersSortedNameDescNicknameDesc.where((User u) {
        return LOWER_BOUND.compareTo(u.name) <= 0;
      }).toList();

      var fooUsers = users.where(
          (User u) => u.languages.contains('foo')).toList();
      var barUsers = users.where(
          (User u) => u.languages.contains('bar')).toList();
      var usersWithWife = users.where(
          (User u) => u.wife == root.append(User, id: 42 + 3)).toList();

      var allInserts = []
          ..addAll(users)
          ..addAll(expandoPersons);
      var allKeys = allInserts.map((db.Model model) => model.key).toList();
      return store.commit(inserts: allInserts).then((_) {
        return waitUntilEntitiesReady(store, allKeys, partition).then((_) {
          var tests = [
            // Queries for [Person] return no results, we only have [User]
            // objects.
            () {
              return store.query(Person, partition: partition).run().toList()
                  .then((List<db.Model> models) {
                compareModels([], models);
              });
            },

            // All users query
            () {
              return store.query(User, partition: partition).run().toList()
                  .then((List<db.Model> models) {
                compareModels(users, models, anyOrder: true);
              });
            },

            // Sorted query
            () async {
              var query = store.query(User, partition: partition)
                  ..order('-name')
                  ..order('nickname');
              var models = await runQueryWithExponentialBackoff(
                  query, usersSortedNameDescNicknameAsc.length);
              compareModels(
                  usersSortedNameDescNicknameAsc, models);
            },
            () async {
              var query = store.query(User, partition: partition)
                  ..order('-name')
                  ..order('-nickname')
                  ..run();
              var models = await runQueryWithExponentialBackoff(
                  query, usersSortedNameDescNicknameDesc.length);
              compareModels(
                  usersSortedNameDescNicknameDesc, models);
            },

            // Sorted query with filter
            () async {
              var query = store.query(User, partition: partition)
                  ..filter('name >=', LOWER_BOUND)
                  ..order('-name')
                  ..order('nickname');
              var models = await runQueryWithExponentialBackoff(
                  query, usersSortedAndFilteredNameDescNicknameAsc.length);
              compareModels(usersSortedAndFilteredNameDescNicknameAsc,
                  models);
            },
            () async {
              var query = store.query(User, partition: partition)
                  ..filter('name >=', LOWER_BOUND)
                  ..order('-name')
                  ..order('-nickname')
                  ..run();
              var models = await runQueryWithExponentialBackoff(
                  query, usersSortedAndFilteredNameDescNicknameDesc.length);
              compareModels(usersSortedAndFilteredNameDescNicknameDesc,
                  models);
            },

            // Filter lists
            () async {
              var query = store.query(User, partition: partition)
                  ..filter('languages =', 'foo')
                  ..order('name')
                  ..run();
              var models = await runQueryWithExponentialBackoff(
                  query, fooUsers.length);
              compareModels(fooUsers, models, anyOrder: true);
            },
            () async {
              var query = store.query(User, partition: partition)
                  ..filter('languages =', 'bar')
                  ..order('name')
                  ..run();
              var models = await runQueryWithExponentialBackoff(
                  query, barUsers.length);
              compareModels(barUsers, models, anyOrder: true);
            },
            () async {
              var query = store.query(User, partition: partition)
                  ..filter('hobbies =', 'swimming')
                  ..run();
              var models = await runQueryWithExponentialBackoff(query, 0);
              expect(models, isEmpty);
            },
            () async {
              var query = store.query(User, partition: partition)
                  ..filter('hobbies =', 'running')
                  ..run();
              var models = await runQueryWithExponentialBackoff(query, 0);
              expect(models, isEmpty);
            },

            // Filter equals
            () async {
              var wifeKey = root.append(User, id: usersWithWife.first.wife.id);
              var query = store.query(User, partition: partition)
                  ..filter('wife =', wifeKey)
                  ..run();
              var models = await runQueryWithExponentialBackoff(
                  query, usersWithWife.length);
              compareModels(usersWithWife, models, anyOrder: true);
            },

            // Simple limit/offset test.
            () async {
              var query = store.query(User, partition: partition)
                  ..order('-name')
                  ..order('nickname')
                  ..offset(3)
                  ..limit(4);
              var expectedModels =
                  usersSortedAndFilteredNameDescNicknameAsc.sublist(3, 7);
              var models = await runQueryWithExponentialBackoff(
                  query, expectedModels.length);
              compareModels(expectedModels, models);
            },

            // Expando queries: Filter on normal property.
            () async {
              var query = store.query(ExpandoPerson, partition: partition)
                  ..filter('name =', expandoPersons.last.name)
                  ..run();
              var models = await runQueryWithExponentialBackoff(query, 1);
              compareModels([expandoPersons.last], models);
            },
            // Expando queries: Filter on expanded String property
            () async {
              var query = store.query(ExpandoPerson, partition: partition)
                  ..filter('foo =', expandoPersons.last.foo)
                  ..run();
              var models = await runQueryWithExponentialBackoff(query, 1);
              compareModels([expandoPersons.last], models);
            },
            // Expando queries: Filter on expanded int property
            () async {
              var query = store.query(ExpandoPerson, partition: partition)
                  ..filter('bar =', expandoPersons.last.bar)
                  ..run();
              var models = await runQueryWithExponentialBackoff(query, 1);
              compareModels([expandoPersons.last], models);
            },
            // Expando queries: Filter normal property with different
            // propertyName (datastore name is 'NN').
            () async {
              var query = store.query(ExpandoPerson, partition: partition)
                  ..filter('nickname =', expandoPersons.last.nickname)
                  ..run();
              var models = await runQueryWithExponentialBackoff(query, 1);
              compareModels([expandoPersons.last], models);
            },

            // Delete results
            () => store.commit(deletes: allKeys),

            // Wait until the entity deletes are reflected in the indices.
            () => waitUntilEntitiesGone(store, allKeys, partition),

            // Make sure queries don't return results
            () => store.lookup(allKeys).then((List<db.Model> models) {
              expect(models.length, equals(allKeys.length));
              for (var model in models) {
                expect(model, isNull);
              }
            }),
          ];
          return Future.forEach(tests, (f) => f());
        });
      });
    });
  }, onPlatform: {
    'mac-os': new Skip('Missing ALPN support on MacOS.'),
  });
}

Future<List<db.Model>> runQueryWithExponentialBackoff(
    db.Query query, int expectedResults) async {
  for (int i = 0; i <= 6; i++) {
    if (i > 0) {
      // Wait for 0.1s, 0.2s, ..., 12.8s
      var duration = new Duration(milliseconds: 100 * (2 << i));
      print("Running query did return less results than expected."
            "Using exponential backoff: Sleeping for $duration.");
      await sleep(duration);
    }

    List<db.Model> models = await query.run().toList();
    if (models.length >= expectedResults) {
      return models;
    }
  }

  throw new Exception(
      "Tried running a query with exponential backoff, giving up now.");
}

Future waitUntilEntitiesReady(db.DatastoreDB mdb,
                              List<db.Key> keys,
                              db.Partition partition) {
  return waitUntilEntitiesHelper(mdb, keys, true, partition);
}

Future waitUntilEntitiesGone(db.DatastoreDB mdb,
                             List<db.Key> keys,
                             db.Partition partition) {
  return waitUntilEntitiesHelper(mdb, keys, false, partition);
}

Future waitUntilEntitiesHelper(db.DatastoreDB mdb,
                               List<db.Key> keys,
                               bool positive,
                               db.Partition partition) {
  var keysByKind = {};
  for (var key in keys) {
    keysByKind.putIfAbsent(key.type, () => []).add(key);
  }

  Future waitForKeys(Type kind, List<db.Key> keys) {
    return mdb.query(kind, partition: partition)
        .run().toList().then((List<db.Model> models) {
      for (var key in keys) {
        bool found = false;
        for (var model in models) {
          if (key == model.key) found = true;
        }
        if (positive) {
          if (!found) return waitForKeys(kind, keys);
        } else {
          if (found) return waitForKeys(kind, keys);
        }
      }
      return null;
    });
  }

  return Future.forEach(keysByKind.keys.toList(), (Type kind) {
    return waitForKeys(kind, keysByKind[kind]);
  });
}
