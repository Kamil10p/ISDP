#!/usr/bin/expect
set timeout -1
spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
spawn jdb -classpath ./target/classes -sourcepath ./src/main/java  pl.lodz.p.it.isdp.Start 10
expect ">"
send "catch java.lang.ArrayIndexOutOfBoundsException\r"
expect ">"
send "run\r"
expect eof