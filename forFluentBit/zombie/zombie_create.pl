#!/usr/bin/perl
use strict;
use warnings;
print "parent $$\n";
my $pid = fork();
die "Could not fork $!\n" if not defined $pid;

if (not $pid) {
  print "in child: $$\n";
  exit;
}

print "In parent $$ child: $pid\n";
sleep 1;
system "ps -lef |grep perl";
sleep 1000;
__END__
https://slides.code-maven.com/linux/zombie-demonstration
