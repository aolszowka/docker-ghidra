FROM lsiobase/kasmvnc:ubuntujammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG GHIDRA_RELEASE="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.4_build/ghidra_10.4_PUBLIC_20230928.zip"
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aolszowka"

RUN \
  echo "**** install packages for pre-dependencies ****" && \
  apt update && \
  apt install -y \
    unzip wget apt-transport-https &&\
  echo "**** install adoptium jdk ***" && \
  mkdir -p /etc/apt/keyrings && \
  wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc && \
  echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
  apt update && \
  apt install -y temurin-17-jdk && \
    echo "**** install ghidra from ${GHIDRA_RELEASE}****" && \
    curl -sL ${GHIDRA_RELEASE} --output /tmp/ghidra.zip && \
    unzip /tmp/ghidra.zip -d /usr/bin && \
    mv /usr/bin/ghidra_10.4_PUBLIC /usr/bin/ghidra && \
    echo "**** cleanup ****" && \
    rm -rf /tmp/*


# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
VOLUME /data
