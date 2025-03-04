{{/*
Return the postgres service endpoint
*/}}
{{- define "results.postgresql.endpoint" -}}
{{- if .Values.env.POSTGRES_HOST -}}
    {{- .Values.env.POSTGRES_HOST -}}
{{- else if .Values.postgresql.fullnameOverride -}}
    {{- print .Values.postgresql.fullnameOverride -}}
{{- else if .Values.postgresql.nameOverride -}}
    {{- printf "%s-%s" .Release.Name .Values.postgresql.nameOverride -}}
{{- else -}}
    {{- printf "%s-result-service-postgresql" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return hub auth API endpoint
*/}}
{{- define "results.hub.authApi" -}}
{{- if .Values.global.hub.endpoints.auth -}}
    {{- .Values.global.hub.endpoints.auth -}}
{{- else -}}
    {{- .Values.hub.authURL -}}
{{- end -}}
{{- end -}}

{{/*
Return hub core API endpoint
*/}}
{{- define "results.hub.coreApi" -}}
{{- if .Values.global.hub.endpoints.core -}}
    {{- .Values.global.hub.endpoints.core -}}
{{- else -}}
    {{- .Values.hub.coreURL -}}
{{- end -}}
{{- end -}}

{{/*
Return hub storage API endpoint
*/}}
{{- define "results.hub.storageApi" -}}
{{- if .Values.global.hub.endpoints.storage -}}
    {{- .Values.global.hub.endpoints.storage -}}
{{- else -}}
    {{- .Values.hub.storageURL -}}
{{- end -}}
{{- end -}}

{{/*
Return the secret containing the hub robot secret
*/}}
{{- define "results.hub.secretName" -}}
{{- $robotSecretName := .Values.hub.auth.existingSecret -}}
{{- if $robotSecretName -}}
    {{- printf "%s" (tpl $robotSecretName $) -}}
{{- else -}}
    {{- printf "%s-results-robot-secret" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return hub robot user ID
*/}}
{{- define "results.hub.robotUser" -}}
{{- if .Values.global.hub.auth.robotUser -}}
    {{- .Values.global.hub.auth.robotUser -}}
{{- else -}}
    {{- .Values.hub.auth.robotUser -}}
{{- end -}}
{{- end -}}

{{/*
Return hub robot user secret
*/}}
{{- define "results.hub.robotSecret" -}}
{{- if .Values.global.hub.auth.robotSecret -}}
    {{- .Values.global.hub.auth.robotSecret | b64enc -}}
{{- else -}}
    {{- .Values.hub.auth.robotSecret | b64enc -}}
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
