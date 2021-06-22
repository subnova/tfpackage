#!/usr/bin/env sh

ACR_LOGIN_SERVER=$1
if [ -z ${ACR_LOGIN_SERVER} ]
then
    echo "Must specify the login server for the Azure container registry"
    exit 1
fi

TOKEN=$(az acr login --name ${ACR_LOGIN_SERVER} --expose-token --output tsv --query accessToken)

mkdir -p docker-config
cat <<EOF > docker-config/config.json
{
  "auths": {
    "${ACR_LOGIN_SERVER}": {
      "username": "00000000-0000-0000-0000-000000000000",
      "password": "$TOKEN"
    }
  }
}
EOF

docker load -i docker.tar
docker tag bazel/apps/backend/src:docker ${ACR_LOGIN_SERVER}/backend
docker --config ./docker-config push ${ACR_LOGIN_SERVER}/backend
