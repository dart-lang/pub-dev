FROM gcr.io/google-containers/debian-base-amd64:v2.0.0

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y unzip ca-certificates curl bash && \
  rm -rf /var/lib/apt/lists/*

ENV PUB_ENVIRONMENT="bot.pub_dev.pub_worker"
ENV CI="true"

# Install pub_worker
COPY . /opt/pub_worker
WORKDIR /opt/pub_worker

# Setup Dart SDK
RUN tool/setup-dart.sh /opt/dart-sdk 2.16.2

# Setup Flutter SDK
RUN tool/setup-flutter.sh /opt/flutter 2.10.5

# Use stable Dart-SDK in path
ENV PATH="/opt/dart-sdk/bin:${PATH}"

# Configure SDKs to be used for analysis
ENV DART_ANALYSIS_SDK="/opt/dart-sdk"
ENV FLUTTER_ANALYSIS_SDK="/opt/flutter"

# Install dependencies for pub_worker
RUN dart pub get

# This container image is launched by cloud-init, and clpud-init is responsible
# for shutting down the VM when the container exits.
ENTRYPOINT dart bin/pub_worker.dart
