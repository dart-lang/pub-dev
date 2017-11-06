// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library gcloud.common;

import 'dart:async';

/// A single page of paged results from a query.
///
/// Use `next` to move to the next page. If this is the last page `next`
/// completes with `null`
abstract class Page<T> {
  /// The items in this page.
  List<T> get items;

  /// Whether this is the last page of results.
  bool get isLast;

  /// Move to the next page.
  ///
  /// The future returned completes with the next page or results.
  ///
  /// If [next] is called on the last page the returned future completes
  /// with `null`.
  Future<Page<T>> next({int pageSize});
}

typedef Future<Page<T>> FirstPageProvider<T>(int pageSize);

/// Helper class to turn a series of pages into a stream.
class StreamFromPages<T> {
  static const int _PAGE_SIZE = 50;
  final FirstPageProvider _firstPageProvider;
  bool _pendingRequest = false;
  bool _paused = false;
  bool _cancelled = false;
  Page _currentPage;
  StreamController _controller;

  StreamFromPages(this._firstPageProvider) {
    _controller = new StreamController(
        sync: true,
        onListen: _onListen,
        onPause: _onPause,
        onResume: _onResume,
        onCancel: _onCancel);
  }

  Stream<T> get stream => _controller.stream;

  void _handleError(e, s) {
    _controller.addError(e, s);
    _controller.close();
  }

  void _handlePage(Page<T> page) {
    if (_cancelled) return;
    _pendingRequest = false;
    _currentPage = page;
    page.items.forEach(_controller.add);
    if (page.isLast) {
      _controller.close();
    } else if (!_paused && !_cancelled) {
      page.next().then(_handlePage, onError: _handleError);
    }
  }

  _onListen() {
    int pageSize = _PAGE_SIZE;
    _pendingRequest = true;
    _firstPageProvider(pageSize).then(_handlePage, onError: _handleError);
  }

  _onPause() {
    _paused = true;
  }

  _onResume() {
    _paused = false;
    if (_pendingRequest) return;
    _pendingRequest = true;
    _currentPage.next().then(_handlePage, onError: _handleError);
  }

  _onCancel() {
    _cancelled = true;
  }
}
