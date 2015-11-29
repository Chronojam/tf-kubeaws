# AWS Authentication Params #
variable "aws_access_key" {}
variable "aws_secret_key" {}

## Misc. ##
variable "artifact_url" {
  default = "https://coreos-kubernetes.s3.amazonaws.com/v0.1.0"
  description = "Public location of coreos-kubernetes deployment artifacts"
}
variable "availability_zone" {
  description = "Specific availability zone"
}
variable "cluster_name" {
  default = "kubernetes"
  description = "Name of Kubernetes cluster"
}
variable "key_name" {
  description = "SSH Access Key to authorize on each instance"
}
variable "coreos_ami" {
  default = "ami-eb97bc9c"
  description = "The ami number to use for the OS"
}

## Infrastructure Stuff ##
variable "controller_instance_type" {
  default = "t2.small"
  description = "EC2 instance type used for each controller instance"
}
variable "worker_instance_type" {
  default = "m3.medium"
  description = "EC2 instance type used for each worker instance"
}
variable "etcd_instance_type" {
  default = "t2.small"
  description = "EC2 instance type used for each etcd instance"
}
## Etcd ##
variable "etcd_cloud_config" {
  description = "cloud config for etcd nodes"
}

## Controller ##
variable "controller_cloud_config" {
  description = "cloud config for the controller"
}


## Workers ##
variable "worker_cloud_config" {
  description = "cloud config for the worker nodes"
}
