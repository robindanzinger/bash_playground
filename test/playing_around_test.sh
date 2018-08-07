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

#@test
function cat_array_read {
  mkdir -p './tmp'
  file="./tmp/foo"
  touch $file
  echo "
    Line ONE
    Two
    3 4 5 6" > $file

  BACKIFS=$IFS
  IFS=$'\n'
  array=($(cat $file))

  echo USE IFS ONLY LINEBREAKS
  counter=0
  for line in ${array[*]}
  do
    echo "LINE NO ${counter}: $line"
    counter=$((counter+1))
  done

  IFS=$BACKIFS 
  echo IFS resetted
  counter=0
  for line in ${array[*]}
  do
    echo "LINE NO ${counter}: $line"
    counter=$((counter+1))
  done

  echo DIRECT ACCESS
  echo ${array[0]}
  echo ${array[1]}
  echo ${array[2]}
}

#@after
function clean_tmp_folder {
  clean_folder ./tmp
}
