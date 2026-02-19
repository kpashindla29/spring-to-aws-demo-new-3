FROM ubuntu:latest

LABEL maintainer="Kishore Pashindla <kpashindla@albanybeck.com>"

# Set environment variables
ENV TOMCAT_VERSION 9.0.80
ENV CATALINA_HOME /opt/tomcat
ENV JAVA_HOME /usr/lib/jvm/java-21-openjdk-amd64
ENV PATH $CATALINA_HOME/bin:$PATH

# Install JDK & wget packages
RUN apt-get update && \
    apt-get install -y openjdk-21-jdk wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install and configure Tomcat
RUN mkdir -p $CATALINA_HOME && \
    wget -q https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tar.gz && \
    tar xzf /tmp/tomcat.tar.gz -C /tmp && \
    cp -rv /tmp/apache-tomcat-${TOMCAT_VERSION}/* $CATALINA_HOME && \
    rm -rf /tmp/apache-tomcat-${TOMCAT_VERSION} /tmp/tomcat.tar.gz

# Change Tomcat port to 8085
RUN sed -i 's/port="8080"/port="8085"/g' $CATALINA_HOME/conf/server.xml

# Remove default webapps to clean up
RUN rm -rf $CATALINA_HOME/webapps/*

# Make sure Tomcat binaries are executable
RUN chmod +x $CATALINA_HOME/bin/*.sh

# Copy WAR file as ROOT.war for root context deployment
COPY target/mysampleapp.war $CATALINA_HOME/webapps/ROOT.war

# DON'T manually extract the WAR - let Tomcat do it
# DON'T change ownership - Tomcat runs as root in Docker

EXPOSE 8085

# Verify catalina.sh exists and is executable
RUN ls -la $CATALINA_HOME/bin/catalina.sh && $CATALINA_HOME/bin/catalina.sh version

CMD ["catalina.sh", "run"]