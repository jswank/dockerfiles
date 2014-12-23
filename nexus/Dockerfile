FROM       dockerfile/java:oracle-java7
MAINTAINER Sonatype <cloud-ops@sonatype.com>

ENV SONATYPE_WORK /sonatype-work

RUN mkdir -p /opt/sonatype/nexus \
  && curl --fail --silent --location --retry 3 \
    http://download.sonatype.com/nexus/professional-bundle/nexus-professional-2.11.1-01-bundle.tar.gz \
  | gunzip \
  | tar x -C /tmp nexus-professional-2.11.1-01 \
  && mv /tmp/nexus-professional-2.11.1-01/* /opt/sonatype/nexus/ \
  && rm -rf /tmp/nexus-professional-2.11.1-01 

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

