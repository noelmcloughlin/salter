#!/usr/bin/env bash

echo "ready .."
SU=sudo && [ "$OSTYPE" == 'cygwin' ] && SU=''
SALTER=https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh

[[ -z "${https_proxy+x}" ]] || export BS_CURL_ARGS="-x ${https_proxy}"
curl ${BS_CURL_ARGS} -LO ${SALTER} && echo "steady .." && $SU bash salter.sh add bootstrap -i && echo 'go ..' && $SU bash salter.sh add salter
