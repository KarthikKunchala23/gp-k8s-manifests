{{/* carts helper functions */}}
{{/*
Name of the chart
*/}}

{{- define "carts.name" -}}
{{- default "carts" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* fully qualified name */ }}
{{- define "carts.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "carts" .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
chart name and version as label
*/}}
{{- define "carts.chart" -}}
{{- printf "%s-%s" "carts" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* common labels */}}
{{- define "carts.labels" -}}
helm.sh/chart: {{ include "carts.chart" . }}
{{ include "carts.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* slector lables */}}
{{- define "carts.selectorLabels" -}}
app.kubernetes.io/name: {{ include .carts.name . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: service
app.kubernetes.io/owner: retail-store-sample
{{- end }}

{{/* create name of the service account to use */}}
{{- define "carts.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default ( include ""carts.fullname . ) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the config map to use
*/}}
{{- define "carts.configMapName" -}}
{{- if .Values.configMap.create }}
{{- default ( include "carts.fullname" . ) .Values.configMap.name }}
{{- else }}
{{- default "default" .Values.configMap.name }}
{{- end }}
{{- end }}

{{/* podAnnotations */}}
{{- define "carts.podAnnotations" -}}
{{- if or .Values.metrics.enabled .Values.podAnnotations }}
{{- $podAnnotations := .Values.podAnnotations }}
{{- $metricAnnotations := .Values.metrics.podAnnotations }}
{{- $allAnnotations := merge $podAnnotations $metricAnnotations }}
{{- toYaml $allAnnotations }}
{{- end }}
{{- end }}

{{- define "carts.dynamodb.fullname" -}}
{{- include "carts.fullname" . }}-dynamodb
{{- end -}}

{{/*
Common labels for dynamodb
*/}}
{{- define "carts.dynamodb.labels" -}}
helm.sh/chart: {{ include "carts.chart" . }}
{{ include "carts.dynamodb.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for dynamodb
*/}}
{{- define "carts.dynamodb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "carts.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: dynamodb
app.kubernetes.io/owner: retail-store-sample
{{- end }}