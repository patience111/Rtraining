#!/bin/bash

rm -rf out || exit 0;
mkdir out;

GH_REPO="@github.com/stephlocke/Rtraining.git"

FULL_REPO="https://$GH_TOKEN$GH_REPO"

for files in '*.tar.gz'; do
        tar xfz $files
done

cd out
git init
git config user.name "stephs-travis"
git config user.email "travis"

R CMD INSTALL Rtraining
R CMD BATCH '../Rtraining/ghgenerate.R'

for files in '../Rtraining/inst/doc/*.html'; do
        cp $files .
done

git add .
git commit -m "deployed to github pages"
git push --force --quiet $FULL_REPO master:gh-pages