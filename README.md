## Prerequisites
### AWS Credentials:
Ensure you have AWS credentials configured with the necessary permissions to create Elastic Beanstalk environments.

### Terraform Installation:
Install Terraform on your local machine.

### Getting Started

1. Clone the Repository:
    ```bash
    git clone https://github.com/dhairya00713/elasticbeanstalk-tf.git
    cd elasticbeanstalk-tf
    ```
2. Initialize Terraform:
    ```bash
    terraform init
    ```
3. Configure Variables:

    Edit `terraform.tfvars` file with your necessary details

### Create Elastic Beanstalk Environment
1. Run Terraform Plan:
    ```bash
    terraform plan
    ```

2. Apply Changes:
    ```bash
    terraform apply -var-file="terraform.tfvars"
    ```
    Enter 'yes' when prompted.

3. Review Outputs:
After successful deployment, review the Terraform outputs for important information such as the environment URL.

### Clean Up
1. Destroy Resources:
    ```bash
    terraform destroy
    ```
    Enter 'yes' when prompted.

2. Verify Deletion:
    Ensure all resources are deleted from the AWS Management Console.