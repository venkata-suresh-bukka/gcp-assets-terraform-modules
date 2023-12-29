variable "schedule_time" {
  type = string
  description = "scheculer time format"
}
variable "scheduler_time_zone" {
  type = string
  description = "scheduler time zone"
}
variable "scheduler_attempt_deadline" {
  type = string
  description = "scheduler attempts deadline in seconds"
}
variable "scheduler_retry_count" {
  type = number
  description = "scheduler retry count"
}
variable "scheduler_http_method" {
  type = string
  description = "type of trigger for the job"
}
variable "scheduler_http_uri" {
  type = string
  description = "http uri for the scheduler"
}