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
# Original work from: https://github.com/saltstack-formulas/salter
#----------------------------------------------------------------

# Overlay salter onto your repo/filesystem, assuming this structure
#
#   - ./profiles directory (copied to salt file_roots)
#   - ./configs directory (copied to salt pillar_roots)
#   - ./formulas directory (copied to salt file_roots); optional
#   - ./scripts/salter.sh (a customized installer); optional
#----------------------------------------------------------------
git config user.email "not@important.com"                                   ##keep git happy
git config user.name "not important"
git init                                                                    ##forget our history
git remote add salter https://github.com/noelmcloughlin/salter.git          ##overlay salter repo
git pull salt master --allow-unrelated-histories -f >/dev/null              ##typically master branch
if (( $? == 0 )); then
    ## your salt artifacts
    FILE_ROOTS=/srv/salt && [ -d /usr/local/etc/salt/states ] && FILE_ROOTS=/usr/local/etc/salt/states
    TARGET_DIR=${FILE_ROOTS}/namespaces/your
    mkdir -p ${TARGET_DIR}/contrib ${TARGET_DIR}/file_roots ${TARGET_DIR}/pillar_roots 2>/dev/null

    cp -Rp ./scripts/* ${TARGET_DIR}/contrib/                               ##Your contrib
    cp -Rp ./profiles/* ${TARGET_DIR}/file_roots/                           ##Your profiles/highstatesa ..
    cp -Rp ./configs/* ${TARGET_DIR}/pillar_roots/                          ##Your pillar data ..
    rm -fr ./scripts ./profiles ./configs 2>/dev/null                       ##cleanup local dirs
    git init                                                                ##forget what just happened
else
    [[ -x "/usr/bin/xcode-select" ]] && /usr/bin/xcode-select --install     ##possible macos issue
    echo "Error - something is wrong - ensure your OS is uptodate (git 2.9 or later) and network is up"
    exit 1 
fi

## Check for a contributed/custom salter.sh script and install salt
[ -f contrib/salter.sh ] && mv contrib/salter.sh salter.sh && chmod +x salter.sh
 
# macos needs brew installed
if [ "`uname`" = "Darwin" ]; then
    USER=$( stat -f "%Su" /dev/console )
    [ -x /usr/local/bin/brew ] | su - ${USER} -c '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
fi

# bash version must be modern
RC=0 && declare -A detect_modern_bash_version 2>/dev/null || RC=$?
(( RC > 0 )) && echo "[info] your bash version is really old - upgrade to a modern version"
(( RC > 0 )) && [ "`uname`" = "Darwin" ] &&  echo "[info] installing newer bash version ..." && su - ${USER} -c 'brew install bash'

## salt-bootstrap plus additions
RC=0 && ./salter.sh -i bootstrap || exit 1
RC=0 && ./salter.sh -i salter || exit 1

## overlay contributed/custom salt formulas
SOURCE_DIR=formulas
mkdir -p ${TARGET_DIR} 2>/dev/null
for formula in $( ls ./${SOURCE_DIR}/ 2>/dev/null | grep '\-formula' | awk -F'-' '{print $1}' )
do
    if [ -d "${SOURCE_DIR}/${formula}-formula/${formula}" ]; then
        rm -fr ${TARGET_DIR}/${formula}-formula ${FILE_ROOTS}/${formula} 2>/dev/null               ##cleanup
        mv ${SOURCE_DIR}/${formula}-formula ${TARGET_DIR}/                                         ##integrate
        ln -s  ${TARGET_DIR}/${formula}-formula/${formula} ${FILE_ROOTS}/${formula} 2>/dev/null    ##symlink
    fi
done

## Check status/cleanup
rm ./salter.sh 2>/dev/null
(( RC > 0 )) && echo "something is wrong" && exit ${RC}
echo "Salter script is installed at /usr/local/bin/salter.sh"
