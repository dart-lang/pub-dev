FROM google/dart-runtime-base:1.23.0

# We install memcached and remove the apt-index again to keep the
# docker image diff small.
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git memcached unzip && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/flutter/bin:${PATH}"
# To ensure actions from this container are not seen as "typical" users.
ENV PUB_ENVIRONMENT="bot.pub_dartlang_org.docker"

RUN git clone -b alpha https://github.com/flutter/flutter.git
# Downloads the Dart SDK and disables analytics tracking – which we always want
RUN flutter config --no-analytics

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
