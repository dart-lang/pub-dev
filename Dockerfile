FROM google/dart-runtime-base:1.9.3

WORKDIR /project/app

ADD app.yaml /project/
ADD app/pubspec.* /project/app/
ADD pkg/mustache/pubspec.* /project/pkg/mustache/
ADD key.json /project/key.json

RUN pub get

ADD pkg /project/pkg
ADD app /project/app

RUN pub get --offline
