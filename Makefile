# sync with https://github.com/fphammerle/docker-onion-service/blob/master/Makefile

DOCKER_IMAGE_NAME := docker.io/fphammerle/postsrsd
DOCKER_TAG_VERSION := $(shell git describe --match=0.* --abbrev=0 --dirty | sed -e 's/^v//')
POSTSRSD_PACKAGE_VERSION := $(shell grep -Po 'POSTSRSD_PACKAGE_VERSION=\K.+' Dockerfile | tr -d -)
ARCH := $(shell arch)
DOCKER_TAG_ARCH_SUFFIX_aarch64 := arm64
DOCKER_TAG_ARCH_SUFFIX_armv6l := armv6
DOCKER_TAG_ARCH_SUFFIX_x86_64 := amd64
DOCKER_TAG_ARCH_SUFFIX = ${DOCKER_TAG_ARCH_SUFFIX_${ARCH}}
DOCKER_TAG = ${DOCKER_TAG_VERSION}-postsrsd${POSTSRSD_PACKAGE_VERSION}-${DOCKER_TAG_ARCH_SUFFIX}

.PHONY: docker-build docker-push

docker-build:
	git diff --exit-code
	git diff --staged --exit-code
	sudo docker build -t "${DOCKER_IMAGE_NAME}:${DOCKER_TAG}" .

docker-push: docker-build
	sudo docker push "${DOCKER_IMAGE_NAME}:${DOCKER_TAG}"
	sleep 4 # wait for repo digest
	@echo git tag --sign --message '$(shell sudo docker image inspect --format '{{join .RepoDigests "\n"}}' "${DOCKER_IMAGE_NAME}:${DOCKER_TAG}")' docker/${DOCKER_TAG} $(shell git rev-parse HEAD)
