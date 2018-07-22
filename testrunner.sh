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

# copy_src "$cha_srcdir" "${cha_outputdir}/${cha_srcdir}" 
copy_src "$cha_testdir" "${cha_outputdir}" 

for cha_testfile in $(find_test_files $cha_outputdir)
do
  source $cha_testfile
  echo "-------------------------------------"
  echo "START TESTFILE: $cha_testfile"
  echo "-------------------------------------"
  for test_func in $(find_test_functions $cha_testfile)
  do
    numberOfTests+=1
    (
      cd ${cha_outputdir}
      echo " o $test_func"
      # before methods?
      # assert lib reinladen
      # try catch
      eval "$test_func"
# ergebnis holen???
      # after methods?
      # ergebnis speichern
      echo ""
      echo "" 
    )
  done
  echo "END TESTFILE: $cha_testfile"
  echo "" 
  echo "" 
done

echo "================================================"
echo -e "Total: $numberOfTests \t success: $success \t error: $error"
echo "================================================"
# wenn error > 0 exit 1
