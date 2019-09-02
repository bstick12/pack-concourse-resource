# Pack CLI Concourse Resource

A proof of concept concourse resource that builds OCI images using the [pack-cli](https://github.com/buildpack/pack)

Uses Docker in Docker so must be run a privileged.

It borrows heavily from the [docker-image-resource](https://github.com/concourse/docker-image-resource)

It utilizes the `in` and `check` behaviours from the [registry-image-resource](https://github.com/concourse/registry-image-resource)

Currently will only work with buildpacks that are build using `pack` > v0.0.9

## Source Configuration

* `repository`: Required. The name of the repository that you want to build e.g `bstick12/built-with-pack`
* `tag`: Optional. The tag value for the image. Defaults to `latest`
* `username`: Required. The username to authenticate with when pushing
* `password`: Required. The password to use when authenticating

### Behaviour
`check`: Discover new digests

See [registry-image-resource/check](https://github.com/concourse/registry-image-resource#check-discover-new-digests)

`in`: Fetch the image's rootfs and metadata

See [registry-image-resource/in](https://github.com/concourse/registry-image-resource#in-fetch-the-images-rootfs-and-metadata)

`out`: Build an OCI image using the `pack` CLI and push to a repository

#### Parameters
* `build`: Required. The source code to build in to the OCI image.
* `builder`: Optional. The builder to use to build the OCI image.

### Example

```
---
resources:
- name: git-resource
  type: git
  source: # ...

- name: pack-built-image
  type: pack-image-resource
  source:
    repository: ((image-name))
    email: ((docker-hub-email))
    username: ((docker-hub-username))
    password: ((docker-hub-password))

resource_types:
- name: pack-image-resource
  type: docker-image
  privileged: true
  source:
    repository: bstick12/pack-concourse-resource
    version: latest

jobs:
- name: build-source-using-pack-image-resource
  plan:
  - get: git-resource
    trigger: true
  - put: pack-built-image
    params:
      build: pack-built-image
      builder: ((pack-builder-image))
```






