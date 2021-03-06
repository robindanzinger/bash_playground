source ./lib/utils.sh
source ./lib/assert.sh

#@before
function setup_tmp_folder {
  clean_folder './tmp'
}

#@after
function clean_tmp_folder {
  clean_folder './tmp'
}

#@test
function test_find_test_files {
  mkdir -p './tmp/subfolder'
  touch './tmp/file_a_test.sh'
  touch './tmp/subfolder/file_c_test.sh'

  cha_testfiles=$(find_test_files './tmp')
  
  assert_equal "${cha_testfiles}" "./tmp/file_a_test.sh ./tmp/subfolder/file_c_test.sh" "should find two files"
}

#@test
function test_create_target_folder {
  create_target_folder './tmp/target/foo'
  assert_folder_exists './tmp/target/foo'
}

#@test
function given_folder_when_clean_folder_then_folder_will_be_deleted {
  mkdir './tmp'
  touch './tmp/foo'
  
  assert_file_exists './tmp/foo'
  
  clean_folder './tmp'

  assert_folder_exists './tmp' not
}

#@test
function clean_folder_on_nonexistent_folder_nothing_happens {
  clean_folder './notexistent'
  assert_folder_exists './notexistent' not
}

#@test
function test_copy_src {
  mkdir -p './tmp/src/sub'
  touch './tmp/src/foo'
  touch './tmp/src/sub/bar'
  mkdir './tmp/target/'

  copy_src './tmp/src' './tmp/target'

  assert_file_exists './tmp/target/foo'
  assert_file_exists './tmp/target/sub/bar'
}

#@test
function test_find_test_functions_in_file {
  tests=$(find_test_functions "./test/file_with_tests.txt")
  assert_equal "${tests}" "testname1 testname5" "should find two valid test declarations"
}

#@test
function can_redirect_to_file {
  mkdir -p './tmp'
  touch './tmp/log'
  (
    echo 'hallo welt'
  ) > ./tmp/log

  assert_cmd "grep 'hallo welt' ./tmp/log" "file doesn't contain string 'hallo welt'"
}


