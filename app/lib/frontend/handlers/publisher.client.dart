// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ClientLibraryGenerator
// **************************************************************************

import 'package:api_builder/_client_utils.dart' show ResponseException;
import 'package:http/http.dart' as _i1;
import 'package:api_builder/_client_utils.dart' as _i2;
import 'package:client_data/publisher_api.dart' as _i3;

/// Client for invoking `PublisherApi` through the generated router.
///
/// Reponses other than 2xx causes the methods to throw
/// `ResponseException`. JSON encoding/decoding errors are not
/// handled gracefully. End-points that does not return a JSON
/// structure result in a method that returns the response body
/// as bytes
class PublisherApiClient {
  PublisherApiClient(String baseUrl, {_i1.Client client})
      : _client = _i2.Client(baseUrl, client: client);

  final _i2.Client _client;

  Future<_i3.PublisherInfo> updatePublisher(
      String publisherId, _i3.UpdatePublisherRequest payload) async {
    return _i3.PublisherInfo.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/publisher/$publisherId',
      body: payload.toJson(),
    ));
  }

  Future<List<int>> deletePublisher(String publisherId) async {
    return await _client.requestBytes(
      verb: 'delete',
      path: '/api/publisher/$publisherId',
    );
  }
}
