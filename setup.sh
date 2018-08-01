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

jdis_password='WelcomeToUdeS'

echo "[+] Defining functions"

add_user () {
  echo "[+] Adding user $1"
  useradd --create-home $1
}

add_user_with_password () {
  echo "[+] Adding user $1"
   $2
}

set_users_count_flag () {
  x=$(cat /etc/passwd | wc -l | tr -d '\n' | md5sum | awk -v ORS= '{print $1}')
  flags[4]=JDIS{$x}
}

print_flags () {
  for flag in ${flags[*]}; do echo $flag; done
}

echo "[+] Adding users"
useradd --create-home alice
useradd --create-home bob
useradd --create-home eve
useradd --create-home jdis -p $jdis_password

echo "[*] Setting users count flag"
set_users_count_flag

echo "Printing flags"
print_flags
