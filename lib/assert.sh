# equal
function equal {
  expected=$1
  actual=$2

  if [ "$expected" != "$actual" ]
  then
    echo "ERROR"
    echo "expected: $1. but got: $2"
    echo $3
    exit 1
  fi
}
