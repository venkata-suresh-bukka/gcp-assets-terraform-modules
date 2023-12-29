# Import the necessary libraries
from googleapiclient import discovery

# Set the project ID
project_id = 'sunlit-vortex-356909'
zone = 'us-central1-c'
# Create the API client
bigquery_service = discovery.build('bigquery', 'v2')

# Initialize the list of resources
try:
    result = bigquery_service.datasets().list(projectId=project_id).execute()
    datasets = result['datasets']
    for dataset in datasets:
        if "friendlyName" in dataset:
            print(f'dataset_name: {dataset["datasetReference"]["datasetId"]}: {dataset["friendlyName"]}')
        else:
            print(f'dataset_name: {dataset["datasetReference"]["datasetId"]}')
except:
    print("No datasets found")

# Print the dataset ID and friendly name of each dataset
