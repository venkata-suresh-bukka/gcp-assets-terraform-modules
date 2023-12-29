##---------------------------------------------GOOGLE BIGQUERY---------------------------

resource "google_bigquery_dataset" "gcp_bigquery_dataset" {
  dataset_id = var.bigquery_dataset_id
}

resource "google_bigquery_table" "gcp_bigquery_table" {
  table_id   = var.bigquery_table_id
  dataset_id = google_bigquery_dataset.gcp_bigquery_dataset.dataset_id
}