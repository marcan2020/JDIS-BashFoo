#!/bin/sh

cd /root/challenges && ./tmp_directory_challenge.sh &
cd /root/challenges/challenge7/ && freeflag.py &
cd /root/challenges/challenge8/ && python -m SimpleHTTPServer 4443 &
