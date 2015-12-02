# Configuration File
# Set the variables here to customize the cluster to your own needs.

# Make sure you source these variables, to avoid entering your credentials when you run terraform

#export TF_VAR_aws_access_key="REDACTED"
#export TF_VAR_aws_secret_key="REDACTED"

## Misc.
export TF_VAR_availability_zone="eu-west-1"
export TF_VAR_cluster_name="kubernetes"
export TF_VAR_key_name="jam-master"
export TF_VAR_coreos_ami="ami-eb97bc9c"

## Infrastructure
export TF_VAR_etcd_instance_type="t2.small"
export TF_VAR_controller_instance_type="t2.small"
export TF_VAR_worker_instance_type="m3.medium"

artifact_url="https://chronojam-coreos.s3-eu-west-1.amazonaws.com"
