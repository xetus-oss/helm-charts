# xetusoss/alertmanager-logging-receiver Helm Chart

The official Kubernetes chart for [xetusoss/alertmanager-logging-receiver](https://github.com/xetus-oss/alertmanager-logging-receiver).

__Current Version__: `0.1.1`

__Tested Against__: `1.14+`

## Configuration

| Parameter                       | Description                                                             | Default                                                                 |
|---------------------------------|-------------------------------------------------------------------------|-------------------------------------------------------------------------|
| `image.repo`                    | Container image                                                         | `xetusoss/alertmanager-logging-receiver`                                |
| `image.tag`                     | Container image tag                                                     | `latest`                                                                |
| `image.pullPolicy`              | Image pull policy                                                       | `Always`                                                                |
| `resources`                     | The resource allocation configurations (requests and limits)            | `{requests: {cpu: 10m, memory: 10Mi}, limits: {cpu: 10m, memory: 10Mi}}`|
| `service.type`                  | `Service` resource type, `ClusterIP`, `NodePort`, or `LoadBalancer`     | `ClusterIP`                                                             |
| `tolerations`                   | `tolerations` for the deployment pods                                   | `nil`                                                                   |
| `nodeSelector`                  | `nodeSelector` for the deployment pods                                  | `nil`                                                                   |
| `priorityClassName`             | `priorityClassName` for the deployment pods                             | `nil`                                                                   |

## Quick Start

To setup a quick release for testing:

1. Add the xetusoss helm repository. See the [README](../README.md).
2. Run the following command.

```
helm install --set service.type=NodePort \
    --namespace alr-test \
    --name alr \
    xetusoss/alertmanager-logging-receiver
```
