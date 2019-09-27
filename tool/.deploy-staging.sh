#!/bin/bash -e

# This script is used by .deploy-staging.yaml
# Do NOT use this script for any other purposes.

# This only works on cloud-build
if [[ "$PROJECT_ID" != 'dartlang-pub-dev' ]]; then 
  echo 'This script is only intended for use on cloud-build, only for staging'
  exit 1;
fi

if [[ "$BRANCH_NAME" != 'staging' ]]; then 
  echo 'This script is only intended for use on staging branch (for now)'
  exit 1;
fi

# Disable interactive gcloud prompts
export CLOUDSDK_CORE_DISABLE_PROMPTS=1

# This script will build image:
IMAGE="gcr.io/dartlang-pub-dev/branch-$BRANCH_NAME-image"

echo "### Building docker image: $IMAGE"
time -p gcloud --project "$PROJECT_ID" builds submit -t "$IMAGE"

APP_VERSION="$BRANCH_NAME"

echo "### Start deploying search.yaml (version: $APP_VERSION)"
time -p gcloud --project 'dartlang-pub-dev' app deploy --no-promote -v "$APP_VERSION" --image-url "$IMAGE" 'search.yaml' &
SEARCH_PID=$!

echo "### Start deploying dartdoc.yaml (version: $APP_VERSION)"
time -p gcloud --project 'dartlang-pub-dev' app deploy --no-promote -v "$APP_VERSION" --image-url "$IMAGE" 'dartdoc.yaml' &
DARTDOC_PID=$!

echo "### Start deploying analyzer.yaml (version: $APP_VERSION)"
time -p gcloud --project 'dartlang-pub-dev' app deploy --no-promote -v "$APP_VERSION" --image-url "$IMAGE" 'analyzer.yaml' &
ANALYZER_PID=$!

echo "### Start deploying app.yaml (version: $APP_VERSION)"
time -p gcloud --project 'dartlang-pub-dev' app deploy --no-promote -v "$APP_VERSION" --image-url "$IMAGE" 'app.yaml'
echo "### app.yaml deployed"

wait $SEARCH_PID
echo "### search.yaml deployed"
wait $DARTDOC_PID
echo "### dartdoc.yaml deployed"
wait $ANALYZER_PID
echo "### analyzer.yaml deployed"

echo ''
echo '### Staging site updated, see:'
echo "https://$APP_VERSION-dot-dartlang-pub-dev.appspot.com/"
