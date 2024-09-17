{{/*
    Renders the full resource name of a flame node component.
    Takes into account that k8s DNS labels cannot exceed a length of 63 characters.
*/}}
{{- define "flame.node.components.fullname" -}}
{{- printf "%s-%s" .name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}