source ./lib/assert.sh
source ./lib/utils.sh

#@test
function should_be_equal {
 assert_equal '1' '2' '1 ist 1'
}

#@test
function should_throw_error {
  fails "assert_equal '1' '2' '1 ist 2'"
}

#@test
function assert_log_contains_should_pass_when_found {
  create_log_file
  assert_log_contains foo
  assert_log_contains bar
  assert_log_contains abc
}

#@test
function assert_log_contains_should_fail_when_not_found {
  create_log_file
  (
    assert_log_contains par 
  ) 
  assert_equal '42' $?
  assert_log_contains par not
}

#@test
function assert_log_line {
  echo 'todo' 
}

function create_log_file {
  cha_logfile='./tmp/mylog.txt'
  touch $cha_logfile
  echo 'foo
  bar
  pattern abc pattern' > $cha_logfile
}

#@before
function create_tmp_folder {
  clean_folder './tmp'
  mkdir -p './tmp'
}
