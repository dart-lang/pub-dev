## Google Cloud Platform

High level interface for Google Cloud Platform APIs

### Running tests

If you want to run the end-to-end tests, a Google Cloud project is required.
When running these tests the following envrionment variables needs to be set:

    GCLOUD_E2E_TEST_PROJECT
    GCLOUD_E2E_TEST_KEY

The vaule of the environment variable `GCLOUD_E2E_TEST_PROJECT` is the name
of the Google Cloud project to use. The value of the environment variable
`GCLOUD_E2E_TEST_KEY` is a Google Cloud Storage path (starting wiht `gs://`)
to a JSON key file for a service account providing access to the Cloud Project. 
