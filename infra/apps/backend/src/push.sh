#!/usr/bin/env sh

LOCAL_IMAGE=$1
if [ -z ${LOCAL_IMAGE} ]
then
    echo "Must specify the local image to push"
    exit 1
fi

REMOTE_IMAGE=$2
if [ -z ${REMOTE_IMAGE} ]
then
    echo "Must specify the remote image name to use"
    exit 1
fi

ACR_LOGIN_SERVER=$3
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
docker tag ${LOCAL_IMAGE} ${ACR_LOGIN_SERVER}/${REMOTE_IMAGE}
docker --config ./docker-config push ${ACR_LOGIN_SERVER}/${REMOTE_IMAGE}
