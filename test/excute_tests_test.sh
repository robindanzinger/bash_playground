source ./lib/utils.sh
source ./lib/assert.sh

#@test
function test_execute_before {
  touch './tmp/before'
  
  typeset -i function_called
  function_called=0

  echo '                      
#''@before                 
function mock_setup {          
  function_called+=1
}                        
'  > "./tmp/before"

  source './tmp/before'
  execute_before './tmp/before'

  assert_equal "1" "$function_called" "function wasn't called"
}

#@test
function test_execute_after {
  touch './tmp/after'
  
  typeset -i function_called
  function_called=0

  echo '                      
#''@after
function mock_teardown {          
  function_called+=1
}                        
'  > "./tmp/after"

  source './tmp/after'
  execute_after './tmp/after'

  assert_equal "1" "$function_called" "function wasn't called"
}

#@test
function std_out_will_be_redirected_to_tmp_log_file {
  touch './tmp/logtest'
  echo '
#''@test
function print {
  echo "hallo welt"
  echo "Line 2"
  echo "END"
}
  ' > ./tmp/logtest
  execute_tests ./tmp/logtest
 
  logfile="./logs/tmp/logtest/print.log"
  assert_file_exists $logfile
  count=0
  while read line
  do 
    lines[$count]=$line
    echo $line
    let count++
  done < $logfile

  assert_equal "hallo welt" "${lines[0]}" 
  assert_equal "Line 2" "${lines[1]}"
  assert_equal "END" "${lines[2]}" 
}

#@before
function setup {
  clean_folder './tmp'
  mkdir './tmp' 
}

#@after
function teardown {
  clean_folder './tmp' 
}
