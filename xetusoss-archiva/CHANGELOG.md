# Change Log
---
Notable changes in the xetusoss-archiva chart

### v0.1.3
* Added support for the custom CA certificate loading feature of the docker image. CA certificates can now be specified using `archiva.caCertsSecret`.
* Fixed an issue where a PVC would be created even if an existing claim was specified.
* Renamed `ingress.tls.secretName` to `ingress.tls.secret`. Backwards compatibility for the previous key name will remain until version `v0.2.0`.
* Renamed the `advanced` key to `archiva`. Backwards compatibility for the previous key name will remain until version `v0.2.0`.
* An empty directory volume is now created on the node when `persistence.enabled = false`.
* PVC's created by this chart are now retained after the release is deleted using `"helm.sh/resource-policy": keep`. This was to prepare for moving to a `StatfulSet` later, and a message about the behavior was added the NOTE.txt.
* Fixed several minor typo's in the README.

### v0.1.2
* Changed the ingress resource definition to support cert-manager & lets-encrypt. See [issue #1](https://github.com/xetus-oss/helm-charts/issues/1).