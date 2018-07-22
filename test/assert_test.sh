source ./lib/assert.sh

#@test
function should_be_equal {
 assert_equal '1' '1' '1 ist 1'
}

#@test
function should_throw_error {
  assert_equal '1' '2' '1 ist 2'
}
