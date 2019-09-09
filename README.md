Open Liberty UBI-min images for OpenShift S2I
=============================================

This repository contains the source for building an Open Liberty Source to Image (S2I) builder using Red Hat Universal Base Image (UBI) 7 and Java 8. 

More information on S2I can be found at https://github.com/openshift/source-to-image

The built S2I image can be run using [Docker](https://docker.io).

Building the images
===================
Images are built using [docker community edition](https://docs.docker.com/) and [cekit version 3](https://cekit.readthedocs.io/en/latest/index.html).
Mac OSX installation and build [tips](doc/build-mac.md).

Cloning the repository:

```
$ git clone https://github.com/openliberty/openliberty-s2i
$ cd openliberty-s2i
```

Building the Open Liberty S2I builder:

```
$ cekit build docker
```
S2I Usage
---------
To build a simple [jee application](https://github.com/openshift/openshift-jee-sample)
using standalone [S2I](https://github.com/openshift/source-to-image) and then run the
resulting image with [Docker](http://docker.io) execute:

```
$ s2i build git://github.com/openshift/openshift-jee-sample openliberty/ol-javaee8-ubi-openshift:latest open-liberty-test
$ docker run -p 9080:9080 open-liberty-test
```

**Accessing the application:**
```
$ curl 127.0.0.1:9080
```

Test
----
The tests for this repository check basic functionality of a JEE application built on top of the Open Liberty S2I image. 
```
$ make test
```
