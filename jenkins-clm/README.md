# jswank/jenkins-clm

A docker image for Jenkins w/ the CLM plugin.  This is based on official
Jenkins image, and modified to include Maven and the CLM CI plugin per
documentation at https://github.com/cloudbees/jenkins-ci.org-docker.

To build:

Copy the this repo and do the build:

```
# docker build --rm --tag=jswank/jenkins-clm
```

Run per the instructions at https://github.com/cloudbees/jenkins-ci.org-docker:

```
docker run -p 8080:8080 jenkins
```
