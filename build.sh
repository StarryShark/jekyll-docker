#!/bin/sh

VERSION='1.0.8'

declare -a LIST=$(curl -s -H "Content-Type: application/json" https://registry.hub.docker.com/v1/repositories/goel/jekyll/tags | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}')

for ITEM in $LIST; do
  if [ "$VERSION" = "$ITEM" ]; then
    echo 'Duplicate version.'
    exit 1
  fi
done

echo "$DOCKER_PASSWORD" | docker login -u goel --password-stdin

# Build image
docker build --pull \
             --compress \
             --rm \
             -t goel/jekyll:$VERSION \
             -t goel/jekyll:latest \
             --build-arg VERSION=$VERSION \
             -f Dockerfile .

# Test image
TEST=$(docker run --rm goel/jekyll:latest bash -c 'cat /tmp/VERSION')

if [ "$VERSION" != "$TEST" ]; then
  echo 'Version mismatch. Test failed.'
  exit 1
fi

# Push image to public docker hub
docker push goel/jekyll
