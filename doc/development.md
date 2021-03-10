# Developing `pub.dev`

## Local Development without external services

The `app/` project is able to run `pub-dev` with a local,
in-memory Datastore and Storage service (being implemented in `pkg/fake_gcloud`).

To initialize it with some minimal data, create the following file:

```
defaultUser: 'your-email@example.com'
packages:
  - name: retry
  - name: http
```

Import the latest versions and their dependencies into a data file:

```shell script
cd app/
dart bin/fake_server.dart init-data-file \
  --test-profile=[the file you have created] \
  --analyze \
  --data-file=dev-data-file.jsonl
```

After the data file has been created, you can start using it locally:

```shell script
cd app/
dart bin/fake_server.dart run --data-file=dev-data-file.jsonl
```

## Updating generated code
The application and various packages uses
[builders](https://pub.dev/packages/build) to generate code based on source
annotations. Input files are usually listed in `build.yaml`, and generated
files usually suffixed `.g.dart`. To generate code use:

```bash
dart pub run build_runner build
```

## Working with `mono_repo`

The app uses [`mono_repo`](https://pub.dev/packages/mono_repo) to organize
multiple packages inside the repository.

### Setup / activate `mono_repo`

To use `mono_repo`, first activate it:

````bash
dart pub global activate mono_repo
````

> Note: Run `pub global list` to make sure the version is at least `2.0.0`.

`mono_repo` has two kinds of configuration files:
- `mono_repo.yaml` (in the root directory)
- `mono_pkg.yaml` (in each package directory)

### Update/upgrade dependencies

````bash
dart pub global run mono_repo pub get
````

### Creating a new package (or vendoring existing packages)

1. Create `mono_pkg.yaml` for the package. (Use the existing ones as template.)

2. Run `dart pub global run mono_repo generate` from the root.


## Local Development with Google AppEngine

To run the default application (web frontend) locally, do the following steps:
```
cd app
dart pub get
export GCLOUD_PROJECT=<gcloud-project>
export GCLOUD_KEY=<path-to-service-account-key.json>
dart bin/server.dart default
```

The server will be available via at [localhost:8080](http://localhost:8080)

The `GCLOUD_KEY` must be an exported service account key for the cloud project.
This can be created in [console.cloud.google.com](https://console.cloud.google.com/)
under `IAM and Admin > Service Accounts > Create Service Account` (export in JSON format).

The key must have access to:
 * Cloud Data Store
 * Google Cloud Storage

(and these must be enabled on the service)

If starting from a new cloud project, APIs for Cloud Data Store will have to be
activated and it might be necessary to define indexes with
`gcloud app deploy index.yaml`.
