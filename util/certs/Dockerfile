FROM eclipse-temurin:17-jre-focal


WORKDIR /opt/certs
COPY add_cert_to_truststore.sh /opt/certs/add_cert_to_truststore.sh

ENTRYPOINT ["./add_cert_to_truststore.sh"]
