library(AzureContainers)
library(AzureRMR)
library(httpuv)

Sys.setenv(TZ = 'Europe/Kiev')


az <- az_rm$new(tenant="andriyshchuroutlook.onmicrosoft.com",
                 app="dfb02874-d551-4a81-b15e-10d0553803fe",
                 password="334e962a-86ed-4f7f-8cd6-739f189ffd62")


# create a resource group for our deployments
sub <- az$get_subscription("530aa984-0423-4f0b-bb20-4576901baa25")


# create container registry ---
rg <- sub$get_resource_group("deployresgrp")


acr <- rg$get_acr("mysmartacr")

# build image 'bos_rf'
AzureContainers::call_docker(cmd = 'build C:/Users/anshch/Documents/Docker/')

# upload the image to Azure
deployreg <- acr$get_docker_registry()
deployreg$push("bos_rf")


# create a Kubernetes cluster with 2 nodes, running Linux
deployclus_svc <- rg$get_aks("myfirstclust")


# get the cluster endpoint

deployclus <- deployclus_svc$get_cluster()

# pass registry authentication details to the cluster
deployclus$create_registry_secret(deployreg,
                                  email="andriy.shchur@outlook.com")

# create and start the service
deployclus$create("bos_rf.yaml")



deployclus$get("deployment bos-rf")
deployclus$get("service bos-rf-svc")



# response <- httr::POST("http://13.81.4.215:8000/score",
#                        body=list(df=MASS::Boston[1:2,]), encode="json")
# 
# httr::content(response, simplifyVector=TRUE)
system.time(httr::content(httr::POST("http://104.40.232.118:8000/score",
                         body=list(df=MASS::Boston[1:2,]), encode="json"), simplifyVector=TRUE))


deployclus$delete("service", "bos-rf-svc")
deployclus$delete("deployment", "bos-rf")



