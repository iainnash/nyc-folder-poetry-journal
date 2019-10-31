# this allows you to walk around my journies

export ROOT=$(pwd)

home() {
  builtin cd $ROOT
}

walk() {
  builtin cd $@;
  if [ -f map.txt ]
  then
    echo '~~~~ map ~~~~~'
    cat map.txt
  fi
  if [[ $(pwd) = $ROOT ]]
  then
    export JOURNEY=''
  fi
  if [[ $(pwd) = $ROOT* ]]
  then
    export JOURNEY=$JOURNEY:$(pwd)
    echo 'in tree'
  fi
}

alias cd='echo "use walk";cd'
