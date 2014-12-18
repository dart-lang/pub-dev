FROM google/dart-runtime-base

WORKDIR /project/app

ADD app.yaml /project/
ADD app/pubspec.* /project/app/
ADD pkg/pubserver/pubspec.* /project/pkg/pubserver/
ADD pkg/appengine/pubspec.* /project/pkg/appengine/
ADD pkg/gcloud/pubspec.* /project/pkg/gcloud/
ADD pkg/mustache/pubspec.* /project/pkg/mustache/
ADD key.json /project/key.json

RUN pub get

ADD pkg /project/pkg
ADD app /project/app

RUN pub get --offline

ENV DART_VM_OPTIONS --enable-async