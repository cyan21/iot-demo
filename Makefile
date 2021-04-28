
STATUS=red
VERSION=1.3.0

build:
	sed  s/STATUS/$(STATUS)/ templates/index.html.tpl > app/index.html
	sed  s/STATUS/$(STATUS)/ templates/turbine.json.tpl | sed s/IMAGE_VERSION/$(VERSION)/ > app/turbine.json
	docker build -t iot-demo.gcp.devopsacc.team:80/docker-local/turbine:$(VERSION) .
	docker login iot-demo.gcp.devopsacc.team:80
	docker push iot-demo.gcp.devopsacc.team:80/docker-local/turbine:$(VERSION) 
clean:
	rm -f app/index.html app/turbine.json
