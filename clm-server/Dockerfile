FROM       dockerfile/java:oracle-java7
MAINTAINER Jason Swank <docker@scalene.net>

ENV SONATYPE_WORK /sonatype-work
ENV CLM_VERSION 1.14.0-1

RUN mkdir -p /opt/sonatype/clm-server \
  && curl --fail --silent --location --retry 3 \
    https://download.sonatype.com/clm/server/sonatype-clm-server-${CLM_VERSION}-bundle.tar.gz \
  | gunzip \
  | tar x -C /opt/sonatype/clm-server sonatype-clm-server-${CLM_VERSION}.jar

RUN useradd -r -u 200 -m -c "clm-server role account" -d ${SONATYPE_WORK} -s /bin/false clm-server

VOLUME ${SONATYPE_WORK}

RUN mkdir -p ${SONATYPE_WORK}/log && chown -R clm-server ${SONATYPE_WORK}/log

ADD ./config.yml /sonatype-work/config.yml

ENV JVM_OPTIONS -server -XX:MaxPermSize=128m
EXPOSE 8070
EXPOSE 8070
WORKDIR /opt/sonatype/clm-server
USER clm-server
CMD java \
  ${JVM_OPTIONS}
  -jar sonatype-clm-server-${CLM_VERSION}.jar \
  server /sonatype-work/config.yml
