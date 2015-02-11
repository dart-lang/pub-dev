FROM google/dart-runtime-base

WORKDIR /project/app

ADD app.yaml /project/
ADD app/pubspec.* /project/app/
ADD pkg/mustache/pubspec.* /project/pkg/mustache/
ADD pkg/pub_server/pubspec.* /project/pkg/pub_server/
ADD key.json /project/key.json

RUN pub get

ADD pkg /project/pkg
ADD app /project/app

RUN pub get --offline

ENV DART_VM_OPTIONS --enable-async
