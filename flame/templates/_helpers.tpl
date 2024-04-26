{{/*
Return the secret containing the Keycloak client secret
*/}}
{{- define "hub.adapter.keycloak.secretName" -}}
{{- $secretName := index .Values "flame-node-hub-adapter" "idp" "existingSecret" -}}
{{- if and $secretName ( not .Values "flame-node-hub-adapter" "idp" "debug" ) -}}
    {{- printf "%s" (tpl $secretName $) -}}
{{- else -}}
    {{- printf "%s-hub-adapter-keycloak-secret" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return the secret key that contains the Keycloak client secret
*/}}
{{- define "hub.adapter.keycloak.secretKey" -}}
{{- $secretName := index .Values "flame-node-hub-adapter" "idp" "existingSecret" -}}
{{- if index .Values "flame-node-hub-adapter" "idp" "debug" -}}
    {{- print "hubAdapterClientSecret" -}}
{{- else if and $secretName index .Values "flame-node-hub-adapter" "idp" "existingSecretKey" -}}
    {{- printf "%s" (.Values "flame-node-hub-adapter" "idp" "existingSecretKey") -}}
{{- else -}}
    {{- print "hubAdapterClientSecret" -}}
{{- end -}}
{{- end -}}

{{- define "hub.adapter.keycloak.clientSecret" -}}
{{ $hubAdapterSecretName := include "hub.adapter.keycloak.secretName" . }}
{{ $hubAdapterSecretKey := include "hub.adapter.keycloak.secretKey" . }}
{{ $hubAdapterClientSecret := (lookup "v1" "Secret" .Release.Namespace $hubAdapterSecretName) }}
{{- if index .Values "flame-node-hub-adapter" "idp" "debug" -}}
    {{- print "cFR2THJCS3V5MHZ4cnV2VXByd3NYcEV0dzg0ZEROOUM=" -}}
{{- else if $hubAdapterClientSecret -}}
    {{- printf "%s" (index $hubAdapterClientSecret "data" $hubAdapterSecretKey | b64dec | quote) -}}
{{- else -}}
    {{- print "noSecretFound" -}}
{{- end -}}
{{- end -}}