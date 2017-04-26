-include env_make

VERSION ?= 1-1.0

REPO = frontid/docker-front-dev
NAME = docker-front-dev-1.0

.PHONY: build test push shell run start stop logs clean release

build:
	docker build -t $(REPO):$(VERSION) ./

test:
	IMAGE=$(REPO):$(VERSION) ./test.sh

push:
	docker push $(REPO):$(VERSION)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION) /bin/sh

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build
	make push -e VERSION=$(VERSION)

default: build

