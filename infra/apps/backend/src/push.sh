#!/usr/bin/env sh
docker load -i docker.tar
docker tag bazel/apps/backend/src:docker dpeakalldemoabc12.azurecr.io/backend
az acr login --name dpeakalldemoabc12
docker push dpeakalldemoabc12.azurecr.io/backend
