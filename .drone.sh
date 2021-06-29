#!/bin/sh

mkdir ~/.ssh
[ -z "$SSH_KEY" ] && echo "missing ssh key" && exit 3
echo -n $SSH_KEY > ~/.ssh/id_rsa
echo $HOME
pwd
chmod 600 ~/.ssh/id_rsa
touch ~/.ssh/known_hosts
chmod 600 ~/.ssh/known_hosts
ssh-keyscan -H github.com > /etc/ssh/ssh_known_hosts 2> /dev/null
ls $HOME/.ssh
cat $HOME/.ssh/id_rsa


git checkout deploy
git fetch origin deploy
sed -i "s+dther/golang-http:.*$*+dther/golang-http:${DRONE_COMMIT_SHA}+g" kustomize/bases/hola/deployment.yaml
git add .
git config --global user.name "drone-ci"
git config --global user.email "ci@drone.io"
git commit -m "Change image version to ${DRONE_COMMIT_SHA}" -a
cat .git/config
git push origin deploy
