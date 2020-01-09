#!/usr/bin/expect
set timeout -1
spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
spawn jdb -classpath target/classes -sourcepath src/main/java pl.lodz.p.it.isdp.Start 9
expect ">"
send "stop in pl.lodz.p.it.isdp.Start.main\r"
expect ">"
send "run\r"
expect "main"
send "fields pl.lodz.p.it.isdp.Start\r"
expect eof