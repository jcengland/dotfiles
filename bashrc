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

if [ -d "$HOME/Library/Python/2.7/bin" ]; then
    PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi

if [ ${HOSTNAME} != "england-desktop.ccs.ornl.gov" ]; then
alias pivot="ssh -X -D 8888 pivot.ccs.ornl.gov"
else
alias pivot="ssh -X pivot.ccs.ornl.gov"
fi

alias vi=vim


if [ -e "/usr/bin/qsub" ]; then
#alias ijob='qsub -I -lnodes=1 -lwalltime=8:00:00 -A stf002'

function ijob {
if [ -z $1 ]; then
   NODES=1
else 
   NODES=${1}
fi

if [ -z $2 ]; then
   WALLTIME="8:00:00"
else 
   WALLTIME=${2}
fi

qsub -I -lnodes=${NODES} -lwalltime=${WALLTIME} -A stf002
}
fi

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



if [ -f /usr/bin/moc ] || [ -f ~/bin/mocp ]; then
alias music="padsp mocp"
alias nomusic="mocp -P"
fi

alias canary="cd /ccs/sys/clusters/canary_jobs"
export PDSH_SSH_ARGS="-q"
export LANG=en_US.UTF-8

unset SSH_ASKPASS

alias vssh="vagrant ssh"
alias vup="vagrant up"
alias vd="vagrant destroy -f"
alias vp="vagrant provision"
alias vstat="vagrant status"
alias vh="vagrant halt"
alias vr="vagrant reload"
alias vcd="cd /home/england/condor_vagrant/vagrant_condor/"
alias role="cd ~/puppet/site/role/"
alias hr="cd ~/puppet/hieradata/"
alias pp="cd ~/puppet"
alias prof="cd ~/puppet/site/profile/" 
alias docs="cd ~/devel/docs-md"

function mod() {
if [ ! -z ${1+x} ]; then
        module=$1
	if [ ! -z ${2+x} ]; then 
		cd ~/puppet/modules/${module}/$2
	else
                cd ~/puppet/modules/${module}/manifests
	fi	
else
        cd ~/puppet/modules/
fi

}

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


