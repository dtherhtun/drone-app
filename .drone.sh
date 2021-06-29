#!/bin/sh

mkdir ~/.ssh
[ -z "$GH_TOKEN" ] && echo "missing github token" && exit 3

git clone https://dtherhtun:$GH_TOKEN@github.com:dtherhtun/drone-app.git -b deploy app
cd app
sed -i "s+dther/golang-http:.*$*+dther/golang-http:${DRONE_COMMIT_SHA}+g" kustomize/bases/hola/deployment.yaml
git add .
git config --global user.name "drone-ci"
git config --global user.email "ci@drone.io"
git commit -m "Change image version to ${DRONE_COMMIT_SHA}" -a
cat .git/config
git push origin deploy
