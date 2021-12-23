{{- define "advanced.config" -}}
[{rabbitmq_auth_backend_ldap,
  [
   {servers, ["{{ .Values.clusterName | trunc 3 }}-dc.megafon.ru"]},
   {user_dn_pattern, "${username}@megafon.ru"},
   {dn_lookup_base,"dc=Megafon,dc=ru"},
   {group_lookup_base, "dc=Megafon,dc=ru"},
   {dn_lookup_attribute,"userPrincipalName"},
   {port, 389},
   {log,network},
   {tag_queries,
        [{administrator, {constant,true}},
         {monitoring, {constant,true}},
         {management, {constant,true}}
        ]
   }
  ]
 }
].
{{- end }}