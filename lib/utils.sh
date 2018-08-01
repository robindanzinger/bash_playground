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
  mkdir -p "./logs/${cha_testfile}/"
  logfilebase="./logs/${cha_testfile}/"

  for test_func in $(find_test_functions $cha_testfile)
  do
    logfile="${logfilebase}/${test_func}.log"
    touch $logfile
    echo " o $test_func"
    numberOfTests+=1
    (
      do_execute_test $test_func $cha_testfile $logfile
      return $?
    )
    cha_testresult=$?
    if (( $cha_testresult == 0 ))
    then
      success+=1
    else
      echo "ERROR Return Code is: $cha_testresult" 
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
  test_func=$1
  cha_testfile=$2
  logfile=$3
  typeset -i cha_testresult
  (
    execute_before $cha_testfile 
  )
  cha_testresult=$?
  # assert lib reinladen
  (
    eval "$test_func"
  ) > $logfile
  cha_testresult+=$?
  (
    execute_after $cha_testfile
  )
  cha_testresult+=$?
  return $cha_testresult
}

function execute_before {
  execute_annotated_funcs $1 '#@before'
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

