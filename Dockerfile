FROM openjdk:21

WORKDIR /usr/src/myapp

COPY renovate.json pom.xml mvnw mvnw.cmd format.xml /.mvn .
COPY target/*.war .

EXPOSE 8080

RUN chmod +x ./mvnw

CMD ["./mvnw", "cargo:run", "-P", "tomcat90"]
