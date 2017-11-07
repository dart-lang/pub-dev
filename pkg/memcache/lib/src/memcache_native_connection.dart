// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library memcache.native_connection;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

// For a specification of the memcached protocol see
// https://code.google.com/p/memcached/wiki/MemcacheBinaryProtocol.

class Opcode {
  static const int OPCODE_GET = 0x00;
  static const int OPCODE_SET = 0x01;
  static const int OPCODE_ADD = 0x02;
  static const int OPCODE_REPLACE = 0x03;
  static const int OPCODE_DELETE = 0x04;
  static const int OPCODE_INCREMENT = 0x05;
  static const int OPCODE_DECREMENT = 0x06;
  static const int OPCODE_QUIT = 0x07;
  static const int OPCODE_FLUSH = 0x08;
  static const int OPCODE_GETQ = 0x09;
  static const int OPCODE_NO_OP = 0x0a;
  static const int OPCODE_VERSION = 0x0b;
  static const int OPCODE_GETK = 0x0c;
  static const int OPCODE_GETKQ = 0x0d;

  static String name(int opcode) {
    if (opcode == OPCODE_GET) return "GET";
    if (opcode == OPCODE_SET) return "SET";
    if (opcode == OPCODE_ADD) return "ADD";
    if (opcode == OPCODE_REPLACE) return "REPLACE";
    if (opcode == OPCODE_DELETE) return "DELETE";
    if (opcode == OPCODE_INCREMENT) return "INCREMENT";
    if (opcode == OPCODE_DECREMENT) return "DECREMENT";
    if (opcode == OPCODE_QUIT) return "QUIT";
    if (opcode == OPCODE_FLUSH) return "FLUSH";
    if (opcode == OPCODE_GETQ) return "GETQ";
    if (opcode == OPCODE_NO_OP) return "NO OP";
    if (opcode == OPCODE_VERSION) return "VERSION";
    if (opcode == OPCODE_GETK) return "GETK";
    if (opcode == OPCODE_GETKQ) return "GETKQ";
    return "UNKNOWN";
  }

  // Additional not yet used opcodes.
  /*
    0x0e   Append
    0x0f   Prepend
    0x10   Stat
    0x11   SetQ
    0x12   AddQ
    0x13   ReplaceQ
    0x14   DeleteQ
    0x15   IncrementQ
    0x16   DecrementQ
    0x17   QuitQ
    0x18   FlushQ
    0x19   AppendQ
    0x1a   PrependQ
    0x1b   Verbosity
    0x1c   Touch
    0x1d   GAT
    0x1e   GATQ
    0x20   SASL list mechs
    0x21   SASL Auth
    0x22   SASL Step
    0x30   RGet
    0x31   RSet
    0x32   RSetQ
    0x33   RAppend
    0x34   RAppendQ
    0x35   RPrepend
    0x36   RPrependQ
    0x37   RDelete
    0x38   RDeleteQ
    0x39   RIncr
    0x3a   RIncrQ
    0x3b   RDecr
    0x3c   RDecrQ
    0x3d   Set VBucket
    0x3e   Get VBucket
    0x3f   Del VBucket
    0x40   TAP Connect
    0x41   TAP Mutation
    0x42   TAP Delete
    0x43   TAP Flush
    0x44   TAP Opaque
    0x45   TAP VBucket Set
    0x46   TAP Checkpoint Start
    0x47   TAP Checkpoint End
  */
}

class ResponseStatus {
  static const int NO_ERROR = 0x0000;
  static const int KEY_NOT_FOUND = 0x0001;
  static const int KEY_EXISTS = 0x0002;
  static const int VALUE_TOO_LARGE = 0x0003;
  static const int INVALID_ARGUMENTS = 0x0004;
  static const int ITEM_NOT_STORED = 0x0005;
  static const int INCR_DECR_NO_NON_NUMERIC = 0x0006;
  static const int VBUCKET_OTHER_SERVER = 0x0007;
  static const int AUTHENTICATION_ERROR = 0x0008;
  static const int AUTHENTICATION_CONTINUE = 0x0009;
  static const int UNKNOWN_COMMAND = 0x0081;
  static const int OUT_OF_MEMORY = 0x0082;
  static const int NOT_SUPPORTED = 0x0083;
  static const int INTERNAL_ERROR = 0x0084;
  static const int BUSY = 0x0085;
  static const int TEMPORARY_FAILURE = 0x0086;

  static String message(int code) {
    if (code == NO_ERROR) return "No error";
    if (code == KEY_NOT_FOUND) return "Key not found";
    if (code == KEY_EXISTS) return "Key exists";
    if (code == VALUE_TOO_LARGE) return "Value too large";
    if (code == INVALID_ARGUMENTS) return "Invalid arguments";
    if (code == ITEM_NOT_STORED) return "Item not stored";
    if (code == INCR_DECR_NO_NON_NUMERIC) {
      return "Incr/Decr on non-numeric value";
    }
    if (code == VBUCKET_OTHER_SERVER) {
      return "The vbucket belongs to another server";
    }
    if (code == AUTHENTICATION_ERROR) return "Authentication error";
    if (code == AUTHENTICATION_CONTINUE) {
      return "Authentication continue";
    }
    if (code == UNKNOWN_COMMAND) return "Unknown command";
    if (code == OUT_OF_MEMORY) return "Out of memory";
    if (code == NOT_SUPPORTED) return "Not supported";
    if (code == INTERNAL_ERROR) return "Internal error";
    if (code == BUSY) return "Busy";
    if (code == TEMPORARY_FAILURE) return "Temporary failure";
    return "Unknown status code";
  }
}

class Header {
  static const int REQUEST_MAGIC = 0x80;
  static const int RESPOSE_MAGIC = 0x81;
  static const int MAGIC_OFFSET = 0;
  static const int OPCODE_OFFSET = 1;
  static const int KEY_LENGTH_OFFSET = 2;
  static const int EXTRAS_LENGTH_OFFSET = 4;
  static const int DATA_TYPE_OFFSET = 5;
  static const int VBUCKET_ID_OR_STATUS_OFFSET = 6;
  static const int VBUCKET_ID_OFFSET = VBUCKET_ID_OR_STATUS_OFFSET;
  static const int STATUS_OFFSET = VBUCKET_ID_OR_STATUS_OFFSET;
  static const int TOTAL_BODY_LENGTH_OFFSET = 8;
  static const int OPAQUE_OFFSET = 12;
  static const int CAS_OFFSET = 16;

  final Uint8List bytes;
  final ByteData data;

  Header(Uint8List b)
      : bytes = b,
        data = new ByteData.view(b.buffer, b.offsetInBytes, b.lengthInBytes);

  int get magic => bytes[MAGIC_OFFSET];

  int get opcode => bytes[OPCODE_OFFSET];

  int get keyLength => data.getUint16(KEY_LENGTH_OFFSET, Endianness.BIG_ENDIAN);

  int get extrasLength => bytes[EXTRAS_LENGTH_OFFSET];

  int get dataType => bytes[DATA_TYPE_OFFSET];

  int get vbucketIdOrStatus {
    return data.getUint16(VBUCKET_ID_OR_STATUS_OFFSET, Endianness.BIG_ENDIAN);
  }

  int get totalBodyLength {
    return data.getUint32(TOTAL_BODY_LENGTH_OFFSET, Endianness.BIG_ENDIAN);
  }

  int get opaque => data.getUint32(OPAQUE_OFFSET, Endianness.BIG_ENDIAN);

  void set opaque(int value) {
    return data.setUint32(OPAQUE_OFFSET, value, Endianness.BIG_ENDIAN);
  }

  int get cas => data.getUint64(CAS_OFFSET, Endianness.BIG_ENDIAN);

  int get valueLength => totalBodyLength - extrasLength - keyLength;

  List<int> get key {
    if (keyLength == 0) return null;
    return bytes.sublist(
        Response.HEADER_LEN + extrasLength,
        Response.HEADER_LEN + extrasLength + keyLength);
  }

  List<int> get value {
    if (totalBodyLength == extrasLength + keyLength) return null;
    return bytes.sublist(
        Response.HEADER_LEN + extrasLength + keyLength, bytes.length);
  }

  String get valueAsString {
    var valueInBytes = value;
    if (valueInBytes == null) return null;
    return UTF8.decode(valueInBytes);
  }


  String formatHex(int value, int bytes) {
    // TODO(kevmoo) Use String.padLeft here?
    const String zeros = '0000000000000000';
    var hex = value.toRadixString(16);
    return '0x${zeros.substring(0, (bytes * 2) - hex.length)}$hex';
  }

  static int totalBodyLengthFromHeader(Uint8List header) {
    return new ByteData.view(header.buffer, header.offsetInBytes).getUint32(
        TOTAL_BODY_LENGTH_OFFSET, Endianness.BIG_ENDIAN);
  }
}

class Request extends Header {
  /*
    Byte/     0       |       1       |       2       |       3       |
       /              |               |               |               |
      |0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|
      +---------------+---------------+---------------+---------------+
     0| Magic         | Opcode        | Key length                    |
      +---------------+---------------+---------------+---------------+
     4| Extras length | Data type     | vbucket id                    |
      +---------------+---------------+---------------+---------------+
     8| Total body length                                             |
      +---------------+---------------+---------------+---------------+
    12| Opaque                                                        |
      +---------------+---------------+---------------+---------------+
    16| CAS                                                           |
      |                                                               |
      +---------------+---------------+---------------+---------------+
      Total 24 bytes

  Extra data for set/add/replace request:

      Byte/     0       |       1       |       2       |       3       |
         /              |               |               |               |
        |0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|
        +---------------+---------------+---------------+---------------+
       0| Flags                                                         |
        +---------------+---------------+---------------+---------------+
       4| Expiration                                                    |
        +---------------+---------------+---------------+---------------+
      Total 8 bytes

  Extra data for incr/decr

       Byte/     0       |       1       |       2       |       3       |
          /              |               |               |               |
         |0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|
         +---------------+---------------+---------------+---------------+
        0| Amount to add / subtract                                      |
         |                                                               |
         +---------------+---------------+---------------+---------------+
        8| Initial value                                                 |
         |                                                               |
         +---------------+---------------+---------------+---------------+
       16| Expiration                                                    |
         +---------------+---------------+---------------+---------------+
         Total 20 bytes

  */

  static final int HEADER_LEN = 24;
  static final int FLAGS_OFFSET = HEADER_LEN;
  static final int EXPIRATION_OFFSET = HEADER_LEN + 4;

  static final int DELTA_OFFSET = HEADER_LEN;
  static final int INITIAL_VALUE_OFFSET = HEADER_LEN + 8;
  static final int INCREMENT_EXPIRATION_OFFSET = HEADER_LEN + 16;

  static final int GET_EXTRAS_LENGTH = 0;
  static final int SET_EXTRAS_LENGTH = 8;  // Flags and expiration.
  static final int ADD_EXTRAS_LENGTH = 8;  // Flags and expiration.
  static final int REPLACE_EXTRAS_LENGTH = 8;  // Flags and expiration.
  static final int DELETE_EXTRAS_LENGTH = 0;
  // Delta, initial and expiration.
  static final int INCREMENT_EXTRAS_LENGTH = 20;

  Request(int opcode, int extrasLen,
          List<int> key, List<int> value, [int cas = 0])
      : super(new Uint8List(HEADER_LEN +
                            extrasLen +
                            (key != null ? key.length : 0) +
                            (value != null ? value.length : 0))) {
    bytes[Header.MAGIC_OFFSET] = Header.REQUEST_MAGIC;
    bytes[Header.OPCODE_OFFSET] = opcode;
    data.setUint16(Header.KEY_LENGTH_OFFSET,
                   key != null ? key.length : 0,
                   Endianness.BIG_ENDIAN);
    bytes[Header.EXTRAS_LENGTH_OFFSET] = extrasLen;
    data.setUint32(Header.TOTAL_BODY_LENGTH_OFFSET,
                   bytes.length - HEADER_LEN,
                   Endianness.BIG_ENDIAN);
    data.setUint32(Header.OPAQUE_OFFSET, 0, Endianness.BIG_ENDIAN);
    data.setUint64(Header.CAS_OFFSET, cas, Endianness.BIG_ENDIAN);
    var keyOffset = HEADER_LEN + extrasLen;
    var valueOffset = keyOffset + (key != null ? key.length : 0);
    if (key != null) {
      bytes.setRange(keyOffset, valueOffset, key);
    }
    if (value != null) {
      bytes.setRange(valueOffset, valueOffset + value.length, value);
    }
  }

  factory Request.flush() {
    return new Request(Opcode.OPCODE_FLUSH, 0, null, null);
  }

  factory Request.get(List<int> key) {
    return new Request._get(Opcode.OPCODE_GET, key);
  }

  factory Request.getq(List<int> key) {
    return new Request._get(Opcode.OPCODE_GETQ, key);
  }

  factory Request.getk(List<int> key) {
    return new Request._get(Opcode.OPCODE_GETK, key);
  }

  factory Request.getqk(List<int> key) {
    return new Request._get(Opcode.OPCODE_GETKQ, key);
  }

  factory Request._get(int opcode, List<int> key) {
    var request = new Request(opcode, GET_EXTRAS_LENGTH, key, null);
    var keyOffset = HEADER_LEN;
    request.bytes.setRange(keyOffset, keyOffset + key.length - 1, key);
    return request;
  }

  factory Request.add(
      List<int> key, List<int> value, {int flags: 0, int expiration: 0}) {
    return new Request._update(
        Opcode.OPCODE_ADD, key, value, flags, expiration, 0);
  }

  factory Request.set(List<int> key, List<int> value,
                      {int flags: 0, int expiration: 0, int cas: 0}) {
    return new Request._update(
        Opcode.OPCODE_SET, key, value, flags, expiration, cas);
  }

  factory Request.replace(List<int> key, List<int> value,
                          {int flags: 0, int expiration: 0, int cas: 0}) {
    return new Request._update(
        Opcode.OPCODE_REPLACE, key, value, flags, expiration, cas);
  }

  factory Request.delete(List<int> key, {int cas: 0}) {
    return new Request(
        Opcode.OPCODE_DELETE, DELETE_EXTRAS_LENGTH, key, null, cas);
  }

  factory Request._update(int opcode, List<int> key, List<int> value,
                          int flags, int expiration, int cas) {
    var extrasLength;
        switch (opcode) {
          case Opcode.OPCODE_SET:
            extrasLength = SET_EXTRAS_LENGTH;
            break;
          case Opcode.OPCODE_ADD:
            extrasLength = ADD_EXTRAS_LENGTH;
            break;
          case Opcode.OPCODE_REPLACE:
            extrasLength = REPLACE_EXTRAS_LENGTH;
            break;
          default:
            throw "Unsupported";
        }
    var request = new Request(opcode, extrasLength, key, value, cas);
    request.data.setUint32(FLAGS_OFFSET, flags, Endianness.BIG_ENDIAN);
    request.data.setUint32(
        EXPIRATION_OFFSET, expiration, Endianness.BIG_ENDIAN);
    return request;
  }

  factory Request.increment(
      List<int> key, int delta, int initialValue, {int expiration: 0}) {
    return new Request._incrDecr(
        Opcode.OPCODE_INCREMENT, key, delta, initialValue, expiration);
  }

  factory Request.decrement(
      List<int> key, int delta, int initialValue, {int expiration: 0}) {
    return new Request._incrDecr(
        Opcode.OPCODE_DECREMENT, key, delta, initialValue, expiration);
  }

  factory Request._incrDecr(int opcode,
      List<int> key, int delta, int initialValue, int expiration) {
    var request = new Request(
        opcode, INCREMENT_EXTRAS_LENGTH, key, null);
    request.data.setUint64(DELTA_OFFSET, delta, Endianness.BIG_ENDIAN);
    request.data.setUint64(
        INITIAL_VALUE_OFFSET, initialValue, Endianness.BIG_ENDIAN);
    request.data.setUint32(
        INCREMENT_EXPIRATION_OFFSET, expiration, Endianness.BIG_ENDIAN);
    return request;
  }

  factory Request.version() {
    return new Request(Opcode.OPCODE_VERSION, 0, null, null);
  }

  int get vbucketId => vbucketIdOrStatus;

  int get flags {
    // The flags are always the first four bytes of the extras data.
    if (extrasLength >= 4) {
      return data.getUint32(FLAGS_OFFSET, Endianness.BIG_ENDIAN);
    } else {
      throw new MemCacheError('Request for $opcode does not contain flags');
    }
  }

  String toString() =>
      'MemCache Request:\n'
      '  Magic        (0)    : ${formatHex(magic, 1)}\n'
      '  Opcode       (1)    : '
          '${formatHex(opcode, 1)} (${Opcode.name(opcode)})\n'
      '  Key length   (2,3)  : ${formatHex(keyLength, 2)}\n'
      '  Extra length (4)    : ${formatHex(extrasLength, 1)}\n'
      '  Data type    (5)    : ${formatHex(dataType, 1)}\n'
      '  vbucket id   (6,7)  : ${formatHex(vbucketId, 2)}\n'
      '  Total body   (8-11) : ${formatHex(totalBodyLength, 4)}\n'
      '  Opaque       (12-15): ${formatHex(opaque, 4)}\n'
      '  CAS          (16-23): ${formatHex(cas, 8)}\n';
}

class Response extends Header {
  /*
      Byte/     0       |       1       |       2       |       3       |
         /              |               |               |               |
        |0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|
        +---------------+---------------+---------------+---------------+
       0| Magic         | Opcode        | Key Length                    |
        +---------------+---------------+---------------+---------------+
       4| Extras length | Data type     | Status                        |
        +---------------+---------------+---------------+---------------+
       8| Total body length                                             |
        +---------------+---------------+---------------+---------------+
      12| Opaque                                                        |
        +---------------+---------------+---------------+---------------+
      16| CAS                                                           |
        |                                                               |
        +---------------+---------------+---------------+---------------+
        Total 24 bytes

  Extra data for the get response:

      Byte/     0       |       1       |       2       |       3       |
         /              |               |               |               |
        |0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|
        +---------------+---------------+---------------+---------------+
       0| Flags                                                         |
        +---------------+---------------+---------------+---------------+
        Total 4 bytes

  Value for increment/decrement response:

      Byte/     0       |       1       |       2       |       3       |
         /              |               |               |               |
        |0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|0 1 2 3 4 5 6 7|
        +---------------+---------------+---------------+---------------+
       0| 64-bit unsigned response.                                     |
        |                                                               |
        +---------------+---------------+---------------+---------------+
        Total 8 bytes
  */

  static const int HEADER_LEN = 24;
  static const int FLAGS_OFFSET = HEADER_LEN;
  static const int INCREMENT_VALUE_OFFSET = HEADER_LEN;

  Response(Uint8List header): super(header);

  int get status => vbucketIdOrStatus;

  String get statusMessage {
    if (status == ResponseStatus.NO_ERROR) return null;
    return valueAsString;
  }

  int get flags {
    if (extrasLength >= 4) {
      return data.getUint32(FLAGS_OFFSET, Endianness.BIG_ENDIAN);
    } else {
      throw new MemCacheError('Request for $opcode does not contain flags');
    }
  }

  int get incrDecrValue {
    if (extrasLength == 0 && keyLength == 0 && totalBodyLength == 8) {
      return data.getUint64(INCREMENT_VALUE_OFFSET, Endianness.BIG_ENDIAN);
    } else {
      throw new MemCacheError('Request for $opcode does not contain '
                              'incremented/decremented value');
    }
  }

  String toString() =>
      'MemCache Response:\n'
      '  Magic        (0)    : ${formatHex(magic, 1)}\n'
      '  Opcode       (1)    : '
          '${formatHex(opcode, 1)} (${Opcode.name(opcode)})\n'
      '  Key length   (2,3)  : ${formatHex(keyLength, 2)}\n'
      '  Extra length (4)    : ${formatHex(extrasLength, 1)}\n'
      '  Data type    (5)    : ${formatHex(dataType, 1)}\n'
      '  Status       (6,7)  : ${formatHex(status, 2)}\n'
      '  Total body   (8-11) : ${formatHex(totalBodyLength, 4)}\n'
      '  Opaque       (12-15): ${formatHex(opaque, 4)}\n'
      '  CAS          (16-23): ${formatHex(cas, 8)}\n';
}

class PendingRequest {
  final opaque;
  final _completer = new Completer();

  PendingRequest(Request request) : opaque = request.opaque;

  Future get future => _completer.future;

  void complete(Response response) {
    _completer.complete(response);
  }

  void completeError(error) {
    _completer.completeError(error);
  }
}

class ResponseTransformer
    implements StreamTransformer<List<int>, Response> {
  const ResponseTransformer();

  Stream<Response> bind(Stream<List<int>> stream) {
    return new Stream<Response>.eventTransformed(
        stream,
        (EventSink<Response> sink) =>
            new _ResponseTransformerSink(sink));
  }
}

class _ResponseTransformerSink implements EventSink<List<int>> {
  // Response parser state.
  static const int STATE_START = 0;
  static const int STATE_HEADER = 1;
  static const int STATE_BODY = 2;
  static const int STATE_FAILURE = 3;

  final controller = new StreamController<Response>();

  int pendingBytes = 0;
  int state = STATE_START;
  final Uint8List header = new Uint8List(Response.HEADER_LEN);
  int remaining;
  Response response;  // Current response being received.

  final EventSink<Response> _outSink;

  _ResponseTransformerSink(this._outSink);

  void add(List<int> bytes) {
    try {
      parse(bytes);
    } catch (e, s) {
      state = STATE_FAILURE;
      _outSink.addError(e, s);
      _outSink.close();
    }
  }

  void addError(e, [s]) {
    _outSink.addError(new MemCacheError(e.toString()), s);
  }

  void close() {
    if (state != STATE_START) {
      _outSink.addError(new MemCacheError('Short message'));
    }
    _outSink.close();
  }

  void parse(List<int> bytes) {
    void addResponse() {
      _outSink.add(response);
      response = null;
      state = STATE_START;
    }

    void checkHeader(Response response) {
      if (response.magic != Header.RESPOSE_MAGIC) {
        throw new MemCacheError(
            'Protocol error: Invalid magic value ${header[0]} in response');
      }
      if (response.extrasLength + response.keyLength >
          response.totalBodyLength) {
        throw new MemCacheError(
            'Protocol error: Invalid length fields in response');
      }
    }

    int index = 0;
    int length = bytes.length;
    while (index < length) {
      switch (state) {
        case STATE_START:
          // Check for full response including body.
          if (bytes is Uint8List && (length - index) >= Response.HEADER_LEN) {
            var totalBodyLengthIndex = index + Header.TOTAL_BODY_LENGTH_OFFSET;
            var totalBodyLength = new ByteData.view(
                bytes.buffer, bytes.offsetInBytes + totalBodyLengthIndex, 4)
                    .getUint32(0, Endianness.BIG_ENDIAN);
            var totalMessageLength = Response.HEADER_LEN + totalBodyLength;
            if (length - index >= totalMessageLength) {
              if (index == 0 && bytes.length == totalMessageLength) {
                response = new Response(bytes);
                checkHeader(response);
              } else {
                var view = new Uint8List.view(
                    bytes.buffer,
                    bytes.offsetInBytes + index,
                    Response.HEADER_LEN + totalBodyLength);
                response = new Response(view);
                checkHeader(response);
              }
              index += totalMessageLength;
              addResponse();
            } else {
              remaining = Response.HEADER_LEN;
              state = STATE_HEADER;
            }
          } else {
            remaining = Response.HEADER_LEN;
            state = STATE_HEADER;
          }
          break;
        case STATE_HEADER:
          // Fill as many header bytes as possible.
          int headerBytes = (bytes.length - index) >= remaining
              ? remaining : (bytes.length - index);
          int headerIndex = Response.HEADER_LEN - remaining;
          for (int i = 0; i < headerBytes; i++) {
            header[headerIndex + i] = bytes[index + i];
          }
          remaining -= headerBytes;
          index += headerBytes;
          if (remaining == 0) {
            int bodyLength = Header.totalBodyLengthFromHeader(header);
            var buffer = new Uint8List(Response.HEADER_LEN + bodyLength);
            for (int i = 0; i < Response.HEADER_LEN; i++) {
              buffer[i] = header[i];
            }
            response = new Response(buffer);
            checkHeader(response);
            remaining = response.totalBodyLength;
            if (remaining > 0) {
              state = STATE_BODY;
            } else {
              addResponse();
            }
          }
          break;
        case STATE_BODY:
          // Fill as many body bytes as possible.
          int bodyBytes = (bytes.length - index) >= remaining
              ? remaining : (bytes.length - index);
          int bodyIndex =
              Response.HEADER_LEN + response.totalBodyLength - remaining;
          for (int i = 0; i < bodyBytes; i++) {
            response.bytes[bodyIndex + i] = bytes[index + i];
          }
          remaining -= bodyBytes;
          index += bodyBytes;
          if (remaining == 0) {
            addResponse();
          }
          break;
        case STATE_FAILURE:
          throw new MemCacheError('Data on failed connection');
          break;
      }
    }
  }
}

class MemCacheError implements Exception {
  final String message;

  MemCacheError(this.message);

  String toString() => "MemCacheError: $message";
}

class MemCacheNativeConnection {
  int _nextRequestId = 0;
  final _pendingRequests = new Queue<PendingRequest>();
  final Socket _socket;
  bool _closed = false;

  MemCacheNativeConnection._(this._socket) {
    _socket.transform(new ResponseTransformer()).listen(
        onResponse, onError: onError, onDone: onDone, cancelOnError: true);
  }

  static Future<MemCacheNativeConnection> connect(server, int port) {
    return Socket.connect(server, port).then((socket) {
      return new MemCacheNativeConnection._(socket);
    });
  }

  bool get isClosed => _closed;

  void onResponse(Response response) {
    // Check whether the corresponding request is found in the queue.
    Iterator it = _pendingRequests.iterator;
    bool found = false;
    while (!found && it.moveNext()) {
      found = (it.current.opaque == response.opaque);
    }

    if (found) {
      // Found the corresponding request in the queue. Now complete all
      // requests up to and including this.
      while (_pendingRequests.isNotEmpty) {
        PendingRequest pending = _pendingRequests.removeFirst();
        if (pending.opaque == response.opaque) {
          pending.complete(response);
          return;
        } else {
          pending.complete(null);
        }
      }
    } else {
      // The corresponding request was not found.
      _closed = true;
      _pendingRequests.forEach((pending) {
        pending.completeError(new MemCacheError("Protocol error"));
      });
      _socket.destroy();
    }
  }

  void onError(error) {
    close(error);
  }

  void onDone() {
    close("Connection closed");
  }

  Future<Response> sendRequest(Request request) {
    if (_closed) {
      return new Future.error(new MemCacheError("Connection closed"));
    }
    request.opaque = _nextRequestId;
    _nextRequestId = (_nextRequestId + 1) & 0xffffffff;
    var pending = new PendingRequest(request);
    _pendingRequests.add(pending);
    _socket.add(request.bytes);
    return pending.future;
  }

  Future close([String error = 'Forcefully closing connection']) async {
    if (_closed) return;
    _closed = true;

    // When there is a communication error complete all pending requests.
    _pendingRequests.forEach((pending) {
      pending.completeError(new MemCacheError(error));
    });

    await _socket.close();
  }
}
