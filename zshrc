# oh-my-zsh setup:
ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="combose"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(autojump django git git-hubflow command-not-found pip python vagrant virtualenvwrapper)

source $ZSH/oh-my-zsh.sh
# END oh-my-zsh

source $HOME/.liquidpromptrc
source $HOME/.liquidprompt/liquidprompt

# zsh options
unsetopt share_history
unsetopt correctall
autoload -U select-word-style
select-word-style bash

# Tweaks
export TERM=xterm-256color # More colorful terminal vim :)

# Aliases
alias ls='ls --color=auto '
alias ll='ls -al'
alias llh='ls -alh'
alias lh='ls -sh'
alias less='less -R'
alias man='LC_ALL=C LANG=C man'
alias now='date +%Y%m%d_%H%M%S'
alias o='less -RS'
alias rv='gvim --remote-tab'
alias ccat='source-highlight -f esc -o STDOUT -i'
alias xo='xdg-open'
alias ncv='nc -vv'
alias digs='dig +short'
alias synhl='pygmentize -f console256 -g' # Syntax highlighting

function ssl() {
	host=$1
	port=$2
	[ -z $port ] && port=443
	openssl s_client -connect $host:$port
}

# Update only a given apt repo
function update-repo() {
	if [ ! -f /etc/apt/sources.list.d/$1 ]; then
		echo "No such file: /etc/apt/sources.list.d/$1"
		return 1
	fi
	sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/$1" \
		-o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
	return 0
}

# Colourise man pages
# http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
# https://gist.github.com/boredzo/06271944983864da495d303638351ca8
function man() {
	env \
		LESS_TERMCAP_md=$'\e[1;36m' \
		LESS_TERMCAP_me=$'\e[0m' \
		LESS_TERMCAP_se=$'\e[0m' \
		LESS_TERMCAP_so=$'\e[1;40;92m' \
		LESS_TERMCAP_ue=$'\e[0m' \
		LESS_TERMCAP_us=$'\e[1;32m' \
			man "$@"
}

# Git aliases
alias ga='git add'
alias gci='git commit'
alias gdiff='git diff --ignore-space-at-eol -b -w'
alias gm='git merge --no-ff'
alias gpr='git pull --rebase'
alias gst='git st'

alias ag='ag --nogroup'

# Set umask to make files non-world readable by default
umask 007

# Setup paths
[ -d $HOME/bin ]               && export PATH="$PATH:$HOME/bin"
[ -d $HOME/.local/bin ]        && export PATH="$PATH:$HOME/.local/bin"
[ -d $HOME/.rvm/bin ]          && export PATH="$PATH:$HOME/.rvm/bin"
[ -d $HOME/node_modules/.bin ] && export PATH="$PATH:$HOME/node_modules/.bin"
[ -d /usr/local/go/bin ]       && export PATH="$PATH:/usr/local/go/bin"
# Add relative node bin directories
export PATH="$PATH:node_modules/.bin"

[ -d $HOME/src/code/python ] && export PYTHONPATH="$PYTHONPATH:$HOME/src/code/python"
[ -d $HOME/src/go ]          && export GOPATH=$HOME/src/go && export PATH=$PATH:$GOPATH/bin

# Load host-specific stuff...
[ -f "$HOME/.zshrc.local" ] && source $HOME/.zshrc.local
