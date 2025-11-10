import boto3

# Create a custom AWS Identity and Access Management (IAM) policy and IAM role for your Lambda function.
# Create Lambda functions that stop and start your EC2 instances.
# Test your Lambda functions.
# Create EventBridge schedules that run your function on a schedule.

def instance_stop_by_tag(tags, region):
    filters = [{"Name": f'tag:{key}', "Values":[value]}for key,value in tags.items()]
    filters.append({'Name': "instance-state-name", "Values": ['running']})  # Include only running instances
    ec2 = boto3.client('ec2',region_name = region)
    try:
        response = ec2.describe_instances(Filters=filters)
        instances_to_stop= []
        # Extract instance IDs
        for reservation in response["Reservations"]:
            for instance in reservation["Instances"]:
                instances_to_stop.append(instance["InstanceId"])
        # Stop instances if any found
        if instances_to_stop:
            stopped_instances = ec2.stop_instances(InstanceIds=instances_to_stop)
            print(f"stopped instances Id's are {instances_to_stop}")
        else:
            print("no instances to stop")

    except Exception as e:
        print(f"Error: {str(e)}")


def lambda_handler(event, context):
    tags = {
        'Auto-instance-scheduler': 'yes',
        'environment': 'dev' 
        }
    region = "us-east-1"
    instance_stop_by_tag(tags,region)

lambda_handler("event","context")    
