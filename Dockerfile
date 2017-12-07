FROM us.gcr.io/dartlang-pub/pub_site_base:latest

ADD pkg /project/pkg

WORKDIR /project/app

ADD static /project/static
ADD app/pubspec.* /project/app/
RUN pub get --no-precompile
ADD app /project/app
RUN pub get --offline --no-precompile

## NOTE: Uncomment the following lines for local testing:
#ADD key.json /project/key.json
#ENV GCLOUD_KEY /project/key.json
#ENV GCLOUD_PROJECT dartlang-pub

# Clear out any arguments the base images might have set and ensure we start
# memcached and wait for it to come up before running the Dart app.
CMD []
ENTRYPOINT /bin/bash /dart_runtime/dart_run.sh
