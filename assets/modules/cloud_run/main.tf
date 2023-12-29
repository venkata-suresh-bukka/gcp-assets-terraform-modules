##-----------------------------------------CLOUD RUN----------------------------------#

resource "google_cloud_run_service" "cloud-run" {
    name     = "cloud-run-service"
    location = var.cloud-run-location

    template {
        spec {
          containers {
            # image = var.cloud-run-image
            image = var.cloud-run-image2
             ports {
              container_port = 5000
            }
            }
          }
        } 
    traffic {
        revision_name = var.cloud-run-revision1
        percent       = var.cloud-run-traffic  
    }

    ###-----------------------------Use this when you want 2 revisions-------------------------###
    # traffic {
    #     revision_name = var.cloud-run-revision2
    #     percent       = var.cloud-run-traffic
    # }
}

##-----------------------------------------CLOUD RUN POLICY DATA AND IAM_POLICY FOR PUBLIC ACCESS OF THE SERVICE----------------------------------#

data "google_iam_policy" "public-binding-data" {
  binding {
    role    = "roles/run.invoker"
    members = [ "allUsers" ]
  }
}

resource "google_cloud_run_service_iam_policy" "public-access-policy" {
  service     = google_cloud_run_service.cloud-run.name
  location    = google_cloud_run_service.cloud-run.location
  policy_data = data.google_iam_policy.public-binding-data.policy_data
}