#!/usr/bin/expect
set timeout -1
proc run {} {
	spawn jdb -classpath target/classes -sourcepath src/main/java pl.lodz.p.it.isdp.Start 50
	expect ">"
	send "run\r"
	expect "The application exited\n\r"
}

spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
set average_time [time {run} 4]
send_user "Average time for one run with 50 philosophers eating 100 meals each:\n"
send_user $average_time