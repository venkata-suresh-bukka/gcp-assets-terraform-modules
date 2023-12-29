resource "google_artifact_registry_repository" "my-repo" {
  location      = "us-central1"
  repository_id = "my-repository"
  description   = "example docker repository"
  format        = "DOCKER"
  provider = google-beta
  project = "sunlit-vortex-356909"
  labels = {
    "key" = "value"
  }
}