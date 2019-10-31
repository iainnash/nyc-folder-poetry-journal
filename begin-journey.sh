# this allows you to walk around my journies

export ROOT=$(pwd)

home() {
  builtin cd $ROOT
}

transit() {
  if [ -e $1.sh ]
  then
    echo '~~ whoosh ~~'
    source $1.sh
  elif [ -e $1 ] && [[ $1 = *.sh ]]
  then
    echo '~~ whoosh ~~'
    source $1
  else
    echo "Journey: $JOURNEY"
    builtin cd $@;
  fi
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
    export JOURNEY=$JOURNEY:${$(pwd)/#$ROOT}
  fi
}

esc=$(printf '\033')

lsnew() {
  /bin/ls | perl -e 'use Term::ANSIColor;' -ne 'if ($_ =~ /\.txt/) { print "→ cat ".colored($_, "blue"); } elsif ($_ =~ /\.sh/) { print "→ transit ".colored(substr($_, 0, -4), "magenta")."\n"; } elsif ($_ =~ /^./) { print "→ transit ".colored($_, "magenta"); } else { print; }'
}

if [ -z "$ALIASED" ]
then
  alias ls='lsnew'
  export ALIASED=true
else
  echo 'already setup'
fi

