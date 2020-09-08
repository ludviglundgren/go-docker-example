GHCR_REPO=ghcr.io/ludviglundgren/go-docker-example
GHCR_COMMIT_TAG=$(GHCR_REPO):commit-$(SHA)
VALID_TAG=$(shell echo $(TAG_NAME) | sed 's/[^a-z0-9_\.-]/-/g')

build:
	go build -o bin/server cmd/main.go

docker/login:
	echo $(CR_TOKEN)
	echo $(secrets.CR_TOKEN)
	echo $(secrets.CR_TOKEN) | docker login ghcr.io -u ludviglundgren --password-stdin

docker/build:
	docker build -f Dockerfile -t $(GHCR_REPO) .

docker/build/dev:
	docker build -f Dockerfile -t $(GHCR_REPO):dev .

docker/tag:
	docker tag $(GHCR_COMMIT_TAG) $(GHCR_REPO):$(VALID_TAG)

docker/push:
	docker push $(GHCR_REPO)
