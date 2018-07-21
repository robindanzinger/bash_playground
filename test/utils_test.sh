source ../lib/utils.sh
source ../lib/assert.sh

#@test
function testa {
  cha_testfiles=$(find_test_files './find_test_files')
  equal "${cha_testfiles}" "./find_test_files/file_a_test.sh ./find_test_files/subfolder/file_c_test.sh" "should find two files"
}

testa
