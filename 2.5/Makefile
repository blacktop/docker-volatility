NAME=volatility
VERSION=$(shell cat VERSION)
DEV_RUN_OPTS ?= -h

NEWSIZE = $(shell docker images --format "{{.Size}}" blacktop/$(NAME):$(VERSION))

dev:
	docker build -f Dockerfile -t $(NAME):dev .
	docker run --rm $(NAME):dev $(DEV_RUN_OPTS)

tags:
	docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" blacktop/$(NAME)

build:
	docker build -t blacktop/$(NAME):$(VERSION) .

size:
ifeq "$(VERSION)" "latest"
	sed -i.bu 's/docker image-.*-blue/docker image-$(NEWSIZE)-blue/' ../README.md
endif
	sed -i.bu '/$(VERSION)/ s/[0-9.]\{3,5\} MB/$(NEWSIZE)/' ../README.md

release:
	rm -rf release && mkdir release
	go get github.com/progrium/gh-release/...
	cp build/* release
	gh-release create blacktop/$(NAME) $(VERSION) \
		$(shell git rev-parse --abbrev-ref HEAD) $(VERSION)
	# glu hubtag maliceio/malice-$(NAME) $(VERSION)

circleci:
	rm -f ~/.gitconfig
	go get -u github.com/gliderlabs/glu
	glu circleci

.PHONY: build size tags release circleci
