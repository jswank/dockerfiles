# jswank/jenkins-clm

A docker image for Jenkins w/ the CLM plugin.  This is a copy of the
official Jenkins image with the following modifications:

  * use dockerfile/java:oracle-java7
  * include Maven
  * include the Sonatype CLM CI plugin

To build:

Copy the this repo and do the build:

```
# docker build --rm --tag=jswank/jenkins-clm .
```

Run per the instructions at https://github.com/cloudbees/jenkins-ci.org-docker:

```
docker run -p 8080:8080 jenkins
```
