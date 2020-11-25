FROM maven:3.6.3-jdk-8

COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn clean package

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=3s \
            --retries=3 \
            --start-period=15s \
            CMD curl -f http://127.0.0.1:8080 || exit 1

EXPOSE 8080
CMD mvn spring-boot:run
