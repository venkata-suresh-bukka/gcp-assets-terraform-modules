# # Import the necessary libraries
# from googleapiclient import discovery
# from googleapiclient import errors

# # Set the project, instance, and new VPC ID
# project_id = 'sunlit-vortex-356909'
# instance_name = 'instance-1'
# new_vpc_id = 'default'

# # Create the API client
# compute = discovery.build('compute', 'v1')

# # Get the instance
# instance = compute.instances().get(project=project_id, zone='us-central1-c', instance=instance_name).execute()

# # Store the current network and subnetwork
# current_network = instance['networkInterfaces'][0]['network']
# current_subnetwork = instance['networkInterfaces'][0]['subnetwork']

# # Update the instance's network and subnetwork
# instance['networkInterfaces'][0]['network'] = new_vpc_id
# instance['networkInterfaces'][0]['subnetwork'] = new_vpc_id + '-subnet-1'

# # Execute the update request
# request = compute.instances().update(project=project_id, zone='us-central1-a', instance=instance_name, body=instance)

# try:
#     # Wait for the update to complete
#     request.execute()
#     print('Instance successfully migrated to new VPC!')
# except errors.HttpError as error:
#     print(f'An error occurred while migrating the instance: {error}')


# from google.oauth2.credentials import Credentials
# from google.cloud import compute
# import google.auth

# # Create a Google Cloud API client
# info = google.auth.compute_engine.get_authorized_user_info()

# credentials = Credentials.from_authorized_user_info(info=info)
# compute_client = compute.Client(credentials=credentials)

# # Create a compute client
# vm_name = "instance-1"
# zone = "us-central1-c"

# new_network_name = "demo-vpc"
# new_subnet = "demo-subnet"
# # Get the VM that you want to migrate
# vm = compute_client.instance(vm_name, zone)

# # Get the current network of the VM
# network = vm.network_interfaces[0]["network"]

# # Get the current subnet of the VM
# subnet = vm.network_interfaces[0]["subnet"]


# # Get the new network and subnet that you want to migrate the VM to
# new_network = compute_client.network(new_network_name)
# new_subnet = new_network.subnet(new_subnet_name)

# # Set the new network and subnet on the VM
# vm.set_network_interface(network=new_network.self_link, subnet=new_subnet.self_link)

# # Save the changes to the VM
# vm.update()


import google.auth
from google.cloud import compute
from googleapiclient import discovery


# Set the project, zone, and VM names
project_id = 'sunlit-vortex-356909'
zone = 'us-central1-c'
vm_name = 'instance-1'

# Set the destination VPC name
destination_vpc = 'demo-vps'

# Authenticate with Google Cloud
credentials, project = google.auth.default()

# Create a compute client
client = discovery.build('compute', 'v1', credentials=credentials)

# Stop the VM
print('Stopping VM')
operation = client.instances().stop(project=project_id, zone=zone, instance=vm_name).execute()

# Wait for the stop operation to complete
client.zoneOperations().wait(project=project_id, zone=zone, operation=operation['name']).execute()

# Detach all disks from the VM
# disks = client.instances().listDisks(project=project_id, zone=zone, instance=vm_name).execute()
# response = client.instances().listDisks(project=project_id, zone=zone, instance=vm_name).execute()
# disks = response.get('items', [])
instance = client.instances(vm_name, zone=zone)
disks = instance.list_disks()

for disk in disks:
    print(f'Detaching disk {disk["deviceName"]}')
    operation = client.instances().detachDisk(project=project_id, zone=zone, instance=vm_name, deviceName=disk['deviceName']).execute()
    client.zoneOperations().wait(project=project_id, zone=zone, operation=operation['name']).execute()

# Create a snapshot of each disk
snapshots = []
for disk in disks:
    snapshot_name = f'{disk["deviceName"]}-snapshot'
    print(f'Creating snapshot {snapshot_name}')
    operation = client.disks().createSnapshot(project=project_id, zone=zone, disk=disk['deviceName'], body={'name': snapshot_name}).execute()
    client.zoneOperations().wait(project=project_id, zone=zone, operation=operation['name']).execute()
    snapshots.append({'deviceName': disk['deviceName'], 'sourceSnapshot': snapshot_name})

# Create a new disk in the destination VPC for each snapshot
new_disks = []
for snapshot in snapshots:
    new_disk_name = f'{snapshot["deviceName"]}-new'
    print(f'Creating new disk {new_disk_name}')
    operation = client.disks().create(project=project_id, zone=zone, body={'name': new_disk_name, 'sourceSnapshot': snapshot['sourceSnapshot'], 'type': 'pd-standard'}, vpc=destination_vpc).execute()
    client.zoneOperations().wait(project=project_id, zone=zone, operation=operation['name']).execute()
    new_disks.append({'deviceName': snapshot['deviceName'], 'source': new_disk_name})

# Create a new VM in the destination VPC using the new disks
print('Creating new VM')
operation = client.instances().create()
