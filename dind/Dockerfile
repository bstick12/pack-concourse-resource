FROM bstick12/ubuntu-docker

RUN set -eu; \
	curl -o /usr/local/bin/dind "https://raw.githubusercontent.com/moby/moby/master/hack/dind" && \
	chmod +x /usr/local/bin/dind && \
        sed -ri 's/if ! mountpoint -q \/tmp/if [ ! -d \/tmp ]/g' /usr/local/bin/dind

RUN set -eu; \
  curl -o /usr/local/bin/dockerd-entrypoint.sh "https://raw.githubusercontent.com/docker-library/docker/master/18.09/dind/dockerd-entrypoint.sh"; \
	chmod +x /usr/local/bin/dockerd-entrypoint.sh

VOLUME /var/lib/docker

ENTRYPOINT ["dockerd-entrypoint.sh"]

CMD []




