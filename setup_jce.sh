#!/bin/bash

which git > /dev/null
GIT=$?

which curl > /dev/null
CURL=$?


#############################
#  Get tmux plugin manager  #
#############################
if [[ ${GIT} -eq 0 ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


##################
#  Get vim Plug  #
##################
if [[ ${CURL} -eq 0 ]]; then
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi



