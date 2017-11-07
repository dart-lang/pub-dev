// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of gcloud.db;

/**
 * Represents a unique identifier for a [Model] stored in a datastore.
 *
 * The [Key] can be incomplete if it's id is `null`. In this case the id will
 * be automatically allocated and set at commit time.
 */
class Key {
  // Either KeyImpl or PartitionImpl
  final Object _parent;

  final Type type;
  final Object id;

  Key(Key parent, this.type, this.id) : _parent = parent {
    if (type == null) {
      throw new ArgumentError('The type argument must not be null.');
    }
    if (id != null && id is! String && id is! int) {
      throw new ArgumentError(
          'The id argument must be an integer or a String.');
    }
  }

  Key.emptyKey(Partition partition)
      : _parent = partition,
        type = null,
        id = null;

  /**
   * Parent of this [Key].
   */
  Key get parent {
    if (_parent is Key) {
      return _parent;
    }
    return null;
  }

  /**
   * The partition of this [Key].
   */
  Partition get partition {
    var obj = _parent;
    while (obj is! Partition) {
      obj = (obj as Key)._parent;
    }
    return obj;
  }

  Key append(Type modelType, {Object id}) {
    return new Key(this, modelType, id);
  }

  bool get isEmpty => _parent is Partition;

  operator ==(Object other) {
    return other is Key &&
        _parent == other._parent &&
        type == other.type &&
        id == other.id;
  }

  int get hashCode => _parent.hashCode ^ type.hashCode ^ id.hashCode;
}

/**
 * Represents a datastore partition.
 *
 * A datastore is partitioned into namespaces. The default namespace is
 * `null`.
 */
class Partition {
  final String namespace;

  Partition(this.namespace) {
    if (namespace == '') {
      throw new ArgumentError('The namespace must not be an empty string');
    }
  }

  /**
   * Returns an empty [Key].
   *
   * Entities where the parent [Key] is empty will create their own entity
   * group.
   */
  Key get emptyKey => new Key.emptyKey(this);

  operator ==(Object other) {
    return other is Partition && namespace == other.namespace;
  }

  int get hashCode => namespace.hashCode;
}

/**
 * Superclass for all model classes.
 *
 * Every model class has a [id] -- which must be an integer or a string, and
 * a [parentKey]. The [key] getter is returning the key for the model object.
 */
abstract class Model {
  Object id;
  Key parentKey;

  Key get key => parentKey.append(this.runtimeType, id: id);
}

/**
 * Superclass for all expanded model classes.
 *
 * The [ExpandoModel] class adds support for having dynamic properties. You can
 * set arbitrary fields on these models. The expanded values must be values
 * accepted by the [RawDatastore] implementation.
 */
@proxy
abstract class ExpandoModel extends Model {
  final Map<String, Object> additionalProperties = {};

  Object noSuchMethod(Invocation invocation) {
    var name = mirrors.MirrorSystem.getName(invocation.memberName);
    if (name.endsWith('=')) name = name.substring(0, name.length - 1);
    if (invocation.isGetter) {
      return additionalProperties[name];
    } else if (invocation.isSetter) {
      var value = invocation.positionalArguments[0];
      additionalProperties[name] = value;
      return value;
    } else {
      throw new ArgumentError('Unsupported noSuchMethod call on ExpandoModel');
    }
  }
}
