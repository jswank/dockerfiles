# jswank/nexus

A busybox-based docker image for Sonatype Nexus (OSS).

To build:

Copy the sources down and do the build-

```
# docker build --rm=true --tag=<username>/nexus
```

To run (if port 8081 is open on your host):

```
# docker run -d -p 8081:8081 --name nexus <username>/nexus
```

or to assign a random port that maps to port 8081 on the container:

```
# docker run -d -p 8081 --name nexus <username>/nexus
```

To determine the port that the container is listening on:

```
# docker ps nexus
```

To test:

```
$ curl http://localhost:8081/service/local/status
```

## Notes

* Installation of Nexus is to `/opt/sonatype/nexus`.  Notably:
  * `/opt/sonatype/nexus-pro/conf/nexus.properties` is the properties
  file.

* A data volume, /sonatype-work`, is used for configuration, logs,
and storage.  This directory needs to be writable by the Nexus process,
which runs as UID 200.

