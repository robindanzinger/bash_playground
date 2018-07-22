source ./lib/utils.sh
source ./lib/assert.sh

#@test
function test_execute_before {
  mkdir './tmp'
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
  mkdir './tmp'
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

#@before
function setup {
  clean_folder './tmp' 
}

#@after
function teardown {
  clean_folder './tmp' 
}
