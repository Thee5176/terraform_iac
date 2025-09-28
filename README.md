# terraform_iac

This folder contains Terraform configuration to provision VPC, EC2 and RDS resources using local modules under `resources/`.

Quick start

1. Initialize Terraform (no remote backend):

   terraform init -backend=false

2. Validate configuration:

   terraform validate

3. Plan and apply (provide any sensitive variables through environment variables or a tfvars file):

   terraform plan -out plan.tfplan
   terraform apply plan.tfplan

Notes
- The root module wires the `vpc` module outputs into `ec2` and `rds` modules.
- Sensitive values (AWS credentials, DB password, tokens) should be provided securely (env vars, TF Cloud, or vault).
