FROM       dockerfile/java:oracle-java7
MAINTAINER Jason Swank <jswank@sonatype.com>

ENV SONATYPE_WORK /sonatype-work

RUN mkdir -p /opt/sonatype/clm-server \
  && curl --fail --silent --location --retry 3 \
    http://download.sonatype.com/clm/server/sonatype-clm-server-1.12.0-04-bundle.tar.gz \
  | gunzip \
  | tar x -C /opt/sonatype/clm-server sonatype-clm-server-1.12.0-04.jar

RUN useradd -r -u 200 -m -c "clm-server role account" -d /sonatype-work -s /bin/false clm-server

VOLUME /sonatype-work

RUN mkdir -p /sonatype-work/log && chown -R clm-server /sonatype-work/log

ADD ./config.yml /sonatype-work/config.yml

ENV JVM_OPTIONS -server -XX:MaxPermSize=128m
EXPOSE 8070
EXPOSE 8070
WORKDIR /opt/sonatype/clm-server
USER clm-server
CMD java \
  -server -XX:MaxPermSize=128m \
  -jar sonatype-clm-server-1.12.0-04.jar \
  server /sonatype-work/config.yml
