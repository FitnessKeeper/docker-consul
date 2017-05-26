#!/bin/sh

REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone/ | sed 's/.$//')
STATUS=$(aws ec2 describe-instance-status --region $REGION --instance-ids $(curl -s http://169.254.169.254/latest/meta-data/instance-id) | jq -r '.InstanceStatuses[0].InstanceStatus.Status')

if [ $STATUS = "ok" ]; then
  echo InstanceStatus is : $STATUS
else
  echo InstanceStatus is : $STATUS
  exit 255
fi
