source ./lib/utils.sh

cha_srcdir="./lib"
cha_testdir="./test"
cha_outputdir="./target/test"

typeset -i numberOfTests success error
numberOfTests=0
success=0
error=0

clean_folder $cha_outputdir
create_target_folder $cha_outputdir

copy_src "$cha_srcdir" "${cha_outputdir}/${cha_srcdir}" 
copy_src "$cha_testdir" "${cha_outputdir}" 

echo "chadobash 0.0.1"
echo ""
cd ${cha_outputdir}

for cha_testfile in $(find_test_files './')
do
  execute_tests $cha_testfile
done

echo "================================================"
echo -e "Total: $numberOfTests \t success: $success \t error: $error"
echo "================================================"

if (( error > 0))
then 
  exit 1
else
  exit 0
fi
# wenn error > 0 exit 1
