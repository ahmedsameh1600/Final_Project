FROM openjdk:21

WORKDIR /usr/src/myapp

COPY . .

EXPOSE 8080

RUN chmod +x ./mvnw

CMD ["./mvnw", "cargo:run", "-P", "tomcat90"]
