resource "kubernetes_deployment" "public_vm" {
  metadata {
    name      = "public-nginx"
    namespace = kubernetes_namespace.custom_vpc.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "public_service" {
  metadata {
    name      = "public-nginx-service"
    namespace = kubernetes_namespace.custom_vpc.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 30007
    }

    type = "NodePort"
  }
}

resource "kubernetes_deployment" "private_vm" {
  metadata {
    name      = "private-app"
    namespace = kubernetes_namespace.custom_vpc.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "private"
      }
    }

    template {
      metadata {
        labels = {
          app = "private"
        }
      }

      spec {
        container {
          image = "busybox"
          name  = "private-container"

          command = ["sleep", "3600"]
        }
      }
    }
  }
}

resource "kubernetes_service" "private_service" {
  metadata {
    name      = "private-service"
    namespace = kubernetes_namespace.custom_vpc.metadata[0].name
  }

  spec {
    selector = {
      app = "private"
    }

    port {
      port = 80
    }

    type = "ClusterIP"
  }
}