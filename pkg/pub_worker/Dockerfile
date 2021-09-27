FROM gcr.io/google-containers/debian-base-amd64:v2.0.0

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y unzip ca-certificates curl bash && \
  rm -rf /var/lib/apt/lists/*

# Install Dart-SDK
RUN cd /opt && \
  curl -sS https://storage.googleapis.com/dart-archive/channels/dev/raw/2.12.0-51.0.dev/sdk/dartsdk-linux-x64-release.zip > /opt/dartsdk.zip && \
  unzip -q /opt/dartsdk.zip && \
  rm -f /opt/dartsdk.zip
ENV PATH="/opt/dart-sdk/bin:${PATH}"

# Install pub_worker
COPY . /opt/pub_worker
WORKDIR /opt/pub_worker
ENV PUB_ENVIRONMENT="bot.pub_dev.docker"
ENV CI="true"
RUN pub get

ENTRYPOINT dart bin/pub_worker.dart
