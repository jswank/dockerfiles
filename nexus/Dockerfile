FROM jswank/oracle-jdk7
MAINTAINER Jason Swank <docker@scalene.net>

# The version of nexus to install
ENV NEXUS_VERSION 2.11.0-02

# This is where nexus writes data- should be persistent storage
ENV SONATYPE_WORK /sonatype-work

# Where to install nexus
ENV INSTALL_DIR /opt/sonatype/nexus

RUN mkdir -p ${INSTALL_DIR} \
  && curl --fail --silent --location --retry 3 \
    http://download.sonatype.com/nexus/oss/nexus-${NEXUS_VERSION}-bundle.tar.gz \
  | gunzip \
  | tar x -C /tmp nexus-${NEXUS_VERSION} \
  && mv /tmp/nexus-${NEXUS_VERSION}/* ${INSTALL_DIR}/ \
  && rm -rf /tmp/nexus-${NEXUS_VERSION} \
  && sed -e "s|^nexus-work=.*|nexus-work=${SONATYPE_WORK}|" \
    -e "s|^nexus-webapp-context-path=.*|nexus-webapp-context-path=/|" \
    -i ${INSTALL_DIR}/conf/nexus.properties \
  && mkdir -p ${SONATYPE_WORK}

RUN adduser -h "${SONATYPE_WORK}" -g "nexus role account" -s /bin/false -S -u 200 nexus

VOLUME ${SONATYPE_WORK}

ENV JVM_OPTIONS -server -XX:MaxPermSize=192m -Djava.net.preferIPv4Stack=true -Xms256m -Xmx1g

EXPOSE 8081
USER nexus
WORKDIR ${INSTALL_DIR}
CMD java \
  ${JVM_OPTIONS} \
  -cp conf/:`(echo lib/*.jar) | sed -e "s/ /:/g"` \
  org.sonatype.nexus.bootstrap.Launcher ./conf/jetty.xml ./conf/jetty-requestlog.xml
