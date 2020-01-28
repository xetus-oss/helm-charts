{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "xetusoss-archiva.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "xetusoss-archiva.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the proxy base url from the proxy.* values
*/}}
{{- define "xetusoss-archiva.proxyBaseUrl" -}}
{{- $proto := .Values.proxy.proto -}}
{{- $host := .Values.proxy.hostname -}}
{{- $path := default "" .Values.proxy.pathPrefix -}}
{{- if .Values.proxy.customPort -}}
  {{- $port := int .Values.proxy.customPort -}}
  {{ printf "%s://%s:%d%s" $proto $host $port $path -}}
{{ else -}}
  {{ printf "%s://%s%s" $proto $host $path -}}
{{- end -}}
{{- end -}}

{{/*
Convert the JVM options array into a string
*/}}
{{- define "xetusoss-archiva.jvmExtraOptsStr" -}}
{{- if (.) -}}
{{- range . }} {{ . }}{{ end -}}
{{- end -}}
{{- end -}}

{{/*
Resolves the tls secret name from the global context, supporting
the previous key name.

Keep in place until v0.2.0 for backwards compatbility.
*/}}
{{- define "xetusoss-archiva.tlsSecret" -}}
{{ default .Values.ingress.tls.secretName .Values.ingress.tls.secret }}
{{- end -}}


{{/*
As of v1.14, kubernetes depreciated extensions/v1beta1, and
ingresses should use networking.k8s.io/v1beta1. In v1.18
extensions/v1beta1 will stop working.

https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.14.md#no-really-you-must-read-this-before-you-upgrade
*/}}
{{- define "xetusoss-archiva.ingressApiVersion" -}}
{{- if semverCompare ">=1.14-0" .Capabilities.KubeVersion.GitVersion -}}
networking.k8s.io/v1beta1
{{- else -}}
extensions/v1beta1
{{- end -}}
{{- end -}}