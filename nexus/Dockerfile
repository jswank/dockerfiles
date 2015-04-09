FROM       dockerfile/java:oracle-java7
MAINTAINER Jason Swank <docker@scalene.net>

ENV SONATYPE_WORK /sonatype-work
NEXUS_VERSION 2.11.2-06

RUN mkdir -p /opt/sonatype/nexus \
  && curl --fail --silent --location --retry 3 \
    https://download.sonatype.com/nexus/professional-bundle/nexus-professional-${NEXUS_VERSION}-bundle.tar.gz \
  | gunzip \
  | tar x -C /tmp nexus-professional-${NEXUS_VERSION} \
  && mv /tmp/nexus-professional-${NEXUS_VERSION}/* /opt/sonatype/nexus/ \
  && rm -rf /tmp/nexus-professional-${NEXUS_VERSION}

RUN useradd -r -u 200 -m -c "nexus role account" -d /sonatype-work -s /bin/false nexus

VOLUME /sonatype-work

EXPOSE 8081
WORKDIR /opt/sonatype/nexus
USER nexus
CMD java \
  -server -XX:MaxPermSize=192m -Djava.net.preferIPv4Stack=true -Xms256m -Xmx1g \
  -Dnexus-work=/sonatype-work -Dnexus-webapp-context-path=/ \
  -cp conf/:`(echo lib/*.jar) | sed -e "s/ /:/g"` \
  org.sonatype.nexus.bootstrap.Launcher ./conf/jetty.xml ./conf/jetty-requestlog.xml

