export ZSH=/Users/chris/.oh-my-zsh
export TERM="xterm-256color"

DEFAULT_USER="chris"
ZSH_THEME="powerlevel9k/powerlevel9k"

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(brew common-alias docker gitfast history history-substring-search java jsontools thefuck osx z zsh-wakatime)

# User configuration
export GOPATH=~/Projects/go
source $ZSH/oh-my-zsh.sh
export LANG=en_GB.UTF-8
export SSH_KEY_PATH="~/.ssh/dsa_id"

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias fixvpn="sudo route -n flush && sudo networksetup -setv4off Wi-Fi && sudo networksetup -setdhcp Wi-Fi"
alias mount_nas="sudo mount -t nfs -o rw,resvport,soft,intr,rsize=8192,wsize=8192,timeo=900,retrans=3,proto=tcp 192.168.1.2:/volume1/Video /Users/chris/Projects/sickrage/data/nas"
alias unmount_nas="sudo umount /Users/chris/Projects/sickrage/data/nas"

alias tn="tmux new-session -s "
alias tk="tmux kill-session -t "
alias tl="tmux ls"
alias ta="tmux attach"

alias k="kubectl"

alias ez="vim ~/.zshrc"
alias rz="source ~/.zshrc"

port() {
    SERVICE=$1
    echo $(kubectl get services/${SERVICE} -o go-template='{{(index .spec.ports 0).nodePort}}')
}

urar() {
	pushd ~/Downloads
	find . -name "*.rar" | xargs -I {} unrar x -y {} ~/Movies
	find . -name "*.mkv" -exec mv {} ~/Movies \;
	find . -name "*.mp4" -exec mv {} ~/Movies \;
	find . -name "*.avi" -exec mv {} ~/Movies \;
	popd
}

export SVN_EDITOR=vim
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export HISTCONTROL=ignorespace:erasedups
export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
export WORKON_HOME=~/.envs

source /usr/local/bin/virtualenvwrapper.sh

mcd() { mkdir -p "$*"; cd "$*" }

latest() {
	TIME=${1-'-30min'};
	find -newermt $TIME -printf "%T@ %p\n" 2>&- | sort -n | gawk '{ print strftime("%F-%T", $1), $2; }';
}
members () { dscl . -list /Users | while read user; do printf "$user "; dsmemberutil checkmembership -U "$user" -G "$*"; done | grep "is a member" | cut -d " " -f 1; };


test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin"

eval "dircolors ~/.dir_colors" > /dev/null 2>&1
eval "$(thefuck --alias)"

