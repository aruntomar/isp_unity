#!/usr/bin/env bash
#------------------------------------------------------------------------------------------
# Author        : Swati A. Rananaware
# Date          : 30-04-2012
# Purpose       : Install Ispunity gem.
# Description   : Install rvm and then ruby 1.9.3. Finally install Ispunity gem. 
# For		: Ispunity
#------------------------------------------------------------------------------------------

CYAN="\033[0;36m"
GREEN="\033[1;34m"
NOCOLOR="\033[0m"

echo -en "$CYAN Please run this script as root user so that all dependencies will be installed through script$NOCOLOR\n\n"

if [ -f /etc/redhat-release ]
then
  yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel
else
  apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion
fi

if [ "$1" != "--without-rvm" ]
then
  echo -en "\n$CYAN Gem Ispunity requires ruby 1.9.3.\
	\n By default, this script will install RVM with ruby 1.9.3\
	\n If you have ruby 1.9.3 installed, you can chose to install gem ispunity directly.\
	\n Using $GREEN./ispunity --without-rvm$NOCOLUR $CYAN or Say no for rvm installation below $NOCOLOR\n\n"
  read -p "Do you want to continue to install rvm ?? (y|n) : " ch
case $ch in
  'y'|'Y')
	# Install RVM	
	echo -en "\n\n$CYAN Installing rvm.........$NOCOLOR\n\n"
	curl -L get.rvm.io | bash -s stable
	source /etc/profile.d/rvm.sh
	#Install ruby 1.9.3
	rvm install 1.9.3-p125
	rvm use 1.9.3-p125;;

  'n'|'N')
	;;
  *)
	echo -en "\n\n$CYAN Wrong Option. Should be 'y' or 'n'"
	echo -en " Exiting the scipt execution$NOCOLOR\n"
	exit;;
esac
fi

echo -en "\n\n$CYAN Installing ispunity $NOCOLOR\n\n"

# Install gem ispunity
gem install ispunity

