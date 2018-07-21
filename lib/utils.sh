function find_test_files {
  echo $(find $1 -name '*test.sh')
}

function create_target_folder {
  mkdir -p $1
}

function clean_folder {
  if [ -d $1 ]
  then
    rm -r $1
  else
    echo "could not clean folder $1, due to folder doesn't exist"
  fi
}

function copy_src {
  cp -r "$1/." "$2"
}

function find_test_functions {
  echo $(grep -A1 '#@test' $1 | grep 'function .* {' | cut -d ' ' -f 2)
}

