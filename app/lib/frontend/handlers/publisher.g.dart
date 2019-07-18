// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher.dart';

// **************************************************************************
// ApiRouterGenerator
// **************************************************************************

Router _$PublisherApiRouter(PublisherApi service) {
  final router = Router();
  router.add('PUT', r'/api/publisher/<publisherId>',
      (Request request, String publisherId) async {
    try {
      final _$result = await service.updatePublisher(
          request,
          publisherId,
          await $utilities.decodeJson<UpdatePublisherRequest>(request, (o) {
            return UpdatePublisherRequest.fromJson(o);
          }));
      return $utilities.jsonResponse(_$result.toJson());
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('DELETE', r'/api/publisher/<publisherId>',
      (Request request, String publisherId) async {
    try {
      final _$result = await service.deletePublisher(request, publisherId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  return router;
}
