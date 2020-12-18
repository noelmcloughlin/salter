#!/usr/bin/env bash

SU=sudo && [ "$OSTYPE" == 'cygwin' ] && SU=''
SALTER=https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh
export ARGS='BS_CURL_ARGS='

[[ -z "${https_proxy+x}" ]] || (BS_CURL_ARGS="-x ${https_proxy}" && ARGS="${ARGS}${BS_CURL_ARGS}")
curl ${BS_CURL_ARGS} -LO ${SALTER} && $SU $ARGS bash salter.sh add bootstrap -i && $SU ${ARGS} bash salter.sh add salter
