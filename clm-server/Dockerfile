FROM jswank/oracle-jdk7
MAINTAINER Jason Swank <docker@scalene.net>

# The version of clm-server to install
ENV CLM_VERSION 1.12.0-04

# Where clm-server writes data- should be persistent storage
ENV SONATYPE_WORK /sonatype-work

# Where to install clm-server
ENV INSTALL_DIR /opt/sonatype/clm-server

RUN mkdir -p ${INSTALL_DIR} \
  && curl --fail --silent --location --retry 3 \
    http://download.sonatype.com/clm/server/sonatype-clm-server-${CLM_VERSION}-bundle.tar.gz \
  | gunzip \
  | tar x -C ${INSTALL_DIR} sonatype-clm-server-${CLM_VERSION}.jar

RUN adduser -h "${SONATYPE_WORK}" -g "clm role account" -s /bin/false -S -u 200 clm-server

VOLUME ${SONATYPE_WORK}

RUN mkdir ${SONATYPE_WORK}/log && chown -R clm-server ${SONATYPE_WORK}/log

ADD ./config.yml ${SONATYPE_WORK}/config.yml

ENV JVM_OPTIONS -server -XX:MaxPermSize=128m
EXPOSE 8070
EXPOSE 8071
USER clm-server
WORKDIR /opt/sonatype/clm-server
CMD java ${JVM_OPTIONS} -jar sonatype-clm-server-${CLM_VERSION}.jar server ${SONATYPE_WORK}/config.yml
