FROM lsiobase/rdesktop-web:focal

# set version label
ARG BUILD_DATE
ARG VERSION
ARG GHIDRA_RELEASE="http://192.168.1.45/ghidra_10.1.2_PUBLIC_20220125.zip"
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aolszowka"

ARG DEBIAN_FRONTEND=noninteractive

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get -qq install --no-cache
    curl unzip && \
    openjdk-11-jdk && \
  echo "**** install ghidra from ${GHIDRA_RELEASE}****" && \
  curl -sL ${GHIDRA_RELEASE} --output /tmp/ghidra.zip && \
  unzip /tmp/ghidra.zip -d /usr/bin && \
  mv /usr/bin/ghidra_10.1.2_PUBLIC /usr/bin/ghidra && \
  echo "**** cleanup ****" && \
  rm -rf /tmp/* && \
  apt-get -qq remove \
    curl unzip


# add local files
COPY /root /

# ports and volumes
EXPOSE 3389
VOLUME /config
VOLUME /data
