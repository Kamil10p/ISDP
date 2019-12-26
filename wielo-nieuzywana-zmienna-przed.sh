#!/usr/bin/expect
set timeout -1
spawn mkdir DiningPhilosophers_debug/target
spawn javac -g DiningPhilosophers_debug/src/main/java/pl/lodz/p/it/isdp/model/PhilosopherModel.java DiningPhilosophers_debug/src/main/java/pl/lodz/p/it/isdp/model/TableModel.java DiningPhilosophers_debug/src/main/java/pl/lodz/p/it/isdp/PhilosopherRunnable.java DiningPhilosophers_debug/src/main/java/pl/lodz/p/it/isdp/Start.java -d DiningPhilosophers_debug/target
spawn jdb -classpath DiningPhilosophers_debug/target -sourcepath DiningPhilosophers_debug/src/main/java pl.lodz.p.it.isdp.Start 9
expect ">"
send "watch pl.lodz.p.it.isdp.Start.THREADS_STATE_DELAY\r"
expect ">"
send "run\r"
expect eof