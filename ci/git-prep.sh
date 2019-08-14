#!/usr/bin/env sh

mkdir ${DRONE_WORKSPACE}/new-repo/ && cd ${DRONE_WORKSPACE}/new-repo/
git init
git config --global user.email ${GIT_EMAIL}
git remote add origin https://${GIT_USER}:${GIT_TOKEN}@github.com/rhysemmas/helm-chart-hoster.git
git fetch
git checkout --track origin/master
git pull
mv ${DRONE_WORKSPACE}/output/* ${DRONE_WORKSPACE}/new-repo/charts/
