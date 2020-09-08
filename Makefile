IMAGE_REPO=ghcr.io/ludviglundgren/go-docker-example

build:
	go build -o bin/server cmd/main.go

docker/login:
	echo $(CR_TOKEN)
	echo $(secrets.CR_TOKEN)
	echo $(secrets.CR_TOKEN) | docker login ghcr.io -u ludviglundgren --password-stdin

docker/build:
	docker build -f Dockerfile -t $(IMAGE_REPO):latest .

docker/build/dev:
	docker build -f Dockerfile -t $(IMAGE_REPO):dev .

docker/push:
	docker push $(IMAGE_REPO):latest
