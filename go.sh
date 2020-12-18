#!/usr/bin/env bash

SU=sudo && [ "$OSTYPE" == 'cygwin' ] && SU=''
SALTER=https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh
ARGS='BS_CURL_ARGS='

[[ -z "${https_proxy+x}" ]] || (BS_CURL_ARGS="-x ${https_proxy}" && ARGS="${ARGS}${BS_CURL_ARGS}")
curl ${BS_CURL_ARGS} -LO ${SALTER} && $SU bash $ARGS salter.sh add bootstrap -i && $SU bash ${ARGS} salter.sh add salter
