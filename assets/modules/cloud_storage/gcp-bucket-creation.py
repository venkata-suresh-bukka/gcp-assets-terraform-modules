# Imports the Google Cloud client library
import os
import subprocess
from google.cloud import storage

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'C:\key.json'

def bucket_creation():
    storage_client = storage.Client()
    # The name for the new bucket
    bucket_name = "bucket_py"

    # Creates the new bucket
    bucket = storage_client.create_bucket(bucket_name)

    print(f"Bucket {bucket.name} created.") 

def upload_obj():
    storage_client = storage.Client()

    bucket = storage_client.get_bucket("bucket_py")
    folder_path = "C:/files_upload_tf"
    subprocess.check_call('gsutil cp -r '+folder_path+' gs://bucket_py/')
    blobs = bucket.list_blobs()
    for blob in blobs:
        print(blob.name) 

def delete_bucket():
    storage_client = storage.Client()
    bucket_name = "bucket_py"
    bucket = storage_client.get_bucket(bucket_name)
    # blobs = bucket.list_blobs()
    if bucket.exists():
        bucket.delete(force=True)
        print("deleted bucket " +bucket_name)
    else:
        print("no bucket")

    ##write fun for infra creation calling terraform files with subprocess
        

bucket_creation()
upload_obj()
delete_bucket()

# reference: https://www.skytowner.com/explore/checking_if_bucket_exists_in_google_cloud_storage_using_python