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
alias tailf="tail -f"

alias tb="function _tb(){ tensorboard --logdir=$1;};_tb"
