source ./lib/utils.sh
source ./lib/assert.sh

#@test
function test_execute_before {
  mkdir './stmp'
  touch './stmp/before'
  
  let function_called=0

  echo '                      
    #@before                 
    function setup {          
      $function_called+=1     
    }                        
  '  > "./stmp/before"

  execute_before './tmp/before'

  assert_equal "1" "$function_called" "function wasn't called"
}
