#!/bin/sh

bundle exec dpl --provider=pages \
  --github-token=$GITHUB_TOKEN   \
  --local-dir=public             \
  --target-branch=master
