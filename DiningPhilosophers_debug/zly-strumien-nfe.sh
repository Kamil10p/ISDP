#!/usr/bin/expect
set timeout -1
spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
spawn jdb -classpath DiningPhilosophers_debug/target/classes -sourcepath DiningPhilosophers_debug/src/main/java pl.lodz.p.it.isdp.Start abc
expect ">"
send "catch java.lang.NumberFormatException\r"
expect ">"
send "step up"
expect eof