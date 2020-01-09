#!/usr/bin/expect
set timeout -1
spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
spawn jdb -classpath target/classes -sourcepath src/main/java pl.lodz.p.it.isdp.Start abc
expect ">"
send "catch java.lang.NumberFormatException\r"
expect ">"
send "run\r"
expect "Exception occurred"
send "step up\r"
expect eof