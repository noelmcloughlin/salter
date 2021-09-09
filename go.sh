#!/usr/bin/env bash

SU='sudo -E' && [ "$OSTYPE" == 'cygwin' ] && SU='' && USER="-u $(id -un)"
SALTER=https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh
BS_CURL_IPV="${BS_CURL_IPV:---ipv4}"
BS_CURL_ARGS=

[[ -z "${https_proxy+x}" ]] || export BS_CURL_ARGS="-x ${https_proxy} ${BS_CURL_IPV}"
curl ${BS_CURL_ARGS} -LO ${SALTER}
if (( $? == 0 )); then
    ${SU} bash salter.sh add bootstrap -i ${USER}
    ${SU} bash salter.sh add salter ${USER}
fi
