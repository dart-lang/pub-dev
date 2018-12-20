## Deploying a new version to production

### Prerequisites

To run `pub-dartlang-dart` in production both a redis server and an SMTP server
is required. These can be configured with `app/bin/tools/set_secret.dart` see
`doc/secrets.md` for details.

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
- First, deploy the new version of the `analyzer` service, and wait until it is done with its first round.
  Wait roughly 1-2 days at the moment, the `/debug` url should give a good estimate, for how long.
- Then deploy the `search` service and the `app` frontend.

While the new `analyzer` is running, the old `frontend` will request and work with old `Analysis` objects,
and by the time we deploy the new version, the new `Analysis` instances will be ready.


## Debugging in production

To trace what is happening during a request, use the following tool:

````
tool/trace_curl.sh https://pub.dartlang.org/
````
