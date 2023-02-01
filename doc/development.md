# Developing `pub.dev`

`pub.dev` runs on Google AppEngine, but we also support a local,
in-memory server that is able to run 95-99% of the site on a single
machine, without any need for AppEngine account or setup.

- If you want to contribute to `pub.dev`, the current document will give you
instructions how to work with the local, in-memory server (`fake_server`).

- If you want to setup the project on Google AppEngine, follow [this guide](appengine.md). 

- Development and runtime support is best on Linux, compatible system may work,
  Windows isn't supported yet (e.g. bash scripts are not compatible).

## Project structure

The main directories that one would be looking at:

- `app/`: contains the main server application.
- `pkg/web_app`: contains the client-side part of the app.
- `pkg/web_css`: contains the SCSS files.
- `static`: contains static files and images deployed alongside the app.
- `third_party`: contains 3rd-party assets that are deployed alongside the app.

## Initial data

The in-memory server starts with no data. Prepopulated data can be created
with test-profiles, using the following steps:

### Create a test-profile description 

A test-profile is a short description of packages, publishers, users,
their flags and relations.

To create an initialize it with some minimal data, create the following YAML file:

```yaml
defaultUser: 'your-email@example.com'
packages:
  - name: retry
  - name: http
```

### Process and create data file

Using the test-profile above, the following process will:
- fetch the latest versions and the archive file from pub.dev
- publish the archive locally under the name of the user or
  the publisher in the test-profile description
- analyze the packages and runs dartdoc on them
- stores the results and all the entities in a local file.

```shell script
cd app/
dart bin/fake_server.dart init-data-file \
  --test-profile=[the file you have created] \
  --analysis=[ none | fake | real ] \
  --data-file=dev-data-file.jsonl
```

`fake` analysis will use a deterministic, but random-looking
process to create analysis results quickly, while `real`
analysis will run `pana` and `dartdoc` the same way as the
production server would run them.

### Using the fake server with the data file

After the data file has been created, you can start using it locally:

```shell script
cd app/
dart bin/fake_server.dart run --data-file=dev-data-file.jsonl
```

## Local accounts

The web app and the API endpoints use a simple mechanism to map access tokens
to authenticated accounts: `user-at-domain-dot-com` gets mapped to `user@domain.com`. 

- On the web app one can use this token by clicking on the `Sign in` top nav item.
- On the API endpoints one should send the `Authorization` header with `Bearer $token` as value.

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

```bash
dart pub global activate mono_repo
```

> Note: Run `pub global list` to make sure the version is at least `2.0.0`.

`mono_repo` has two kinds of configuration files:
- `mono_repo.yaml` (in the root directory)
- `mono_pkg.yaml` (in each package directory)

### Update/upgrade dependencies

```bash
dart pub global run mono_repo pub get
```

### Update/upgrade SDK in all mono_pkg.yaml

```bash
dart tool/update_mono_pkg_yaml.dart
dart pub global run mono_repo generate
```

### Creating a new package (or vendoring existing packages)

1. Create `mono_pkg.yaml` for the package. (Use the existing ones as template.)

2. Run `dart pub global run mono_repo generate` from the root.
