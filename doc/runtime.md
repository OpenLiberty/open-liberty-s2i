Open Liberty S2I Runtime Images
===============================

The Open Liberty S2I Runtime image can be used to produce a lighter weight container that does not have the maven binaries and dependencies that are not needed at runtime. Depending on the application, this can potentially save several gigabytes of space in the image. 

The runtime image is produced by running `s2i` with the `runtime-image` and `runtime-artifact` options. The build process will first build the normal builder image and then copy the output files specified in the `runtime-artifact` option into the image specified by `runtime-image`. 

Example
-------
The following command will build a runtime image named `open-liberty-runtime-test`. It will use `openliberty/open-liberty-s2i` as the builder image and `openliberty/open-liberty-s2i-runtime` as the runtime image. It will copy all applications from the `dropins` directory of the builder image to the `dropins` directory of the runtime image. 

```
$ s2i build git://github.com/openshift/openshift-jee-sample openliberty/open-liberty-s2i:latest open-liberty-runtime-test --runtime-image openliberty/open-liberty-s2i-runtime:latest --runtime-artifact /opt/ol/wlp/usr/servers/defaultServer/dropins 
$ docker run -p 9080:9080 open-liberty-runtime-test
```

Options for Runtime Artifacts
-----------------------------
Current valid arguments for the `runtime-artifact` option include:

* `/opt/ol/wlp/usr` -- Will copy the entire `usr` directory from the server in the builder image. Use this option if your builder image contains supporting libraries or other files underneath the `usr` directory. 
* `/opt/ol/wlp/usr/server/defaultServer/dropins` -- Will copy all files from the dropins directory of the builder image to the dropins directory of the runtime image
* `/opt/ol/wlp/usr/servers/defaultServer/apps` -- Will copy all files from the apps directory of the builder image to the apps directory of the runtime image
* `/opt/ol/wlp/usr/servers/defaultServer/server.xml` -- Will copy server.xml from the builder image to the runtime image

Note that s2i does not support wildcards in this option. 
