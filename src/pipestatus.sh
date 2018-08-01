ls -l /etc/ | grep $1 | wc -l

status=${PIPESTATUS[*]}
set $status

echo "ls   : $1"
echo "grep : $2"
echo "wc   : $3"

if [ $1 -ne 0 ]; then
   echo "Fehler bei ls" >&2
fi
if [ $2 -ne 0 ]; then
   echo "Fehler bei grep" >&2
fi
if [ $3 -ne 0 ]; then
   echo "Fehler bei wc" >&2
fi
