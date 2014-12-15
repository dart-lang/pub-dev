// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library error_matchers;

import 'package:unittest/unittest.dart';

import 'package:appengine/api/errors.dart';
import 'package:gcloud/datastore.dart' as datastore;

import 'package:memcache/memcache.dart' as memcache;

class _NetworkError extends TypeMatcher {
  const _NetworkError() : super("NetworkError");
  bool matches(item, Map matchState) => item is NetworkError;
}

class _ProtocolError extends TypeMatcher {
  const _ProtocolError() : super("ProtocolError");
  bool matches(item, Map matchState) => item is ProtocolError;
}

class _ServiceError extends TypeMatcher {
  const _ServiceError() : super("ServiceError");
  bool matches(item, Map matchState) => item is ServiceError;
}

class _ApplicationError extends TypeMatcher {
  const _ApplicationError() : super("ApplicationError");
  bool matches(item, Map matchState) => item is datastore.ApplicationError;
}

class _AppEngineApplicationError extends TypeMatcher {
  const _AppEngineApplicationError() : super("ApplicationError");
  bool matches(item, Map matchState) => item is ApplicationError;
}

class _TransactionAbortedError extends TypeMatcher {
  const _TransactionAbortedError() : super("TransactionAbortedError");
  bool matches(item, Map matchState)
      => item is datastore.TransactionAbortedError;
}

class _NeedIndexError extends TypeMatcher {
  const _NeedIndexError() : super("NeedIndexError");
  bool matches(item, Map matchState) => item is datastore.NeedIndexError;
}

class _TimeoutError extends TypeMatcher {
  const _TimeoutError() : super("TimeoutError");
  bool matches(item, Map matchState) => item is datastore.TimeoutError;
}

class _MemcacheError extends TypeMatcher {
  const _MemcacheError() : super("MemcacheError");
  bool matches(item, Map matchState) => item is memcache.MemcacheError;
}

class _MemcacheNotStoredError extends TypeMatcher {
  const _MemcacheNotStoredError() : super("NotStoredError");
  bool matches(item, Map matchState) => item is memcache.NotStoredError;
}


class _IntMatcher extends TypeMatcher {
  const _IntMatcher() : super("IntMatcher");
  bool matches(item, Map matchState) => item is int;
}

const isNetworkError = const _NetworkError();
const isProtocolError = const _ProtocolError();
const isServiceError = const _ServiceError();
const isApplicationError = const _ApplicationError();
const isAppEngineApplicationError = const _AppEngineApplicationError();

const isTransactionAbortedError = const _TransactionAbortedError();
const isNeedIndexError = const _NeedIndexError();
const isTimeoutError = const _TimeoutError();

const isMemcacheError = const _MemcacheError();
const isMemcacheNotStored = const _MemcacheNotStoredError();

const isInt = const _IntMatcher();
