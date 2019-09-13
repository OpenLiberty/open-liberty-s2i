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
$ s2i build git://github.com/openshift/openshift-jee-sample openliberty/open-liberty-s2i:latest open-liberty-test
$ docker run -p 9080:9080 open-liberty-test
```

**Accessing the application:**
```
$ curl 127.0.0.1:9080/ROOT
```

Test
----
The tests for this repository check basic functionality of a JEE application built on top of the Open Liberty S2I image. 
```
$ make test
```
Environment variables to be used at s2i build time
--------------------------------------------------
The following environment variables can be passed to the S2I build process to customize Open Liberty. More information on these variables and the functions they enable can be found at https://github.com/OpenLiberty/ci.docker

* `HTTP_ENDPOINT`
  *  Decription: Add configuration properties for an HTTP endpoint.
  *  XML Snippet Location: [http-ssl-endpoint.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/http-ssl-endpoint.xml) when SSL is enabled. Otherwise [http-endpoint.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/http-endpoint.xml)
* `MP_HEALTH_CHECK`
  *  Decription: Check the health of the environment using Liberty feature `mpHealth-1.0` (implements [MicroProfile Health](https://microprofile.io/project/eclipse/microprofile-health)).
  *  XML Snippet Location: [mp-health-check.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/mp-health-check.xml)
* `MP_MONITORING`
  *  Decription: Monitor the server runtime environment and application metrics by using Liberty features `mpMetrics-1.1` (implements [Microprofile Metrics](https://microprofile.io/project/eclipse/microprofile-metrics)) and `monitor-1.0`.
  *  XML Snippet Location: [mp-monitoring.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/mp-monitoring.xml)
  *  Note: With this option, `/metrics` endpoint is configured without authentication to support the environments that do not yet support scraping secured endpoints.
* `TLS` or `SSL` (SSL is being deprecated)
  *  Decription: Enable Transport Security in Liberty by adding the `transportSecurity-1.0` feature (includes support for SSL).
  *  XML Snippet Location:  [keystore.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/keystore.xml).
* `IIOP_ENDPOINT`
  *  Decription: Add configuration properties for an IIOP endpoint.
  *  XML Snippet Location: [iiop-ssl-endpoint.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/iiop-ssl-endpoint.xml) when SSL is enabled. Otherwise, [iiop-endpoint.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/iiop-endpoint.xml).
  *  Note: If using this option, `env.IIOP_ENDPOINT_HOST` environment variable should be set to the server's host. See [IIOP endpoint configuration](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.liberty.autogen.base.doc/ae/rwlp_config_orb.html#iiopEndpoint) for more details.
* `JMS_ENDPOINT`
  *  Decription: Add configuration properties for an JMS endpoint.
  *  XML Snippet Location: [jms-ssl-endpoint.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/jms-ssl-endpoint.xml) when SSL is enabled. Otherwise, [jms-endpoint.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/jms-endpoint.xml)
* `OIDC`
  *  Decription: Enable OpenIdConnect Client function by adding the `openidConnectClient-1.0` feature.
  *  XML Snippet Location: [oidc.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/oidc.xml)
* `OIDC_CONFIG`
  *  Decription: Enable OpenIdConnect Client configuration to be read from environment variables.  
  *  XML Snippet Location: [oidc-config.xml](https://github.com/OpenLiberty/ci.docker/common/helpers/build/configuration_snippets/oidc-config.xml)
  *  Note: The following variables will be read:  OIDC_CLIENT_ID, OIDC_CLIENT_SECRET, OIDC_DISCOVERY_URL.  

  OpenShift `oc` usage
--------------------

If your openshift installation doesn't already contain the Open Liberty image:

* Adding the image streams: `oc create -f imagestreams/openliberty-ubi-min.json` 
An `Open Liberty` imagestream will be created.

* When adding the `Open Liberty` imagestream to the `openshift` namespace, the OpenShift catalog is automatically populated with a the template `Open Liberty` allowing you to
create a new build and new deployment from the OpenShift Web Console.