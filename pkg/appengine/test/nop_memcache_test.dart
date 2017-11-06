// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:memcache/src/memcache_impl.dart';
import 'package:appengine/src/api_impl/nop_memcache_impl.dart';

main() async {
  test('nop-memcache', () async {
    final memcache = new MemCacheImpl(new NopMemcacheRpcImpl());

    expect(await memcache.remove('a'), isNull);
    expect(await memcache.set('a', 'b'), isNull);
    expect(await memcache.get('a'), isNull);
    expect(await memcache.increment('a'), 0);
    expect(await memcache.increment('a', initialValue: 42), 42);
    expect(await memcache.clear(), isNull);
  });
}
