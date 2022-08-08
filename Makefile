.PHONY: lint
lint:
	golangci-lint --color always run

.PHONY: test
test:
	go test ./...

.PHONY: build
build:
	CGO_ENABLED=0 GOFLAGS="-gcflags=-trimpath=${GOPATH} -asmflags=-trimpath=${GOPATH}" GOOS=linux go build -trimpath -ldflags "-s -w" -o build/bcrypt github.com/Placidina/crypt-tools/cmd/bcrypt

.PHONY: clean
clean:
	-rm -r build

.PHONY: deps
deps:
	@go mod tidy && go mod verify && go mod download

.PHONY: clean-cache
clean-cache:
	@go clean -modcache