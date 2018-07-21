source ./utils.sh

cha_workdir=./src
cha_testdir=./test
cha_outputdir=./target/test


numberOfTests=0
success=0
error=0

clean_folder cha_outputdir
create_target_folder cha_outputdir

for cha_testfile in $(find_test_files $cha_testdir)
do
    echo 'Datei gefunden...'
    echo $cha_testfile
    # copy src folder to target/test
    # alle functions mit test suchen

    # subshell öffnen
    # assert lib reinladen 

    # pro funktion
    # try catch 
    # #beforeTest Funktion suchen
  
    # try catch
    # Funktion aufrufen
  
    # try catch 
    # #afterTest Funktion suchen
  
    # ergebnis speichern

done

# report erzeugen
# wenn error > 0 exit 1
