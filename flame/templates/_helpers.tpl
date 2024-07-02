{{- define "hub.adapter.keycloak.clientSecret" -}}
{{ $hubAdapterSecretName := (include "adapter.keycloak.secretName" (index .Subcharts "flame-node-hub-adapter") ) }}
{{ $hubAdapterSecretKey := include "adapter.keycloak.secretKey" (index .Subcharts "flame-node-hub-adapter") }}
{{ $hubAdapterClientSecret := (lookup "v1" "Secret" .Release.Namespace $hubAdapterSecretName) }}
{{- if index .Values "flame-node-hub-adapter" "idp" "debug" -}}
    {{- print "cFR2THJCS3V5MHZ4cnV2VXByd3NYcEV0dzg0ZEROOUM=" -}}
{{- else if $hubAdapterClientSecret -}}
    {{- print (index $hubAdapterClientSecret "data" $hubAdapterSecretKey) -}}
{{- else -}}
    {{- print ("noSecretFound" | b64enc) -}}
{{- end -}}
{{- end -}}

{{- define "frontend.ui.keycloak.clientSecret" -}}
{{ $nodeUiSecretName := include "ui.keycloak.secretName" (index .Subcharts "flame-node-ui") }}
{{ $nodeUiSecretKey := include "ui.keycloak.secretKey" (index .Subcharts "flame-node-ui") }}
{{ $nodeUiClientSecret := (lookup "v1" "Secret" .Release.Namespace $nodeUiSecretName) }}
{{- if index .Values "flame-node-ui" "idp" "debug" -}}
    {{- print "UU4ySGVPMkxlWE1ZMTBWclA0Y2YyeDVKSFRGSW5tNGY=" -}}
{{- else if $nodeUiClientSecret -}}
    {{- print (index $nodeUiClientSecret "data" $nodeUiSecretKey) -}}
{{- else -}}
    {{- print ("noSecretFound" | b64enc) -}}
{{- end -}}
{{- end -}}