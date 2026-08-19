// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:appengine/src/errors.dart';
import 'package:gcloud/datastore.dart' as datastore;

const isNetworkError = TypeMatcher<NetworkError>();
const isProtocolError = TypeMatcher<ProtocolError>();
const isServiceError = TypeMatcher<ServiceError>();
const isApplicationError = TypeMatcher<AppEngineError>();
const isAppEngineApplicationError = TypeMatcher<ApplicationError>();

const isDatastoreApplicationError = TypeMatcher<datastore.ApplicationError>();
const isTransactionAbortedError =
    TypeMatcher<datastore.TransactionAbortedError>();
const isNeedIndexError = TypeMatcher<datastore.NeedIndexError>();
const isTimeoutError = TypeMatcher<datastore.TimeoutError>();

const isInt = TypeMatcher<int>();
