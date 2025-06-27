APP := kbot
VERSION := $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
REGISTRY := ghcr.io/tooggi
TARGETOS ?= linux
TARGETARCH ?= amd64

.PHONY: format get build linux_amd64 linux_arm64 darwin_amd64 darwin_arm64 windows_amd64 windows_arm64 image push clean

format:
	gofmt -s -w ./

get:
	@go get

test:
	@echo "Running tests..."
	@go test -v -cover ./...

build: format get
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o kbot -ldflags "-X=github.com/tooggi/kbot/cmd.appVersion=$(VERSION) -s -w"

linux_amd64: format get
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o kbot -ldflags "-X=github.com/tooggi/kbot/cmd.appVersion=$(VERSION) -s -w"

linux_arm64: format get
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -v -o kbot -ldflags "-X=github.com/tooggi/kbot/cmd.appVersion=$(VERSION) -s -w"

darwin_amd64: format get
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o kbot -ldflags "-X=github.com/tooggi/kbot/cmd.appVersion=$(VERSION) -s -w"

darwin_arm64: format get
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -v -o kbot -ldflags "-X=github.com/tooggi/kbot/cmd.appVersion=$(VERSION) -s -w"

windows_amd64: format get
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o kbot.exe -ldflags "-X=github.com/tooggi/kbot/cmd.appVersion=$(VERSION) -s -w"

windows_arm64: format get
	CGO_ENABLED=0 GOOS=windows GOARCH=arm64 go build -v -o kbot.exe -ldflags "-X=github.com/tooggi/kbot/cmd.appVersion=$(VERSION) -s -w"

image:
	docker build -t $(REGISTRY)/$(APP):$(VERSION)-$(TARGETOS)-$(TARGETARCH) --build-arg TARGETOS=$(TARGETOS) --build-arg TARGETARCH=$(TARGETARCH) --build-arg VERSION=$(VERSION) .

push:
	docker push $(REGISTRY)/$(APP):$(VERSION)-$(TARGETOS)-$(TARGETARCH)

clean:
	rm -f kbot kbot.exe
	docker rmi $(REGISTRY)/$(APP):$(VERSION)-$(TARGETOS)-$(TARGETARCH) || true
