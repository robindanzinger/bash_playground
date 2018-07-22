function find_test_files {
  echo $(find $1 -name '*test.sh')
}

function create_target_folder {
  mkdir -p $1
}

function clean_folder {
  if [ -d $1 ]
  then
    rm -r $1
  fi
}

function copy_src {
  cp -r "$1/." "$2"
}

function find_test_functions {
  echo $(grep -A1 '#@test' $1 | grep 'function .* {' | cut -d ' ' -f 2)
}

function execute_tests {
  cha_testfile=$1
  source $cha_testfile
  echo " -------------------------------------"
  echo " START: $cha_testfile"
  echo " -------------------------------------"
  for test_func in $(find_test_functions $cha_testfile)
  do
    numberOfTests+=1
    (
      typeset -i cha_testresult
      cd ${cha_outputdir}
      echo " o $test_func"
      do_execute_test $test_func
      return $cha_testresult
    )
    cha_testresult=$?
    if (( $cha_testresult == 0 ))
    then
      success+=1
    else
      error+=1
    fi
#   
  done
  echo " -------------------------------------"
  echo " END"
  echo " -------------------------------------"
  echo "" 
  echo "" 
}

function do_execute_test {
  (
    execute_before
  )
  cha_testresult=$?

  # assert lib reinladen
  (
    eval "$test_func"
  )
  cha_testresult+=$?
  (
    execute_after
  )
  cha_testresult+=$?
  return $cha_testresult
}

function execute_before {
  return 0
}

function execute_after {
  return 0
}

function execute_funcs {
  return 0
}

