{{/*
Return the Keycloak endpoint
*/}}
{{- define "adapter.keycloak.endpoint" -}}
{{- if .Values.env.IDP_URL -}}
    {{- .Values.env.IDP_URL -}}
{{- else -}}
    {{- printf "http://%s-keycloak-headless:8080" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return the Results service endpoint
*/}}
{{- define "adapter.results.endpoint" -}}
{{- if .Values.env.RESULTS_SERVICE_URL -}}
    {{- .Values.env.RESULTS_SERVICE_URL -}}
{{- else -}}
    {{- printf "http://%s-node-result-service:8080" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return the Kong admin service endpoint
*/}}
{{- define "adapter.kong.endpoint" -}}
{{- if .Values.env.KONG_ADMIN_SERVICE_URL -}}
    {{- .Values.env.KONG_ADMIN_SERVICE_URL -}}
{{- else -}}
    {{- printf "http://%s-kong-service:8000" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return the pod orchestrator endpoint
*/}}
{{- define "adapter.po.endpoint" -}}
{{- if .Values.env.PODORC_SERVICE_URL -}}
    {{- .Values.env.PODORC_SERVICE_URL -}}
{{- else -}}
    {{- printf "http://%s-po-service:8000" .Release.Name -}}
{{- end -}}
{{- end -}}