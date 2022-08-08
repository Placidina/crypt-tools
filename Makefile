TARGET ?= local

export DOCKER_BUILDKIT = 1

.PHONY: lint
lint:
	docker run --pull always --rm -v $(shell pwd):/crypt-tools -w /crypt-tools -v $(shell go env GOCACHE):/cache/go -e GOCACHE=/cache/go -e GOLANGCI_LINT_CACHE=/cache/go -v $(shell go env GOPATH)/pkg:/go/pkg golangci/golangci-lint:latest golangci-lint --color always run

.PHONY: test
test:
	go test ./...

.PHONY: build
build:
ifeq (${TARGET},local)
	CGO_ENABLED=0 GOFLAGS="-gcflags=-trimpath=${GOPATH} -asmflags=-trimpath=${GOPATH}" GOOS=linux go build -trimpath -ldflags "-s -w" -o build/output/bcrypt github.com/Placidina/crypt-tools/cmd/bcrypt
endif

.PHONY: clean
clean:
	-rm -r dist
	-rm -r build/output

.PHONY: deps
deps:
	@go mod tidy && go mod verify && go mod download

.PHONY: clean-cache
clean-cache:
	@go clean -modcache

.PHONY: changelog
changelog:
	github_changelog_generator -u Placidina -p crypt-tools