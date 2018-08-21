#!/usr/bin/perl
use strict;
use warnings;
use IO::Socket::INET;

# auto-flush on socket
$| = 1;

my $EOL = "\015\012";

local $/ = undef;
open FILE, "flag.txt" or die "Couldn't open file: $!";
binmode FILE;
my $flag = <FILE>;
close FILE;

while(1){
  sleep(2);

  # create a connecting socket
  my $socket = new IO::Socket::INET (
    PeerHost => '127.0.0.1',
    PeerPort => '31337',
    Proto => 'tcp',
  );

  next if not $socket;
  #print "connected to the server\n";

  # notify server that request has been sent
  #shutdown($socket, 1);

  # receive a response of up to 1024 characters from server
  my $response = "";
  $socket->recv($response, 1024);
  #print "received response: $response\n";

  if ($response eq "Hello Sir") {
    # data to send to a server
    my $req = $flag;;
    my $size = $socket->send($req);
    #print "sent data of length $size\n";
  } else {
    my $req = 'Be more polite...'.$EOL;;
    my $size = $socket->send($req);
  }

  $socket->close();
}
