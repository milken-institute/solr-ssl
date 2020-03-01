-include env_make

SOLR_VER ?= 8.4.1
SOLR_MINOR_VER=$(shell echo "${SOLR_VER}" | grep -oE '^[0-9]+\.[0-9]+')

TAG ?= $(SOLR_MINOR_VER)

REPO = wodby/solr
# NAME = solr-$(SOLR_VER)

NAME = solr

NETWORK = --network=solr-proxy_solr-network

PORTS = -p 8983:8983/tcp

CMD = 

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg SOLR_VER=$(SOLR_VER) ./

test:
	cd ./tests && IMAGE=$(REPO):$(TAG) NAME=$(NAME) ./run.sh

push:
	docker push $(REPO):$(TAG)

shell:
	docker exec -it $(NAME) sh

root-shell:
	docker exec -it --user=root $(NAME) sh

run:
	docker run --rm --name $(NAME) -e DEBUG=1 $(NETWORK) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(NETWORK) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	docker rm -f $(NAME); 

prune: 
	docker rm -f $(NAME); docker container prune -f; docker system prune --all -f;

release: build push
