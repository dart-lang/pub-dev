#!/bin/bash

set -ex

base_name="us.gcr.io/dartlang-pub/pub_site_base"
tag=$(date -u +"%Y%m%dt%H%M%S")

date_tag="$base_name:$tag"

echo $date_tag

docker build --no-cache -t $date_tag .

latest_tag="$base_name:latest"
gcloud docker -- push $date_tag

docker tag $date_tag $latest_tag
gcloud docker -- push $latest_tag
