IMAGE_REPO=docker.pkg.github.com/ludviglundgren/go-docker-example/go-docker

build:
	go build -o bin/server cmd/main.go

docker/login:
	cat $(GITHUB_TOKEN) | docker login docker.pkg.github.com -u ludviglundgren --password-stdin

docker/build:
	docker build -f Dockerfile -t $(IMAGE_REPO):latest .

docker/push:
	docker push $(IMAGE_REPO):latest
