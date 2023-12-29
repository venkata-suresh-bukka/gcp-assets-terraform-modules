import googleapiclient.discovery

def start_vm(request):
    project = 'sunlit-vortex-356909'
    zone = 'us-central1-c'
    instance = 'demo'
    
    compute = googleapiclient.discovery.build('compute', 'v1')
    result = compute.instances().start(project=project, zone=zone, instance=instance).execute()
    # result = compute.instances().stop(project=project, zone=zone, instance=instance).execute()
    # result = compute.instances().delete(project=project, zone=zone, instance=instance).execute()
    return result