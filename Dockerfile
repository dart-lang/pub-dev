FROM google/dart-runtime-base:1.10.0

WORKDIR /project/app

ADD app.yaml /project/
ADD app/pubspec.* /project/app/
ADD pkg/markdown/pubspec.* /project/pkg/markdown/
ADD pkg/appengine/pubspec.* /project/pkg/appengine/

ADD key.json /project/key.json

RUN pub get

ADD app /project/app
ADD pkg /project/pkg

RUN pub get --offline
