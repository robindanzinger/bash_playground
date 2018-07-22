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

function find_annotated_function {
  echo $(grep -A1 $2 $1 | grep 'function .* {' | cut -d ' ' -f 2)
}

function execute_tests {
### log start
  echo " -------------------------------------"
  echo " START: $cha_testfile"
  echo " -------------------------------------"

### run tests
  cha_testfile=$1
  source $cha_testfile

  for test_func in $(find_test_functions $cha_testfile)
  do
    echo " o $test_func"
    numberOfTests+=1
    (
      do_execute_test $test_func $cha_testfile
      return $?
    )
    cha_testresult=$?
    if (( $cha_testresult == 0 ))
    then
      success+=1
    else
      error+=1
    fi
  done
  
### log result
  echo " -------------------------------------"
  echo " END"
  echo " -------------------------------------"
  echo "" 
  echo "" 
}

function do_execute_test {
  typeset -i cha_testresul
  (
    execute_before $2
  )
  cha_testresult=$?
  # assert lib reinladen
  (
    eval "$test_func"
  )
  cha_testresult+=$?
  (
    execute_after $2
  )
  cha_testresult+=$?
  return $cha_testresult
}

function execute_before {
  execute_annotated_funcs $1 '#@before'
#  for before_func in $(find_annotated_function $1 '#@before')
#  do
#    eval "$before_func"
#  done
}

function execute_after {
  execute_annotated_funcs $1 '#@after'
}

function execute_annotated_funcs {
  for annotated_func in $(find_annotated_function $1 $2)
  do
    eval "$annotated_func"
  done
}

