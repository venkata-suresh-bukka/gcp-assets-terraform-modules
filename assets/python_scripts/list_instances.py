# Import the necessary libraries
from googleapiclient import discovery

# Set the project ID
project_id = 'sunlit-vortex-356909'
zone = 'us-central1-c'
# Create the API client
compute = discovery.build('compute', 'v1')

# Initialize the list of resources
result = compute.instances().list(project=project_id, zone=zone).execute()
instances = result['items']

# Print the name and status of each instance
for instance in instances:
    print(f'instance name: {instance["name"]}- (STATUS={instance["status"]})')

