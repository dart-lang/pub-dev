import 'dart:io' show HttpHeaders;
import 'package:shelf/shelf.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

/// Auxiliary function to read multipart requests to shelf.
Stream<MimeMultipart> readMultiparts(Request request) {
  String? boundary;
  try {
    final c = MediaType.parse(
      request.headers[HttpHeaders.contentTypeHeader] ?? '',
    );
    if (c.type == 'multipart') {
      boundary = c.parameters['boundary'];
    }
  } on FormatException {
    // pass
  }
  if (boundary == null) {
    throw StateError('request must be multipart');
  }
  return request.read().transform(MimeMultipartTransformer(boundary));
}
