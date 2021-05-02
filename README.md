# DEMO WORKFLOW

## Pre requisites
* Artifactory : docker repo created
* Pipelines already loaded with this git repo 
* Xray watches and policies
* Distribution : ready to distribute Edge (GPG key + circle of trust)
* Edge : referenced in Mission Control
* workstation : Docker client ready to push + yq + git client configured for commit/push + make

## Create base image

1. Update variables in `manual/create-base-image/Makefile`
```
VERSION=1.0.0
NEW_VERSION=1.0.1
```

2. Execute following commands
 ```
cd manual/create-base-image
make init
 ```

## Create app

### Via JFrog pipelines

Update values.yml and push to git repo => this will fire JFrog pipelines
 ```
# cd to root folder of the git repo and run 
cd ../../
make bump STATUS="red" VERSION="1.0.0" 
 ```

### Manually

1. Update variables in `Makefile`
2. Execute following commands
 ```
make prep build
 ```

## Fix the base image

1. Update variables in `manual/create-base-image/Makefile`
2. Execute following commands
 ```
cd manual/create-base-image
make fix
 ```

## Fix the app

### Via JFrog pipelines

Update values.yml and push to git repo => this will fire JFrog pipelines
 ```
 # cd to root folder of the git repo and run 
cd ../../
make bump STATUS="green" VERSION="1.0.1" BASE_IMAGE_VERSION="1.0.1"
 ```

### Manually

1. Update variables in `Makefile`
2. if you're on a MAC, add '' before -i 
3. Execute following commands
 ```
make prep build 
 ```



## OPTIONAL : Manual Distribution

* To distribute the docker image :  
    * update the  variables in the `automate-distrib/test.sh`
    * run `automate-distrib/test.sh`
