#!/usr/bin/env bash
#########################################################
# Copyright (c) 2019 Overstock.com. All Rights Reserved.
#########################################################

USER=username
SALTFS=/srv/salt
[[ `id -u` != 0    ]] && echo "Run script with sudo, exiting" && exit 1

if [ -f "/usr/bin/zypper" ] || [ -f "/usr/sbin/pkg" ]; then
    # No major version pegged packages support
    RELEASE=""
else
    RELEASE='stable 2019.2.0'
fi

#parse commandline (not tested yet)
while getopts ":r:" option; do
    case "${option}" in
    r)  RELEASE='stable ${OPTARG}'
        ;;
    esac
done
shift $((OPTIND-1))

if [ `uname` = 'FreeBSD' ]
then
    SALTFS=/usr/local/etc/salt/states
    mkdir -p ${SALTFS} 2>/dev/null
fi

case "$OSTYPE" in
darwin*) OSHOME=/Users
         USER=$( stat -f "%Su" /dev/console )

         echo "Setup Darwin known good baseline ..."
         ### https://github.com/Homebrew/legacy-homebrew/issues/19670
         sudo chown -R ${USER}:admin /usr/local/*
         sudo chmod -R 0755 /usr/local/* /Library/Python/2.7/site-packages/pip* /Users/${USER}/Library/Caches/pip 2>/dev/null
 
         ### https://stackoverflow.com/questions/34386527/symbol-not-found-pycodecinfo-getincrementaldecoder
         su - ${USER} -c 'hash -r python'

         ### Secure install pip https://pip.pypa.io/en/stable/installing/
         su - ${USER} -c 'curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py'
         sudo python get-pip.py

         which brew | su - ${USER} -c '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
         su - ${USER} -c '/usr/local/bin/pip install --upgrade wrapper barcodenumber npyscreen'
         [[ ! -x /usr/local/bin/brew ]] && echo "Install homebrew (https://docs.brew.sh/Installation.html)" && exit 1
         
         echo "Install salt ..."
         /usr/local/bin/salt --version >/dev/null 2>&1
         if (( $? > 0 )); then
             su ${USER} -c 'brew install saltstack'
         else
             su ${USER} -c 'brew upgrade saltstack'
         fi
         su ${USER} -c 'brew unlink saltstack && brew link saltstack'
         su ${USER} -c 'brew tap homebrew/services'
         mkdir /etc/salt 2>/dev/null
         echo $( hostname ) >/etc/salt/minion_id
         cp /usr/local/etc/saltstack/minion /etc/salt/minion
         sed -i'orig' 's/#file_client: remote/file_client: local/' /etc/salt/minion

         ##Workaround https://github.com/Homebrew/brew/issues/4099
         echo '--no-alpn' >> ~/.curlrc
         export HOMEBREW_CURLRC=1
         ;;

freebsd*|linux*)
         OSHOME=/home
         echo "Setup Linux baseline and install saltstack masterless minion ..."
         if [ -f "/usr/bin/dnf" ]; then
             /usr/bin/dnf install -y --best --allowerasing python3-pip git wget redhat-rpm-config python3-devel || exit 1 
             pip3 install --upgrade --ignore-installed --pre wrapper barcodenumber npyscreen || exit 1
         elif [ -f "/usr/bin/yum" ]; then
             /usr/bin/yum install -y epel-release
             /usr/bin/yum install -y python34-pip git wget redhat-rpm-config python34-devel || exit 1 
             pip3.4 install --upgrade --ignore-installed --pre wrapper barcodenumber npyscreen || exit 1
         elif [ -f "/usr/bin/zypper" ]; then
             /usr/bin/zypper install -y git python3-PyYAML python3-devel python3-pip python3-curses || exit 1
             /usr/bin/zypper remove -y python2-pip 2>/dev/null
             pip install --upgrade --ignore-installed --pre wrapper barcodenumber npyscreen || exit 1
         elif [ -f "/usr/bin/apt-get" ]; then
             /usr/bin/apt autoremove -y
             /usr/bin/apt-get update --fix-missing
             ## https://github.com/pypa/pip/issues/5253 only install python-pip if pip is missing
             which pip || /usr/bin/apt-get install -y python3-pip
             /usr/bin/apt-get install -y git ssh wget python3-dev curl software-properties-common || exit 1
             /usr/bin/apt-add-repository universe
             /usr/bin/apt autoremove -y
             /usr/bin/apt-get update -y
             pip3 install --upgrade --ignore-installed --pre wrapper barcodenumber npyscreen || exit 1
         elif [ -f "/usr/bin/pacman" ]; then
             /usr/bin/pacman-mirrors -g
             /usr/bin/pacman -Syyu --noconfirm
             /usr/bin/pacman -S --noconfirm git python3-yaml python3-pip psutils || exit 1
             pip install --upgrade --ignore-installed --pre wrapper barcodenumber npyscreen || exit 1
         fi
         rm -f install_salt.sh 2>/dev/null
         wget -O install_salt.sh https://bootstrap.saltstack.com || exit 1
         (sh install_salt.sh -x python3 -P ${RELEASE} && rm -f install_salt.sh) || exit 1

         ### workaround for https://github.com/saltstack/salt-bootstrap/issues/1355
         ### and ensure python3 is systemd default python
         if [ -f "/usr/bin/dnf" ] || [ -f "/usr/bin/yum" ]; then
             rm /usr/bin/python 2>/dev/null; ln -s /usr/bin/python3 /usr/bin/python
         elif [ -f "/usr/bin/apt-get" ]; then
             /usr/bin/apt-get remove -y python2.7 python2.7-minimal || exit 1
             rm /usr/bin/python 2>/dev/null; ln -s /usr/bin/python3 /usr/bin/python
         elif [ -f "/usr/bin/zypper" ]; then
             rm /usr/bin/python 2>/dev/null; ln -s /usr/bin/python3 /usr/bin/python
         fi
         ;;
esac

echo "Clone salt-desktop ..."
[[ -d ${SALTFS} ]] && rm -fr ${SALTFS} 2>/dev/null
mkdir -p ${SALTFS} 2>/dev/null
git clone https://github.com/saltstack-formulas/salt-desktop.git ${SALTFS}
(( $? != 0 )) && echo "Cannot clone from github.com" && exit 111
cd ${SALTFS}

rm -f /usr/local/bin/devsetup 2>/dev/null
ln -s ${SALTFS}/bin/devsetup.sh /usr/local/bin/devsetup
echo
echo "For usage ideas visit ..."
echo " https://github.com/saltstack-formulas/salt-desktop#stack-profiles"
echo
echo "////////////////////////////////////////////////////////////////////////"
echo "///////////                                              ///////////////"
echo "///////////               Congratulations                ///////////////"
echo "///////////     Salt and Salt-Desktop are installed      ///////////////"
echo "///////////                                              ///////////////"
echo "////////////////////////////////////////////////////////////////////////"
echo
echo
exit 0
