// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library http_wrapper;

import 'dart:async';
import 'dart:io';
import 'dart:convert';

class AppengineHttpRequest implements HttpRequest {
  final HttpRequest _realRequest;
  AppengineHttpResponse _response;
  bool _hasSubscriber = false;

  AppengineHttpRequest(this._realRequest) {
    _response = new AppengineHttpResponse(this, _realRequest.response);
  }

  AppengineHttpResponse get response => _response;

  Future<bool> any(bool test(List<int> element)) {
    _hasSubscriber = true;
    return _realRequest.any(test);
  }

  Stream<List<int>> asBroadcastStream(
      {void onListen(StreamSubscription<List<int>> subscription),
       void onCancel(StreamSubscription<List<int>> subscription)}) {
    _hasSubscriber = true;
    return _realRequest.asBroadcastStream(onListen: onListen,
                                          onCancel: onCancel);
  }

  Stream asyncExpand(Stream convert(List<int> event)) {
    _hasSubscriber = true;
    return _realRequest.asyncExpand(convert);
  }

  Stream asyncMap(convert(List<int> event)) {
    _hasSubscriber = true;
    return _realRequest.asyncMap(convert);
  }

  Future<bool> contains(Object needle) {
    _hasSubscriber = true;
    return _realRequest.contains(needle);
  }

  Stream<List<int>> distinct(
      [bool equals(List<int> previous, List<int> next)]) {
    _hasSubscriber = true;
    return _realRequest.distinct(equals);
  }

  Future drain([futureValue])  {
    _hasSubscriber = true;
    return _realRequest.drain(futureValue);
  }

  Future<List<int>> elementAt(int index) {
    _hasSubscriber = true;
    return _realRequest.elementAt(index);
  }

  Future<bool> every(bool test(List<int> element)) {
    _hasSubscriber = true;
    return _realRequest.every(test);
  }

  Stream expand(Iterable convert(List<int> value)) {
    _hasSubscriber = true;
    return _realRequest.expand(convert);
  }

  Future<List<int>> get first {
    _hasSubscriber = true;
    return _realRequest.first;
  }

  Future firstWhere(bool test(List<int> element), {Object defaultValue()}) {
    _hasSubscriber = true;
    return _realRequest.firstWhere(test, defaultValue: defaultValue);
  }

  Future fold(initialValue, combine(previous, List<int> element)) {
    _hasSubscriber = true;
    return _realRequest.fold(initialValue, combine);
  }

  Future forEach(void action(List<int> element)) {
    _hasSubscriber = true;
    return _realRequest.forEach(action);
  }

  Stream<List<int>> handleError(Function onError, {bool test(error)}) {
    _hasSubscriber = true;
    return _realRequest.handleError(onError, test: test);
  }

  Future<bool> get isEmpty {
    _hasSubscriber = true;
    return _realRequest.isEmpty;
  }

  Future<String> join([String separator = ""]) {
    _hasSubscriber = true;
    return _realRequest.join(separator);
  }

  Future<List<int>> get last {
    _hasSubscriber = true;
    return _realRequest.last;
  }

  Future lastWhere(bool test(List<int> element), {Object defaultValue()}) {
    _hasSubscriber = true;
    return _realRequest.lastWhere(test, defaultValue: defaultValue);
  }

  Future<int> get length {
    _hasSubscriber = true;
    return _realRequest.length;
  }

  StreamSubscription<List<int>> listen(void onData(List<int> event),
      {Function onError, void onDone(), bool cancelOnError}) {
    _hasSubscriber = true;
    return _realRequest.listen(onData,
                               onError: onError,
                               onDone: onDone,
                               cancelOnError: cancelOnError);
  }

  Stream map(convert(List<int> event)) {
    _hasSubscriber = true;
    return _realRequest.map(convert);
  }

  Future<List<int>> get single {
    _hasSubscriber = true;
    return _realRequest.single;
  }

  Future<List<int>> singleWhere(bool test(List<int> element)) {
    _hasSubscriber = true;
    return _realRequest.singleWhere(test);
  }

  Stream<List<int>> skip(int count) {
    _hasSubscriber = true;
    return _realRequest.skip(count);
  }

  Stream<List<int>> skipWhile(bool test(List<int> element)) {
    _hasSubscriber = true;
    return _realRequest.skipWhile(test);
  }

  Stream<List<int>> take(int count) {
    _hasSubscriber = true;
    return _realRequest.take(count);
  }

  Stream<List<int>> takeWhile(bool test(List<int> element)) {
    _hasSubscriber = true;
    return _realRequest.takeWhile(test);
  }

  Stream timeout(Duration timeLimit, {void onTimeout(EventSink sink)}) {
    _hasSubscriber = true;
    return _realRequest.timeout(timeLimit, onTimeout: onTimeout);
  }

  Future<List<List<int>>> toList() {
    _hasSubscriber = true;
    return _realRequest.toList();
  }

  Future<Set<List<int>>> toSet() {
    _hasSubscriber = true;
    return _realRequest.toSet();
  }

  Stream transform(StreamTransformer<List<int>, dynamic> streamTransformer) {
    _hasSubscriber = true;
    return _realRequest.transform(streamTransformer);
  }

  Stream<List<int>> where(bool test(List<int> event)) {
    _hasSubscriber = true;
    return _realRequest.where(test);
  }

  Future<List<int>> reduce(
      List<int> combine(List<int> previous, List<int> element)) {
    _hasSubscriber = true;
    return _realRequest.reduce(combine);
  }

  Future pipe(StreamConsumer<List<int>> streamConsumer) {
    _hasSubscriber = true;
    return _realRequest.pipe(streamConsumer);
  }

  Uri get uri => _realRequest.uri;

  X509Certificate get certificate => _realRequest.certificate;

  HttpConnectionInfo get connectionInfo => _realRequest.connectionInfo;

  int get contentLength => _realRequest.contentLength;

  List<Cookie> get cookies => _realRequest.cookies;

  HttpHeaders get headers => _realRequest.headers;

  bool get isBroadcast => _realRequest.isBroadcast;

  String get method => _realRequest.method;

  bool get persistentConnection => _realRequest.persistentConnection;

  String get protocolVersion => _realRequest.protocolVersion;

  Uri get requestedUri => _realRequest.requestedUri;

  HttpSession get session => _realRequest.session;
}

abstract class AppengineIOSinkMixin {
  void writeAll(Iterable objects, [String separator = ""]) {
    Iterator iterator = objects.iterator;
    if (!iterator.moveNext()) return;
    if (separator.isEmpty) {
      do {
        write(iterator.current);
      } while (iterator.moveNext());
    } else {
      write(iterator.current);
      while (iterator.moveNext()) {
        write(separator);
        write(iterator.current);
      }
    }
  }

  void writeln([Object obj = ""]) {
    write(obj);
    write('\n');
  }

  void writeCharCode(int charCode) {
    write(new String.fromCharCode(charCode));
  }

  void write(Object obj) {
    add(encoding.encode('$obj'));
  }

  void add(List<int> data);

  Encoding get encoding;
}

class AppengineHttpResponse extends Object
                            with AppengineIOSinkMixin
                            implements HttpResponse {
  final AppengineHttpRequest _request;
  final HttpResponse _realResponse;
  AppengineHttpHeaders _headers;

  // Buffer mechanism + state
  static const int _STATE_BUILDING_HEADER = 0;
  static const int _STATE_BUILDING_RESPONSE = 1;
  static const int _STATE_ADDING_STREAM = 2;
  static const int _STATE_FINISHED = 3;

  final BytesBuilder _data = new BytesBuilder();
  final List<Function> _hooksToRunBeforeEnd = [];
  final Completer _hooksAndResponseComplete = new Completer();
  int _state = _STATE_BUILDING_HEADER;
  Future _drainFuture = null;

  AppengineHttpResponse(this._request, this._realResponse) {
    _headers = new AppengineHttpHeaders(this);
  }

  void registerHook(Function function) => _hooksToRunBeforeEnd.add(function);

  void add(List<int> data) {
    if (_state == _STATE_BUILDING_HEADER) {
      _state = _STATE_BUILDING_RESPONSE;
    } else if (_state == _STATE_ADDING_STREAM) {
      throw new StateError(
          'Cannot add data while addStream() has not finished');
    }
    _enqueueData(data);
  }

  void addError(error, [StackTrace stackTrace]) {
    if (_state == _STATE_BUILDING_HEADER) {
      _state = _STATE_BUILDING_RESPONSE;
    } else if (_state == _STATE_ADDING_STREAM) {
      throw new StateError(
          'Cannot add data while addStream() has not finished');
    }
    _submitData(error, stackTrace);
  }

  Future addStream(Stream<List<int>> stream) {
    if (_state == _STATE_ADDING_STREAM) {
      throw new StateError(
          'Cannot call addStream() before previous addStream() is done.');
    }
    _state = _STATE_ADDING_STREAM;
    var completer = new Completer();

    stream.listen((List<int> data) {
      _enqueueData(data);
    }, onError: (error, stack) {
      // NOTE: The error will be reported on the returned Future of addStream().
      // The close()/done future will complete without an error.
      _submitData();
      completer.completeError(error, stack);
    }, onDone: () {
      _state = _STATE_BUILDING_RESPONSE;
      completer.complete(this);
    }, cancelOnError: true);

    return completer.future;
  }

  Future flush() {
    // We have to collect all data before sending it back, so we do not support
    // flushing the output stream.
    return new Future.value();
  }

  Future close() {
    _submitData();
    return done;
  }

  Future get done => _hooksAndResponseComplete.future;

  HttpConnectionInfo get connectionInfo => _realResponse.connectionInfo;

  void set deadline(Duration deadline) {
    _realResponse.deadline = deadline;
  }

  Duration get deadline => _realResponse.deadline;

  void set bufferOutput(bool bufferOutput) {
    _realResponse.bufferOutput = bufferOutput;
  }

  bool get bufferOutput => _realResponse.bufferOutput;

  Future redirect(Uri location, {int status: HttpStatus.MOVED_TEMPORARILY}) {
    _ensureInHeaderBuildingState();
    return _submitRedirect(location, status);
  }

  void set contentLength(int contentLength) {
    // NOTE: The state checking will be handled by [_headers].
    _headers.contentLength = contentLength;
  }

  int get contentLength => _headers.contentLength;

  // NOTE: We have custom headers here, to override state checking, since the
  // underlying [_realResponse], doesn't know when we start buffering data.
  HttpHeaders get headers => _headers;

  // NOTE: The 'dart:io' implementation allows you to modify cookies after
  // writing data, so we just forward.
  List<Cookie> get cookies => _realResponse.cookies;

  void set statusCode(int statusCode) {
    _ensureInHeaderBuildingState(stateError: true);
    _realResponse.statusCode = statusCode;
  }

  int get statusCode => _realResponse.statusCode;

  void set persistentConnection(bool persistentConnection) {
    _ensureInHeaderBuildingState();
    _realResponse.persistentConnection = persistentConnection;
  }

  bool get persistentConnection => _realResponse.persistentConnection;

  void set reasonPhrase(String reasonPhrase) {
    _ensureInHeaderBuildingState(stateError: true);
    _realResponse.reasonPhrase = reasonPhrase;
  }

  String get reasonPhrase => _realResponse.reasonPhrase;


  void set encoding(Encoding _encoding) {
    throw new StateError('HttpResponse encoding is not mutable.');
  }

  Encoding get encoding => _realResponse.encoding;

  Future<Socket> detachSocket({bool writeHeaders: true}) {
    throw new UnsupportedError('You cannot detach the socket '
        'from AppengineHttpResponse implementation.');
  }

  Future _drain() {
    // Asynchronously detect whether we need to drain and if so drain it.
    return new Future(() {
      // If someone listens to the data, we will not drain it.
      if (_request._hasSubscriber) {
        return new Future.value();
      }
      _request._hasSubscriber = true;
      return _request.drain().catchError((_) {});
    });
  }

  _enqueueData(List<int> data) {
    if (_state == _STATE_FINISHED) return;

    if (_drainFuture == null) {
      _drainFuture = _drain();
    }

    _data.add(data);
  }

  _submitData([error, stack]) {
    if (_state == _STATE_FINISHED) return;
    _state = _STATE_FINISHED;

    if (_drainFuture == null) {
      _drainFuture = _drain();
    }

    // Run all hooks before sending the data and closing.
    _drainFuture.then((_) {
      _runHooks().then((_) {
        if (_request.method != 'HEAD' &&_realResponse.contentLength == -1) {
          _realResponse.contentLength = _data.length;
        }
        _realResponse.add(_data.takeBytes());
        _data.clear();
        _realResponse.close().then((_){
          _hooksAndResponseComplete.complete(this);
        }).catchError((error, stack) {
          _hooksAndResponseComplete.completeError(error, stack);
        });
      });
    });
  }

  Future _submitRedirect(Uri location, int status) {
    _state = _STATE_FINISHED;

    if (_drainFuture == null) {
      _drainFuture = _drain();
    }

    // Run all hooks before sending the redirect.
    return _drainFuture.then((_) {
      return _runHooks().then((_) {
        return _realResponse.redirect(location, status: status);
      });
    });
  }

  void _ensureInHeaderBuildingState({bool stateError: false}) {
    if (_state != _STATE_BUILDING_HEADER) {
      if (stateError) {
        throw new StateError('HTTP headers were already sent.');
      } else {
        throw new HttpException('HTTP headers were already sent.');
      }
    }
  }

  Future _runHooks() {
    // TODO: We swallow errors from the hooks here. Having an internal error
    // mechanism would be beneficial where we could report these kinds of
    // errors.
    var futures = _hooksToRunBeforeEnd.map((hook) => hook());
    return Future.wait(futures).catchError((_) {});
  }
}

class AppengineHttpHeaders implements HttpHeaders {
  final AppengineHttpResponse _response;
  final HttpHeaders _realHeaders;

  AppengineHttpHeaders(AppengineHttpResponse response)
      : _response = response, _realHeaders = response._realResponse.headers;

  List<String> operator [](String name) {
    // NOTE: The underlying HttpResponse from dart:io doesn't do checks, so we
    // don't do checks either here.
    return _realHeaders[name];
  }

  void add(String name, Object value) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.add(name, value);
  }

  void set chunkedTransferEncoding(bool chunkedTransferEncoding) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.chunkedTransferEncoding = chunkedTransferEncoding;
  }

  bool get chunkedTransferEncoding => _realHeaders.chunkedTransferEncoding;

  void set contentLength(int contentLength) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.contentLength = contentLength;
  }

  int get contentLength => _realHeaders.contentLength;

  void set contentType(ContentType contentType) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.contentType = contentType;
  }

  ContentType get contentType => _realHeaders.contentType;

  void set date(DateTime date) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.date = date;
  }

  DateTime get date => _realHeaders.date;

  void set expires(DateTime expires) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.expires = expires;
  }

  DateTime get expires => _realHeaders.expires;

  void forEach(void f(String name, List<String> values)) {
    // NOTE: The underlying HttpResponse from dart:io leaks the List (which is
    // modifiable even after writing data), so we don't change that.
    _realHeaders.forEach(f);
  }

  void set host(String host) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.host = host;
  }

  String get host => _realHeaders.host;

  void set ifModifiedSince(DateTime ifModifiedSince) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.ifModifiedSince = ifModifiedSince;
  }

  DateTime get ifModifiedSince => _realHeaders.ifModifiedSince;

  void noFolding(String name) {
    // NOTE: The underlying HttpResponse from dart:io doesn't do checks, so we
    // don't do checks either here.
    _realHeaders.noFolding(name);
  }

  void set persistentConnection(bool persistentConnection) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.persistentConnection = persistentConnection;
  }

  bool get persistentConnection => _realHeaders.persistentConnection;

  void set port(int port) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.port = port;
  }

  int get port => _realHeaders.port;

  void remove(String name, Object value) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.remove(name, value);
  }

  void removeAll(String name) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.removeAll(name);
  }

  void set(String name, Object value) {
    _response._ensureInHeaderBuildingState();
    _realHeaders.set(name, value);
  }

  String value(String name) => _realHeaders.value(name);

  void clear() {
    _response._ensureInHeaderBuildingState();
    _realHeaders.clear();
  }
}
