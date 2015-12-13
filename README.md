Kubernetes on AWS, Terraform style.
=

Introduction
-

The following is an adaptation of  
https://coreos.com/kubernetes/docs/latest/kubernetes-on-aws.html

With a few minor changes:
   
- it's built using terraform!  
- etcd has been seperated out into its own set of dedicated machines.


Getting Started
-
Start by cloning the repository:  

     $] git clone https://github.com/Chronojam/tf-kubeaws

edit the aws-rc.scrt.sh file to add your AWS keys, and other changes you might make (eg. Artifact url if you are planning on customising the bootstrapping scripts)

    $] vim tf-kubeaws/aws-rc.scrt.sh

Create or add your CA cert and key to the root of the certificates folder:

New Key:
    $] cd certificates/
    $] ./root_ca.sh

Existing Key:
( Note, because of the lack of customization currently in the instance creation scripts, these have to be this exact name and in this location )

    $] mv path/to/my/ca-key.pem certificates/ca-key.pem
    $] mv path/to/my/ca.pem certificates/ca.pem

Then you can add various components (etcd servers, worker's, controllers)
by running the appropriate creation script

( these are rough-and-ready, so there is currently very little room for customization, although feel free to change the worker and etcd server ips as you see fit, we currently only support a single controller and it has to have ip 10.0.0.50 ( ability to add more is coming later ) )

    $] cd controller_instances/
    $] ./new_controller.sh 10.0.0.50

    $] cd worker_instances/
    $] ./new_worker.sh 10.0.0.60
    $] ./new_worker.sh 10.0.0.61

    $] cd etcd_instances/
    $] ./new_etcd.sh 10.0.0.20
    $] ./new_etcd.sh 10.0.0.21

Then you can just run:

    $] terraform apply

