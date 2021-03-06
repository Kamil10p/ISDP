#!/usr/bin/expect
set timeout 1
spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
spawn jdb -classpath ./target/classes -sourcepath ./src/main/java  pl.lodz.p.it.isdp.Start 3
expect ">"
send "stop in pl.lodz.p.it.isdp.SortTabNumbers.sort\r"
expect ">"
send "run\r"
expect -re "main... "
send "dump tab\r"
expect -re "main... "
send "list\r"
expect -re "main... "
for {set i 0} {$i < 3} {incr i 1} {
	send "set tab\[$i\] = 5\r"
	expect -re "main... "
}
expect -re "main... "
send "dump tab\r"
expect -re "main... "
send "step\r"
expect -re "main... "
send "step\r"
expect -re "main... "
send "list\r"
expect -re "main... "
send "eval i\r"
expect -re "main... "
send "eval j\r"
expect -re "main... "
send "eval tab\[i\]\r"
expect -re "main... "
send "eval tab\[j\]\r"
expect -re "main... "
send "step\r"
expect -re "main... "
send "list\r"
expect -re "main... "
