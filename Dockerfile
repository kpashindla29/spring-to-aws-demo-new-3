FROM ubuntu:22.04

LABEL maintainer="Kishore Pashindla <kpashindla@albanybeck.com>"

# Set environment variables
ENV TOMCAT_VERSION=9.0.80 \
    CATALINA_HOME=/opt/tomcat \
    JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64 \
    PATH=$CATALINA_HOME/bin:$PATH \
    DEBIAN_FRONTEND=noninteractive

# Install JDK & wget packages in a single layer
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        openjdk-21-jdk \
        wget \
        && \
    # Clean apt cache to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install and configure Tomcat
RUN mkdir -p $CATALINA_HOME && \
    wget -q https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tar.gz && \
    tar xzf /tmp/tomcat.tar.gz -C /tmp && \
    cp -Rv /tmp/apache-tomcat-${TOMCAT_VERSION}/* $CATALINA_HOME && \
    rm -rf /tmp/apache-tomcat-${TOMCAT_VERSION} /tmp/tomcat.tar.gz && \
    # Remove default webapps for security
    rm -rf $CATALINA_HOME/webapps/*

# Create a non-root user to run Tomcat (security best practice)
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat && \
    chown -R tomcat:tomcat $CATALINA_HOME

# Copy your WAR file
COPY target/mysampleapp.war $CATALINA_HOME/webapps/ROOT.war

# Extract WAR file for faster startup (optional)
RUN cd $CATALINA_HOME/webapps && \
    mkdir -p ROOT && \
    cd ROOT && \
    jar -xf ../ROOT.war && \
    chown -R tomcat:tomcat $CATALINA_HOME/webapps

# Switch to tomcat user
USER tomcat

EXPOSE 8085

CMD ["catalina.sh", "run"]