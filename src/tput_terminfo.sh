
tput sc
tput cup 23 45
echo "input from tput/echo at 23/45"
tput rc

echo "hallo welt"
echo "zeile 2"
echo "zeile 3"
echo "ENDE"

sleep 2

tput sc

tput cuu1
tput cuu1
tput cuu1
tput cuu1

tput dl1
tput il1 
echo "zeile1"

tput rc


sleep 1
echo "foobar"
