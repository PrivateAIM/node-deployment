{{/*
Return the secret containing the Keycloak client secret
*/}}
{{- define "adapter.keycloak.secretName" -}}
{{- $secretName := .Values.idp.existingSecret -}}
{{- if and $secretName ( not .Values.idp.debug ) -}}
    {{- printf "%s" (tpl $secretName $) -}}
{{- else -}}
    {{- printf "%s-hub-adapter-keycloak-secret" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return the secret key that contains the Keycloak client secret
*/}}
{{- define "adapter.keycloak.secretKey" -}}
{{- $secretName := .Values.idp.existingSecret -}}
{{- if .Values.idp.debug -}}
    {{- print "hubAdapterClientSecret" -}}
{{- else if and $secretName .Values.idp.existingSecretKey -}}
    {{- printf "%s" .Values.idp.existingSecretKey -}}
{{- else -}}
    {{- print "hubAdapterClientSecret" -}}
{{- end -}}
{{- end -}}

{{/*
Generate a random clientSecret value for the hub-adapter client in keycloak if none provided
*/}}
{{- define "adapter.keycloak.clientSecret" -}}
{{- if .Values.idp.debug -}}
    {{- print "cFR2THJCS3V5MHZ4cnV2VXByd3NYcEV0dzg0ZEROOUM=" -}}
{{- else -}}
    {{- printf "%s" ( randAlphaNum 22 | b64enc | quote ) -}}
{{- end -}}
{{- end -}}

{{/*
Return the Keycloak endpoint
*/}}
{{- define "adapter.keycloak.endpoint" -}}
{{- if .Values.idp.host -}}
    {{- .Values.idp.host -}}
{{- else -}}
    {{- printf "http://%s-keycloak:80" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return the Results service endpoint
*/}}
{{- define "adapter.results.endpoint" -}}
{{- if .Values.node.results -}}
    {{- .Values.node.results -}}
{{- else -}}
    {{- printf "http://%s-node-result-service:8080" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return the Kong admin service endpoint
*/}}
{{- define "adapter.kong.endpoint" -}}
{{- if .Values.node.kong -}}
    {{- .Values.node.kong -}}
{{- else -}}
    {{- printf "http://%s-kong-admin:80" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return the Pod Orchestrator endpoint
*/}}
{{- define "adapter.po.endpoint" -}}
{{- if .Values.node.po -}}
    {{- .Values.node.po -}}
{{- else -}}
    {{- printf "http://%s-po-service:8000" .Release.Name -}}
{{- end -}}
{{- end -}}
