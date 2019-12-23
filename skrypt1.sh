#!/usr/bin/expect
set timeout -1
spawn mkdir ./SortingTable_debug/target
spawn javac ./SortingTable_debug/src/main/java/pl/lodz/p/it/isdp/SortTabNumbers.java ./SortingTable_debug/src/main/java/pl/lodz/p/it/isdp/Start.java -d ./SortingTable_debug/target
spawn jdb -classpath ./SortingTable_debug/target -sourcepath ./SortingTable_debug/src/main/java  pl.lodz.p.it.isdp.Start 10
expect ">"
send "catch java.lang.ArrayIndexOutOfBoundsException\r"
expect ">"
send "run\r"
expect eof