DOCKER_COMPOSE := docker compose

OS := $(shell uname)

build:
	$(DOCKER_COMPOSE) build

up:
	$(DOCKER_COMPOSE) up

down:
	$(DOCKER_COMPOSE) down
	
clean:
	docker system prone -y 

