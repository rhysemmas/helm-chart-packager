#!/usr/bin/env sh

cd ${DRONE_WORKSPACE}/new-repo/
git config --global user.email ${GIT_EMAIL}
git remote add origin https://${GIT_USER}:${GIT_TOKEN}@github.com/rhysemmas/helm-chart-hoster.git
git add .
git commit -m "Helm package robot commit"
git push -u origin master
