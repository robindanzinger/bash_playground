for datei in *.jpg
do
  echo $datei
  case "$datei" in
    \*.jpg) echo "Keine Datei zum Muster *.jpg vorhanden" ;;
    *) echo $datei ;;
  esac
done
