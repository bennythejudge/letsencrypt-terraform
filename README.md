# Let's Encrypt Terraform example

[![GuardRails badge](https://badges.production.guardrails.io/bennythejudge/letsencrypt-terraform.svg)](https://www.guardrails.io)

This repository houses the source code referenced in the blog [Let's Encrypt and Terraform - Getting free certificates for your infrastructure](https://opencredo.com/letsencrypt-terraform). It demonstrates a working example of leveraging the [Terraform ACME provider](https://github.com/paybyphone/terraform-provider-acme) to generate and install a free Let's Encrypt certificate on an AWS ELB, fronting some EC2 instances with NGINX on them. Please see the blog for more details / instructions.


# Pre-requisites (if running the examples as-is) 
**An AWS account**

You will need a working AWS account as well as acquire credentials for a user who has the necessary privileges in an AWS account to be able to create and destroy the appropriate resources defined in the Terraform files. For more information about AWS access keys, and how to create them see https://aws.amazon.com/developers/access-keys.

**A domain** 

You will need a domain which you can control. You can use an existing one, or buy a new one which is not been taken yet. This can be acquired from somewhere like GoDaddy, NameCheap etc. 

**AWS Route53 configured as your DNS provider**

Within AWS, using Route53 you will need to configure a public hosted zone for this domain. Once created, you can then take the nameservers generated by AWS for you, and update them in your DNS registrar as your new nameservers. This will allow Terraform to use Route53 to manage the domain. For more information on how to do this see http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html and http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/GetInfoAboutHostedZone.html.

# Running the consolidated all in one version 
These instructions are for Mac OS

* Get the binaries, setup your PATH
````
mkdir ~/demobin
wget https://releases.hashicorp.com/terraform/0.8.4/terraform_0.8.4_darwin_amd64.zip
unzip terraform_0.8.4_darwin_amd64.zip -d ~/demobin
wget https://github.com/paybyphone/terraform-provider-acme/releases/download/v0.2.1/terraform-provider-acme_v0.2.1_darwin_amd64.zip
unzip terraform-provider-acme_v0.2.1_darwin_amd64.zip -d ~/demobin
sudo chmod +x demobin/terraform*
export PATH=$PATH:~/demobin
````

* Get the GitHub repo
````
git clone https://github.com/opencredo/letsencrypt-terraform.git
cd demos/acme-consolidated
````


* Configure variables
Within the `demos/acme-consolidated/variables.tf` file, change to configure to point to your domain (i.e. not example.com), and point at the appropriate Let's Encrypt server. (staging or production)

````
# -- Staging
variable "demo_acme_server_url"          { default = "https://acme-staging.api.letsencrypt.org/directory"}
variable "demo_acme_registration_email"  { default = "your-email@example.com" }

# Domain against which certificate will be created
# i.e. letsencrypt-terraform.example.com
variable "demo_domain_name"              { default = "example.com"}
variable "demo_domain_subdomain"         { default = "letsencrypt-terraform"}
````

* Configure core Terraform (AWS) provider credentials
```` 
export AWS_ACCESS_KEY_ID=yyyyyyyy 
export AWS_SECRET_ACCESS_KEY=zzzzzzzz 
export AWS_DEFAULT_REGION=eu-west-1
````

* Configure credentials used by the ACME Terraform provider
````
# These can simply be the same as those specified for the core 
# AWS terraform credentials 
export TF_VAR_demo_acme_challenge_aws_access_key_id=$AWS_ACCESS_KEY_ID 
export TF_VAR_demo_acme_challenge_aws_secret_access_key=$AWS_SECRET_ACCESS_KEY
export TF_VAR_demo_acme_challenge_aws_region=$AWS_DEFAULT_REGION
````

* Run terraform
````
terraform get
terraform plan 
terraform apply
````

* Verify

Go to a browser and go to your domain i.e. https://letsencrypt-terraform.example.com

