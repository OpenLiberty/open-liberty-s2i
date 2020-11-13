Open Liberty UBI-min images for OpenShift S2I
=============================================

This repository contains the source for building an Open Liberty Source to Image (S2I) builder using Red Hat Universal Base Image (UBI) 7 and either Java 8 or Java 11. 

More information on S2I can be found at https://github.com/openshift/source-to-image

The built S2I image can be run using [Docker](https://docker.io).

Building the images
===================
Images are built using [docker community edition](https://docs.docker.com/) and [cekit version 3](https://cekit.readthedocs.io/en/latest/index.html).
Mac OSX installation and build [tips](doc/build-mac.md).

Cloning the repository:

```
$ git clone https://github.com/openliberty/open-liberty-s2i
$ cd open-liberty-s2i
```

Building the Open Liberty S2I images:

```
$ cd images/java8
$ cekit build docker
$ cd ../java11
$ cekit build docker
```
S2I Usage
---------
To build a simple [jee application](https://github.com/openshift/openshift-jee-sample)
using standalone [S2I](https://github.com/openshift/source-to-image) and then run the
resulting image with [Docker](http://docker.io) execute:

```
$ s2i build git://github.com/openshift/openshift-jee-sample openliberty/open-liberty-s2i:latest open-liberty-test
$ docker run -p 9080:9080 open-liberty-test
```

**Accessing the application:**
```
$ curl 127.0.0.1:9080/ROOT
```

Test
----
The tests for this repository check basic functionality of a JEE application built on top of the Open Liberty S2I images. 
```
$ make test
```

S2I Build Behavior
--------------------

If a pom.xml file is found in the root of the source tree, it will be built using maven. 

If the root of the source tree contains a file named `Dockerfile` and a directory named `maven` then the build will assume that the source tree is the output of the [fabric8 maven plugin](https://github.com/fabric8io/fabric8-maven-plugin)

If the environment variable `LIBERTY_RUNNABLE_JAR` is set, the build will attempt to copy that file to `/opt/ol/ol-runnable.jar`. At runtime, S2I will run that jar file instead of running the normal Liberty instance.

If a `server.xml` file exists in the directory `src/main/liberty/config` it will be copied to the config directory of the Liberty instance. 

If the directory `src/wlp/usr` exists, it will be copied to the `wlp` directory o the Libert instance. 

All `WAR`, `JAR`, `EAR`, and `RAR` files from the build will be copied to either the `apps` or `dropins` directory the Liberty instance depending on the value of the `DEPLOY_TO_APPS` environment variable. 


Environment variables to be used at s2i build time
--------------------------------------------------
The following environment variables can be passed to the S2I build process to customize Open Liberty. More information on these variables and the functions they enable can be found at https://github.com/OpenLiberty/ci.docker

* `MAVEN_MIRROR_URL`
  * Description: Use the specified maven mirror to resolve dependencies
* `DEPLOY_TO_APPS`
  * Description: When true, applicaton binaries will be copied to `apps` instead of `dropins`
* `TLS` or `SSL` (SSL is deprecated)
  *  Description: Enable Transport Security in Liberty by adding the `transportSecurity-1.0` feature (includes support for SSL).
  *  XML Snippet Location:  [keystore.xml](https://github.com/OpenLiberty/ci.docker/tree/master/common/helpers/build/configuration_snippets/keystore.xml).

The following environment variables are now deprecated. Support will be removed in the future. 

* `HTTP_ENDPOINT`
  *  Description: Add configuration properties for an HTTP endpoint.
  *  XML Snippet Location: [http-ssl-endpoint.xml](https://github.com/OpenLiberty/ci.docker/tree/master/common/helpers/build/configuration_snippets/http-ssl-endpoint.xml) when SSL is enabled. Otherwise [http-endpoint.xml](https://github.com/OpenLiberty/ci.docker/tree/master/common/helpers/build/configuration_snippets/http-endpoint.xml)
* `MP_HEALTH_CHECK`
  *  Description: Check the health of the environment using Liberty feature `mpHealth-1.0` (implements [MicroProfile Health](https://microprofile.io/project/eclipse/microprofile-health)).
  *  XML Snippet Location: [mp-health-check.xml](https://github.com/OpenLiberty/ci.docker/tree/master/common/helpers/build/configuration_snippets/mp-health-check.xml)
* `MP_MONITORING`
  *  Description: Monitor the server runtime environment and application metrics by using Liberty features `mpMetrics-1.1` (implements [Microprofile Metrics](https://microprofile.io/project/eclipse/microprofile-metrics)) and `monitor-1.0`.
  *  XML Snippet Location: [mp-monitoring.xml](https://github.com/OpenLiberty/ci.docker/tree/master/common/helpers/build/configuration_snippets/mp-monitoring.xml)
  *  Note: With this option, `/metrics` endpoint is configured without authentication to support the environments that do not yet support scraping secured endpoints.
* `IIOP_ENDPOINT`
  *  Description: Add configuration properties for an IIOP endpoint.
  *  XML Snippet Location: [iiop-ssl-endpoint.xml](https://github.com/OpenLiberty/ci.docker/tree/master/common/helpers/build/configuration_snippets/iiop-ssl-endpoint.xml) when SSL is enabled. Otherwise, [iiop-endpoint.xml](https://github.com/OpenLiberty/ci.docker/tree/master/common/helpers/build/configuration_snippets/iiop-endpoint.xml).
  *  Note: If using this option, `env.IIOP_ENDPOINT_HOST` environment variable should be set to the server's host. See [IIOP endpoint configuration](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.liberty.autogen.base.doc/ae/rwlp_config_orb.html#iiopEndpoint) for more details.
* `JMS_ENDPOINT`
  *  Description: Add configuration properties for an JMS endpoint.
  *  XML Snippet Location: [jms-ssl-endpoint.xml](https://github.com/OpenLiberty/ci.docker/tree/master/common/helpers/build/configuration_snippets/jms-ssl-endpoint.xml) when SSL is enabled. Otherwise, [jms-endpoint.xml](https://github.com/OpenLiberty/ci.docker/tree/master/common/helpers/build/configuration_snippets/jms-endpoint.xml)


Server Configuration 
--------------------------------------------------

If you want to use your own server.xml file rather than the default, it should be present in the `src/main/liberty/config` directory. 

  OpenShift `oc` usage
--------------------

If your openshift installation doesn't already contain the Open Liberty image:

* Adding the image streams: `oc create -f imagestreams/openliberty-ubi-min.json` 
An `Open Liberty` imagestream will be created.

* When adding the `Open Liberty` imagestream to the `openshift` namespace, the OpenShift catalog is automatically populated with a the template `Open Liberty` allowing you to
create a new build and new deployment from the OpenShift Web Console.
