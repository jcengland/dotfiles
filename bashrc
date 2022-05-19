export GOHOME=$HOME/go
PATH=/bin/noarch:~/bin:$PATH
export EDITOR=vim
export VISUAL=vim
export GIT_EDITOR=vim
export TERM=xterm-256color

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
alias dev="cd ~/devel"
alias exit_slic="ssh -O exit rzslic; ssh -O exit oslic"
alias rzslic=" ssh -O exit rzslic; ssh rzslic"
alias oslic="ssh -O exit oslic; ssh oslic"
alias clean_mc="ssh -O exit rzslic; ssh -O exit oslic"
alias ansi="cd ~/devel/ansible"
alias cf="cd ~/devel/cfengine3"
alias kcs="keychain --stop all"

set -o vi
bind '"jk":vi-movement-mode'





if [ -f ~/.bash-git-prompt/gitprompt.sh ] ; then


source ~/.bash-git-prompt/gitprompt.sh
source ~/.bash-git-prompt/prompt-colors.sh

override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Custom"
  GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${ResetColor} [${USER}${Red}|${ResetColor}${Green}${HOSTNAME%%.*}${Red}|${ResetColor}${Yellow}${PathShort}${ResetColor}]"
  GIT_PROMPT_START_ROOT="${GIT_PROMPT_START_USER}"
}

reload_git_prompt_colors "Custom"
GIT_PROMPT_ONLY_IN_REPO=1
fi


#keychain stuff

function kc {
STOP=${1}

if [ "${STOP}" == "stop" ]; then
	keychain --stop all
else 

eval $(keychain --nogui --eval --agents ssh id_rsa_iz)
eval $(keychain --nogui --eval --agents ssh id_rsa_cz)
fi
}




export PDSH_SSH_ARGS="-q"

#unset SSH_ASKPASS



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

source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash

