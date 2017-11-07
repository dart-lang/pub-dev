// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth.test_utils;

import 'dart:async';

import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/src/crypto/pem.dart';
import 'package:googleapis_auth/src/utils.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

const Matcher isUserConsentException = const _UserConsentException();

class _UserConsentException extends TypeMatcher {
  const _UserConsentException() : super("UserConsentException");

  bool matches(item, Map matchState) => item is UserConsentException;
}

const Matcher isRefreshFailedException = const _RefreshFailedException();

class _RefreshFailedException extends TypeMatcher {
  const _RefreshFailedException() : super("RefreshFailedException");

  bool matches(item, Map matchState) => item is RefreshFailedException;
}

const Matcher isAccessDeniedException = const _AccessDeniedException();

class _AccessDeniedException extends TypeMatcher {
  const _AccessDeniedException() : super("AccessDeniedException");

  bool matches(item, Map matchState) => item is AccessDeniedException;
}

const Matcher isTransportException = const _TransportException();

class _TransportException extends TypeMatcher {
  const _TransportException() : super("TransportException");

  bool matches(item, Map matchState) => item is TransportException;
}

class TransportException implements Exception {}

Client get transportFailure {
  return new MockClient(expectAsyncT((Request _) {
    return new Future<Response>.error(new TransportException());
  }));
}

Function/*=T*/ expectAsyncT/*<T>*/(Function/*=T*/ handler, {int count: 1}) {
  return expectAsync(handler as Function, count: count) as Function/*=T*/;
}

const TestPrivateKeyString = '''-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAuDOwXO14ltE1j2O0iDSuqtbw/1kMKjeiki3oehk2zNoUte42
/s2rX15nYCkKtYG/r8WYvKzb31P4Uow1S4fFydKNWxgX4VtEjHgeqfPxeCL9wiJc
9KkEt4fyhj1Jo7193gCLtovLAFwPzAMbFLiXWkfqalJ5Z77fOE4Mo7u4pEgxNPgL
VFGe0cEOAsHsKlsze+m1pmPHwWNVTcoKe5o0hOzy6hCPgVc6me6Y7aO8Fb4OVg0l
XQdQpWn2ikVBpzBcZ6InnYyJ/CJNa3WL1LJ65mmYnfHtKGoMqhLK48OReguwRwwF
e9/2+8UcdZcN5rsvt7yg3ZrKNH8rx+wZ36sRewIDAQABAoIBAQCn1HCcOsHkqDlk
rDOQ5m8+uRhbj4bF8GrvRWTL2q1TeF/mY2U4Q6wg+KK3uq1HMzCzthWz0suCb7+R
dq4YY1ySxoSEuy8G5WFPmyJVNy6Lh1Yty6FmSZlCn1sZdD3kMoK8A0NIz5Xmffrm
pu3Fs2ozl9K9jOeQ3xgC9RoPFLrm8lHJ45Vn+SnTxZnsXT6pwpg3TnFIx5ZinU8k
l0Um1n80qD2QQDakQ5jyr2odAELLBDlyCkxAglBXAVt4nk9Kl6nxb4snd9dnrL70
WjLynWQsDczaV9TZIl2hYkMud+9OLVlUUtB+0c5b0p2t2P0sLltDaq3H6pT6yu2G
8E86J9IBAoGBAPJaTNV5ysVOFn+YwWwRztzrvNArUJkVq8abN0gGp3gUvDEZnvzK
weF7+lfZzcwVRmQkL3mWLzzZvCx77RfulAzLi5iFuRBPhhhxAPDiDuyL9B7O81G/
M/W5DPctGOyD/9cnLuh72oij0unc5MLSfzJf8wblpcjJnPBDqIVh6Qt9AoGBAMKT
Gacf4iSj1xW+0wrnbZlDuyCl6Msptj8ePcvLQrFqQmBwsXmWgVR+gFc/1G3lRft0
QC6chsmafQHIIPpaDjq3sQ01/tUu7LXL+g/Hw9XtUHbkg3sZIQBtC26rKdStfHNS
KTvuCgn/dAJNjiohfhWMt9R4Q6E5FV6PqQHJzPJXAoGAC41qZDKuC8GxKNvrPG+M
4NML6RBngySZT5pOhExs5zh10BFclshDfbAfOtjTCotpE5T1/mG+VrQ6WBSANMfW
ntWFDfwx2ikwRzH7zX+5HmV9eYp75sWqgGgVyiKIMZ4JMARaJBLjU+gbQbKZ5P+L
uKcCOq3vvSZ/KKTQ/6qvJTECgYBiWgbCgoxF5wdmd4Gn5llw+lqRYyur3hbACuJD
rCe3FDYfF3euNRSEiDkJYTtYnWbldtqmdPpw14VOrEF3KqQ8q/Nz8RIx4jlGn6dz
6I8mCIH+xv1q8MXMuFHqC9zmIxdgF2y+XVF3wkd6jodI5oscC3g0juHokbkqhkVw
oPfWmwKBgBfR6jv0gWWeWTfkNwj+cMLHQV1uvz6JyLH5K4iISEDFxYkd37jrHB8A
9hz9UDfmCbSs2j8CXDg7zCayM6tfu4Vtx+8S5g3oN6sa1JXFY1Os7SoXhTfX9M+7
QpYYDJZwkgZrVQoKMIdCs9xfyVhZERq945NYLekwE1t2W+tOVBgR
-----END RSA PRIVATE KEY-----''';

final TestPrivateKey = keyFromString(TestPrivateKeyString);

expectExpiryOneHourFromNow(AccessToken accessToken) {
  var now = new DateTime.now().toUtc();
  var diff = accessToken.expiry.difference(now).inSeconds -
      (3600 - MAX_EXPECTED_TIMEDIFF_IN_SECONDS);
  expect(-2 <= diff && diff <= 2, isTrue);
}

Client mockClient(Future<Response> requestHandler(Request _),
    {bool expectClose: true}) {
  return new ExpectCloseMockClient(requestHandler, expectClose ? 1 : 0);
}

/// A client which will keep the VM alive until `close()` was called.
class ExpectCloseMockClient extends MockClient {
  Function _expectedToBeCalled;

  ExpectCloseMockClient(Future<Response> requestHandler(Request _), int c)
      : super(requestHandler) {
    _expectedToBeCalled = expectAsync(() {}, count: c);
  }

  void close() {
    super.close();
    _expectedToBeCalled();
  }
}
