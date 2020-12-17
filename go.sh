#!/usr/bin/env bash

echo "ready .."
DOO=sudo && [ "$OSTYPE" == 'cygwin' ] && DOO=''
SALTER=https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh

[[ -z "${https_proxy+x}" ]] || GETPROXY="-x ${https_proxy}"
curl ${GETPROXY} -LO ${SALTER} && echo "steady .." && $DOO bash salter.sh add bootstrap -i && echo 'go ..' && $DOO bash salter.sh add salter
rm salter.sh >/dev/null 2>&1

