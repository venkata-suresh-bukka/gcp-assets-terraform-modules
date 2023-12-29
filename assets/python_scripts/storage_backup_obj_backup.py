from google.cloud import storage
import datetime


def rename_blob(bucket_name):
    """Copies a blob from one bucket to another with a new name."""
    time = datetime.datetime.now().strftime("%H%M%S")
    bucket_name = "gcp-asset-tf-bucket"
    blob_name = "objects/course.png"
    destination_bucket_name = "gcp-asset-tf-bucket-copy"
    destination_blob_name = time+blob_name
  

    storage_client = storage.Client()

    source_bucket = storage_client.bucket(bucket_name)
    source_blob = source_bucket.blob(blob_name)
    destination_bucket = storage_client.bucket(destination_bucket_name)

    blob_copy = source_bucket.copy_blob(
        source_blob, destination_bucket, destination_blob_name
    )

    print(
        "Blob {} in bucket {} copied to blob {} in bucket {}.".format(
            source_blob.name,
            source_bucket.name,
            blob_copy.name,
            destination_bucket.name,
        )
    )
    return 'done'
