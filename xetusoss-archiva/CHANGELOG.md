# Change Log
---
Notable changes in the xetusoss-archiva chart

### v0.1.3
* Added support for the custom CA certificate loading feature of the docker image. CA certificates can now be specified using a `ConfigMap` using the `advanced.caCertsConfigMap` field.
* Fixed an issue where a PVC would be created even if an existing claim was specified.
* Fixed a minor typo in the README.

### v0.1.2
* Changed the ingress resource definition to support cert-manager & lets-encrypt. See [issue #1](https://github.com/xetus-oss/helm-charts/issues/1).