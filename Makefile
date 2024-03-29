COMMIT_HASH := $(shell git rev-parse --short $$(git rev-list -1 HEAD))

.PHONY: teapot
teapot:
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o teapot .
	docker build -t teapot-server:$(COMMIT_HASH) \
	    -t docker.pkg.github.com/martinsirbe/go-teapot-server/go-teapot-server:$(COMMIT_HASH) \
	    -t martinsirbe/go-teapot-server:$(COMMIT_HASH) -f Dockerfile .

.PHONY: start
start: teapot
	docker run -d -p8080:8080 teapot-server:$(COMMIT_HASH)
