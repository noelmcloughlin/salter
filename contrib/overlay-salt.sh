#!/usr/bin/env bash
#----------------------------------------------------------------
# Copyright 2019 Saltstack Formulas
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Original from: https://github.com/saltstack-formulas/salter
#----------------------------------------------------------------

# Overlay salter with any git repo. Extend Salter by exposing
# your salt files in this directory structure:
#
#   - ./profiles/
#   - ./configs/
#   - ./scripts/
#
# Your content overlay Salter's directory hierarchy, extending
# Salter's features and overriding default salt configuration.
#
##################################################################
# bash version must be modern
RC=0
declare -A your solution fork 2>/dev/null || RC=$?
if (( RC > 0 )) && [ "$( uname )" = "Darwin" ]; then
    echo "[warning] your bash version is too old ..."
    # macos needs homebrew (unattended https://github.com/Homebrew/legacy-homebrew/issues/46779#issuecomment-162819088)
    export USER=$( stat -f "%Su" /dev/console )
    export HOMEBREW=/usr/local/bin/brew
    ${HOMEBREW} >/dev/null 2>&1
    (( $? == 127 )) && su - ${USER} -c 'echo | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
    # macos needs modern bash
    (( RC > 0 )) && (su - ${USER} -c "${HOMEBREW} install bash" || exit 12) && RC=0
fi
if (( RC > 0 )); then
    # linux needs modern bash
    echo "[error] your bash version is too old ..."
    exit ${RC}
fi

# merge unrelated repos
GIT="$( which git)"
${GIT} config user.email "not@important.com"                                   ##keep everyone happy
${GIT} config user.name "not important"
${GIT} init                                                                    ##forget our history
${GIT} remote remove salter
${GIT} remote add salter https://github.com/noelmcloughlin/salter.git          ##overlay salter repo
${GIT} pull salter master --allow-unrelated-histories -f >/dev/null || RC=$?   ##typically master branch
# problem
if (( RC > 0 )) && [ "$( uname )" = "Darwin" ]; then
    ## macos issue https://stackoverflow.com/questions/15371925/how-to-check-if-command-line-tools-is-installed
    /usr/bin/xcode-select -p 1>/dev/null && RC=$?
    (( $RC > 0 )) && /usr/bin/xcode-select --install && RC=0
fi
# no problem
if (( RC == 0 )); then
    FILE_ROOTS=/srv/salt && [ -d /usr/local/etc/salt/states ] && FILE_ROOTS=/usr/local/etc/salt/states
    TARGET_DIR=${FILE_ROOTS}/namespaces/your
    mkdir -p ${TARGET_DIR}/contrib ${TARGET_DIR}/file_roots ${TARGET_DIR}/pillar_roots 2>/dev/null

    cp -Rp ./scripts/* ${TARGET_DIR}/contrib/ 2>/dev/null                   ##Your contrib
    cp -Rp ./profiles/* ${TARGET_DIR}/file_roots/ 2>/dev/null               ##Your profiles/highstatesa ..
    cp -Rp ./configs/* ${TARGET_DIR}/pillar_roots/ 2>/dev/null              ##Your pillar data ..
    rm -fr ./scripts ./profiles ./configs 2>/dev/null                       ##cleanup local dirs
    ${GIT} init                                                                ##forget what just happened
else
    # problem
    echo "Error - something is wrong - ensure your OS is uptodate (git 2.9 or later) and network is up"
    exit ${RC} 
fi

## Check for a contributed/custom salter.sh script
[ -f /tmp/mysalter.sh ] && cp /tmp/mysalter.sh contrib/salter.sh                  ## developers?
[ -f contrib/salter.sh ] && mv contrib/salter.sh salter.sh && chmod +x salter.sh  ## integrators?
 
## modern bash plus salt-bootstrap plus additions
./salter.sh bootstrap || exit 1
./salter.sh add salter || exit 1

## copy/overlay formulas found in ./formulas/ local directory
SOURCE_DIR=formulas
if [ -d "${SOURCE_DIR}" ]; then
    mkdir -p ${TARGET_DIR} 2>/dev/null
    for formula in $( ls ./${SOURCE_DIR}/ 2>/dev/null | grep '\-formula' | awk -F'-' '{print $1}' )
    do
        if [ -d "${SOURCE_DIR}/${formula}-formula/${formula}" ]; then
            rm -fr ${TARGET_DIR}/${formula}-formula ${FILE_ROOTS}/${formula} 2>/dev/null               ##cleanup
            mv ${SOURCE_DIR}/${formula}-formula ${TARGET_DIR}/                                         ##integrate
            ln -s  ${TARGET_DIR}/${formula}-formula/${formula} ${FILE_ROOTS}/${formula} 2>/dev/null    ##symlink
        fi
    done
fi

## Check status/cleanup
rm ./salter.sh 2>/dev/null
echo "Salter script linked to /usr/local/bin/salter.sh"
exit 0
