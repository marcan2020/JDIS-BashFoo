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
mkdir -p bin
cat scripts/$challenge.sh |
  sed s/FLAG1/$flags[2]/g |
  sed s/FLAG2/$flags[3]/g |
  sed s/USER/$jdis_user/g > bin/$challenge.sh

echo "[+] Adding challenge: users count (/etc/passwd)"
echo "[+] Adding users"
useradd --create-home alice
useradd --create-home bob
useradd --create-home eve
useradd --create-home $jdis_user -p $jdis_password

echo "[*] Setting users count flag"
set_users_count_flag

echo "Printing flags"
print_flags
