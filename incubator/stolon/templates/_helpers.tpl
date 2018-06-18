{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cluster.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "cluster.fullname" -}}
{{- $name := include "cluster.name" . -}}
{{- printf "%s-%s" .Values.stolon.clusterName $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Get cluster specification
*/}}
{{- define "cluster.specification.json" -}}
{{- $clusterSpecification := .Values.stolon.clusterSpecification -}}
{{- if $clusterSpecification -}}
  {{- $initMode := include "cluster.specification.initMode" . -}}
  {{- if eq $initMode "existing" -}}
    {{- $keeperUID := include "keeper.UID" (dict "root" . "count" 0) -}}
    {{- $clusterSpecification | merge (dict "existingConfig" (dict "keeperUID" $keeperUID)) | toJson -}}
  {{- else -}}
    {{- toJson $clusterSpecification -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified sentinel name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "sentinel.fullname" -}}
{{- $name := include "cluster.fullname" . -}}
{{- printf "%s-sentinel" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified secret name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "secret.fullname" -}}
{{- $name := include "cluster.fullname" . -}}
{{- printf "%s-secret" $name | lower | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified sentinel name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "keeper.fullname" -}}
{{- $name := include "cluster.fullname" . -}}
{{- printf "%s-keeper" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified store name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "store.fullname" -}}
{{- $name := include "cluster.fullname" . -}}
{{- printf "%s-%s" $name .Values.store.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified store name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "proxy.fullname" -}}
{{- $name := include "cluster.fullname" . -}}
{{- printf "%s-proxy" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified store name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "proxy.service" -}}
{{- $name := include "cluster.name" . -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified PVC name for stolon keeper.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "pvc.fullname" -}}
{{- $name := include "cluster.fullname" . -}}
{{- printf "%s-pvc" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Store endpoint
*/}}
{{- define "store.endpoint" -}}
{{- if .Values.etcdoperator.create -}}
{{- $name := include "store.fullname" . -}}
{{- printf "http://%s-client:%d" $name 2379 | trimSuffix "-" -}}
{{- else -}}
{{- $name := required "Provide a store endpoint" .Values.store.endpoint -}}
{{- printf "http://%s:%d" $name 2379 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Generate replication password
*/}}
{{- define "password" -}}
{{- $generatedPassword := randAlphaNum 12 -}}
{{- $password := default $generatedPassword .password -}}
{{- $value := $password | b64enc -}}
{{- printf "%s" $value -}}
{{- end -}}

{{/*
Generate replication password
*/}}
{{- define "replication.password" -}}
{{- $value := include "password" .Values.postgres.replication -}}
{{- printf "%s" $value -}}
{{- end -}}

{{/*
Generate user password
*/}}
{{- define "application.password" -}}
{{- $value := include "password" .Values.postgres.application -}}
{{- printf "%s" $value -}}
{{- end -}}

{{/*
Get initMode from cluster specification
*/}}
{{- define "cluster.specification.initMode" -}}
{{- $clusterSpecification := .Values.stolon.clusterSpecification -}}
{{- if $clusterSpecification -}}
  {{- default "new" $clusterSpecification.initMode -}}
{{- else -}}
  new
{{- end -}}
{{- end -}}

{{/*
Volume claim for keeper with no data
When initMode=new, all the keepers claim dynamic PVs
When initMode=existing, all keepers except the first one claim dynamic PVs
*/}}
{{- define "keeper.volume.new" -}}
{{- $initMode := include "cluster.specification.initMode" .root -}}
{{- if (or (eq $initMode "new")  (and (eq $initMode "existing") (ne .count 0))) -}}
	volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        storageClassName: {{ required "Provide a storage class for persisting keeper data" .root.Values.persistence.storageClass }}
        accessModes:
          - {{ .root.Values.persistence.accessMode | quote }}
        resources:
          requests:
            storage: {{ .root.Values.persistence.size | quote }}
{{- end -}}
{{- end -}}

{{/*
Volume claim for keeper with data
When initMode=new, first keeper uses the persistent volume claim specified by stolon.keeper.pvcName
*/}}
{{- define "keeper.volume.existing" -}}
{{- $initMode := include "cluster.specification.initMode" .root -}}

{{- if (and (eq $initMode "existing") (eq .count 0)) -}}
- name: data
          persistentVolumeClaim:
            claimName: {{ required "PVC name is required when initMode='existing'" .root.Values.stolon.keeper.pvcName }}
{{- end -}}
{{- end -}}

{{/*
Generate keeper UID
*/}}
{{- define "keeper.UID" -}}
{{ $hyphenatedReleaseName := (.root.Release.Name | replace "-" "_") }}
{{- printf "%s_keeper_%d_0" $hyphenatedReleaseName .count -}}
{{- end -}}