VERSION=0.4.1

.PHONY: all docker dind docker-push dind-push pack-concourse-resource pack-concourse-resource-push

all: create push

create: docker dind pack-concourse-resource

push:	docker-push dind-push pack-concourse-resource-push

docker:
	docker build ./docker -t bstick12/ubuntu-docker

docker-push: docker
	docker push bstick12/ubuntu-docker

dind: docker
	docker build ./dind -t bstick12/ubuntu-dind

dind-push: dind
	docker push bstick12/ubuntu-dind

pack-concourse-resource: dind
	docker build . --build-arg pack_version=$(VERSION) -t bstick12/pack-concourse-resource

pack-concourse-resource-push: pack-concourse-resource
	docker push bstick12/pack-concourse-resource



