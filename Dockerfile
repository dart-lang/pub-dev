FROM google/dart-runtime-base:1.25.0-dev.9.0

# Let the pub server know that this is not a "typical" pub client but rather a bot.
ENV PUB_ENVIRONMENT="bot.pub_dartlang_org.docker"

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
ENTRYPOINT /bin/bash /dart_runtime/dart_run.sh
