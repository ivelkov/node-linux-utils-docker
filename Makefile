NAME = teams-for-linux-build
VERSION = latest
REGISTRY = docker.io/ivelinvelkov

.PHONY: all build tag_latest run check-env release

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

release: check-env tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker tag $(NAME):$(VERSION) $(REGISTRY)/$(NAME):$(VERSION) &&\
	docker push $(REGISTRY)/$(NAME):$(VERSION)