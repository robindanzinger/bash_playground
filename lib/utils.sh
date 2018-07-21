function find_test_files {
  echo $(find $1 -name '*test.sh')
}

function create_target_folder {
  mkdir -p $1
}

function clean_folder {
  rm -r $1
}
