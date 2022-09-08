#!/usr/bin/env bash

i=0
for f in /opt/certs/your_certs/*.pem; do
  if [ -f "$f" ]; then
      echo "Importing additional certificate at $f into truststore."

      if ! keytool -importcert -file "${f}" -alias "additional-cert-${i}" -storepass changeit -noprompt \
          -cacerts
      then
        echo "Importing additional certificate at $f into truststore failed."
        exit 1
      fi

      i=$((i+1))
  fi
done

echo -n "Copying truststore to output directory..."
if ! cp "$JAVA_HOME"/lib/security/cacerts /opt/certs/output/
then
  echo "FAILED"
else
  echo "OK"
fi
