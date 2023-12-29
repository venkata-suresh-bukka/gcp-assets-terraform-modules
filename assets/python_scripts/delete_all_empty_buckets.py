from google.cloud import storage

def delete_empty_buckets(data):
    """Cloud Function that deletes empty buckets in GCP and returns the number of deleted buckets."""
    
    # Create a Cloud Storage client
    storage_client = storage.Client()

    # List all buckets in the project
    buckets = storage_client.list_buckets()

    # Iterate through the buckets and delete any empty ones
    count = 0
    for bucket in buckets:
        if not list(bucket.list_blobs()):
            bucket.delete()
            print(f"Deleted empty bucket: {bucket.name}")
            count += 1

    return f"Deleted {count} empty buckets"



diskss