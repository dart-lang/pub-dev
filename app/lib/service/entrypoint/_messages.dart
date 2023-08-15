// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:isolate';

/// Base class for inter-isolate messages.
sealed class Message {
  /// Decode message from JSON-like [map], this is JSON + [SendPort] objects.
  ///
  /// ## Supported messages
  /// 
  /// ### `entry` message
  /// ```js
  /// {
  ///   entry: {
  ///     protocolSendPort: <port>,
  ///     aliveSendPort: <port>,
  ///   },
  /// }
  /// ```
  ///
  /// ### `ready` message
  /// TODO: documentation
  static Message decodeFromMap(Map<String, dynamic> map) {
    if (map.keys.length != 1) {
      throw FormatException(
          'Expected only a single key, got "${map.keys.join(', ')}"');
    }
    final key = map.keys.single;
    final inner = map[key] as Map<String, dynamic>;
    switch (key) {
      case 'entry':
        return EntryMessage(
          protocolSendPort: inner['protocolSendPort'] as SendPort,
          aliveSendPort: inner['aliveSendPort'] as SendPort,
        );
      case 'ready':
        return ReadyMessage(
          requestSendPort: inner['requestSendPort'] as SendPort?,
        );
      case 'request':
        return RequestMessage(
          inner['kind'] as String,
          inner['payload'] as Object,
          inner['replyPort'] as SendPort,
        );
      case 'reply':
        return ReplyMessage._(
          error: inner['error'] as String?,
          result: inner['result'],
        );
      case 'debug':
        return DebugMessage(inner['text'] as String);
    }
    throw FormatException('Unknown key: "$key".');
  }

  Map<String, dynamic> encodeAsJson();
}

/// Initializing message send from the controller isolate to the new isolate.
class EntryMessage extends Message {
  /// Port to which ??? must be sent when ???
  ///
  /// This message is used to ???
  final SendPort protocolSendPort;
  
  /// Port to which ??? must be sent periodically (Approximatically every ??? seconds).
  ///
  /// This message tells the isolate owner that the isolate isn't stuck.
  /// In particular, this aims to allow the [IsolateRunner???] to terminate
  /// the isolate if it gets stuck in an infinite-loop.
  final SendPort aliveSendPort;

  EntryMessage({
    required this.protocolSendPort,
    required this.aliveSendPort,
  });

  @override
  Map<String, dynamic> encodeAsJson() {
    return {
      'entry': {
        'protocolSendPort': protocolSendPort,
        'aliveSendPort': aliveSendPort,
      },
    };
  }
}

/// Message sent from the isolate to indicate that it is ready.
///
/// This message indicates that initialization has completed successfully.
class ReadyMessage extends Message {
  final SendPort? requestSendPort;

  ReadyMessage({
    this.requestSendPort,
  });

  @override
  Map<String, dynamic> encodeAsJson() {
    return {
      'ready': {
        'requestSendPort': requestSendPort,
      },
    };
  }
}

/// Message sent to a different isolate group for processing.
class RequestMessage extends Message {
  /// The `kind` of the target isolate group.
  final String kind;

  /// The payload (request) object.
  final Object payload;

  /// Port to which a [ReplyMessage] must be sent when the request is processed.
  ///
  /// The sender of the request may close the [replyPort], if the sender has decided
  /// timeout and not wait any further.
  final SendPort replyPort;

  RequestMessage(this.kind, this.payload, this.replyPort);

  @override
  Map<String, dynamic> encodeAsJson() {
    return {
      'request': {
        'kind': kind,
        'payload': payload,
        'replyPort': replyPort,
      },
    };
  }
}

/// Message sent as a reply to a [RequestMessage].
class ReplyMessage extends Message {
  final String? error;
  final Object? result;

  ReplyMessage._({
    required this.error,
    required this.result,
  });
  ReplyMessage.error(String message)
      : error = message,
        result = null;
  ReplyMessage.result(Object value)
      : result = value,
        error = null;

  bool get isError => error != null;

  @override
  Map<String, dynamic> encodeAsJson() {
    return {
      'reply': {
        if (error != null) 'error': error,
        if (result != null) 'result': result,
      }
    };
  }
}

/// Message sent from the isolate with arbitrary text.
class DebugMessage extends Message {
  final String text;

  DebugMessage(this.text);

  @override
  Map<String, dynamic> encodeAsJson() {
    return {
      'debug': {
        'text': text,
      },
    };
  }
}

/// Send [RequestMessage] and wait for [ReplyMessage] returning
/// [ReplyMessage.result], or throws [IsolateRequestException]
Future<Object?> sendRequest({
  required SendPort target,
  required String kind,
  required Object payload,
  required Duration timeout,
}) async {
  final replyRecievePort = ReceivePort();
  final firstFuture = replyRecievePort.first;
  requestSendPort.send(
      RequestMessage(kind, payload, replyRecievePort.sendPort).encodeAsJson());
  final first = await firstFuture.timeout(timeout) as Map<String, dynamic>;
  final reply = Message.decodeFromMap(first) as ReplyMessage;
  if (reply.isError) {
    throw IsolateRequestException(reply.error, kind);
  }
  return reply.result;
}
