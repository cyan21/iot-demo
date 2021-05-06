
REGISTRY=iotdemocloud.jfrogdev.org
REPO=demo-docker-release-local
IMAGE=turbine-safety
STATUS=red
VERSION=1.0.0
BASE_IMAGE_VERSION=1.0.0

prep:
	sed  s/STATUS/$(STATUS)/ templates/index.html.tpl > app/index.html
	sed  s/STATUS/$(STATUS)/ templates/turbine.json.tpl | sed s/IMAGE_VERSION/$(VERSION)/ > app/turbine.json
	sed  s/REGISTRY/$(REGISTRY)/ templates/Dockerfile.tpl | sed s/REPOSITORY/$(REPO)/ | sed s/VERSION/$(BASE_IMAGE_VERSION)/ > Dockerfile
	cat Dockerfile
	
build:
	sed '' -i s/REGISTRY/$(REGISTRY)/ Dockerfile
	sed '' -i s/REPOSITORY/$(REPO)/ Dockerfile
	sed '' -i s/VERSION/$(BASE_IMAGE_VERSION)/ Dockerfile
	docker build -t $(REGISTRY)/$(REPO)/$(IMAGE):$(VERSION) $(OPT) .
	docker login $(REGISTRY)
	docker push $(REGISTRY)/$(REPO)/$(IMAGE):$(VERSION) 

clean:
	rm -f app/index.html app/turbine.json

bump:
	yq e -i '.DemoApp.status = "$(STATUS)"' ci/values.yml
	yq e -i '.DemoApp.container.tag = "$(VERSION)"' ci/values.yml
	yq e -i '.DemoApp.container.baseImageTag = "$(BASE_IMAGE_VERSION)"' ci/values.yml
	git commit -m "fix for vulnerability, bump app to $(VERSION)" ci/values.yml
	git push