#!/usr/bin/env bash

# move file to ~/.trash dir instead of really remove them
remove() {
  for file in "$@"; do
    if [[ $file == /* ]]; then
      fullpath=$file
    else
      fullpath=$(pwd)/$file
    fi
    dir=$(dirname "$fullpath")
    filename=$(basename "$fullpath")
    base=$HOME/.trash/$dir
    if [[ -f $base ]]; then
      /bin/rm "$base"
    fi
    /bin/rm -rf "${base:?}/$filename"
    mkdir -p "$base"
    mv -f "$fullpath" "$base"/
  done
}
alias rm="remove"

list() {
  ls "$HOME/.trash/$(pwd)"
}
alias lsrm="list"

restore() {
  mv "$HOME/.trash/$(pwd)/$1" ./
}
alias re="restore"



slay() {
  if [ -z "$1" ];then
    echo "Give me a name or should I slay them all?"
  else
    px aux | grep -v grep | grep $(whoami) | grep hint=$1
    ps aux | grep -v grep | grep $(whoami) | grep hint=$1 | awk '{print $2}' | xargs kill
  fi
}
alias slay="slay"

alias hig="history | grep"
alias psg="ps aux | grep"
alias tailf="tail -f"

alias tb='function _tb(){ tensorboard --logdir=$1;};_tb'
