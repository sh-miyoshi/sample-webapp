imageName="sample-webapp"
version="0.1"

all: build run

build:
	docker build -t $(imageName):$(version) --build-arg http_proxy="$(http_proxy)" --build-arg https_proxy="$(https_proxy)" .

run:
	docker run -d --name $(imageName) -p 4567:4567 $(imageName):$(version)

bash:
	docker exec -it $(imageName) bash

rm:
	docker stop $(imageName)
	docker rm $(imageName)

restart:
	docker restart $(imageName)

log:
	docker logs $(imageName)
