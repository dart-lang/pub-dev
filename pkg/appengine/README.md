# Dart support for Google AppEngine

This package provides support for running server applications written in Dart on
[Google App Engine](https://cloud.google.com/appengine/) using
[Custom Runtimes with Flex Environment](https://cloud.google.com/appengine/docs/flexible/custom-runtimes/).


## Prerequisites

### Install Dart and Cloud SDKs

This page assumes the Dart SDK (see
[dartlang.org/install](https://www.dartlang.org/install)) as well as the Google
Cloud SDK (see [cloud.google.com/sdk](https://cloud.google.com/sdk/)) were
installed and their bin folders have been added to `PATH`.

### Setup gcloud

To ensure gcloud was authorized to access the cloud project and we have the
`app` component installed, we assume the following has been run:
```console
$ gcloud auth login
$ gcloud config set project <project-name>
$ gcloud components update app
```

### Creation service account

Furthermore in order to operate on the data of the cloud project, a service
account needs to be created which allows downloading a private key in JSON
format. Such a key can be obtained via the
[Cloud Console](https://console.cloud.google.com) under
`IAM & Admin > Service Accounts > Create Service Account`.

## Creating a hello world application

To setup a hello world application we need 4 different things:

#### An `app/pubspec.yaml` file describing the Dart package:
```yaml
name: hello_world
version: 0.1.0
dependencies:
  appengine: '>=0.4.0 <0.5.0'
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
#ENV GCLOUD_KEY /project/key.json
#ENV GCLOUD_PROJECT dartlang-pub
```

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

There are two ways to run the application locally - with or without docker. Both
of which require a service account key.

### Running without Docker

The simplest way to run the application is on the command line like this:
```console
$ export GCLOUD_KEY=<path-to-service-account-key.json>
$ export GCLOUD_PROJECT=<project-name>
$ dart bin/server.dart
```

This will serve the application at [localhost:8080](http://localhost:8080)!

Please note: There is an [Issue 63](https://github.com/dart-lang/appengine/issues/63) which
causes this to not work on MacOS at the moment.

### Running with Docker

To be closer to the production environment one can run the application inside a
docker container. In order to do so, docker needs to be installed first (see the
[official instructions](https://docs.docker.com/engine/installation/).

In order to run the application locally we uncomment the 3 lines in the
`Dockerfile` and place the service account key in under `app/key.json`:
```Dockerfile
ADD key.json /project/key.json
ENV GCLOUD_KEY /project/key.json
ENV GCLOUD_PROJECT dartlang-pub
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


## Using memcache via memcached

By default, the `memcacheService` in `package:appengine` is a NOP – it does not
perform any caching – unless a memcache service is found at the default port –
`localhost:11211`.

App Engine Flexible Environment doesn't have a memcache service at the moment,
but it is possible to simply install a `memcached` inside the Docker container.

Update the `Dockerfile` with the installation of `memcached`:

```Dockerfile
FROM ...

# We install memcached and remove the apt-index again to keep the
# docker image diff small.
RUN apt-get update && \
    apt-get install -y memcached && \
    rm -rf /var/lib/apt/lists/*

...

CMD []
ENTRYPOINT service memcached start && sleep 1 && /bin/bash /dart_runtime/dart_run.sh
```


## Using the datastore emulator

The gcloud sdk provides an easy-to-use datastore emulator. The emulator can be
launched via

```console
$ gcloud beta emulators datastore start
...
[datastore] If you are using a library that supports the DATASTORE_EMULATOR_HOST
[datastore] environment variable, run:
[datastore] 
[datastore]   export DATASTORE_EMULATOR_HOST=localhost:8268
[datastore] 
[datastore] Dev App Server is now running.
...
```

To make the application use the emulator, the `DATASTORE_EMULATOR_HOST`
environment variable needs to be set (in addition to the other variables):

```console
$ export DATASTORE_EMULATOR_HOST=localhost:8268
$ export GCLOUD_KEY=<path-to-service-account-key.json>
$ export GCLOUD_PROJECT=<project-name>
$ dart bin/server.dart
```
