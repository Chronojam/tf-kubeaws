# Configuration File
# Set the variables here to customize the cluster to your own needs.

# Make sure you source these variables, to avoid entering your credentials when you run terraform

#export TF_VAR_aws_access_key="REDACTED"
#export TF_VAR_aws_secret_key="REDACTED"

WORKER_ADDR="10.0.0.60 10.0.0.61"
CONTROLLER_ADDR="10.0.0.50"

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
ca_cert=$(cat certificates/ca/ca.pem |base64 |sed ':a;N;$!ba;s/\n//g')

## Configuration
export TF_VAR_etcd_cloud_config=$(cat config/etcd.yml)

for ADDR in $WORKER_ADDR
do
  worker_cert=$(cat certificates/worker/$ADDR-worker.pem |base64 |sed ':a;N;$!ba;s/\n//g')
  worker_key=$(cat certificates/worker/$ADDR-worker-key.pem |base64 |sed ':a;N;$!ba;s/\n//g')
  t_var_name="TF_VAR_worker_cloud_config_$ADDR"
  var_name=${t_var_name//"."/"_"}
  var_value=$(cat config/worker.yml| \
  sed -e "s#{{ ca_cert }}#$ca_cert#g" | \
  sed -e "s#{{ worker_cert }}#$worker_cert#g" | \
  sed -e "s#{{ worker_key }}#$worker_key#g" | \
  sed -e "s#{{ artifact_url }}#$artifact_url#g")
  # Tried several ways with eval, declare, export etc, before getting it to work like this
  # Im trying to export variable names that have the name of the value of other variables,
  # this makes it easier to template into terraform at a later date
  export $( echo $var_name )="$var_value"
  echo "Processed worker $ADDR"
done

for ADDR in $CONTROLLER_ADDR
do
  api_server_cert=$(cat certificates/api-server/$ADDR-apiserver.pem |base64 |sed ':a;N;$!ba;s/\n//g')
  api_server_key=$(cat certificates/api-server/$ADDR-apiserver-key.pem |base64 |sed ':a;N;$!ba;s/\n//g')
  t_var_name="TF_VAR_controller_cloud_config_$ADDR"
  var_name=${t_var_name//"."/"_"}
  var_value=$(cat config/controller.yml| \
  sed -e "s#{{ ca_cert }}#$ca_cert#g" | \
  sed -e "s#{{ api_server_cert }}#$api_server_cert#g" | \
  sed -e "s#{{ api_server_key }}#$api_server_key#g" | \
  sed -e "s#{{ artifact_url }}#$artifact_url#g" )
  export $( echo $var_name )="$var_value"
  echo "Processed controller $ADDR"
done
