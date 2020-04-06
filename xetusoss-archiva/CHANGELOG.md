# Change Log
---
Notable changes in the xetusoss-archiva chart

### v0.1.7

* Fixed the update strategy. Prior to this fix, Archiva pods had to be manually killed each time the chart was updated. See [pull request #11](https://github.com/xetus-oss/helm-charts/pull/11).

### v0.1.6

* Added support for specifying a `PriorityClassName` on the archiva pod. See [pull request #9](https://github.com/xetus-oss/helm-charts/pull/9).

### v0.1.5

* Added better support for `v2` images after the [`archiva:v2.2.4-1`](https://github.com/xetus-oss/docker-archiva#v224-1) changes. The new image version sets the `XX:+UseContainerSupport` flag so `cgroups` are respected.
  * Renamed `resourceConf.jvmMaxMemory` to `resourceConf.memory` and adjusted the default to `512`. Backwards compatibility with the `resourceConf.jvmMaxMemory` will be supported until chart version `v0.2.0`.
  * The `JVM_MAX_MEMORY` environment variable is no longer set in Archiva container since support for this has been dropped. __WARNING:__ If an earlier version tag of the `xetusoss/archiva` image is manually specified, the `JVM_MAX_MEMORY` variable will not be set and the image's default settings will be used.
* Added support for customizing the MySQL image used when `userdb.type=mysql` (see [pull request #7](https://github.com/xetus-oss/helm-charts/pull/7)). However, please note that using MySQL is not recommended for new deployments!

### v0.1.4
* Added support for Kubernetes `v1.16+` and removed support for versions before `v1.9` (see [pull request #4](https://github.com/xetus-oss/helm-charts/pull/4)).
* Fixed a bug with the `PROXY_BASE_URL` support when not including a customPort (see [issue #5](https://github.com/xetus-oss/helm-charts/issues/5))
* Added the support for using the new `networking.k8s.io/v1beta1` API version for ingresses in Kubernetes `v1.14+`.

### v0.1.3
* Added support for the custom CA certificate loading feature of the docker image. CA certificates can now be specified using `archiva.caCertsSecret`.
* Fixed an issue where a PVC would be created even if an existing claim was specified.
* Renamed `ingress.tls.secretName` to `ingress.tls.secret`. Backwards compatibility for the previous key name will remain until version `v0.2.0`.
* Renamed the `advanced` key to `archiva`. Backwards compatibility for the previous key name will remain until version `v0.2.0`.
* An empty directory volume is now created on the node when `persistence.enabled = false`.
* PVC's created by this chart are now retained after the release is deleted using `"helm.sh/resource-policy": keep`. This was to prepare for moving to a `StatefulSet` later, and a message about the behavior was added to the NOTE.txt.
* Fixed several minor typos in the README and a format issue with the `xetusoss-archiva.proxyBaseUrl` used in the release NOTES.txt.

### v0.1.2
* Changed the ingress resource definition to support cert-manager & lets-encrypt. See [issue #1](https://github.com/xetus-oss/helm-charts/issues/1).
