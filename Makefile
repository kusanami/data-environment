.PHONY: test clean

all: build
	docker-compose up -d

build:
	make build -C hadoop
	make build -C presto
	make build -C consumer
	docker-compose build

run:
	docker-compose up -d
	@echo "Startup completed, go to http://localhost:9080"

presto-cli:
	presto/presto-cli.jar --server http://localhost:9080
