{{/*
Return hub auth API endpoint
*/}}
{{- define "broker.hub.authApi" -}}
{{- if .Values.global.hub.endpoints.auth -}}
    {{- .Values.global.hub.endpoints.auth -}}
{{- else -}}
    {{- .Values.broker.HUB_AUTH_BASE_URL -}}
{{- end -}}
{{- end -}}

{{/*
Return hub core API endpoint
*/}}
{{- define "broker.hub.coreApi" -}}
{{- if .Values.global.hub.endpoints.core -}}
    {{- .Values.global.hub.endpoints.core -}}
{{- else -}}
    {{- .Values.broker.HUB_BASE_URL -}}
{{- end -}}
{{- end -}}

{{/*
Return hub messenger API endpoint
*/}}
{{- define "broker.hub.messengerApi" -}}
{{- if .Values.global.hub.endpoints.messenger -}}
    {{- .Values.global.hub.endpoints.messenger -}}
{{- else -}}
    {{- .Values.broker.HUB_MESSENGER_BASE_URL -}}
{{- end -}}
{{- end -}}

## TODO: does message broker use realmId? If not, remove it from the template
# {{/*
# Return hub realmId
# */}}
# {{- define "broker.hub.realmId" -}}
# {{- if .Values.global.hub.realmId -}}
#     {{- .Values.global.hub.realmId -}}
# {{- else -}}
#     {{- .Values.broker.HUB_AUTH_REALM_ID -}}
# {{- end -}}
# {{- end -}}

{{/*
Return hub robot user ID
*/}}
{{- define "broker.hub.robotUser" -}}
{{- if .Values.global.hub.auth.robotUser -}}
    {{- .Values.global.hub.auth.robotUser -}}
{{- else -}}
    {{- .Values.broker.HUB_AUTH_ROBOT_ID -}}
{{- end -}}
{{- end -}}

{{/*
Return hub robot user secret
*/}}
{{- define "broker.hub.robotSecret" -}}
{{- if .Values.global.hub.auth.robotSecret -}}
    {{- .Values.global.hub.auth.robotSecret | b64enc -}}
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