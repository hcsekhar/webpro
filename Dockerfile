FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/sresrinivas/webpro.git
FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone  /app/webpro /app
RUN mvn package
FROM tomcat:7-jre7
ADD settings.xml /usr/local/tomcat/conf/
ADD tomcat-users.xml  /usr/local/tomcat/conf
COPY --from=build /app/target/webpro-1.0.war /usr/local/tomcat/webapps
