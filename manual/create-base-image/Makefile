
REGISTRY=yann-swampup.dev.aws.devopsacc.team/demo-docker-release-local
IMAGE=nginx-myorg
VERSION=1.0.0
NEW_VERSION=1.0.1

init:
	docker build -t $(REGISTRY)/$(IMAGE):$(VERSION) -f Dockerfile-init .
	docker login $(REGISTRY)
	docker push $(REGISTRY)/$(IMAGE):$(VERSION)

fix:
	docker build --squash -t $(REGISTRY)/$(IMAGE):$(NEW_VERSION) -f Dockerfile-with-fix .
	docker login $(REGISTRY)
	docker push $(REGISTRY)/$(IMAGE):$(NEW_VERSION)

clean:
	docker rmi $(REGISTRY)/$(IMAGE):$(VERSION)
	docker rmi $(REGISTRY)/$(IMAGE):$(NEW_VERSION)