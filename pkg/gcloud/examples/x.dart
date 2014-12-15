import 'dart:async';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:gcloud/storage.dart';
import 'package:gcloud/http.dart';
import 'package:gcloud/service_scope.dart' as ss;

Future runApp() {
  // The `runApp` function runs inside a context and can therefore
  // access any registered values. In this case we use the `storage`
  // object. But the `authenticatedClient` object is available as well.
  return storageService.listBucketNames().listen(print).asFuture();
}

main() {
  // Assumes we are running on a ComputeEngine VM with the storage scopes
  // enabled.
  auth.clientViaMetadataServer().then((httpClient) {
    // Creates a new context and runs the given closure inside it.
    ss.fork(() {
      ss.registerScopeExitCallback(httpClient.close);

      // We register the HTTP client.
      registerAuthClientService(httpClient);

      // We register the storage object inside the newly created service scope.
      // This makes it available to all code running inside this context.
      registerStorageService(new Storage(httpClient, 'my-project-id'));
      return runApp();
    });
  });
}
