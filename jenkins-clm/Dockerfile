FROM jenkins:latest
MAINTAINER Jason Swank <docker@scalene.net>

USER root 
RUN apt-get update \
    && apt-get install -y maven \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/WEB-INF/plugins \
    && cd /tmp/WEB-INF/plugins \
    && curl --fail --silent --location --retry 3 --remote-name \
    http://download.sonatype.com/clm/ci/sonatype-clm-ci-2.11.6.hpi \
    && jar -uvf /usr/share/jenkins/jenkins.war -C /tmp WEB-INF \
    && rm -rf /tmp/WEB-INF \
    && chmod 644 /usr/share/jenkins/jenkins.war

# drop back to the regular jenkins user - good practice
USER jenkins
