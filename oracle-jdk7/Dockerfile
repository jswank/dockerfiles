FROM        progrium/busybox 
MAINTAINER  Jason Swank <dovker@scalene.net>

RUN opkg-install curl ca-certificates

ENV INSTALL_DIR /usr/jdk1.7.0_71

RUN curl \
  --silent \
  --location \
  --retry 3 \
  --cacert /etc/ssl/certs/GeoTrust_Global_CA.crt \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/7u71-b14/jdk-7u71-linux-x64.tar.gz" \
    | gunzip \
    | tar x -C /usr/ \
    && ln -s $INSTALL_DIR /usr/java \
    && rm -rf $INSTALL_DIR/src.zip $INSTALL_DIR/javafx-src.zip $INSTALL_DIR/man

ENV JAVA_HOME /usr/java
ENV PATH ${PATH}:${JAVA_HOME}/bin

CMD java -version
