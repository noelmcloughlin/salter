#!/usr/bin/env bash
#########################################################
# Copyright (c) 2019 Overstock.com. All Rights Reserved.
#########################################################

### DEFAULTS
DEVUSER=''
loglevel='warning'
profile='menu'
SALTFS=/srv/salt
PILLARFS=/srv/pillar
PROFILEAPI=${SALTFS}/profiles
FORMULA_REPO=${SALTFS}/repo

usage()
{
    echo "Usage: sudo $0 [ options ]" 1>&2
    echo 1>&2
    echo "  [-l <all|debug|warning|error|quiet]" 1>&2
    echo "        Optionally specify log-level, default is warning" 1>&2
    echo 1>&2
    echo "  [-s <stack-name>]" 1>&2
    echo "        Named 'devstack' to install; Defaults to 'menu'." 1>&2
    echo 1>&2
    echo "  [-a <app-name>]" 1>&2
    echo "        Name 'appname' to install; Defaults to 'menu'." 1>&2
    echo 1>&2
    echo "  [-u <loginname>]" 1>&2
    echo "        Valid loginname (local or corporate user)." 1>&2
    echo 1>&2
    exit 0
}

### PREPARATION PHASE ###
mkdir -p ${FORMULA_REPO} ${PILLARFS} 2>/dev/null
rm -f ${PILLARFS}/* 2>/dev/null

[[ `id -u` != 0 ]] && usage

#parse commandline
while getopts ":u:l:s:a:" option; do
    case "${option}" in
    l)  l=${OPTARG}
        case ${l} in
        'all'|'garbage'|'trace'|'debug'|'info'|'warning'|'error'|'quiet') loglevel=${l}
           ;;
        *) loglevel='warning'
           ;;
        esac 
        ;;

    u)  DEVUSER=${OPTARG}
        [[ "${DEVUSER}" == "username" ]] && usage
        [[ -z "${DEVUSER}" ]] && usage
        ;;

    s)  profile=stacks/${OPTARG}
        ;;

    a)  profile=apps/${OPTARG}
        ;;

    *)  usage
        ;;
    esac
done
shift $((OPTIND-1))

##### PROFILE PHASE
echo "${profile}" | grep menu >/dev/null 2>&1
if (( $? == 0 ))
then
    ${SALTFS}/bin/menu.py menu || exit 11
else
    echo
    echo "custom choice [ $profile ] selected"
    [[ ! -f ${PROFILEAPI}/${profile} ]] && echo "Choice not found" && exit 1
fi

# Prepare salt pillars
cp ${PROFILEAPI}/${profile} ${SALTFS}/top.sls || exit 1

# User preferences: '/srv/salt/profiles/<username>_config.sls'
if [[ ! -f "${SALTFS}/profiles/${DEVUSER}_config.sls" ]]
then
    cp ${SALTFS}/profiles/config.sls ${SALTFS}/profiles/${DEVUSER}_config.sls
fi
cp ${SALTFS}/profiles/${DEVUSER}_config.sls ${PILLARFS}/${DEVUSER}.sls
echo "base:
  '*':
    - ${DEVUSER}" >${PILLARFS}/top.sls || exit 1

#### HACKS
if [[ "$OSTYPE" == darwin* ]]
then
    awk >/dev/null 2>&1
    if (( $? == 134 ))
    then
        #### From https://github.com/atomantic/dotfiles/issues/23#issuecomment-298784915 ###
        brew uninstall gawk
        brew uninstall readline
        brew install readline
        brew install gawk
    fi
fi


#### FORMULA PHASE
for formula in $( grep '^.* - ' ${PROFILEAPI}/${profile} |awk '{print $2}' |cut -d'.' -f1 |uniq )
do
    source=${formula}
    rm -fr ${FORMULA_REPO}/${formula} 2>/dev/null
    case ${formula} in
    example)   cp -Rp ${SALTFS}/etc/examplet clone https://git.example.com/internal/salt/example-formula ${FORMULA_REPO}/${formula}
               ;;
    *)         ## When formula and repo names differ, handle here ..
               [[ "${formula}" == "linuxvda" ]] && source='citrix-linuxvda'
               [[ "${formula}" == "pycharm" ]] && source='jetbrains-pycharm'
               [[ "${formula}" == "resharper" ]] && source='jetbrains-resharper'
               [[ "${formula}" == "goland" ]] && source='jetbrains-goland'
               [[ "${formula}" == "rider" ]] && source='jetbrains-rider'
               [[ "${formula}" == "datagrip" ]] && source='jetbrains-datagrip'
               [[ "${formula}" == "clion" ]] && source='jetbrains-clion'
               [[ "${formula}" == "rubymine" ]] && source='jetbrains-rubymine'
               [[ "${formula}" == "appcode" ]] && source='jetbrains-appcode'
               [[ "${formula}" == "webstorm" ]] && source='jetbrains-webstorm'
               [[ "${formula}" == "phpstorm" ]] && source='jetbrains-phpstorm'

               git clone https://github.com/saltstack-formulas/${source}-formula.git ${FORMULA_REPO}/${formula} >/dev/null 2>&1
               ;;
    esac
    (( $? != 0 )) && echo "Failed to clone/create ${FORMULA_REPO}/${formula}" && exit 13
    rm -f ${SALTFS}/${formula} 2>/dev/null
    ln -s ${FORMULA_REPO}/${formula}/${formula} ${SALTFS}/${formula} 2>/dev/null
done

#### USER PHASE
case "$OSTYPE" in
darwin*) grep -rl 'domainadm' ${PILLARFS} | xargs sed -i '' "s/domainadm/undefined_user/g" 2>/dev/null
         grep -rl 'undefined_user' ${PILLARFS} | xargs sed -i '' "s/undefined_user/${DEVUSER}/g" 2>/dev/null
         ;;
linux*)  grep -rl 'domainadm' ${PILLARFS} | xargs sed -i "s/domainadm/undefined_user/g" 2>/dev/null
         grep -rl 'undefined_user' ${PILLARFS} | xargs sed -i "s/undefined_user/${DEVUSER}/g" 2>/dev/null
         ;;
esac

#### WORKAROUND PHASE
CWD=$(pwd)
bash /tmp/saltdesktop_workarounds.cmd 2>/dev/null

# Forked formulas
CURRENT_FORKS=""
for formula in ${CURRENT_FORKS}
do
  if [[ -d "${FORMULA_REPO}/${formula}" ]]
  then
    rm -fr ${FORMULA_REPO}/${formula}* ${SALTFS}/${formula} 2>/dev/null
    if [[ "${formula}" == "linuxvda" ]]
    then
        git clone https://github.com/noelmcloughlin/citrix-${formula}-formula.git ${FORMULA_REPO}/${formula} >/dev/null 2>&1
    else
        git clone https://github.com/noelmcloughlin/${formula}-formula.git ${FORMULA_REPO}/${formula} >/dev/null 2>&1
    fi
    if (( $? == 0 ))
    then
        ln -s ${FORMULA_REPO}/${formula}/${formula} ${SALTFS}/${formula} 2>/dev/null
        cd ${FORMULA_REPO}/${formula}
        git checkout fixes >/dev/null 2>&1
        (( $? > 0 )) && echo "Failed to checkout ${formula} fixes branch" && exit 1
    fi
  fi
done

#### LOG PHASE
cd ${CWD}
LOGDIR=/tmp/saltdesktop/${profile}
mkdir -p ${LOGDIR} 2>/dev/null
LOG=${LOGDIR}/log.$( date '+%Y%m%d%H%M' )
echo "Logging to [ $LOG ]"
cat ${PILLARFS}/${DEVUSER}.sls >>${LOG} 2>&1

#### ORCHESTRATION PHASE
echo "Orchestrating things, please be patient ..."
salt-call state.highstate -l ${loglevel} --local --retcode-passthrough saltenv=base >> ${LOG} 2>&1

#### DISPLAY LOG PHASE
tail -8 ${LOG}
echo "See full log in [ $LOG ]"
echo
