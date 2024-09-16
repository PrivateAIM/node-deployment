{{- define "components.fullname" -}}
{{- printf "%s-%s" . .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}