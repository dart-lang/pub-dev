import 'package:client_data/publisher_api.dart' as p;
import 'package:http/http.dart' as http;
import 'package:api_builder/_client_utils.dart' as utils;

export 'package:api_builder/_client_utils.dart' show RequestException;

class PublisherApiClient {
  final utils.Client _client;

  PublisherApiClient(String baseUrl, {http.Client client})
      : _client = utils.Client(baseUrl, client: client);

  Future<p.PublisherInfo> updatePublisher(
      String publisherId, p.UpdatePublisherRequest payload) async {
    return p.PublisherInfo.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/publisher/$publisherId',
      body: payload.toJson(),
    ));
  }
}
