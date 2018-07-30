#!/bin/sh
echo ''
echo '-------------------------------------'
echo 'Deploy to Demo...'
echo '-------------------------------------'
echo ''
mkdir ./deploy-git
cd ./deploy-git
git init
git config --global push.default matching
git config --global user.email "isukkaw@gmail.com"
git config --global user.name "SukkaW"
git remote add origin https://${GitHubKEY}@github.com/theme-suka/demo.git
git pull origin master
rm -rf ./*
cp -rf ../public/* ./
git add --all .
git commit -m "Travis Auto Tester for hexo-theme-suka"
git push --quiet --force origin HEAD:master