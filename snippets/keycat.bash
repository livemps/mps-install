#!/bin/bash

if [ -f ~/.ssh/id_rsa.pub ] ; then
    cat ~/.ssh/id_rsa.pub
else
    echo "No pubkey available"
fi

