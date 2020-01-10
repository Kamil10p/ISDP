#!/usr/bin/expect
set timeout -1
proc onDeadlock {} {
set timeout -1
send "suspend\r"
expect ">"
send "threadlocks all\r"	
expect ">"
}

spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
spawn jdb -classpath target/classes -sourcepath src/main/java pl.lodz.p.it.isdp.Start 2
expect ">"
send "run\r"

set timeout 2
expect {
	"Wątek" exp_continue
	timeout onDeadlock	
}