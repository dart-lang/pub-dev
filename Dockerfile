FROM google/dart-runtime-base:1.24.0

# We install memcached and remove the apt-index again to keep the
# docker image diff small.
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y memcached && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /project/app

ADD static /project/static
ADD app/pubspec.* /project/app/
RUN pub get
ADD app /project/app
RUN pub get --offline

## NOTE: Uncomment the following lines for local testing:
#ADD key.json /project/key.json
#ENV GCLOUD_KEY /project/key.json
#ENV GCLOUD_PROJECT dartlang-pub

# Clear out any arguments the base images might have set and ensure we start
# memcached and wait for it to come up before running the Dart app.
CMD []
ENTRYPOINT service memcached start && sleep 1 && /bin/bash /dart_runtime/dart_run.sh
