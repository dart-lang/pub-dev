This package provide support for running Dart on
[Google App Engine Managed VMs][managed-vms].

### Getting started

Visit [dartlang.org/cloud](https://www.dartlang.org/cloud) for more information
on the requirements for getting started.

When you are up and running a simple hello world application looks like this:

```
import 'dart:io';
import 'package:appengine/appengine.dart';

void requestHandler(HttpRequest request) {
  request.response
      ..write('Hello, world!');
      ..close();
}

void main() {
  runAppEngine(requestHandler).then((_) {
    // Server running.
  });
}
```

Add the application configuration in a `app.yaml` file and run it locally using
by running:

    gcloud preview app run app.yaml

When you are ready to deploy your application, make sure you have authenticated
with `gcloud` and defined your current project. Then run:

    gcloud preview app deploy app.yaml

### Send Feedback

We'd love to hear from you! If you encounter a bug, have suggestions for our
APIs or is missing a feature, file it an issue on the
[GitHub issue tracker](https://github.com/dart-lang/appengine/issues/new).

**Note** The Dart support for App Engine is currently in beta.

[managed-vms]: https://developers.google.com/appengine/docs/managed-vms/
