resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend         = vault_auth_backend.kubernetes.path
  kubernetes_host = "https://kubernetes.default.svc.cluster.local:443"
}

resource "vault_kubernetes_auth_backend_role" "read-secrets" {
  backend   = vault_auth_backend.kubernetes.path
  role_name = "read-secrets"
  token_ttl = 3600
  token_policies = [
    vault_policy.read-secrets.name
  ]
  audience = "vault"
  bound_service_account_names = [
    "default",
  ]
  bound_service_account_namespaces = [
    "foo",
    "bar",
  ]
}
