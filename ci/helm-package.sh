#!/usr/bin/env sh

# install git
apk add git

# check if changes have been made to the helm chart
if ! git diff HEAD~1 | grep -iE 'a\/helm.*';
then
  echo "No changes to helm chart made, skipping..."
  exit 0
else
  # package helm chart
  helm init --client-only
  mkdir ./output/
  helm package ./helm/${APP}/ -d ./output/

  # create new git repo and add remote
  mkdir ${DRONE_WORKSPACE}/new-repo/ && cd ${DRONE_WORKSPACE}/new-repo/
  git init
  git config --global user.email ${GIT_EMAIL}
  git remote add origin https://${GIT_USER}:${GIT_TOKEN}@${REPO}
  git fetch
  git checkout --track origin/master
  git pull

  # add packaged helm chart and reindex
  mv ${DRONE_WORKSPACE}/output/* ${DRONE_WORKSPACE}/new-repo/charts/
  helm repo index ${DRONE_WORKSPACE}/new-repo/charts/

  # stage and commit new files, push to remote
  git add .
  git commit -m "Original commit: ${DRONE_COMMIT_SHA}"
  git push -u origin master
fi
