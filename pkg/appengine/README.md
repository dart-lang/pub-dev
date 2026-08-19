[![package:appengine](https://github.com/dart-lang/labs/actions/workflows/appengine.yml/badge.svg)](https://github.com/dart-lang/labs/actions/workflows/appengine.yml)
[![pub package](https://img.shields.io/pub/v/appengine.svg)](https://pub.dev/packages/appengine)
[![package publisher](https://img.shields.io/pub/publisher/appengine.svg)](https://pub.dev/packages/appengine/publisher)

## Dart support for Google AppEngine

This package provides support for running server applications written in Dart on
[Google App Engine](https://cloud.google.com/appengine/) using
[Custom Runtimes with Flex Environment](https://cloud.google.com/appengine/docs/flexible/custom-runtimes/).

## Status: Experimental

**NOTE**: This package is currently experimental and published under the
[labs.dart.dev](https://dart.dev/dart-team-packages) pub publisher in order to
solicit feedback. 

For packages in the labs.dart.dev publisher we generally plan to either graduate
the package into a supported publisher (dart.dev, tools.dart.dev) after a period
of feedback and iteration, or discontinue the package. These packages have a
much higher expected rate of API and breaking changes.

Your feedback is valuable and will help us evolve this package. For general
feedback, suggestions, and comments, please file an issue in the 
[bug tracker](https://github.com/dart-lang/appengine/issues).

## Prerequisites

### Install Dart and Cloud SDKs

This page assumes the Dart SDK (see
[dart.dev/get-dart](https://dart.dev/get-dart)) as well as the Google
Cloud SDK (see [cloud.google.com/sdk](https://cloud.google.com/sdk/)) were
installed and their bin folders have been added to `PATH`.

### Setup gcloud

To ensure gcloud was authorized to access the cloud project and we have the
`app` component installed, we assume the following has been run:
```console
$ gcloud auth login
$ gcloud auth application-default login
$ gcloud config set project <project-name>
$ gcloud components update app
```

Instead of running `gcloud auth application-default login` it is also possible
to authenticate by making the environment variable
`GOOGLE_APPLICATION_CREDENTIALS` point to a file containing
_exported service account credentials_.

## Creating a hello world application

To setup a hello world application we need 4 different things:

#### An `app/pubspec.yaml` file describing the Dart package:
```yaml
name: hello_world
version: 0.1.0
environment:
  sdk: '>=2.0.0 <3.0.0'

dependencies:
  appengine: ^0.12.0
```
#### An `app/app.yaml` file describing the AppEngine app:
```yaml
runtime: custom
env: flex
service: default
```
#### An `app/Dockerfile` describing how to build/bundle the app:
```Dockerfile
FROM google/dart-runtime

### NOTE: Uncomment the following lines for local testing:
#ADD key.json /project/key.json
#ENV GOOGLE_APPLICATION_CREDENTIALS /project/key.json
#ENV GOOGLE_CLOUD_PROJECT dartlang-pub
```

This requires _exported service account credentials_ in `key.json`.

#### An `app/bin/server.dart` containing the app code
```dart
import 'dart:io';
import 'package:appengine/appengine.dart';

requestHandler(HttpRequest request) {
  request.response
      ..write('Hello, world!')
      ..close();
}

main() async {
  await runAppEngine(requestHandler);
}
```

## Running the app locally

There are two ways to run the application locally - with or without docker.

### Running without Docker

The simplest way to run the application is on the command line like this:
```console
$ gcloud auth application-default login
$ export GOOGLE_CLOUD_PROJECT=<project-name>
$ dart bin/server.dart
```

This will serve the application at [localhost:8080](http://localhost:8080)!

### Running with Docker

To be closer to the production environment one can run the application inside a
docker container. In order to do so, docker needs to be installed first (see the
[official instructions](https://docs.docker.com/engine/installation/).

In order to run the application locally we uncomment the 3 lines in the
`Dockerfile` and place the service account key in `key.json`:
```Dockerfile
ADD key.json /project/key.json
ENV GOOGLE_APPLICATION_CREDENTIALS /project/key.json
ENV GOOGLE_CLOUD_PROJECT dartlang-pub
```

We can then run the application via:
```console
$ docker build .
...
Sucessfully built <docker-imgage-hash>
$ docker run -it <docker-imgage-hash>
...
```

In order to find out at which IP the Docker container is available we inspect
the running container via:
```console
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
<container-id>       ...
app % docker inspect --format '{{ .NetworkSettings.IPAddress }}' <container-id>
172.17.0.2
```

Then the application will be available at [172.17.0.2:8080](http://172.17.0.2:8080).

## Deployment

Before deploying the app, be sure to remove the environment variables in the
`Dockerfile` which we used for local testing!

To deploy the application to the cloud we run the following command (optionally
passing the `--no-promote` flag to avoid replacing the production version)

```console
$ gcloud app deploy --no-promote app.yaml
...
Updating service [default]...done.
Deployed service [default] to [https://<version-id>-dot-<project-id>.appspot.com]
...
```

This will perform a remote docker build in the cloud and deploy a new version.
You can find the URL to the version that got deployed
in the output of `gcloud app deploy` (as well as via the
[Cloud Console](https://console.cloud.google.com) under `AppEngine > Versions`).

## Regenerating protobuf

You need to have protoc in `$PATH`.
Run the `tool/fetch_protos_and_regenerate_dart.sh` script. It will fetch the
latest protos and compile them for dart using the protoc_plugin in
`dev_dependencies`.
