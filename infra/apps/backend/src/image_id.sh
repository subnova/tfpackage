#!/usr/bin/env sh
eval "$(jq -r '@sh "ACR_LOGIN_SERVER=\(.acr_login_server) REMOTE_IMAGE_NAME=\(.remote_image_name)"')"

IMAGE_WITH_SHA=$(docker image inspect ${ACR_LOGIN_SERVER}/${REMOTE_IMAGE_NAME} | jq -r --arg acr_login_server $ACR_LOGIN_SERVER --arg remote_image_name $REMOTE_IMAGE_NAME '.[0].RepoDigests | .[] | select(. | contains($acr_login_server + "/" + $remote_image_name))')

jq -n --arg image ${IMAGE_WITH_SHA} '{"image":$image}'
