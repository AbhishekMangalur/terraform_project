resource "kubernetes_namespace" "custom_vpc" {
  metadata {
    name = "custom-vpc"
  }
}