#!/bin/sh

cd /root/challenges && sh tmp_directory_challenge.sh > /dev/null &
cd /root/challenges/challenge7/ && python freeflag.py > /devnull &
cd /root/challenges/challenge8/ && python -m SimpleHTTPServer 4443 > /dev/null &
cd /opt/likeasir/ && ./likeasir.pl > /dev/null &
