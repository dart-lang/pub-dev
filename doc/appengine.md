# AppEngine setup

`pub.dev` runs on Google AppEngine, and the current document describes
the setup  steps required for deploying and running it in a custom project.
(Some sections are incomplete, contributions are welcome!)

## Access and IAM

TODO: required services and access rights
TODO: service accounts

## Storage buckets

TODO: list of buckets to create
TODO: make sure that the app is able to operate without non-critical buckets

## Datastore maintenance

TODO: describe index review and deployment
TODO: describe backup and restore (which entities may be dropped)

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
