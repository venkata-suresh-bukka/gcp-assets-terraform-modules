##---create bucket--
##---upload zip file--
##---deploy function--
##---policy binding--

resource "google_storage_bucket" "function_bucket" {
  name = "cloud-fun-bucket"
}

resource "google_storage_bucket_object" "src_code" {
  name   = "index.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = var.source_code_path
}

resource "google_cloudfunctions_function" "google_function" {
  name                  = "google-function"
  runtime               = var.runtime

  available_memory_mb   = var.available_memory
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.src_code.name    

  trigger_http          = var.trigger_type
  entry_point           = var.entry_point
  
}

resource "google_cloudfunctions_function_iam_member" "member" {
  region         = google_cloudfunctions_function.google_function.region
  cloud_function = google_cloudfunctions_function.google_function.name
  # unauthenticated_invocations = true

  role           = var.role
  member         = var.member
}