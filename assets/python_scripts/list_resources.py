from google.cloud.resource_manager_v1 import ResourceManagerClient

# Create a Resource Manager client object
resource_manager_client = ResourceManagerClient()

# Get a list of all resources in the project
project_id = 'sunlit-vortex-356909'
resources = resource_manager_client.search(project_id=project_id).results

# Print out information for each resource
for resource in resources:
    print(f'Resource type: {resource.resource_type}')
    print(f'Resource ID: {resource.name}')
    print(f'Resource display name: {resource.display_name}')
    print(f'Resource parent: {resource.parent}')
    print(f'Resource location: {resource.location}')
    print()




