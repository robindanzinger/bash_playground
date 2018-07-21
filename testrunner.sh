source ./lib/utils.sh

cha_srcdir="./lib"
cha_testdir="./test"
cha_outputdir="./target/test"

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
    for func in $(find_test_functions $cha_testfile)
    do

     # execute in own process / relative paths are wrong
     echo "execute func $func of file $cha_testfile"
     # before methods?
     # subshell öffnen
     # assert lib reinladen
     # try catch
     eval "$func"
     # after methods?
     # ergebnis speichern
    done 

done

# report erzeugen
# wenn error > 0 exit 1
