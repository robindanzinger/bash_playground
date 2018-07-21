# equal
function equal {
  expected=$1
  actual=$2

  if [ "$expected" != "$actual" ]
  then
    echo "ERROR"
    echo $3
    echo "$1"
    echo "$2"
    exit 1
  fi
}
