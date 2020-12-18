#!/usr/bin/env bash

SU='sudo -E' && [ "$OSTYPE" == 'cygwin' ] && SU=''
SALTER=https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh
BS_CURL_IPV="${BS_CURL_IPV:-'--ipv4'}"

[[ -z "${https_proxy+x}" ]] || export BS_CURL_ARGS="-x ${https_proxy} ${BS_CURL_IPV}"
curl ${BS_CURL_ARGS} -LO ${SALTER} && $SU bash salter.sh add bootstrap -i && $SU bash salter.sh add salter
