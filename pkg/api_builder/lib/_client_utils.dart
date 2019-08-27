/// Utilities for use in generated client code.
library client_utils;

import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class RequestException implements Exception {
  final int status;
  final Map<String, String> headers;
  final List<int> body;

  RequestException(this.status, this.headers, [this.body]);

  String bodyAsString() => utf8.decode(body);

  Map<String, dynamic> bodyAsJson() =>
      json.decode(bodyAsString()) as Map<String, dynamic>;

  @override
  String toString() => 'RequestException(status = $status)';
}

class Client {
  final String _baseUrl;
  final http.Client _client;

  Client(String baseUrl, {http.Client client})
      : _baseUrl = baseUrl,
        _client = client {
    ArgumentError.checkNotNull(_baseUrl, 'baseUrl');
  }

  Future<T> _withClient<T>(FutureOr<T> Function(http.Client) fn) async {
    if (_client != null) {
      return fn(_client);
    }
    final client = http.Client();
    try {
      return await fn(client);
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> requestJson({
    @required String verb,
    @required String path,
    Map<String, String> query,
    Map<String, dynamic> body,
  }) =>
      _withClient((client) async {
        final u = Uri.parse(_baseUrl + path).replace(queryParameters: query);
        final req = http.Request(verb, u);
        if (body != null) {
          req.bodyBytes = json.fuse(utf8).encode(body);
          req.headers['content-type'] = 'application/json; charset="utf-8"';
        }
        final res = await http.Response.fromStream(await client.send(req));
        if (200 <= res.statusCode && res.statusCode < 300) {
          return json.fuse(utf8).decode(res.bodyBytes) as Map<String, dynamic>;
        }
        throw RequestException(res.statusCode, res.headers, res.bodyBytes);
      });

  Future<List<int>> requestBytes({
    @required String verb,
    @required String path,
    Map<String, String> query,
    Map<String, dynamic> body,
  }) =>
      _withClient((client) async {
        final u = Uri.parse(_baseUrl + path).replace(queryParameters: query);
        final req = http.Request(verb, u);
        if (body != null) {
          req.bodyBytes = json.fuse(utf8).encode(body);
          req.headers['content-type'] = 'application/json; charset="utf-8"';
        }
        final res = await http.Response.fromStream(await client.send(req));
        if (200 <= res.statusCode && res.statusCode < 300) {
          return res.bodyBytes;
        }
        throw RequestException(res.statusCode, res.headers, res.bodyBytes);
      });
}

/// Utility method exported for use in generated code.
Future<http.Response> sendRequest(
  http.Client client,
  String verb,
  String url, [
  Map<String, dynamic> body,
]) async {
  final req = http.Request(verb, Uri.parse(url));
  if (body != null) {
    req.bodyBytes = json.fuse(utf8).encode(body);
    req.headers['content-type'] = 'application/json; charset="utf-8"';
  }
  return await http.Response.fromStream(await client.send(req));
}
