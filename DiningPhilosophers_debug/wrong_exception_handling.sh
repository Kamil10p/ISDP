#!/usr/bin/expect
set timeout -1
set main_prompt "main\\\[?\\\] "
proc check_exc {} {
	expect "\\\[?\\\]"
	send "list\r"
	expect "\\\[?\\\]"
	send "cont\r"
	expect "Aplication Exited"
}
proc check_lack {} {
	expect "Wątek"
	expect "Wątek"
}
spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
spawn jdb -classpath target/classes -sourcepath src/main/java pl.lodz.p.it.isdp.Start 3
expect ">"
send "stop in pl.lodz.p.it.isdp.PhilosopherRunnable.<init>\r"
expect ">"
send "stop in pl.lodz.p.it.isdp.Start\$1.uncaughtException\r"
expect ">"
send "run\r"
expect $main_prompt
send "set philosopher = null\r"
expect $main_prompt
send "clear pl.lodz.p.it.isdp.PhilosopherRunnable.<init>\r"
expect $main_prompt
send "cont\r"
expect "\\\[?\\\]"
send "step up\r"
set timeout 2
expect {
	timeout check_exc
	"Thread.java" check_lack
}
