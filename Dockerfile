FROM concourse/golang-builder as builder
COPY ./registry-image-resource /src
WORKDIR /src
ENV CGO_ENABLED 0
RUN go get -d ./...
RUN go build -o /assets/in ./cmd/in
RUN go build -o /assets/check ./cmd/check
RUN set -e; for pkg in $(go list ./...); do \
		go test -o "/tests/$(basename $pkg).test" -c $pkg; \
	done

FROM bstick12/ubuntu-dind

ARG pack_version

RUN apt-get install wget jq -y
RUN wget -c https://github.com/buildpack/pack/releases/download/v$pack_version/pack-$pack_version-linux.tar.gz -O - | tar -zx -C /usr/local/bin

COPY --from=builder /assets/ /opt/resource
COPY out /opt/resource/out
COPY common.sh /opt/resource/common.sh

RUN chmod +x /opt/resource/check /opt/resource/in /opt/resource/out

WORKDIR /opt/resource
