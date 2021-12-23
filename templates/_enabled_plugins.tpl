{{- define "enabled_plugins" -}}
[rabbitmq_management,rabbitmq_peer_discovery_k8s,rabbitmq_shovel_management,rabbitmq_shovel,rabbitmq_auth_backend_ldap,rabbitmq_prometheus].
{{- end }}