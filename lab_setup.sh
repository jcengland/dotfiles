#!/bin/bash

if [ -d .git ]; then
  if [ ! -d .git/lab ]; then
  mkdir .git/lab
  cp ~/dotfiles/lab.toml .git/lab
  fi
else
  echo "No .git dir"
  exit
fi



