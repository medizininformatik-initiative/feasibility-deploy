#!/usr/bin/env bash

i=0
for f in /opt/certs/your_certs/*.pem; do
  if [ -f "$f" ]; then
      echo "Importing additional certificate at $f into truststore."

      keytool -importcert -file "${f}" -alias "additional-cert-${i}" -storepass changeit -noprompt \
          -cacerts

      if [[ $? -ne 0 ]]; then
        echo "Importing additional certificate at $f into truststore failed."
        exit 1
      fi

      i=$((i+1))
  fi
done

echo -n "Copying truststore to output directory..."
cp $JAVA_HOME/lib/security/cacerts /opt/certs/output/

if [[ $? -ne 0 ]]; then
  echo "FAILED"
else
  echo "OK"
fi
