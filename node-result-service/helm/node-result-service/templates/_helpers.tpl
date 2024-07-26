{{/*
Return hub auth API endpoint
*/}}
{{- define "results.hub.authApi" -}}
{{- if .Values.global.hub.endpoints.auth -}}
    {{- .Values.global.hub.endpoints.auth -}}
{{- else -}}
    {{- .Values.env.HUB__AUTH_BASE_URL -}}
{{- end -}}
{{- end -}}

{{/*
Return hub core API endpoint
*/}}
{{- define "results.hub.coreApi" -}}
{{- if .Values.global.hub.endpoints.core -}}
    {{- .Values.global.hub.endpoints.core -}}
{{- else -}}
    {{- .Values.env.HUB__CORE_BASE_URL -}}
{{- end -}}
{{- end -}}

{{/*
Return hub storage API endpoint
*/}}
{{- define "results.hub.storageApi" -}}
{{- if .Values.global.hub.endpoints.storage -}}
    {{- .Values.global.hub.endpoints.storage -}}
{{- else -}}
    {{- .Values.env.HUB__STORAGE_BASE_URL -}}
{{- end -}}
{{- end -}}

{{/*
Return hub robot user ID
*/}}
{{- define "results.hub.robotUser" -}}
{{- if .Values.global.hub.auth.robotUser -}}
    {{- .Values.global.hub.auth.robotUser -}}
{{- else -}}
    {{- .Values.env.HUB_USERNAME -}}
{{- end -}}
{{- end -}}

{{/*
Return hub robot user secret
*/}}
{{- define "results.hub.robotSecret" -}}
{{- if .Values.global.hub.auth.robotSecret -}}
    {{- .Values.global.hub.auth.robotSecret | b64enc -}}
{{- else -}}
    {{- .Values.env.HUB_PASSWORD | b64enc -}}
{{- end -}}
{{- end -}}

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
