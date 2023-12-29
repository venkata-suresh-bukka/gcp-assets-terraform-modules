#resource for bucket creation
resource "google_storage_bucket" "storage-bucket" {
  name                        = var.bucket_name
  location                    = var.bucket_location
  force_destroy               = true
  uniform_bucket_level_access = true
  labels  = {
    "env" = "dev"
  }
  # public_access_prevention = "enforced" (preventing pub access)
}

#resource for bucket object creation
resource "google_storage_bucket_object" "storage-bucket-objects" {
  name          = var.bucket_oject_name
  source        = var.bucket_object_source
  bucket        = google_storage_bucket.storage-bucket.name
  storage_class = var.bucket_storage_class
}

# gives access to objects as admin to all users
data "google_iam_policy" "admin-policy" {
  binding {
    role    = "roles/storage.admin"
    members = [
      "allUsers",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "policy" {
  bucket      = google_storage_bucket.storage-bucket.name
  policy_data = data.google_iam_policy.admin-policy.policy_data
}


## this resourse is for applying acl with role and desired users, for this we need to enable fine grain

# resource "google_storage_bucket_access_control" "public-rule" {
#   bucket = google_storage_bucket.storage_bucket.name
#   role   = "READER"
#   entity = "allUsers"
# }


## this resource is for uploading a folder with multiple files to an object "facing one prblm"

# resource "null_resource" "upload-folder-objects" {
#   triggers      = {
#     file_hashes = jsonencode({
#       for fn in fileset(var.bucket_object_source, "*"):
#       fn => filesha256("${var.bucket_object_source}/${fn}")
#     })
#   }
#   provisioner "local-exec" {
#   command = "gsutil -m cp -r ${var.bucket_object_source} gs://${var.bucket_name}/"
#   }
# }

