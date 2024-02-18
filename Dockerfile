 FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/sresrinivas/webpro.git
FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
RUN mvn package 
COPY ./webpro-1.0-SNAPSHOT.war /app

FROM tomcat:7-jre7
ADD settings.xml /usr/local/tomcat/conf/
ADD tomcat-users.xml  /usr/local/tomcat/conf
COPY --from=build /app/webpro-1.0-SNAPSHOT.war /usr/local/tomcat/webapps
