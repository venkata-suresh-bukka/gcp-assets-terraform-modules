import os
from google.cloud import compute

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'C:\key.json'

# Create a client for interacting with the Compute Engine API
client = compute.Client()

# Set the name and description for the VPC
name = 'my-vpc'
description = 'My VPC'

# Create a configuration object for the VPC
vpc_config = {
    'name': name,
    'description': description,
}

# Use the client to create the VPC
vpc = client.create_vpc(vpc_config)

# Print the ID of the VPC
print(vpc.id)
