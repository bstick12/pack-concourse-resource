FROM bstick12/ubuntu-dind

ARG pack_version

RUN apt-get install wget jq -y
RUN wget -c https://github.com/buildpack/pack/releases/download/v$pack_version/pack-$pack_version-linux.tar.gz -O - | tar -zx -C /usr/local/bin

COPY check /opt/resource/check
COPY in /opt/resource/in
COPY out /opt/resource/out
COPY common.sh /opt/resource/common.sh

RUN chmod +x /opt/resource/check /opt/resource/in /opt/resource/out

WORKDIR /opt/resource
