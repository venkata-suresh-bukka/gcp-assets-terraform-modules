terraform {
  required_providers {
    google = {
        source  = "hashicorp/google"
        version = "3.55.0"
    }
  }
}
provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = var.credentials
}

#------------------------------------------gcp storage module-------------------------------#

module "gcs-dev-module" {
  # count              = 2
  source               = "../../modules/cloud_storage"
  bucket_name          = "gcp-asset-tf-bucket"
  bucket_location      = "us-central1"
  bucket_oject_name    = "gcp-tf-object"
  bucket_object_source = "objects/course.png"
  bucket_storage_class = "STANDARD" 
}

# output "storage-output" {
#   value       = module.gcs-dev-module.gcs-output
#   description = "cloud storage bucket creation output"
# }


#---------------------------------------------gcp vpc network module----------------------------#

# module "google-network-module" {
#   source                                     = "../../modules/compute_networks_vpc"
#   custom_subnet_cidr                         = "10.1.0.0/24"
#   custom_subnet_region                       = "asia-south2"
#   custom_vpc_instance_machine_type           = "f1-micro"
#   custom_vpc_instance_zone                   = "asia-south2-a"
#   custom_vpc_instance_boot_disk              = "debian-cloud/debian-11"
#   custom_vpc_instance_disk_label             = "custom-vpc-boot-disk-label"
#   custom-vpc-instance-firewall-ports         = [ "22","80","8080" ]
#   custom-vpc-instance-firewall-tcp-protocol  = "tcp"
#   custom-vpc-instance-firewall-icmp-protocol = "icmp"

#   custom_subnet_region2                      = "us-west1"
#   custom_subnet_cidr2                        = "10.128.0.0/20"
#   custom_vpc_instance_zone2                  = "us-west1-a"
# }

#---------------------------------------------gcp vpc network module----------------------------#

# module "google-cloud-run-module" {
#   source                = "../../modules/cloud-run"
#   cloud-run-location    = "us-central1"
#   # cloud-run-image     = "us-docker.pkg.dev/cloudrun/container/hello"
#   cloud-run-image2      = "gcr.io/sunlit-vortex-356909/flask-demo:v1"
#   cloud-run-traffic     = 50
#   # cloud-run-revision1 = "cloud-run-service-xxdp5"
#   cloud-run-revision2   = "cloud-run-service-z7v4d"
# }


##-------------------------------------CLOUD FUNCTIONS--------------------------------------#
module "google-cloud-functions" {
  source           = "../../modules/cloud_functions"
  source_code_path = "index.zip" #index.zip contains source code for the functions
  runtime          = "python310"
  available_memory = 128
  trigger_type     = true
  entry_point      = "delete_all_empty_buckets"
  role             = "roles/cloudfunctions.invoker"
  # member           = "serviceAccount:gcp-terraform@sunlit-vortex-356909.iam.gserviceaccount.com"
  member           = "allUsers"

}
#-------------------------------------CLOUD SCHEDULER--------------------------------------#
module "google-cloud-scheduler" {
  source = "../../modules/cloud_scheduler"
  schedule_time = "* * * * *"
  scheduler_time_zone = "Asia/Calcutta"
  scheduler_attempt_deadline = "320s"
  scheduler_retry_count = 1
  scheduler_http_method = "GET"
  scheduler_http_uri = "http-url-here"
}

##-------------------------------------CLOUD BIGQUERY--------------------------------------#
# module "google-cloud-bigquery" {
#   source              = "../../modules/cloud_bigquery"
#   bigquery_dataset_id = "google-dataset"
#   bigquery_table_id   ="google-dataset-table"
# }

##-------------------------------------CLOUD PUB/SUB--------------------------------------#
# module "google-cloud-pubsub" {
#   source = "../../modules/cloud_pub_sub"
# }


# module "google-cloud-artifact" {
#   source = "../../modules/cloud_artifact"
# }

# module "google-container-reg" {
#   source = "../../modules/cloud_container_reg"
# }

# module "google-public-gke" {
#   source = "../../modules/google_public_gke"
# }