# jswank/clm-server

A busybox-based docker image for Sonatype CLM server.

To build:

Copy the sources down and do the build:

```
# docker build --rm --tag=jswank/clm-server.
```

To run (if port 8070 is open on your host):

```
# docker run -d -p 8070:8070 -p 8071:8071 --name clm-server jswank/clm-server
```

or to assign a random port that maps to ports 8070 and 8071 on the container:

```
# docker run -d -p 8070 -p 8071 --name clm-server jswank/clm-server
```

To determine the port that the container is listening on:

```
# docker ps clm-server
```

To test:

```
$ curl http://localhost:8071/ping
```

## Notes

* A data volume, `/sonatype-work`, is used for config, scans, reports,
and logs.  This directory needs to be writable by the clm-server process,
which runs as UID 200.

* The main configuration file is `/sonatype-work/config.yml`.
This configuration differs from the distributed configuration:

  1. Log level for console and file logging is at the **INFO** level

  2. Logs are retained for 10 days rather than 5.

