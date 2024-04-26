{{/*
Return the Keycloak certs endpoint
*/}}
{{- define "po.keycloak.endpoint" -}}
{{- if .Values.env.KEYCLOAK_URL -}}
    {{- .Values.env.KEYCLOAK_URL -}}
{{- else -}}
    {{- printf "http://%s-keycloak-headless" .Release.Name -}}
{{- end -}}
{{- end -}}