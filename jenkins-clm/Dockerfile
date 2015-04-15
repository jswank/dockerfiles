FROM dockerfile/java:oracle-java7
MAINTAINER Jason Swank <docker@scalene.net>

RUN apt-get update && apt-get install -y wget git curl zip && rm -rf /var/lib/apt/lists/*

ENV JENKINS_HOME /var/jenkins_home

# Jenkins is ran with user `jenkins`, uid = 1000
# If you bind mount a volume from host/vloume from a data container, 
# ensure you use same uid
RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins

# Jenkins home directoy is a volume, so configuration and build history 
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

# `/usr/share/jenkins/ref/` contains all reference configuration we want 
# to set on a fresh new installation. Use it to bundle additional plugins 
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d

COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

ENV JENKINS_VERSION latest

# could use ADD but this one does not check Last-Modified header 
# see https://github.com/docker/docker/issues/8331
RUN curl -L http://mirrors.jenkins-ci.org/war/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war

ENV JENKINS_UC https://updates.jenkins-ci.org

RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref

# install maven
RUN apt-get update \
    && apt-get install -y maven \
    && rm -rf /var/lib/apt/lists/*

# install CLM CI plugin
ENV CI_VERSION 2.13.0

RUN mkdir -p /usr/share/jenkins/ref/plugins \
    && curl --fail --silent --location --retry 3 \
    --output /usr/share/jenkins/ref/plugins/sonatype-clm-ci-${CI_VERSION}.hpi \
    http://download.sonatype.com/clm/ci/sonatype-clm-ci-${CI_VERSION}.hpi
     
# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

COPY jenkins.sh /usr/local/bin/jenkins.sh

USER jenkins
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]

