#!/usr/bin/env sh
jq -n --arg image dpeakalldemoabc12.azurecr.io/backend@sha256:3ff9f07ad1c3e261f7ab34bbad442bf64fcc0ab19659ce4b0d42f478100bc19d {"image":$image}
