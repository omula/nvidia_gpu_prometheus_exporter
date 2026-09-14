PKG=github.com/plazonic/nvidia_gpu_prometheus_exporter
REGISTRY=plazonic
IMAGE=nvidia_gpu_prometheus_exporter
TAG=0.2

# Stamp the build so a running exporter can be traced back to a commit.
# Defaults to the tag/commit description of the working tree.
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo unknown)
LDFLAGS = -X main.version=$(VERSION)

.PHONY: build
build:
	go build -ldflags "$(LDFLAGS)" -o nvml_exporter .

.PHONY: container
container:
	docker build --pull -t ${REGISTRY}/${IMAGE}:${TAG} .

.PHONY: push
push:
	docker push ${REGISTRY}/${IMAGE}:${TAG}
