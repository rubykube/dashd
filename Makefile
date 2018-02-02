VERSION	?= $(shell cat VERSION)
NAME		?= dashd
IMAGE		?= rubykube/$(NAME):$(VERSION)

.PHONY: default build run push deploy

default: build run

build:
	@echo '> Building "$(NAME)" docker image...'
	@docker build -t $(IMAGE) .

run:
	@echo '> Starting "$(NAME)" container...'
	@docker run -p 9998:9998 \
							-p 19998:19998 \
							-d $(IMAGE)

push:
	docker push $(IMAGE)
