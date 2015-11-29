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


You'll either want to generate your own certificates, or use your own, if you want to generate them, then you can run the scripts inside the certificate folder (Note that the certificate paths have to match up with what's inside the aws-rc.scrt file):  

    $] tf-kubeaws/certificates/ca/root-ca.sh
    $] tf-kubeaws/certificates/api-server/api-server.sh
    $] tf-kubeaws/certificates/worker/worker.sh


Then you can just run:

    $] cd tf-kubeaws
    $] terraform apply

rc.scrt.sh variables
--

###Terraform Variables
- TF\_VAR\_aws\_access\_key : Your AWS Access key
- TF\_VAR\_aws\_secret\_key  : Your AWS Secret Access key
- TF\_VAR\_availability\_zone : Where you want the cluster to spawn [ Default : eu-west-1 ]
- TF\_VAR\_cluster\_name : The name of your cluster [ Default : kubernetes ]
- TF\_VAR\_key\_name : The SSH key pair name that you'll want to access the machines.
- TF\_VAR\_coreos\_ami: The ami of a CoreOS image, you should only need to change this if you are also changing the avaliabilty zone [ Default:  ami-eb97bc9c ]
- TF\_VAR\_etcd\_instance\_type : what size you want the etcd instances to be [ Default: t2.small ]
- TF\_VAR\_controller\_instance\_type :  what size you want the controller instances to be [ Default: t2.small ]
- TF\_VAR\_worker\_instance\_type: what size you want the worker instances to be [ Default: t3.medium ]


### Controller Specific.
If you are using custom certificates, make sure to update the values here.
  
- api\_server\_cert=$(cat certificates/api-server/apiserver.pem |base64 |sed ':a;N;$!ba;s/\n//g')  
- api\_server\_key=$(cat certificates/api-server/apiserver-key.pem |base64 |sed ':a;N;$!ba;s/\n//g')

### Worker Specific.
likewise, if you are using custom certificates, make sure you update it here
  
- worker\_cert=$(cat certificates/worker/worker.pem |base64 |sed ':a;N;$!ba;s/\n//g')  
- worker\_key=$(cat certificates/worker/worker-key.pem |base64 |sed ':a;N;$!ba;s/\n//g')


### Misc
- artifact\_url="https://chronojam-coreos.s3-eu-west-1.amazonaws.com"  
  if you have updated the artifacts, you'll need to point this to the location where they are hosted.
- ca\_cert=$(cat certificates/ca/ca.pem |base64 |sed ':a;N;$!ba;s/\n//g')  
  if you have custom certs, make sure to update this.

Debugging
-
wip
