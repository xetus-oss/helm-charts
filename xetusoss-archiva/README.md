# xetusoss/archiva Helm Chart

The official Kubernetes chart for [xetusoss/archiva](https://github.com/xetus-oss/docker-archiva).

__Current Version__: `0.1.7`

__Tested Against__: `1.14+`

> See the [Change Log](CHANGELOG.md) if upgrading

## Prerequisites

* PV support in the Kuberentes cluster (if persistence is used)
* Ingress support in the Kuberentes cluster (if ingress is used)

## Configuration

| Parameter                       | Description                                                                                                      | Default            |
|---------------------------------|------------------------------------------------------------------------------------------------------------------|--------------------|
| `image.repo`                    | Container image                                                                                                  | `xetusoss/archiva` |
| `image.tag`                     | Container image tag                                                                                              | `v2`               |
| `image.pullPolicy`              | Image pull policy                                                                                                | `Always`           |
| `smtp.host`                     | SMTP_HOST in the container. See [xetusoss/archiva](https://github.com/xetus-oss/docker-archiva)                  | `nil`              |
| `smtp.port`                     | SMTP_PORT in the container. See [xetusoss/archiva](https://github.com/xetus-oss/docker-archiva)                  | `25`               |
| `proxy.enabled`                 | Enable HTTP proxy configuration                                                                                  | `false`            |
| `proxy.hostname`                | The hostname for the proxy frontend used with this deployment.                                                   | `nil`              |
| `proxy.proto`                   | The protocol used on the proxy, either `http` or `https`.                                                        | `https`            |
| `proxy.pathPrefix`              | Path prefix configured on the proxy's frontend (e.g. `/archiva`)                                                 | `nil`              |
| `proxy.customPort`              | Custom http or https port used on the proxy frontend                                                             | `nil`              |
| `userDb.type`                   | User database type, either `derby` or `mysql`. `mysql` is not recommended for new deployments.                   | `derby`            |
| `userDb.user`                   | User database user, needed when `userdb.type=mysql`                                                              | `archiva`          |
| `userDb.password`               | User database password, needed when `userdb.type=mysql`                                                          | `nil`              |
| `userDb.host`                   | User database host, needed when `userdb.type=mysql`                                                              | `nil`              |
| `userDb.port`                   | User database port, needed when `userdb.type=mysql`                                                              | `3306`             |
| `userDb.name`                   | User database name, needed when `userdb.type=mysql`                                                              | `archiva`          |
| `userDb.image`                  | User database image, needed when `userdb.type=mysql`                                                             | `mysql:8`          |
| `resourceConf.memory   `        | Memory, in megabytes, allocated to the archiva pod                                                               | `512`              |
| `resourceConf.cpuLimit`         | CPU limit for Archiva                                                                                            | `2`                |
| `resourceConf.cpuRequest`       | CPU request for Archiva                                                                                          | `500m`             |
| `archiva.jvmExtraOpts`          | Extra jvm arguments for Archiva                                                                                  | `[]`               |
| `archiva.caCertsSecret`         | Secret to mount under `/certs`. See [xetusoss/archiva](https://github.com/xetus-oss/docker-archiva)              | `nil`              |
| `service.type`                  | `Service` resource type, `ClusterIP`, `NodePort`, or `LoadBalancer`                                              | `ClusterIP`        |
| `ingress.enabled`               | Enable ingress support                                                                                           | `false`            |
| `ingress.annotations`           | Optional ingress annotation values                                                                               | `{}`               |
| `ingress.tls.enabled`           | Enable tls support within the ingress resource                                                                   | `false`            |
| `ingress.tls.secret`            | The secret which contains the TLS keypair for the ingress. Required when `ingress.tls.enable` = `true`           | `nil`              |
| `persistence.enabled`           | Enable persistent storage                                                                                        | `true`             |
| `persistence.existingClaim`     | Specify an existing claim for a `PersistentVolume`                                                               | `nil`              |
| `persistence.storageClass`      | `StorageClass` type for the `PersistentVolume`. Ignored if `persistence.existingClaim` exists                    | `nil`              |
| `persistence.requestSize`       | The `PersistentVolume` request size. Ignored if `persistence.existingClaim` exists                               | `20Gi`             |
| `tolerations`                   | `tolerations` for the xetusoss/archiva `Pod`                                                                     | `nil`              |
| `nodeSelector`                  | `nodeSelector` for the xetusoss/archiva `Pod`                                                                    | `nil`              |
| `priorityClassName`             | `priorityClassName` for the xetusoss/archiva `Pod`                                                               | `nil`              |


To setup a quick release for testing, without persistent volume support.

1. Add the xetusoss helm repository. See the [README](../README.md).
2. Run the following command.

```
helm install --set service.type=NodePort\
    --set persistence.enabled=false\
    --namespace archiva-test\
    --name archiva\
    xetusoss/xetusoss-archiva
```
