[![Build Status](https://travis-ci.org/dart-lang/pub-dartlang-dart.svg?branch=master)](https://travis-ci.org/dart-lang/pub-dartlang-dart)

# Code for the "pub.dartlang.org" website.

The server for hosting pub packages on [pub.dartlang.org](https://pub.dartlang.org)
is implemented using AppEngine Custom Runtimes with Flexible environment
(see [package:appengine](github.com/dart-lang/appengine) for more information about
Dart support for AppEngine).

## Local Development

### Running the entire server locally

Generally speaking it is very easy to run the entire application locally
(though be careful: it uses **production data** by default)!

**Switch to using dev/staging data (optional)**

To use a different Google Cloud Project, the `app/bin/configuration.dart` needs
to be modified:
```diff
- final activeConfiguration = new Configuration.prod();
+ final activeConfiguration = new Configuration.dev();
```

This can be done in two ways, running with or without Docker. Running with Docker will
be closer to the way the app runs on production (e.g. including using a memcache) -- though
the turnaround time is a bit longer.

For both variants it is necessary to obtain a service account key for the Cloud Project.
Such a key can be obtained via the [Developers Console](https://console.cloud.google.com/)
under `IAM and Admin > Service Accounts > Create Service Account` using the `JSON` (not the `P12`)
key variant.

#### Variant a) Running locally without Docker

To run the `frontend` application locally follow these steps:
```
pub-dartlang-dart $ cd app
pub-dartlang-dart/app $ pub get
pub-dartlang-dart/app $ export GCLOUD_PROJECT=dartlang-pub
pub-dartlang-dart/app $ export GCLOUD_KEY=<path-to-service-account-key.json>
pub-dartlang-dart/app $ dart bin/server.dart
```

The server will be available via at [localhost:8080](http://localhost:8080)

To run the `analyzer` service locally:

```
pub-dartlang-dart/app $ GAE_SERVICE="analyzer" dart bin/server.dart
```

#### Variant b) Running locally With Docker

To run the application locally with Docker follow these steps (please note you need to have the
service account key inside the checkout (preferrably at `key.json`), because only files inside
the checkout can go into the docker context):
```
pub-dartlang-dart $ vim Dockerfile

# NOTE: Uncomment the following lines for local testing:
ADD key.json /project/key.json
ENV GCLOUD_KEY /project/key.json
ENV GCLOUD_PROJECT dartlang-pub

pub-dartlang-dart $ docker build .
<docker-imgage-hash>
pub-dartlang-dart $ docker run -it <docker-imgage-hash>
```

The server will be available via at [172.17.0.2:8080](http://172.17.0.2:8080/). The IP address might differ
and can be obtained via `docker ps` and `docker inspect <container-id>`.


### Running unit tests

The unittests for the site can be run (tested on linux) via:

```
pub-dartlang-dart $ cd app
pub-dartlang-dart/app $ pub get
pub-dartlang-dart/app $ pub run test
00:17 +63: All tests passed!
```

## Deploying a new version to production

### Shortcut

Run `dart deploy.dart all --delete-old`

### Longer version

Before being able to deploy, please ensure you have an up-to-date version of the
[Google Cloud SDK](https://cloud.google.com/sdk/) installed.

To deploy a new version use the following steps:

```
pub-dartlang-dart $ gcloud config set project dartlang-pub
pub-dartlang-dart $ gcloud app deploy --no-promote app.yaml
...
Updating service [default]...done.
Deployed service [default] to [https://<2017...>-dot-dartlang-pub.appspot.com]

You can stream logs from the command line by running:
  $ gcloud app logs tail -s default

To view your application in the web browser run:
  $ gcloud app browse
```

This will do a remote docker build in the cloud, push the generated docker image layers to a
GCS bucket and deploy a new version to AppEngine.

After deploying a new version to the cloud we tag the git commit and push it to the repository.
This allows others to correlate the production version with the Git commit that was used for
deployment.

```
pub-dartlang-dart $ git tag -a <version> -m <version>
pub-dartlang-dart $ git push origin <version>
```

### Services

The pub site uses three services:
- `analyzer`
- `dartdoc` (pending)
- `search`

To deploy each, use the following:

```
pub-dartlang-dart $ gcloud app deploy --no-promote analyzer.yaml
pub-dartlang-dart $ gcloud app deploy --no-promote dartdoc.yaml
pub-dartlang-dart $ gcloud app deploy --no-promote search.yaml
```

Check the following URLs for immediate feedback on the services:
- `analyzer`: [prod](https://analyzer-dot-dartlang-pub.appspot.com/debug), [staging](https://analyzer-dot-dartlang-pub-dev.appspot.com/debug)
- `dartdoc`: [prod](https://dartdoc-dot-dartlang-pub.appspot.com/debug), [staging](https://dartdoc-dot-dartlang-pub-dev.appspot.com/debug).
- `search`: [prod](https://search-dot-dartlang-pub.appspot.com/debug), [staging](https://search-dot-dartlang-pub-dev.appspot.com/debug). Make sure that `ready` flag is `true` before diverting traffic to the new version.

Services can be deployed and updated independently, but version-specific deploy instructions may apply in the PR description.

### Version upgrade with breaking changes: pana

When a breaking change of `pana` is applied, the newly deployed `analyzer` service will
populate new `Analysis` instances with the new format. There is a short window, where this
could lead to issues, either the old `frontend` reading new values badly, or the new `frontend`
reading the old values in a wrong way.

To minimize the risk of such issues, a two-phase release is required:
- First, deploy the new version of the `analyzer` service, and wait until its done with its first round.
  Wait roughly 1-2 days at the moment, the `/debug` url should give a good estimate, for how long.
- Then deploy the `search` service and the `app` frontend.

While the new `analyzer` is running, the old `frontend` will request and work with old `Analysis` objects,
and by the time we deploy the new version, the new `Analysis` instances will be ready.

## Updating generated code

The app uses `json_serializable` to generate `toJson` and `fromJson` for several
classes. The associated files all have an associated `.g.dart` file. If you
change any of the associated classes, you can regenerate the code by running
`./tool/build.dart` from the `app` directory.

## Using custom third-party packages (or any non-published packages)

If one wants to use customized versions of packages we depend on (e.g. `package:markdown` with a fix)
we do this by adding them to this repository and wiring things up.

Here is an example of using a customized version of `package:markdown`:

```
# Create the customized-package
pub-dartlang-dart $ mkdir -p pkgs
pub-dartlang-dart $ cp -Rp ~/.pub-cache/hosted/pub.dartlang.org/markdown-0.11.2 pkgs/markdown
pub-dartlang-dart $ vim pkgs/markdown/lib/**/*dart

# Change pubspec.yaml
pub-dartlang-dart $ cd app
pub-dartlang-dart/app $ vim pubspec.yaml
+
+dependency_override:
+  markdown:
+    path: ../pkgs/markdown
pub-dartlang-dart/app $ pub get

# Change Dockerfile to include it into the docker context.
pub-dartlang-dart $ vim Dockerfile
 ADD app/pubspec.* /project/app/
+ADD pkgs project/pkgs
 RUN pub get
```
