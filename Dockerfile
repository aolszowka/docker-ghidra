FROM lsiobase/rdesktop-web:alpine

# set version label
ARG BUILD_DATE
ARG VERSION
ARG GHIDRA_RELEASE="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.1.2_build/ghidra_10.1.2_PUBLIC_20220125.zip"
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aolszowka"

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    curl unzip && \
  apk add --no-cache \
    openjdk11 gcompat && \
   echo "**** install ghidra from ${GHIDRA_RELEASE}****" && \
   curl -sL ${GHIDRA_RELEASE} --output /tmp/ghidra.zip && \
   unzip /tmp/ghidra.zip -d /usr/bin && \
   mv /usr/bin/ghidra_10.1.2_PUBLIC /usr/bin/ghidra && \
   echo "**** cleanup ****" && \
   rm -rf /tmp/* && \
   apk del --purge \
     build-dependencies


# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
VOLUME /data
