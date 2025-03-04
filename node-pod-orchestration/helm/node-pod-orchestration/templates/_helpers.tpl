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

{{/*
Generate a random clientSecret value for the PO client in keycloak if none provided
*/}}
{{- define "po.keycloak.clientSecret" -}}
{{- if .Values.idp.debug -}}
    {{- print "9dd01665c2f3f02f93c32d03bd854569f03cd62f439ccf9f0861c141b9d6330e" -}}
{{- else -}}
{{/*    {{- print ( randAlphaNum 22 | b64enc | quote ) -}}*/}}
    {{- /* Create "po_secret" dict inside ".Release" to store various stuff. */ -}}
    {{- if not (index .Release "po_secret") -}}
        {{-   $_ := set .Release "po_secret" dict -}}
    {{- end -}}
    {{- /* Some random ID of this password, in case there will be other random values alongside this instance. */ -}}
    {{- $key := printf "%s_%s" .Release.Name "password" -}}
    {{- /* If $key does not yet exist in .Release.po_secret, then... */ -}}
    {{- if not (index .Release.po_secret $key) -}}
        {{- /* ... store random password under the $key */ -}}
        {{-   $_ := set .Release.po_secret $key (randAlphaNum 32) -}}
    {{- end -}}
        {{- /* Retrieve previously generated value. */ -}}
        {{- print (index .Release.po_secret $key | b64enc) -}}
{{- end -}}
{{- end -}}

{{/*
Return hub auth API endpoint
*/}}
{{- define "po.hub.authApi" -}}
{{- if .Values.global.hub.endpoints.auth -}}
    {{- .Values.global.hub.endpoints.auth -}}
{{- else -}}
    {{- .Values.hub.authAPI -}}
{{- end -}}
{{- end -}}

{{/*
Return hub core API endpoint
*/}}
{{- define "po.hub.coreApi" -}}
{{- if .Values.global.hub.endpoints.core -}}
    {{- .Values.global.hub.endpoints.core -}}
{{- else -}}
    {{- .Values.hub.coreAPI -}}
{{- end -}}
{{- end -}}

{{/*
Return hub robot user ID
*/}}
{{- define "po.hub.robotUser" -}}
{{- if .Values.global.hub.auth.robotUser -}}
    {{- .Values.global.hub.auth.robotUser -}}
{{- else -}}
    {{- .Values.hub.auth.robotUser -}}
{{- end -}}
{{- end -}}

{{/*
Return hub robot user secret
*/}}
{{- define "po.hub.robotSecret" -}}
{{- if .Values.global.hub.auth.robotSecret -}}
    {{- .Values.global.hub.auth.robotSecret -}}
{{- else -}}
    {{- .Values.hub.auth.robotSecret -}}
{{- end -}}
{{- end -}}

{{/*
Return node minio endpoint
*/}}
{{- define "po.minio.endpoint" -}}
{{- if .Values.env.MINIO_URL -}}
    {{- .Values.env.MINIO_URL -}}
{{- else -}}
    {{- printf "http://%s-minio" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Return node minio access key
*/}}
{{- define "po.minio.accessKey" -}}
{{- if (index .Values.global "flame-node-result-service").MINIO_ACCESS_KEY -}}
    {{- .Values.env.MINIO_ACCESS_KEY -}}
{{- else -}}
    {{- .Values.minio.accessKey -}}
{{- end -}}
{{- end -}}

{{/*
Return node minio secret key
*/}}
{{- define "po.minio.secretKey" -}}
{{- if .Values.env.MINIO_SECRET_KEY -}}
    {{- .Values.env.MINIO_SECRET_KEY -}}
{{- else -}}
    {{- .Values.minio.secretKey -}}
{{- end -}}
{{- end -}}
