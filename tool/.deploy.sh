#!/bin/bash

# This script is used by .deploy.yaml

# Always exit on error
set -e

# Echos The message and sends it to team chat
message() {
  echo "$1"
  if [ "$PROJECT_ID" = 'dartlang-pub' ]; then
    CHAT_KEY=$(gcloud --project=dartlang-pub secrets versions access latest --secret=google-chat-pub-dev-hackers-key)
    CHAT_TOKEN=$(gcloud --project=dartlang-pub secrets versions access latest --secret=google-chat-pub-dev-hackers-token)
    CHAT_ID="AAAAkQUOtE8"
    THREAD_KEY="${TAG_NAME%-all}"
    curl -H 'Content-Type: application/json' -X POST "https://chat.googleapis.com/v1/spaces/$CHAT_ID/messages?key=$CHAT_KEY&token=$CHAT_TOKEN&threadKey=$THREAD_KEY" --data "{\"text\": \"$1\"}"
  fi
}

# Print an error message, if exiting non-zero
trap 'if [ $? -ne 0 ]; then message "Deployment failed!"; fi' EXIT

# This only works with PROJECT_ID defined
if [ -z "$PROJECT_ID" ]; then
  echo 'PROJECT_ID must be specified';
  exit 1;
fi

if [ "$PROJECT_ID" = 'dartlang-pub' ]; then
  # Use TAG_NAME as appengine version
  if [ -z "$TAG_NAME" ]; then
    echo 'TAG_NAME must be specified';
    exit 1;
  fi

  if [[ "$TAG_NAME" != *-all ]]; then
    echo 'This script is only intended for use on staging-<name> branches'
    exit 1;
  fi

  # Remove the -all suffix to create a version name.
  APP_VERSION="${TAG_NAME%-all}"
else
  # Use BRANCH_NAME as appengine version
  if [ -z "$BRANCH_NAME" ]; then
    echo 'BRANCH_NAME must be specified';
    exit 1;
  fi

  if [[ "$BRANCH_NAME" != staging-* ]]; then 
    echo 'This script is only intended for use on staging-<name> branches'
    exit 1;
  fi

  # Remove the staging- prefix to create a version name.
  APP_VERSION="${BRANCH_NAME#staging-}"

  # Setup number of instances to one
  # NOTICE: this modifies the current folder, which is a bit of a hack
  sed -i 's/_num_instances:[^\n]*/_num_instances: 1/' app.yaml search.yaml dartdoc.yaml analyzer.yaml
fi

# Disable interactive gcloud prompts
export CLOUDSDK_CORE_DISABLE_PROMPTS=1

echo "### Deploying index.yaml"
time -p gcloud --project "$PROJECT_ID" app deploy index.yaml

# This script will build images:
APP_IMAGE="gcr.io/$PROJECT_ID/pub-dev-$APP_VERSION-app"
WORKER_IMAGE="us-central1-docker.pkg.dev/dartlang-pub-tasks/$PROJECT_ID-worker-images/task-worker:$APP_VERSION"

echo "### Building docker image for appengine: $APP_IMAGE"
cp Dockerfile.app Dockerfile
time -p gcloud --project "$PROJECT_ID" builds submit --timeout=1500 --machine-type=e2-highcpu-8 -t "$APP_IMAGE"

echo "### Building docker image for pub_worker: $WORKER_IMAGE"
cp Dockerfile.worker Dockerfile
time -p gcloud --project "$PROJECT_ID" builds submit --timeout=1500 --machine-type=e2-highcpu-8 -t "$WORKER_IMAGE"

echo "### Start deploying search.yaml (version: $APP_VERSION)"
time -p gcloud --project "$PROJECT_ID" app deploy --no-promote -v "$APP_VERSION" --image-url "$APP_IMAGE" 'search.yaml' &
SEARCH_PID=$!

echo "### Start deploying dartdoc.yaml (version: $APP_VERSION)"
time -p gcloud --project "$PROJECT_ID" app deploy --no-promote -v "$APP_VERSION" --image-url "$APP_IMAGE" 'dartdoc.yaml' &
DARTDOC_PID=$!

echo "### Start deploying analyzer.yaml (version: $APP_VERSION)"
time -p gcloud --project "$PROJECT_ID" app deploy --no-promote -v "$APP_VERSION" --image-url "$APP_IMAGE" 'analyzer.yaml' &
ANALYZER_PID=$!

echo "### Start deploying app.yaml (version: $APP_VERSION)"
time -p gcloud --project "$PROJECT_ID" app deploy --no-promote -v "$APP_VERSION" --image-url "$APP_IMAGE" 'app.yaml'
echo "### app.yaml deployed"

wait $SEARCH_PID
echo "### search.yaml deployed"
wait $DARTDOC_PID
echo "### dartdoc.yaml deployed"
wait $ANALYZER_PID
echo "### analyzer.yaml deployed"

echo ''
echo '### Site updated, see:'
echo "https://$APP_VERSION-dot-$PROJECT_ID.appspot.com/"
echo ''
echo 'Traffic must be migrated manually.'

message 'Build complete'
