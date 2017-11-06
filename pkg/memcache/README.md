## Memcache interface for the `appengine` package.

This package define Dart interfaces for memcache. The package defines both
a high-level interface and a low-level interface.

These interfaces are used for the memcache support in the `appengine` package.
Therefore these interfaces only support the memcache operations supported by
App Engine.

### High-level interface

The high-level interface is called `Memcache`. It provides a `Future` based API
for the most common access patterns. It defaults to use `String` values for
both keys and values. Store and retrieve single values:

```
Memcache memcache = ...
memcache.set('MyKey', 'MyValue').then((_) {
  memcache.get('MyKey').then((String value) {
    // value is read from memcache.
  });
});
```

Store and retrieve multiple values:

```
Memcache memcache = ...
memcache.setAll({'MyKey1': 'MyValue1',
                 'MyKey2': 'MyValue2').then((_) {
  memcache.getAll(['MyKey1', 'MyKey2']).then((Map result) {
    // result is a map with the values for MyKey1 and MyKey2.
  });
});
```

The high-level interface does not expose the CAS values directly. However
through the `withCAS` method, it becomes simple to use CAS with memcache
operations. `withCAS` returns an implemetation of `Memcache` which internally
keeps track of the CAS for all keys retrieved. When a key is stored the CAS
value from when it was retrieved, will be passed automatically to memcache.

```
Memcache memcache = ...
Memcache cas = memcache.withCAS();
cas.get('MyKey').then((value) {
  memcache.set('MyKey', 'MyNewValue').then((_) {
    // MyNewValue is stored in memcache if the CAS did not
    // change from when it was retrieved.
  });
});
```

### Low-level interface

The low-level interface is called `RawMemcache` and provides a generic
interface using request/response objects send in batches to memcache.

### Using these interfaces in an App Engine application.

In a Dart App Engine application using the `appengine` package the memcahce
interface is available on the client context.

    context.services.memcache.get('MyKey').then(String value) => ...

### Native protocol implementation

This package will also provide an implementation of the native memcached
protocol. This is still work in progress, and it will support the interfaces
defined in this package.