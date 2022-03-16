IMAGE:=sat-solver
TAG:=$(shell git rev-parse HEAD)

.PHONY: build
build:
	go build

.PHONY: docker-build
docker-build:
	docker build -t $(IMAGE):$(TAG) .

.PHONY: docker-run-test
docker-run-test: docker-unit-test docker-integration-test

.PHONY: docker-unit-test
docker-unit-test: docker-build
	docker run --rm $(IMAGE):$(TAG) go test

.PHONY: docker-integration-test
docker-integration-test: docker-build
	docker run --rm $(IMAGE):$(TAG) ./integration-test.sh
