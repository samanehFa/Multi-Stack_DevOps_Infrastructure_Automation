# Multi-Stack DevOps Infrastructure Automation

## Overview
This repository provides infrastructure automation scripts for deploying a multi-stack DevOps environment. It includes configurations for provisioning, deployment, and management of backend and frontend services using tools like Terraform, Ansible, and Docker.

There are two deployment attempts documented in this repository:

1. **Database Hosted on EC2**: In this approach, the database is deployed on an EC2 instance, providing full control over configuration and management.
2. **Database Hosted on AWS RDS**: In this attempt, AWS RDS is used for database hosting, leveraging managed services for improved scalability and maintenance.

## Reference
The application code used in the `result`, `vote`, and `worker` components originates from [this repository](https://github.com/Pokfinner/ironhack-project-1).

![image](https://github.com/user-attachments/assets/cf91f411-4095-4cbe-a83b-cab7f501d652)

## SSH ProxyJump Configuration
To access different backend and frontend instances securely via a bastion host, configure your SSH settings by adding the following to your `~/.ssh/config` file:

```ini
Host bastion
    User ubuntu
    Hostname <BASTION_PUBLIC_IP>
    IdentityFile <YOUR_PRIVATE_KEY_PATH>
 
Host backend1-redis-worker
    ProxyJump bastion
    HostName <PRIVATE_IP_BACKEND1>
    User ubuntu
    IdentityFile <YOUR_PRIVATE_KEY_PATH>

Host backend2-postgresql
    ProxyJump bastion
    HostName <PRIVATE_IP_BACKEND2>
    User ubuntu
    IdentityFile <YOUR_PRIVATE_KEY_PATH>

Host frontend-vote-result
    ProxyJump bastion
    HostName <PRIVATE_IP_FRONTEND>
    User ubuntu
    IdentityFile <YOUR_PRIVATE_KEY_PATH>
```

### How to Use ProxyJump
1. Ensure your private key has the correct permissions:
   ```sh
   chmod 400 <YOUR_PRIVATE_KEY_PATH>
   ```
2. Use SSH to connect to any instance through the bastion:
   ```sh
   ssh backend1-redis-worker
   ```
   or
   ```sh
   ssh backend2-postgresql
   ```

By using this configuration, you can securely tunnel into private instances via the bastion without exposing them to the public internet.

### Project Architecture
![image](https://github.com/user-attachments/assets/04dbdcf6-9b18-4ab7-a03d-cafcb914bcae)

## Getting Started
1. Clone the repository:
   ```sh
   git clone https://github.com/samanehFa/Multi-Stack_DevOps_Infrastructure_Automation.git
   cd Multi-Stack_DevOps_Infrastructure_Automation
   ```
2. Provision the AWS infrastructure using Terraform:
   ```sh
   cd terraform
   terraform init
   terraform apply -auto-approve
   ```
3. Run the Ansible playbook to configure the instances:
   ```sh
   cd ../Ansible
   ansible-playbook -i inventory playbook.yml
   ```

Once these steps are completed, the infrastructure and application services should be fully deployed and operational.
