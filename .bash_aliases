#!/usr/bin/env bash

# move file to ~/.trash dir instead of really remove them
rm() {
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
alias rm="rm"

lsrm() {
  ls "$HOME/.trash/$(pwd)"
}
alias lsrm="lsrm"

re() {
  mv "$HOME/.trash/$(pwd)/$1" ./
}
alias re="re"

psg() {
  cmd="ps aux | grep -v grep"
  for key in "$@"; do
    cmd=$cmd" | grep $key"
  done
  eval "$cmd"
}
alias psg="psg"

psgk() {
  if [ -z "$1" ];then
    echo "Give me a name or should I slay them all?"
  else
    eval psg "$(whoami)" "$@"
    eval psg "$(whoami)" "$@" | awk '{print $2}' | xargs kill
  fi
}
alias slay="psgk"

alias hig="history | grep"
alias tailf="tail -f"

alias tb='function _tb(){ tensorboard --logdir=$1;};_tb'
