#!/usr/bin/expect
set timeout -1
spawn mvn compile
expect "\\\[INFO\\\] BUILD SUCCESS"
spawn jdb -classpath target/classes -sourcepath src/main/java  pl.lodz.p.it.isdp.Start 10
set main_prompt "main\\\[?\\\] "
expect ">"
send "stop in pl.lodz.p.it.isdp.SortTabNumbers.swap\r"
expect ">"
send "run\r"
expect $main_prompt
send "trace method exit\r"
expect $main_prompt
send "set i = 0\r"
expect $main_prompt
send "set j = 1\r"
expect $main_prompt
send "set tab\[i\] = 10\r"
expect $main_prompt
send "set tab\[j\] = 14\r"
expect $main_prompt
send "print tab\[i\]\r"
expect $main_prompt
send "print tab\[j\]\r"
expect $main_prompt
send "cont\r"
expect $main_prompt
send "print tab\[i\]\r"
expect $main_prompt
send "print tab\[j\]\r"
expect $main_prompt