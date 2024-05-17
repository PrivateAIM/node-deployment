{{/*
Return hub robot user ID
*/}}
{{- define "broker.hub.robotUser" -}}
{{- if .Values.global.hubAuth.robotUser -}}
    {{- .Values.global.hubAuth.robotUser -}}
{{- else -}}
    {{- .Values.broker.HUB_AUTH_ROBOT_ID -}}
{{- end -}}
{{- end -}}

{{/*
Return hub robot user secret
*/}}
{{- define "broker.hub.robotSecret" -}}
{{- if .Values.global.hubAuth.robotSecret -}}
    {{- .Values.global.hubAuth.robotSecret | b64enc -}}
{{- else -}}
    {{- .Values.broker.HUB_AUTH_ROBOT_SECRET | b64enc -}}
{{- end -}}
{{- end -}}

{{/*
Return the Keycloak certs endpoint
*/}}
{{- define "broker.keycloak.endpoint" -}}
{{- if .Values.broker.AUTH_JWKS_URL -}}
    {{- .Values.broker.AUTH_JWKS_URL -}}
{{- else -}}
    {{- printf "http://%s-keycloak:80/realms/flame/protocol/openid-connect/certs" .Release.Name -}}
{{- end -}}
{{- end -}}