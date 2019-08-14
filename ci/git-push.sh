#!/usr/bin/env sh

cd ${DRONE_WORKSPACE}/new-repo/
git add .
git commit -m "Helm package robot commit"
git push -u origin master
