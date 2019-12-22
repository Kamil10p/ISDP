import sys
import wexpect

cmd = wexpect.spawn('cmd.exe')
cmd.logfile = sys.stdout
cmd.expect('>')
cmd.sendline(r'mkdir SortingTable_debug\target')
cmd.expect('>')
cmd.sendline(r"javac SortingTable_debug\src\main\java\pl\lodz\p\it\isdp\SortTabNumbers.java .\SortingTable_debug\src\main\java\pl\lodz\p\it\isdp\Start.java -d .\SortingTable_debug\target")
cmd.expect('>')
cmd._spawn("jdb -classpath ./SortingTable_debug/target -sourcepath "
                "./SortingTable_debug/src/main/java  pl.lodz.p.it.isdp.Start 10")
cmd.expect('>')
cmd.sendline("catch java.lang.ArrayIndexOutOfBoundsException")
cmd.expect('>')
cmd.sendline("run")
cmd.expect(wexpect.EOF)
cmd.sendline('exit')