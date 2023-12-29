resource "google_cloud_scheduler_job" "http_scheduler_job" {
  name = "instance-state-job"
  schedule         = var.schedule_time
  time_zone        = var.scheduler_time_zone
  attempt_deadline = var.scheduler_attempt_deadline
  
  retry_config {
    retry_count = var.scheduler_retry_count
  }
  http_target {
    http_method = var.scheduler_http_method
    uri = var.scheduler_http_uri
  }
}