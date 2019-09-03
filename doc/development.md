## Updating generated code

The app uses `json_serializable` to generate `toJson` and `fromJson` for several
classes. The associated files all have an associated `.g.dart` file. If you
change any of the associated classes, you can regenerate the code by running
`pub run build_runner build` from the given package's directory.

## Working with `mono_repo`

The app uses [`mono_repo`](https://pub.dartlang.org/packages/mono_repo) to organize
multiple packages inside the repository.

### Setup / activate `mono_repo`

To use `mono_repo`, first activate it:

````bash
pub global activate mono_repo
````

> Note: Run `pub global list` to make sure the version is at least `2.0.0`.

`mono_repo` has two kinds of configuration files:
- `mono_repo.yaml` (in the root directory)
- `mono_pkg.yaml` (in each package directory)

### Update/upgrade dependencies

````bash
pub global run mono_repo pub get
````

### Creating a new package (or vendoring existing packages)

1. Create `mono_pkg.yaml` for the package. (Use the existing ones as template.)

2. Run `pub global run mono_repo travis` from the root.

3. Revert change in `tool/travis.sh`: always use `pub get` instead of `pub upgrade`.


## Local Development

### Compile script.dart to script.dart.js

```
dart2js --dump-info --minify --trust-primitives --trust-type-annotations static/js/script.dart -o static/js/script.dart.js
```

### Running the entire server locally

Generally speaking it is very easy to run the entire application locally
(though be careful: it uses **production data** by default)!

**Switch to using dev/staging data (optional)**

To use a different Google Cloud Project, the `app/lib/shared/configuration.dart` file needs
to be modified. For that, change the `fromEnv` method to create a `_local` configuration
with the name of the new Google Cloud project you will need to create:

```diff
  factory Configuration.fromEnv(EnvConfig env) {
+    return new Configuration._local(<gcloud-project>);
-    if (env.gcloudProject == 'dartlang-pub-dev')) {
-      return new Configuration._dev();
-    } else {
-      return new Configuration._prod();
-    }
  }
```

This can be done in two ways, running with or without Docker. Running with Docker will
be closer to the way the app runs on production (e.g. including using a memcache) -- though
the turnaround time is a bit longer.

For both variants, it is necessary to obtain a service account key for the Cloud Project.
Such a key can be obtained via the [Developers Console](https://console.cloud.google.com/)
under `IAM and Admin > Service Accounts > Create Service Account` using the `JSON` (not the `P12`)
key variant.

You will also need to enable Datastore support for your new project using the following link:

```
  https://console.cloud.google.com/datastore/setup?project=<gcloud-project>
```

#### Variant a) Running locally without Docker

To run the `frontend` (default) application locally, follow these steps:
```
pub-dartlang-dart $ cd app
pub-dartlang-dart/app $ pub get
pub-dartlang-dart/app $ export GCLOUD_PROJECT=<gcloud-project>
pub-dartlang-dart/app $ export GCLOUD_KEY=<path-to-service-account-key.json>
pub-dartlang-dart/app $ dart bin/server.dart default
```

The server will be available via at [localhost:8080](http://localhost:8080)

To run the `analyzer` service locally:

```
pub-dartlang-dart/app $ dart bin/server.dart analyzer
```

#### Variant b) Running locally With Docker

To run the application locally with Docker follow these steps (please note you need to have the
service account key inside the checkout (preferably at `key.json`), because only files inside
the checkout can go into the docker context):
```
pub-dartlang-dart $ vim Dockerfile

# NOTE: Uncomment the following lines for local testing:
ADD key.json /project/key.json
ENV GCLOUD_KEY /project/key.json
ENV GCLOUD_PROJECT <gcloud-project>

pub-dartlang-dart $ docker build .
<docker-imgage-hash>
pub-dartlang-dart $ docker run -it <docker-imgage-hash>
```

The server will be available via at [172.17.0.2:8080](http://172.17.0.2:8080/). The IP address might differ
and can be obtained via `docker ps` and `docker inspect <container-id>`.

In addition to the app, you can also run a local memcache instance with docker:

```
docker run -ti -p 11211:11211 memcached -vv
```

### Running unit tests

The unittests for the site can be run (tested on linux) via:

```
pub-dartlang-dart $ cd app
pub-dartlang-dart/app $ pub get
pub-dartlang-dart/app $ pub run test
00:17 +63: All tests passed!
```

### Ensuring small `pngs`

PNGs are compressed using Zopfli - https://github.com/google/zopfli

There is a homebrew formula for Mac:
https://github.com/Homebrew/homebrew-core/blob/master/Formula/zopfli.rb

A simple wrapper is a convenient way to use it:

```sh
#!/usr/bin/env sh
# png-press.sh

tmpfile=$(mktemp)
zopflipng -m -y $1 $tmpfile
mv $tmpfile $1
```

To shard across multiple CPUs:

```
find . -iname '*png*' | xargs -n 1 -P 8 png-press.sh'
```

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
