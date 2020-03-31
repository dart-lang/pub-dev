import 'dart:convert';
import 'package:shelf/shelf.dart' as shelf;
import 'package:meta/meta.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:uuid/uuid.dart' show Uuid;

export 'package:shelf_router/shelf_router.dart' show Router;
export 'package:shelf/shelf.dart' show Request, Response;

final _log = Logger('api_builder');

/// Annotation for an API end-point.
class EndPoint {
  /// HTTP verb for requests routed to the annotated method.
  final String verb;

  /// HTTP route for request routed to the annotated method.
  final String route;

  /// Create an annotation that routes requests matching [verb] and [route] to
  /// the annotated method.
  const EndPoint(this.verb, this.route);

  /// Route `GET` requests matching [route] to annotated method.
  const EndPoint.get(this.route) : verb = 'GET';

  /// Route `HEAD` requests matching [route] to annotated method.
  const EndPoint.head(this.route) : verb = 'HEAD';

  /// Route `POST` requests matching [route] to annotated method.
  const EndPoint.post(this.route) : verb = 'POST';

  /// Route `PUT` requests matching [route] to annotated method.
  const EndPoint.put(this.route) : verb = 'PUT';

  /// Route `DELETE` requests matching [route] to annotated method.
  const EndPoint.delete(this.route) : verb = 'DELETE';

  /// Route `CONNECT` requests matching [route] to annotated method.
  const EndPoint.connect(this.route) : verb = 'CONNECT';

  /// Route `OPTIONS` requests matching [route] to annotated method.
  const EndPoint.options(this.route) : verb = 'OPTIONS';

  /// Route `TRACE` requests matching [route] to annotated method.
  const EndPoint.trace(this.route) : verb = 'TRACE';
}

/// Thrown to cause a different response than what the end-point would normally
/// return.
class ApiResponseException implements Exception {
  final int status;
  final String code;
  final String message;

  ApiResponseException({
    @required this.status,
    @required this.code,
    @required this.message,
  });

  shelf.Response asApiResponse() => shelf.Response(status,
          body: json.fuse(utf8).encode({
            'error': {
              'code': code,
              'message': message,
            },
            // TODO: remove after the above gets deployed live
            'code': code,
            'message': message,
          }),
          headers: {
            'content-type': 'application/json; charset="utf-8"',
            'x-content-type-options': 'nosniff',
          });
}

/// Utility methods exported for use in generated code.
abstract class $utilities {
  /// Utility method exported for use in generated code.
  static Future<T> decodeJson<T>(
    shelf.Request request,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    // TODO: Consider enforcing that requests should have 'Content-Type' set to
    // 'application/json'. Notice that we should be careful as the CLI client,
    // might be sending a different Content-Type.
    final data = await request.readAsString();
    try {
      final value = json.decode(data);
      if (value is Map<String, dynamic>) {
        try {
          return fromJson(value);
        } catch (_) {
          throw FormatException('payload structure is not valid');
        }
      }
      throw FormatException('payload must always be a JSON object');
    } on FormatException {
      throw ApiResponseException(
        status: 400,
        code: 'InvalidInput',
        message: 'Malformed JSON payload',
      );
    }
  }

  /// Utility method exported for use in generated code.
  static shelf.Response jsonResponse(Map<String, dynamic> payload) {
    return shelf.Response(200, body: json.fuse(utf8).encode(payload), headers: {
      'content-type': 'application/json; charset="utf-8"',
      'x-content-type-options': 'nosniff',
    });
  }

  /// Utility method exported for use in generated code.
  static shelf.Response unhandledError(Object e, StackTrace st) {
    final incidentId = Uuid().v4();
    _log.severe(
        'Unhandled error in API handler (incidentId: $incidentId)', e, st);
    return ApiResponseException(
      status: 500,
      code: 'InternalError',
      message:
          'Internal server error, ask operator to lookup incidentId: $incidentId',
    ).asApiResponse();
  }
}
