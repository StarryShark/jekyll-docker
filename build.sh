#!/bin/sh

VERSION='1.0.4'

declare -a LIST=$(curl -s -H "Content-Type: application/json" https://registry.hub.docker.com/v1/repositories/goel/jekyll/tags | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}')

for ITEM in $LIST; do
  if [ "$VERSION" = "$ITEM" ]; then
    echo 'Duplicate version.'
    exit 1
  fi
done

echo "$DOCKER_PASSWORD" | docker login -u goel --password-stdin
docker build --compress --rm -t goel/jekyll:$VERSION -f Dockerfile .
docker run --rm goel/jekyll 'pwd && ls -la'
docker push goel/jekyll:$VERSION
