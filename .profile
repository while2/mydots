# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

remove() {
  for file in $@; do
    fullpath=`pwd`/$file
    dir=`dirname $fullpath`
    filename=`basename $fullpath`
    base=$HOME/.trash/$dir
    /bin/rm -rf $base/$filename
    mkdir -p $base
    mv -f $fullpath $base/
  done
}
alias rm="remove"

restore() {
  mv $HOME/.trash/`pwd`/$1 ./
}
alias re="restore"

slay() {
  if [ -z "$1" ];then
    echo "Give me a name or should I slay them all?"
  else
    ps aux | grep -v grep | grep ^`whoami` | grep name=$1
    ps aux | grep -v grep | grep ^`whoami` | grep name=$1 | awk '{print $2}' | xargs kill
  fi
}
alias slay="slay"

alias hig="history | grep"
alias psg="ps aux | grep"
alias tailf="tailf -f"

