# equal
function assert_equal {
  expected=$1
  actual=$2

  if [ "$expected" != "$actual" ]
  then
    throw_error "$expected is not equal to $actual"
  fi
}

# $1 folder $2 mode [not]
function assert_folder_exists {
  if [ $2 ] && [[ "$2" == "not" ]]
  then 
    assert "! -d $1" "folder $1 exists" 
  else
    assert "-d $1" "folder $1 doesn't exist"
  fi
}

function assert_file_exists {
  assert "-e $1" "file $1 doesn't exist"
}

function assert {
  if test $1
  then
    :
  else
    throw_error "$2"
  fi
}

function assert_cmd {
  if (eval $1)
  then
    :
  else
    throw_error $2
  fi
}

function assert_cmd_not {
  if (eval $1)
  then
    throw_error $2
  fi
}

function throw_error {
  echo "assertion failed"
  echo "$1"
  exit 42
}

# $1 pattern $2 mode [not]
function assert_log_contains {
  cmd="grep $1 $cha_logfile"
  if [ $2 ] && [[ "$2" == "not" ]]
  then 
    assert_cmd_not "$cmd" "log contains $1, but wasn't expected"
  else
    assert_cmd "$cmd" "log doesn't contain $1, but was expected"
  fi
}

function fails {
  echo "fails cmd" $1
  if ($1)
  then 
    throw_error "should fail, but passed"
  fi
}
