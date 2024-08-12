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