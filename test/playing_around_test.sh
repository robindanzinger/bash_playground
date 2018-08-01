source ./lib/utils.sh
source ./lib/assert.sh

#@test
function test_scopes {
  var="leer"
  assert_equal $var "leer"
  func_a
  assert_equal $var "func_a"
}

function func_a {
  var="func_a"
  echo "out_before: $var"
  (
    func_b
  )
  echo "out_after: $var"
}

function func_b {
  echo "inner_before $var"
  var="func_b"
  echo "inner_after $var"
}
