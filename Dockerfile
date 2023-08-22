#
## For Java 8, try this
## FROM openjdk:8-jdk-alpine
#
## For Java 11, try this
#FROM openjdk:17-oracle
#
## Refer to Maven build -> finalName
#ARG JAR_FILE=target/spring-boot-test-build.jar
## cd /opt/app
#WORKDIR /app
#COPY ${JAR_FILE} app.jar
#
## java -jar /opt/app/app.jar
#ENTRYPOINT ["java","-jar","app.jar"]


FROM maven:3.8.3-openjdk-17 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package


FROM openjdk:17-oracle

LABEL mentainer="spring-boot-test-build"

WORKDIR /app

COPY --from=build /home/app/target/spring-boot-test-build.jar /app/coffeeshop.jar

ENTRYPOINT ["java", "-jar", "coffeeshop.jar"]