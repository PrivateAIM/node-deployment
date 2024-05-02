{{/*
Return the Keycloak certs endpoint
*/}}
{{- define "po.keycloak.endpoint" -}}
{{- if .Values.env.KEYCLOAK_URL -}}
    {{- .Values.env.KEYCLOAK_URL -}}
{{- else -}}
    {{- printf "http://%s-keycloak" .Release.Name -}}
{{- end -}}
{{- end -}}


{{/*
Return the postgres service endpoint
*/}}
{{- define "po.postgres.endpoint" -}}
{{- if .Values.env.POSTGRES_HOST -}}
    {{- .Values.env.POSTGRES_HOST -}}
{{- else if .Values.postgresql.fullnameOverride -}}
    {{- print .Values.postgresql.fullnameOverride -}}
{{- else if .Values.postgresql.nameOverride -}}
    {{- printf "%s-%s" .Release.Name .Values.postgresql.nameOverride -}}
{{- else -}}
    {{- printf "%s-postgresql" .Release.Name -}}
{{- end -}}
{{- end -}}