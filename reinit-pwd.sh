#!/bin/bash

echo "Kerberos sidecar container is started at $(date)."

PASSWORD=`cat $SECRETS/password`

if [ -z ${PRINCIPAL+x}]; then PRINCIPAL=`cat $SECRETS/principal`; fi


while true; do
  echo "*** Trying to kinit at $(date). ***"
  echo $PASSWORD | kinit "$PRINCIPAL"

  result=$?
  if [ "$result" -eq 0 ]; then
    echo "kinit is successfull. Sleeping for $REKINIT_PERIOD seconds."
  else
    echo "kinit is exited with error. result code: $result"
    exit 1
  fi

  sleep "$REKINIT_PERIOD"
done