# Terraform AWS VPC Module

A highly modular Terraform configuration for deploying a customizable AWS Virtual Private Cloud (VPC) with public and private subnets across multiple availability zones.

## Architecture

This module creates a complete networking foundation including:

- VPC with DNS support
- Public and private subnets across multiple availability zones
- Internet Gateway for public internet access
- NAT Gateway for private subnet outbound internet access
- Route tables with appropriate routes
- Network ACLs for network traffic control

## Directory Structure

```
.
├── main.tf                  # Root module configuration
├── variables.tf             # Root variables
├── outputs.tf               # Root outputs
├── terraform.tfvars         # Variable values
└── modules/
    └── vpc/
        ├── main.tf          # VPC module orchestration
        ├── variables.tf     # VPC module variables
        ├── outputs.tf       # VPC module outputs
        ├── vpc_core/        # Core VPC resources
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        ├── subnets/         # Subnet resources
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        ├── internet_gateway/ # Internet Gateway resources
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        ├── nat_gateway/     # NAT Gateway resources
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        ├── route_tables/    # Route Table resources
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        └── network_acls/    # Network ACL resources
            ├── main.tf
            ├── variables.tf
            └── outputs.tf
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (>= 1.2.0)
- AWS account with appropriate permissions
- AWS CLI configured

## Usage

### Basic Usage

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/terraform-aws-vpc.git
   cd terraform-aws-vpc
   ```

2. Update the `terraform.tfvars` file with your desired configuration
   ```hcl
   region               = "us-east-1"
   vpc_cidr             = "10.0.0.0/16"
   environment          = "development"
   availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
   public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
   private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
   ```

3. Initialize Terraform
   ```bash
   terraform init
   ```

4. Review the execution plan
   ```bash
   terraform plan
   ```

5. Apply the configuration
   ```bash
   terraform apply
   ```

### Multiple Environments

Create separate tfvars files for each environment:

1. Create environment-specific files:
   ```
   dev.tfvars
   staging.tfvars
   prod.tfvars
   ```

2. Apply with the appropriate file:
   ```bash
   terraform apply -var-file=dev.tfvars
   ```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| region | AWS region to deploy resources | string | "us-east-1" |
| vpc_cidr | CIDR block for the VPC | string | "10.0.0.0/16" |
| environment | Environment name for tagging | string | "development" |
| availability_zones | List of availability zones | list(string) | ["us-east-1a", "us-east-1b", "us-east-1c"] |
| public_subnet_cidrs | CIDR blocks for public subnets | list(string) | ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] |
| private_subnet_cidrs | CIDR blocks for private subnets | list(string) | ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the created VPC |
| vpc_cidr | CIDR block of the created VPC |
| public_subnet_ids | List of public subnet IDs |
| private_subnet_ids | List of private subnet IDs |
| internet_gateway_id | ID of the Internet Gateway |
| nat_gateway_id | ID of the NAT Gateway |

## Module Components

### VPC Core
Creates the base VPC with DNS support enabled.

### Subnets
Creates public and private subnets across multiple availability zones.

### Internet Gateway
Provisions an Internet Gateway and attaches it to the VPC.

### NAT Gateway
Sets up a NAT Gateway in a public subnet with an Elastic IP for private subnet internet access.

### Route Tables
Configures route tables for public and private subnets with appropriate routes.

### Network ACLs
Sets up basic network access control lists for public and private subnets.

## Customization

### Adding Custom Tags
You can add custom tags to all resources by modifying the tags block in each resource definition.

### Adjusting CIDR Blocks
Modify the CIDR blocks in the `terraform.tfvars` file to suit your needs.

### Adding Additional Subnets
Increase the number of elements in the availability_zones, public_subnet_cidrs, and private_subnet_cidrs variables.

## Security Considerations

- The default Network ACLs allow all traffic. For production environments, consider implementing more restrictive rules.
- The NAT Gateway is deployed in the first public subnet. For high availability, consider deploying NAT Gateways in multiple AZs.

## Cost Considerations

Resources in this module that incur costs:
- NAT Gateway hourly usage and data processing
- Elastic IP if not associated with a running instance

## Troubleshooting

### Common Issues

1. **Availability Zone Validation Failure**
   - Make sure the specified availability zones are available in your account and region

2. **CIDR Block Conflicts**
   - Ensure there are no overlapping CIDR blocks

3. **Insufficient Permissions**
   - Verify your AWS credentials have the necessary permissions

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Terraform documentation and best practices
- AWS architecture guidelines
