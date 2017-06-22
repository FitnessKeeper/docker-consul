# docker-consul


### Customizations ontop of the standard consul image

We create a InstanceStatus services which attempts to determain if the instance is running is Terminating:Wait state, and if so to gracefully exit the cluster.  - Useful for autoscaling events. 

S3_BUCKET - if S3_BUCKET is passed as an env var it will enable a consul backup script. This script requires write access to the backup bucket
