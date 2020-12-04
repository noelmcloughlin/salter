#!/usr/bin/env bash

echo "ready .."
DOO=sudo && [ "$OSTYPE" == 'cygwin' ] && DOO=''
SALTER=https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh

curl -LO ${SALTER} && echo "steady .." && $DOO bash salter.sh add bootstrap -i && echo 'go ..' && $DOO bash salter.sh add salter

