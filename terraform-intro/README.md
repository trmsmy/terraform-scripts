# Terraform Introduction 

Simple example of Terraform script which creates bunch of EC2 instances to expose them to internet

The script creates:

* AWS EC2 Launch Configuration
* AWS AutoScaling Group for EC2
* EC2 Instances (t2.micro)
* AWS Elastic Load Balancer (ELB)
* AWS Security Group

## How to run it

### Initialize Terraform environment

```
terraform init
```
The above command downloads terraform provides based on the configuration in "provider" block 

### Terraform plan  

```
terraform plan
```
This command outputs all the AWS resources created/modified if `terraform apply` is executed. Carefully review these before applying the configuration. 

### Terraform Apply

```
terraform apply
```
This intracts with AWS (or any cloud provider APIs) to create/modify/delete AWS services like EC2, ELB etc. The final state of this deployment is saved in terraform.tfstate file. 

At end of the deployment, it also prints all the output values from the script to the console. 

To change the default port for Apache

``` 
terraform apply -var="server_port=<NEW_PORT>" 
```

### Terraform Destroy

To cleanup all AWS Services, 
```
terraform destroy
```

NOTE: EC2 instances should be terminated, but will be visible in the web console for an hour or so before AWS removes it.