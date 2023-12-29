import googleapiclient.discovery

def delete_instances(request):
    # Replace these values with your own project ID and zone
    project_id = 'sunlit-vortex-356909'
    zone = 'us-central1-c'
    instances_lst = []

    # Authenticate with the Compute Engine API
    compute = googleapiclient.discovery.build('compute', 'v1')

    # List all instances in the project and zone
    result = compute.instances().list(project=project_id, zone=zone).execute()
    instances = result.get('items', [])

    if not instances:
        return 'No instances found.'  
    else:
    # Delete each instance
        for instance in instances:
            instance_name = instance['name']
            print(f'Deleting instance {instance_name}...')
            instances_lst.append(instance_name)
            compute.instances().delete(project=project_id, zone=zone, instance=instance_name).execute()
    return f'{instances_lst} Instances deleted.'
        


