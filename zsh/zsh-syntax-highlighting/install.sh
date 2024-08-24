#!/usr/bin/env bash
# Install or update zsh-syntax-highlighting by downloading latest `master`
# branch snapshot from git

pushd $(dirname $0)

function on_exit() {
	popd
}

trap on_exit EXIT

wget https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz
tar xzvf master.tar.gz zsh-syntax-highlighting-master/{zsh-syntax-highlighting.zsh,.version,.revision-hash} $(tar tf master.tar.gz | grep -- '-highlighter\.zsh$')
[ -d highlighters ] && rm -r highlighters
mv zsh-syntax-highlighting-master/* ./
mv zsh-syntax-highlighting-master/{.version,.revision-hash} ./
rm master.tar.gz
rmdir zsh-syntax-highlighting-master
