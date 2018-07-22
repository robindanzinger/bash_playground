source ./lib/utils.sh
source ./lib/assert.sh

#@after

#@before

#@test
function test_find_test_files {
  mkdir -p './tmp/subfolder'
  touch './tmp/file_a_test.sh'
  touch './tmp/subfolder/file_c_test.sh'

  cha_testfiles=$(find_test_files './tmp')
  
  equal "${cha_testfiles}" "./tmp/file_a_test.sh ./tmp/subfolder/file_c_test.sh" "should find two files"
  
  clean_folder './tmp'
}

#@test
function test_create_target_folder {
  create_target_folder './target/tmp'
  assert_folder_exists './target/tmp'
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

  clean_folder './tmp'
}

#@test
function test_find_test_functions_in_file {
  tests=$(find_test_functions file_with_tests.txt)
  equal "${tests}" "testname1 testname5" "should find two valid test declarations"
}


