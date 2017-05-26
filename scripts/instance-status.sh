#!/bin/sh

REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone/ | sed 's/.$//')
ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
ASG=$(aws ec2 describe-instances --region $REGION --instance-ids $ID | jq -r '.Reservations[0].Instances[0].Tags[1].Value')
STATUS=$(aws autoscaling describe-auto-scaling-instances --instance-ids $ID --region $REGION | jq -r '.AutoScalingInstances[0].LifecycleState')

if [ $STATUS = "InService" ]; then
  echo InstanceStatus is : $STATUS
elif [ $STATUS = "Terminating:Wait" ]; then
  echo InstanceStatus is : $STATUS
  exit 255
else
  echo InstanceStatus is : $STATUS
  exit 1
fi
