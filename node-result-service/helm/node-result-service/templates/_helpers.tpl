{{/*
Return the Keycloak certs endpoint
*/}}
{{- define "results.keycloak.endpoint" -}}
{{- if .Values.env.OIDC_CERTS_URL -}}
    {{- .Values.env.OIDC_CERTS_URL -}}
{{- else -}}
    {{- printf "http://%s-keycloak:80/realms/flame/protocol/openid-connect/certs" .Release.Name -}}
{{- end -}}
{{- end -}}
