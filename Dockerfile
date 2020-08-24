 FROM ubuntu:16.04 
MAINTAINER "pp5577488@gmail.com"
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr
ADD apache-tomcat-8.5.38.tar.gz /root
COPY target/mydemo-1.0-SNAPSHOT.jar /root/apache-tomcat-8.5.38/webapps
EXPOSE 8080
ENTRYPOINT /root/apache-tomcat-8.5.38/bin/startup.sh && bash

