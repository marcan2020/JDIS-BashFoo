#!/bin/bash
# This should setup a classic Debian server for the CTF.

if [ "$EUID" -ne 0 ]
  then echo "[!] Please run as root"
  exit
fi

echo "Setup Starting..."

echo "[+] Initializing constants"

flags[0]='JDIS{IcanDols}'
flags[1]='JDIS{IcanDolsEvenMore}'
flags[2]='JDIS{LearningMyWayAroundLinux}'
flags[3]='JDIS{WhyWouldYouTakeMyFlagAway...}'
flags[4]='JDIS{TODO_NOT_THE_FLAG_TODO}'
flags[5]='JDIS{OneFlagToRuleThemAll}'
flags[6]='JDIS{ImSoHappyToTalkToYou}'
flags[7]='JDIS{SimpleHTTPServerAtYourService}'
flags[8]='JDIS{Finally...IWasCallingYouForWeeks}'
flags[9]='JDIS{DoYouKnowWhereAliceWent?}'
flags[10]='JDIS{ClassicPrivesc}'
flags[11]='JDIS{WellDoneL33TH4X0R}'

jdis_user="jdis"
jdis_password='WelcomeToUdeS'
script_path=`pwd`

echo "[+] Defining functions"

set_users_count_flag () {
  x=$(cat /etc/passwd | wc -l | tr -d '\n' | md5sum | awk -v ORS= '{print $1}')
  flags[4]=JDIS{$x}
}

print_flags () {
  for flag in ${flags[*]}; do echo $flag; done
}

echo "[+] Adding challenge: ls"
echo flags[0] > /home/$jdis_user/flag.txt

echo "[+] Adding challenge: hidden flag"
echo flags[1] > /home/$jdis_user/.flag.txt

echo "[+] Adding challenge: create directory"
challenge="tmp_directory_challenge"
chmod 333 /tmp # Remove directory listing from tmp
mkdir -p /root/chalenges/
cat challenges/$challenge.sh |
  sed s/FLAG1/$flags[2]/g |
  sed s/FLAG2/$flags[3]/g |
  sed s/USER/$jdis_user/g > /root/challenges/$challenge.sh

echo "[+] Adding challenge: users count (/etc/passwd)"
echo "[+] Adding users"
useradd --create-home alice
useradd --create-home bob
useradd --create-home eve
useradd --create-home $jdis_user -p $jdis_password

echo "[*] Setting users count flag"
set_users_count_flag

echo "[+] Adding challenge: find the good one"
path="/home/eve/"
mkdir -p $path
cd $path
mkdir -p {a..h}/{i..p}/{q..z}
cp $script_path/resources/fake_flags.txt /tmp/fake_flags_with_good_flag.txt
# Add real flag to fake flags mulitple times to mess up thing a bit
echo $flag[5] >> /tmp/fake_flags_with_good_flag.txt
echo $flag[5] >> /tmp/fake_flags_with_good_flag.txt
echo $flag[5] >> /tmp/fake_flags_with_good_flag.txt
find -mindepth 1 -type d -exec bash -c 'for i in {1..2}; do shuf /tmp/resources/fake_flags_with_good_flag.txt -n $((RANDOM%15+5)) >> {}/$RANDOM.txt; done' \;
find -mindepth 1 -type d -exec bash -c 'shuf $script_path/resources/fake_flags.txt -n $((RANDOM%30+5)) >> {}/$RANDOM' \;
echo $flag[5] >> `find ./b/o/y/ -not -name '*.txt' -type f | head -n 1`
find -mindepth 2 -type f -exec bash -c 'shuf $script_path/resources/fake_flags.txt -n $((RANDOM%10+5)) >> {}' \;
rm /tmp/fake_flags_with_good_flag.txt
chmod -R 755 $path

echo "[+] Adding the challenge: Learning nc"
path="/root/challenges/challenge7/"
mkdir -p $path
cd $path
echo $flag[6] > flag.txt
cp $script_path/challenges/challenge7.py freeflag.py

echo "[+] Adding the challenge: Learning wget"
path="/root/challenges/challenge8/"
mkdir -p $path
cd $path
cp -r $script_path/resources/resources/starwars_website/* .
echo $flag[7] > starwars_files/flag.txt

echo "[+] Adding the challenge: Learning enumeration"
path="/opt/likeasir/"
mkdir -p $path
cd $path
cp $script_path/challenges/challenge9.pl likeasir.pl
echo $flag[8] > flag.txt
chmod 600 flag.txt

echo "[+] Adding the challenges: sudo for fun"
path="/home/bob"
cd $path
echo $flag[9] > flag.txt
echo $flag[10] > bang.txt
echo "$jdis_user (ALL)=(bob) NOPASSWD:`which vim`" > /etc/sudoers

echo "Printing flags"
print_flags
