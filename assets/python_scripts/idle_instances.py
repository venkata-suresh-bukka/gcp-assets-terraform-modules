import googleapiclient.discovery

def get_cpu_utilization(project_id, zone, instance_name):
  """Gets the CPU utilization of the specified VM instance.

  Args:
    project_id: The ID of the project that the VM instance belongs to.
    zone: The zone where the VM instance is located.
    instance_name: The name of the VM instance.

  Returns:
    The CPU utilization of the VM instance, as a number between 0 and 100.
  """

  client = googleapiclient.discovery.build('compute', 'v1',
                                          credentials=None)

  request = client.instances().get(
      project=project_id, zone=zone, instance=instance_name)
  response = request.execute()

  # The CPU utilization is returned as a number between 0 and 100.

  cpu_utilization = response['metric_utilization']['cpuUtilization'] * 100

  return cpu_utilization


def main():
  project_id = 'vertical-hook-393809'
  zone = 'us-west4-b'
  instance_name = 'instance-2'

  cpu_utilization = get_cpu_utilization(project_id, zone, instance_name)

  print('The CPU utilization of the VM instance is {}%.'.format(cpu_utilization))


if __name__ == '__main__':
  main()


