export GOHOME=$HOME/go
PATH=~$GOHOME:/bin/noarch:~/bin:$PATH
export EDITOR=vim
export VISUAL=vim
export GIT_EDITOR=vim
export TERM=screen

#comment

red='\e[0;31m'
cyan='\e[0;36m'
green='\e[0;32m'
gray='\e[0;37m'
NC='\e[0m'

if [ $(whoami) == "root" ]; then
export PS1="\[$red\]\u\[$green\]|\[$NC\]\[$gray\]\H\[$NC\]\[$green\]|\[$NC\]\[$red\]\w\[$NC\] # "
else
export PS1="\[$gray\]\u\[$red\]|\[$NC\]\[$green\]\H\[$NC\]\[$red\]|\[$NC\]\[$cyan\]\w\[$NC\] > "
fi

alias vi=vim



#git prompt stuff
   GIT_PROMPT_ONLY_IN_REPO=1
if [ -f ~/.bash-git-prompt/gitprompt.sh ] ; then
source ~/.bash-git-prompt/gitprompt.sh
fi

#keychain stuff

function kc {
STOP=${1}

if [ ${STOP} == "stop" ]; then
	keychain --stop all
else 

eval $(keychain --nogui --eval --agents ssh id_dsa)
eval $(keychain --nogui --eval --agents ssh id_rsa)
fi
}




export PDSH_SSH_ARGS="-q"

unset SSH_ASKPASS



function ssh-sc() {
    # This function removes and adds keys to the ssh-agent you are using
    echo "removing keys provided by PKCS#11 shared library"
#    ssh-add -e /Library/OpenSC/lib/opensc-pkcs11.so 2>/dev/null
#    ssh-add -s /Library/OpenSC/lib/opensc-pkcs11.so 
# /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so
# /usr/lib64/opensc-pkcs11.so
    
    ssh-add -e /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so 2>/dev/null
    ssh-add -s /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so
}

# auto-update sock directory
# This is important to point at your most recent forwarded agent
function _update_auth_sock() {
  # if not empty
  if [[ -n "${SSH_AUTH_SOCK+x}" ]]; then
    # update to point to newest socket
    NEW_SSH_AUTH_SOCK=$(ls -t $(find /tmp/ -user $USER -type s -regex '/tmp/ssh-.*/agent.*' 2>/dev/null ) | head -n 1)
    if [[ "${SSH_AUTH_SOCK}" != "${NEW_SSH_AUTH_SOCK}" ]]; then
      echo "Updating SSH_AUTH_SOCK"
      export SSH_AUTH_SOCK="${NEW_SSH_AUTH_SOCK}"
    fi
  fi
}

alias sc='ssh-sc'

alias ssh='_update_auth_sock && ssh'

alias vim-vundle='vim +PluginInstall +qall'
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#sloppy focus in gnome3
#gsettings set org.gnome.desktop.wm.preferences auto-raise true;
#gsettings set org.gnome.desktop.wm.preferences focus-mode sloppy;
#gsettings set org.gnome.desktop.wm.preferences auto-raise-delay 100;
 

# Shows branches with descriptions
function gb() {
  branches=$(git for-each-ref --format='%(refname)' refs/heads/ | sed 's|refs/heads/||')
  for branch in $branches; do
    desc=$(git config branch.$branch.description)
    if [ $branch == $(git rev-parse --abbrev-ref HEAD) ]; then
      branch="* \033[0;32m$branch\033[0m"
     else
       branch="  $branch"
     fi
     echo -e "$branch, \033[0;36m$desc\033[0m"
  done
}

p () {
    open=xdg-open   # this will open pdf file withthe default PDF viewer on KDE, xfce, LXDE and perhaps on other desktops.

    ag -U -g ".pdf$" \
    | fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | tr " " "|"); 
            echo -e {1}"\n"{2} | grep -E "^|$v" -i --color=always;
        ' \
    | cut -z -f 1 -d $'\t' | tr -d '\n' | xargs -r --null $open > /dev/null 2> /dev/null
}


