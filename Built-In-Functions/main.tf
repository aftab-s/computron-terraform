locals {
  # String Functions
  project_name      = "terraform-demo"
  environment      = "development"
  full_name        = "${local.project_name}-${local.environment}"
  uppercase_name   = upper(local.full_name)
  lowercase_name   = lower(local.full_name)
  title_name       = title(local.project_name)
  
  # List Functions
  server_types     = ["web", "app", "db"]
  server_count     = length(local.server_types)
  first_server     = local.server_types[0]
  sorted_servers   = sort(local.server_types)
  reversed_servers = reverse(local.server_types)
  
  # Map Functions
  server_configs = {
    web = "t2.micro"
    app = "t2.small"
    db  = "t2.medium"
  }
  config_keys    = keys(local.server_configs)
  config_values  = values(local.server_configs)
  
  # Numeric Functions
  base_port      = 8000
  port_range     = range(local.base_port, local.base_port + 3)
  max_port       = max(local.port_range...)
  min_port       = min(local.port_range...)
  
  # Date/Time Functions
  current_time   = timestamp()
  formatted_date = formatdate("YYYY-MM-DD", local.current_time)
  
  # Conditional Functions
  is_production  = var.environment == "production"
  instance_type  = local.is_production ? "t3.large" : "t2.micro"
  
  # Collection Functions
  server_tags = {
    for server_type in local.server_types :
    server_type => {
      Name        = "${local.server_type[0]}-${local.environment}"
      Type        = server_type
      Environment = local.environment
      CreatedAt   = local.formatted_date
    }
  }
  
  # Merge function example
  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    CreatedBy   = "Terraform"
    CreatedAt   = local.formatted_date
  }
  
  # File and encoding functions
  sample_data = base64encode("Hello, Terraform!")
  
  # Network functions (examples)
  cidr_block    = "10.0.0.0/16"
  subnet_cidrs  = [for i in range(3) : cidrsubnet(local.cidr_block, 8, i)]
}

# Demonstration resource using functions
resource "local_file" "function_demo" {
  filename = "./function-demo-output.txt"
  content = templatefile("${path.module}/demo-template.tftpl", {
    project_name      = local.project_name
    environment      = local.environment
    full_name        = local.full_name
    uppercase_name   = local.uppercase_name
    server_types     = local.server_types
    server_count     = local.server_count
    server_configs   = local.server_configs
    current_time     = local.current_time
    formatted_date   = local.formatted_date
    instance_type    = local.instance_type
    port_range       = local.port_range
    subnet_cidrs     = local.subnet_cidrs
    encoded_data     = local.sample_data
  })
}
