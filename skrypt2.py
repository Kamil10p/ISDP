import sys
import wexpect

cmd = wexpect.spawn('cmd.exe', timeout=3)
cmd.logfile = sys.stdout
cmd.expect('>')
cmd.sendline(r'mkdir SortingTable_debug\target')
cmd.expect('>')
cmd.sendline(
    r"javac SortingTable_debug\src\main\java\pl\lodz\p\it\isdp\SortTabNumbers.java .\SortingTable_debug\src\main\java\pl\lodz\p\it\isdp\Start.java -d .\SortingTable_debug\target")
cmd.expect('>')
cmd._spawn("jdb -classpath ./SortingTable_debug/target -sourcepath "
           "./SortingTable_debug/src/main/java  pl.lodz.p.it.isdp.Start 10")
cmd.expect('>')
cmd.sendline("stop in pl.lodz.p.it.isdp.SortTabNumbers.<init>")
cmd.expect('>')
cmd.sendline("run")
cmd.expect('Breakpoint hit: ')
cmd.sendline("trace method exit")
cmd.expect('main.. ')
cmd.sendline("cont")
cmd.expect('main.. ')
cmd.sendline("eval tab[" + str(0) + "]")
cmd.expect('main.. ')
cmd.sendline("eval tab[" + str(1) + "]")
cmd.expect('main.. ')
cmd.sendline("eval tab[" + str(2) + "]")
cmd.expect('main.. ')
cmd.expect(wexpect.EOF)

