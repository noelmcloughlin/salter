#!/usr/bin/env bash

SU=sudo && [ "$OSTYPE" == 'cygwin' ] && SU=''
SALTER=https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh

[[ -z "${https_proxy+x}" ]] || export BS_CURL_ARGS="-x ${https_proxy}"
curl ${BS_CURL_ARGS} -LO ${SALTER} && $SU bash ${BS_CURL_ARGS} salter.sh add bootstrap -i && $SU bash ${BS_CURL_ARGS} salter.sh add salter
