# Machine-learning-operationalization

## Useful command
### CMD
* [Build New Docker Image ]

docker build -t image_name .

* Log in to docker hub

docker login --username=yourhubusername

* Check the image ID using

docker images

* Tag image

docker tag img_id docker_hub_repositories:image_name

* Push image to the repository

docker push docker_hub_repositories

### AZURE CLI

* Import to ACR

az acr import --name myregistry --source docker.io/library/hello-world:latest --image hello-world:latest

* Deploy to ACI

az container create -g MyResourceGroup --name myapp --image myimage:latest --cpu 1 --memory 1
