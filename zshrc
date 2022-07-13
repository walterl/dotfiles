# oh-my-zsh setup:
ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="combose"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

# $WORKON_HOME is required by oh-my-zsh's virtualenvwrapper plugin
export WORKON_HOME=$HOME/.virtualenvs

plugins=(autojump command-not-found dotenv git pip python virtualenvwrapper)

source $ZSH/oh-my-zsh.sh
# END oh-my-zsh

# Setup paths
[ -d $HOME/bin ]         && export PATH="$PATH:$HOME/bin"
[ -d $HOME/.local/bin ]  && export PATH="$PATH:$HOME/.local/bin"
[ -d $HOME/.rvm/bin ]    && export PATH="$PATH:$HOME/.rvm/bin"
[ -d /usr/local/go/bin ] && export PATH="$PATH:/usr/local/go/bin"

# Fancy prompt
if command -v starship > /dev/null; then
	eval "$(starship init zsh)"
fi

# zsh options
unsetopt share_history
unsetopt correctall
autoload -U select-word-style
select-word-style bash

# Tweaks
export TERM=xterm-256color # More colorful terminal vim :)

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Aliases
alias ls='ls --color=auto '
alias ll='ls -al'
alias llh='ls -alh'
alias lh='ls -sh'
alias less='less -R'
alias man='LC_ALL=C LANG=C man'
alias now='date +%Y%m%d_%H%M%S'
alias today='date +%Y-%m-%d'
alias o='less -RS'
alias ccat='source-highlight -f esc -o STDOUT -i'
alias xo='xdg-open'
alias ncv='nc -vv'
alias digs='dig +short'
alias synhl='pygmentize -f console256 -g' # Syntax highlighting
alias t='tree -hp'

function prettier-diff {
	prettier "$1" | colordiff "$1" -
}

function ssl() {
	host=$1
	shift
	port=$1
	shift
	[ -z $port ] && port=443
	openssl s_client -connect $host:$port $@
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
alias gbranch='git rev-parse --abbrev-ref HEAD'
alias gci='git commit'
alias gdiff='git diff --ignore-space-at-eol -b -w'
alias gm='git merge --no-ff'
alias gpr='git pull --rebase'
alias gst='git st'

alias ag='ag --nogroup'

# Set umask to make files non-world readable by default
umask 027

# Add relative node bin directories
export PATH="$PATH:node_modules/.bin"
[ -d $HOME/node_modules/.bin ] && export PATH="$PATH:$HOME/node_modules/.bin"

[ -f $HOME/.startup.py ]     && export PYTHONSTARTUP="$HOME/.startup.py"
[ -d $HOME/src/code/python ] && export PYTHONPATH="$PYTHONPATH:$HOME/src/code/python"
[ -d $HOME/src/go ]          && export GOPATH=$HOME/src/go && export PATH=$PATH:$GOPATH/bin

# Load host-specific stuff...
[ -f "$HOME/.zshrc.local" ] && source $HOME/.zshrc.local

# Enable vi-mode
VIMODE="$(dirname $(readlink -f ~/.zshrc))/_vi-mode.zsh"
[ -f $VIMODE ] && source $VIMODE

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set editor
if [ -z "$EDITOR" ]; then
	for editor in nvim vim vi; do
		command -v $editor > /dev/null && break
	done
	export EDITOR=$(command -v $editor)
	unset editor
fi

# Load nvm if available
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# vim:ts=4 sts=4 sw=4
