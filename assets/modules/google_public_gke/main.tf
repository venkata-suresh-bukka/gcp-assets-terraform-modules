resource "google_container_cluster" "my_cluster" {
  name     = "my-cluster"
  location = "us-east1"
  remove_default_node_pool = true
  initial_node_count = 1

  node_config {
    disk_size_gb              = 100
    machine_type = "n1-standard-1"
    disk_type = "pd-standard"
    oauth_scopes = ["https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]    
    service_account = "gcp-terraform@sunlit-vortex-356909.iam.gserviceaccount.com"
  }
  network_policy {
    enabled = true
  }
}




# resource "kubernetes_deployment" "example" {
#   metadata {
#     name = "sample-deploy"
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "sample-deploy"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "sample-deploy"
#         }
#       }

#       spec {
#         container {
#           name  = "flask"
#           image = "venkatrobin/flask-demo:v1"
#           port {
#             name = "http"
#             container_port = 80
#           }
#         }
#       }
#     }
#   }
# }

