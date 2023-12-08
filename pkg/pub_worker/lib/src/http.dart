import 'dart:async' show FutureOr;
import 'package:http/http.dart' as http;

const pubWorkerUserAgent =
    'pub_worker/0.0.0 +(http://github.com/dart-lang/pub-dev)';

extension WithAuthorization on http.Client {
  /// Returns an [http.Client] which sends a `Bearer` token as `Authorization`
  /// header for each request.
  http.Client withAuthorization(
    FutureOr<String?> Function() tokenProvider, {
    bool closeParent = true,
  }) =>
      _AuthenticatedClient(
        tokenProvider,
        this,
        closeParent,
      );
}

extension WithUserAgent on http.Client {
  /// Returns an [http.Client] which sends `User-Agent` header for each request.
  ///
  /// This will only set `User-Agent`, if the header isn't already present.
  http.Client withUserAgent(
    String userAgent, {
    bool closeParent = true,
  }) =>
      _UserAgentClient(
        userAgent,
        this,
        closeParent,
      );
}

/// An [http.Client] which sends a `Bearer` token as `Authorization` header for
/// each request.
class _AuthenticatedClient extends http.BaseClient {
  final FutureOr<String?> Function() _tokenProvider;
  final http.Client _client;
  final bool _closeInnerClient;

  _AuthenticatedClient(
    this._tokenProvider,
    this._client,
    this._closeInnerClient,
  );

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = await _tokenProvider();
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    return await _client.send(request);
  }

  @override
  void close() {
    if (_closeInnerClient) {
      _client.close();
    }
    super.close();
  }
}

/// An [http.Client] which sends a `User-Agent` header for each request.
class _UserAgentClient extends http.BaseClient {
  final String _userAgent;
  final http.Client _client;
  final bool _closeInnerClient;

  _UserAgentClient(
    this._userAgent,
    this._client,
    this._closeInnerClient,
  );

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (!request.headers.containsKey('User-Agent')) {
      request.headers['User-Agent'] = _userAgent;
    }
    return await _client.send(request);
  }

  @override
  void close() {
    if (_closeInnerClient) {
      _client.close();
    }
    super.close();
  }
}
