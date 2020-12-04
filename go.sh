#!/usr/bin/env bash

DOO=sudo [ "$OSTYPE" == 'cygwin' ] && DOO=''
SALTER=https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh

curl -LO ${SALTER} && $DOO bash salter.sh add bootstrap -i && $DOO bash salter.sh add salter

