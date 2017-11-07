// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library error_matchers;

import 'package:unittest/unittest.dart';
import 'package:gcloud/datastore.dart';

class _ApplicationError extends TypeMatcher {
  const _ApplicationError() : super("ApplicationError");
  bool matches(item, Map matchState) => item is ApplicationError;
}

class _DataStoreError extends TypeMatcher {
  const _DataStoreError() : super("DataStoreError");
  bool matches(item, Map matchState) => item is DatastoreError;
}

class _TransactionAbortedError extends TypeMatcher {
  const _TransactionAbortedError() : super("TransactionAbortedError");
  bool matches(item, Map matchState) => item is TransactionAbortedError;
}

class _NeedIndexError extends TypeMatcher {
  const _NeedIndexError() : super("NeedIndexError");
  bool matches(item, Map matchState) => item is NeedIndexError;
}

class _TimeoutError extends TypeMatcher {
  const _TimeoutError() : super("TimeoutError");
  bool matches(item, Map matchState) => item is TimeoutError;
}

class _IntMatcher extends TypeMatcher {
  const _IntMatcher() : super("IntMatcher");
  bool matches(item, Map matchState) => item is int;
}

const isApplicationError = const _ApplicationError();

const isDataStoreError = const _DataStoreError();
const isTransactionAbortedError = const _TransactionAbortedError();
const isNeedIndexError = const _NeedIndexError();
const isTimeoutError = const _TimeoutError();

const isInt = const _IntMatcher();
