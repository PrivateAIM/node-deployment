{{/*
Return hub robot user ID
*/}}
{{- define "broker.hub.robotUser" -}}
{{- if .global.hubAuth.robotUser -}}
    {{- .global.hubAuth.robotUser -}}
{{- else -}}
    {{- .Values.broker.HUB_AUTH_ROBOT_ID -}}
{{- end -}}
{{- end -}}

{{/*
Return hub robot user secret
*/}}
{{- define "broker.hub.robotSecret" -}}
{{- if .global.hubAuth.robotSecret -}}
    {{- .global.hubAuth.robotSecret -}}
{{- else -}}
    {{- .Values.broker.HUB_AUTH_ROBOT_SECRET -}}
{{- end -}}
{{- end -}}