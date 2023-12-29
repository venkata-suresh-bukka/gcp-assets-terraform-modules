variable "source_code_path" {
  type        = string
  description = "cloud function source code path"
}
variable "runtime" {
  type        = string
  description = "runtime environment compiler"
}
variable "available_memory" {
  type        = number
  description = "cloud function available memory"
}
variable "trigger_type" {
  type        = string
  description = "cloud function trigger type"
}
variable "entry_point" {
  type        = string
  description = "function entry point in code"
}
variable "role" {
  type        = string
  description = "public access roles"
}
variable "member" {
  type        = string
  description = "public access members"
}