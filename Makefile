PHP_VERSION?=7.4
PHP_EXT_DIR=${PHP_VERSION}/bullseye
DOCKER_IMAGE=etriasnl/php-extensions
DOCKER_PT_TAG=etriasnl/percona-toolkit:$(shell cat percona-toolkit/Dockerfile | grep 'ENV PERCONA_TOOLKIT_VERSION' | cut -f3 -d' ')
DOCKER_PROGRESS?=auto
MAKEFLAGS += --warn-undefined-variables --always-make
.DEFAULT_GOAL := _

exec_docker=docker run -it --rm -v "$(shell pwd):/app" -w /app

${PHP_EXT_DIR}/%/.releaser: PATCH_VERSION=$$(($(shell curl -sS "https://hub.docker.com/v2/repositories/${DOCKER_IMAGE}/tags/?page_size=1&page=1&name=${PHP_VERSION}-bullseye-$(shell basename "${@D}")-&ordering=last_updated" | jq -r '.results[0].name' | cut -f4 -d '-') + 1))
${PHP_EXT_DIR}/%/.releaser: VERSION=$(subst /,-,${@D})-${PATCH_VERSION}
${PHP_EXT_DIR}/%/.releaser: DOCKER_TAG=${DOCKER_IMAGE}:${VERSION}
${PHP_EXT_DIR}/%/.releaser:
	${exec_docker} hadolint/hadolint hadolint --ignore DL3059 "${@D}/Dockerfile"
	cp install.sh.dist "${@D}/install.sh"
	docker buildx build --progress "${DOCKER_PROGRESS}" -t "${DOCKER_TAG}" --load "${@D}"
	rm "${@D}/install.sh"

${PHP_EXT_DIR}/%/.releaser: PATCH_VERSION=$$(($(shell curl -sS "https://hub.docker.com/v2/repositories/${DOCKER_IMAGE}/tags/?page_size=1&page=1&name=${PHP_VERSION}-bullseye-$(shell basename "${@D}")-&ordering=last_updated" | jq -r '.results[0].name' | cut -f4 -d '-') + 1))
${PHP_EXT_DIR}/%/.releaser: VERSION=$(subst /,-,${@D})-${PATCH_VERSION}
${PHP_EXT_DIR}/%/.releaser: DOCKER_TAG=${DOCKER_IMAGE}:${VERSION}
${PHP_EXT_DIR}/%/.publisher: ${PHP_EXT_DIR}/%/.releaser
	docker push "${DOCKER_TAG}"
	git tag "${VERSION}"
	git push --tags

release: ${PHP_EXT_DIR}/${ext}/.releaser
release-all: $(shell find "${PHP_EXT_DIR}" -name Dockerfile | sed 's/Dockerfile/.releaser/')
publish: ${PHP_EXT_DIR}/${ext}/.publisher
publish-all: $(shell find "${PHP_EXT_DIR}" -name Dockerfile | sed 's/Dockerfile/.publisher/')

pt-release:
	${exec_docker} hadolint/hadolint hadolint --ignore DL3059 percona-toolkit/Dockerfile
	docker buildx build --progress "${DOCKER_PROGRESS}" -t "${DOCKER_PT_TAG}" --load percona-toolkit
pt-publish:
	docker push "${DOCKER_PT_TAG}"
	git tag "${DOCKER_PT_TAG}"
	git push --tags
