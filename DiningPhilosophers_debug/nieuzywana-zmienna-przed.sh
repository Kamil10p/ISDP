#!/usr/bin/expect
set timeout -1
spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
spawn jdb -classpath target/classes -sourcepath src/main/java pl.lodz.p.it.isdp.Start 9
expect ">"
send "watch pl.lodz.p.it.isdp.Start.THREADS_STATE_DELAY\r"
expect ">"
send "run\r"
expect eof