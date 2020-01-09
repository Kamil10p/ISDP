#!/usr/bin/expect
set timeout 3
spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
spawn jdb -classpath ./target/classes -sourcepath ./src/main/java  pl.lodz.p.it.isdp.Start 10
expect ">"
send "stop in pl.lodz.p.it.isdp.SortTabNumbers.sort\r"
expect ">"
send "run\r"
expect -re "main... "
for {set i 0} {$i < 10} {incr i 1} {
	send "eval tab\[$i\]\r"
	expect -re "main... "
}
send "step up\r"
expect "if"
expect -re "main.. "
for {set i 0} {$i < 10} {incr i 1} {
	send "eval sortExample.tab\[$i\]\r"
	expect "main... "
}
expect eof
