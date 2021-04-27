#!/bin/bash

# configure the CLI and make sure to set the JFrog Distribution URL 
# artifactory URL : http://artifactory-eu-yannc4-0.soleng-emea-staging.jfrog.team/artifactory
# distribution URL : http://artifactory-eu-yannc4-0.soleng-emea-staging.jfrog.team/distribution
#jfrog rt c yannc4
#jfrog c use iot-demo-test 
jfrog c use iot-demo-shay


releaseBundleName=Turbine
releaseBundleVers=1.2.0
repoName=docker-local
repoName=docker
imageName=turbine

sed s/REPO_NAME/${repoName}/ releaseBundleCreate.json.tpl | sed s/IMAGE_NAME/${imageName}/ | sed s/IMAGE_TAG/${releaseBundleVers}/ > releaseBundleCreate.json

#jfrog rt dp iot-demo.gcp.devopsacc.team:80/docker-local/turbine:1.0.2 jupiter-docker-dev-local
#jfrog rt dp iot-demo.gcp.devopsacc.team:80/docker-local/turbine:$releaseBundleVers jupiter-docker-dev-local

# create release bundle
# AQL with path mapping  isn't supported yet (03/2021), only with patterns (check releaseBundleCreate.json)
jfrog rt rbc --sign=true --desc="new version $releaseBundleVers" --spec=releaseBundleCreate.json --release-notes-path=release_notes.txt --release-notes-syntax=markdown $releaseBundleName $releaseBundleVers 

jfrog rt rbd --dist-rules=distribution_rules.json $releaseBundleName $releaseBundleVers 

