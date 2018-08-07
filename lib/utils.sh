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
  echo $(find_annotated_functions $1 '#@test')
}

function find_annotated_functions {
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
    cha_logfile="${logfilebase}/${test_func}.log"
    touch $cha_logfile
    echo " o $test_func"
    numberOfTests+=1
    (
      do_execute_test $test_func $cha_testfile $cha_logfile
      return $?
    )
    cha_testresult=$?
    if (( $cha_testresult == 0 ))
    then
      update_console "v" "$test_func" 2
      success+=1
    else
      update_console "x" "$test_func" 1
      echo "ERROR Return Code is: $cha_testresult"
#      cat $cha_testresult 
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

function update_console {
  tput cuu1
  tput dl1
  tput il1
  echo "$(tput setaf $3) $1 $(tput setaf 7) $2"
}

function do_execute_test {
  test_func=$1
  cha_testfile=$2
  cha_logfile=$3
  typeset -i cha_testresult
  (
    execute_before $cha_testfile 
  )
  cha_testresult=$?
  # assert lib reinladen
  (
    $test_func
  ) > $cha_logfile
  cha_testresult+=$?
  (
    execute_after $cha_testfile
  )
  cha_testresult+=$?
  return $cha_testresult
}

function execute_before {
  execute_annotated_functions $1 '#@before'
}

function execute_after {
  execute_annotated_functions $1 '#@after'
}

function execute_annotated_functions {
  for annotated_func in $(find_annotated_functions $1 $2)
  do
    $annotated_func
  done
}

