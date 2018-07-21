source ../lib/utils.sh
source ../lib/assert.sh

#@test
function test_a {
  cha_testfiles=$(find_test_files './find_test_files')
  equal "${cha_testfiles}" "./find_test_files/file_a_test.sh ./find_test_files/subfolder/file_c_test.sh" "should find two files"
}

#@test
function test_b {
  create_target_folder './target/tmp'
  assert_folder_exists './target/tmp'
}

#@test
function test_c {
  mkdir './tmp'
  touch './tmp/foo'
  
  assert_file_exists './tmp/foo'
  
  clean_folder './tmp'

  assert_folder_exists './tmp' not

}

test_a
test_b
test_c
