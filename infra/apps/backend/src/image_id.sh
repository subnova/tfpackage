#!/usr/bin/env sh
eval "$(jq -r '@sh "ACR_LOGIN_SERVER=\(.acr_login_server) REMOTE_IMAGE_NAME=\(.remote_image_name)"')"

IMAGE_WITH_SHA=$(docker image inspect ${ACR_LOGIN_SERVER}/${REMOTE_IMAGE_NAME} -f "{{ index .RepoDigests 0 }}")

jq -n --arg image ${IMAGE_WITH_SHA} '{"image":$image}'
