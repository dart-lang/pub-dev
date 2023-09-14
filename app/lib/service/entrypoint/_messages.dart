// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:isolate';

/// Base class for inter-isolate messages.
sealed class Message {
  /// Decode message from JSON-like map, this is JSON + [SendPort] objects.
  ///
  /// ## Supported messages
  ///
  /// ### `entry` message, converted to [EntryMessage]
  ///
  /// ```js
  /// {
  ///   entry: {
  ///     protocolSendPort: <port>,
  ///   },
  /// }
  /// ```
  ///
  /// ### `ready` message, converted to [ReadyMessage]
  ///
  /// ```js
  /// {
  ///   ready: {
  ///     requestSendPort: <port>,
  ///   },
  /// }
  /// ```
  ///
  /// ### `debug` message, converted to [DebugMessage]
  ///
  /// ```js
  /// {
  ///   debug: {
  ///     text: <string>,
  ///   }
  /// }
  /// ```
  ///
  /// ### `request` message, converted to [RequestMessage]
  ///
  /// ```js
  /// {
  ///   request: {
  ///     payload: <object>,
  ///     replyPort: <port>,
  ///   }
  /// }
  /// ```
  ///
  /// ### `reply` message, converted to [ReplyMessage]
  ///
  /// ```js
  /// {
  ///   reply: {
  ///     error: <string>,
  ///     result: <object>,
  ///   }
  /// }
  /// ```
  static Message fromObject(Object? value) {
    if (value is Message) {
      return value;
    }
    if (value is Map) {
      if (value.keys.length != 1) {
        throw FormatException(
            'Expected only a single key, got "${value.keys.join(', ')}"');
      }
      final key = value.keys.single;
      final inner = value[key] as Map<String, dynamic>;
      switch (key) {
        case 'entry':
          return EntryMessage(
            protocolSendPort: inner['protocolSendPort'] as SendPort,
          );
        case 'ready':
          return ReadyMessage(
            requestSendPort: inner['requestSendPort'] as SendPort?,
          );
        case 'request':
          return RequestMessage(
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
    throw ArgumentError('Unknown argument: "$value"');
  }

  Map<String, dynamic> encodeAsJson();
}

/// Initializing message send from the controller isolate to the new isolate.
class EntryMessage extends Message {
  /// Port to which the isolate must be send its messages, starting with the
  /// [ReadyMessage] when all the initialization is done after starting it.
  ///
  /// The isolate must use this port to send [RequestMessage] for cross-isolate
  /// communication.
  ///
  /// The isolate may use this port to send [DebugMessage] when special logging
  /// is needed.
  final SendPort protocolSendPort;

  EntryMessage({
    required this.protocolSendPort,
  });

  @override
  Map<String, dynamic> encodeAsJson() {
    return {
      'entry': {
        'protocolSendPort': protocolSendPort,
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

/// Message sent to an isolate group for processing.
class RequestMessage extends Message {
  /// The payload (request) object.
  final Object payload;

  /// Port to which a [ReplyMessage] must be sent when the request is processed.
  ///
  /// The sender of the request may close the [replyPort], if the sender has decided
  /// timeout and not wait any further.
  final SendPort replyPort;

  RequestMessage(this.payload, this.replyPort);

  @override
  Map<String, dynamic> encodeAsJson() {
    return {
      'request': {
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

/// Thrown when an isolate requests is returning an error.
class IsolateRequestException implements Exception {
  final String message;

  IsolateRequestException(this.message);
}
