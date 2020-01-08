#!/usr/bin/expect
set timeout 1
spawn mkdir ./SortingTable_debug/target
spawn javac ./SortingTable_debug/src/main/java/pl/lodz/p/it/isdp/SortTabNumbers.java ./SortingTable_debug/src/main/java/pl/lodz/p/it/isdp/Start.java -d ./SortingTable_debug/target
spawn jdb -classpath ./SortingTable_debug/target -sourcepath ./SortingTable_debug/src/main/java  pl.lodz.p.it.isdp.Start 10
expect ">"
send "stop in pl.lodz.p.it.isdp.SortTabNumbers.<init>\r"
expect ">"
send "run\r"
expect "Breakpoint hit: "
send "trace method exit\r"
expect -re "main.. "
send "cont\r"
expect -re "main.. "
for {set i 0} {$i < 10} {incr i 1} {
	send "eval tab\[$i\]\r"
	expect -re "main.. "
}
expect eof