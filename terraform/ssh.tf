resource "random_string" "ssh_key" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "ssh_secret" {
  metadata {
    name      = "ssh-secret"
    namespace = kubernetes_namespace.custom_vpc.metadata[0].name
  }

  data = {
    key = random_string.ssh_key.result
  }
}