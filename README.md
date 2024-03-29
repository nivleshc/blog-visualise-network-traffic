# Visualise Network Traffic in AWS using VPC Flow Logs and Grafana

This repository contains code for visualising network traffic in AWS.

The code is written using Terraform.

Detailed instructions are available at [https://nivleshc.wordpress.com/2024/03/28/visualise-network-traffic-in-aws-using-vpc-flow-logs-and-grafana-part-1-vpc-setup/](https://nivleshc.wordpress.com/2024/03/28/visualise-network-traffic-in-aws-using-vpc-flow-logs-and-grafana-part-1-vpc-setup/)

## Prerequisites
This code will be deployed from your local computer. Before starting, ensure
you have the below mentioned tools alread installed on your local machine.
- AWS CLI (installed and a default profile configured)
- Terraform

## Implementation
Use the following steps to download the code and then deploy into your own AWS Account.

```
git clone https://github.com/nivleshc/blog-visualise-network-traffic.git

cd blog-visualise-network-traffic
terraform apply
```

