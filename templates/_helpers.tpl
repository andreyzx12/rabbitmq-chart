{{/*
Expand the name of the chart.
*/}}
{{- define "kpi-rabbitmq.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kpi-rabbitmq.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kpi-rabbitmq.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kpi-rabbitmq.labels" -}}
helm.sh/chart: {{ .Values.global.name }}
app.kubernetes.io/managed-by: Helm
{{ include "kpi-rabbitmq.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kpi-rabbitmq.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.global.name }}
app.kubernetes.io/instance: {{ .Values.global.name }}
{{- end }}

{{/*
All labels
*/}}
{{- define "allLabels" -}}
helm.sh/chart: {{ include "chart" . }}
app.kubernetes.io/name: {{ .Values.global.name }}
app.kubernetes.io/instance: {{ .Values.global.name }}
app.kubernetes.io/version: {{ .Values.global.version | quote }}
app.kubernetes.io/component: {{ .Values.global.component }}
app.kubernetes.io/part-of: {{ trimSuffix .Values.global.component .Values.global.name | trimSuffix "-" | default .Values.global.component }}
app.kubernetes.io/managed-by: Helm
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "kpi-rabbitmq.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kpi-rabbitmq.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
