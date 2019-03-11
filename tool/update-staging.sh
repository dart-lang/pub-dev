#!/bin/bash -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd ${SCRIPT_DIR}/.. && pwd )"

# Change to repo-root folder
cd "$PROJECT_DIR";

ALL_SERVICES='app.yaml search.yaml dartdoc.yaml analyzer.yaml'
SERVICES=${@:-$ALL_SERVICES}    

# This script will attempt to 
IMAGE="gcr.io/dartlang-pub-dev/$USER-staging"

for f in $SERVICES; do
  if [ $f == '--help' ] || [ $f == '-h' ] ; then
    echo 'usage: ./tool/update-staging.sh app.yaml search.yaml ...'
    echo ''
    echo 'This script will build /Dockerfile with gcloud build, and tag it:'
    echo "    $IMAGE"
    echo "Then create or overwrite the $USER version of the staging project."
    exit 0;
  fi
  if [ ! -f $f ]; then
    echo "No such file: $f"
    echo ''
    echo 'usage: ./tool/update-staging.sh app.yaml search.yaml ...'
    exit 1;
  fi
  if [ ${f: -5} != ".yaml" ] ; then
    echo "Expected an YAML file got: $f"
    echo ''
    echo 'usage: ./tool/update-staging.sh app.yaml search.yaml ...'
    exit 1;
  fi
done

echo "### Building docker image: $IMAGE"
time gcloud --project dartlang-pub-dev builds submit -t "$IMAGE"

for f in $SERVICES; do
  echo "### Deploying $f (version: $USER)"
  time gcloud --project dartlang-pub-dev app deploy --quiet -v "$USER" --image-url "$IMAGE" "$f"
  echo "### Deployed $f"
done

echo '### Staging site updated, see:'
echo "https://$USER-dot-dartlang-pub-dev.appspot.com/"
