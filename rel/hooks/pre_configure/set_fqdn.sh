#!/bin/sh
echo "Setting HOSTNAME_FQDN"
export HOSTNAME_FQDN=$(hostname -f)
