# Variables directory — types & examples

This folder contains Terraform variable definitions (`variables.tf`) and example override values (`terraform.tfvars`).

This README expands on every Terraform variable type with short, copyable examples (declaration, `*.tfvars`, CLI, and `-var-file`) and PowerShell-friendly commands.

Files
- `variables.tf` — declares input variables (type, description, defaults).
- `terraform.tfvars` — example values to override defaults during local development.

Quick reference (this repo)
- Current variables declared in `variables.tf`:
  - `filename` — string (default: `iac.txt`)

Terraform variable types and examples

1) string
----------------
Declaration (in `variables.tf`):

```hcl
variable "example_string" {
  description = "A simple string"
  type        = string
  default     = "hello"
}
```

Set in `terraform.tfvars`:

```hcl
example_string = "custom text"
```

CLI override:

**Windows (PowerShell):**
```powershell
terraform apply -var "example_string=cli-value"
```

**Linux/Mac (Bash):**
```bash
terraform apply -var "example_string=cli-value"
```

2) number
----------------
Declaration:

```hcl
variable "example_number" {
  description = "A numeric value"
  type        = number
  default     = 42
}
```

`terraform.tfvars`:

```hcl
example_number = 100
```

CLI override:

**Windows (PowerShell):**
```powershell
terraform apply -var "example_number=7"
```

**Linux/Mac (Bash):**
```bash
terraform apply -var "example_number=7"
```

3) bool
----------------
Declaration:

```hcl
variable "example_bool" {
  description = "A boolean flag"
  type        = bool
  default     = true
}
```

`terraform.tfvars`:

```hcl
example_bool = false
```

CLI override:

**Windows (PowerShell):**
```powershell
terraform apply -var "example_bool=false"
```

**Linux/Mac (Bash):**
```bash
terraform apply -var "example_bool=false"
```

4) list
----------------
Declaration (list of strings):

```hcl
variable "example_list" {
  description = "A list of strings"
  type        = list(string)
  default     = ["a", "b"]
}
```

`terraform.tfvars`:

```hcl
example_list = ["one", "two", "three"]
```

CLI override (JSON format is easiest for complex types):

**Windows (PowerShell):**
```powershell
terraform apply -var 'example_list=["x","y","z"]'
```

**Linux/Mac (Bash):**
```bash
terraform apply -var 'example_list=["x","y","z"]'
```

5) map
----------------
Declaration:

```hcl
variable "example_map" {
  description = "A map of string -> string"
  type        = map(string)
  default     = { key1 = "value1" }
}
```

`terraform.tfvars`:

```hcl
example_map = {
  name  = "app"
  owner = "team"
}
```

CLI override:

**Windows (PowerShell):**
```powershell
terraform apply -var 'example_map={name="cli",owner="you"}'
```

**Linux/Mac (Bash):**
```bash
terraform apply -var 'example_map={name="cli",owner="you"}'
```

6) object
----------------
Declaration (typed object):

```hcl
variable "example_object" {
  description = "A structured object"
  type = object({
    name = string
    port = number
  })
  default = { name = "web", port = 80 }
}
```

`terraform.tfvars`:

```hcl
example_object = { name = "api", port = 8080 }
```

CLI override (JSON is simpler for nested values):

**Windows (PowerShell):**
```powershell
terraform apply -var 'example_object={name="cli-api",port=9090}'
```

**Linux/Mac (Bash):**
```bash
terraform apply -var 'example_object={name="cli-api",port=9090}'
```

7) tuple
----------------
Declaration (fixed-order heterogeneous list):

```hcl
variable "example_tuple" {
  description = "A tuple with fixed types"
  type = tuple([string, number, bool])
  default = ["ok", 1, true]
}
```

`terraform.tfvars`:

```hcl
example_tuple = ["x", 2, false]
```

Using variables in main.tf
----------------

Once variables are declared, you reference them in your `main.tf` (or other `.tf` files) using `var.<variable_name>`. Here's how to work with each type:

**1) String variables:**

```hcl
# variables.tf
variable "bucket_name" {
  type = string
}

# main.tf
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
}
```

**2) Number variables:**

```hcl
# variables.tf
variable "instance_count" {
  type = number
}

# main.tf
resource "aws_instance" "web" {
  count         = var.instance_count
  instance_type = "t2.micro"
  # ...
}
```

**3) Bool variables:**

```hcl
# variables.tf
variable "enable_encryption" {
  type = bool
}

# main.tf
resource "aws_s3_bucket" "example" {
  bucket = "my-bucket"
  
  # Use in conditionals
  versioning {
    enabled = var.enable_encryption
  }
}
```

**4) List variables - Indexing:**

```hcl
# variables.tf
variable "availability_zones" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# main.tf
# Access specific element by index (zero-based)
resource "aws_subnet" "first" {
  availability_zone = var.availability_zones[0]  # "us-east-1a"
}

resource "aws_subnet" "second" {
  availability_zone = var.availability_zones[1]  # "us-east-1b"
}

# Iterate over the entire list
resource "aws_subnet" "all" {
  count             = length(var.availability_zones)
  availability_zone = var.availability_zones[count.index]
}

# Use with for_each
resource "aws_subnet" "foreach_example" {
  for_each          = toset(var.availability_zones)
  availability_zone = each.value
}
```

**5) Map variables - Key lookup:**

```hcl
# variables.tf
variable "instance_types" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    prod = "t3.large"
  }
}

# main.tf
# Access specific value by key
resource "aws_instance" "web" {
  instance_type = var.instance_types["prod"]  # "t3.large"
}

# Dynamic key lookup
variable "environment" {
  type = string
}

resource "aws_instance" "dynamic" {
  instance_type = var.instance_types[var.environment]
}

# Iterate over map with for_each
resource "aws_instance" "all_envs" {
  for_each      = var.instance_types
  instance_type = each.value  # The map value
  
  tags = {
    Environment = each.key  # The map key
  }
}
```

**6) Object variables - Attribute access:**

```hcl
# variables.tf
variable "database_config" {
  type = object({
    name     = string
    port     = number
    username = string
    backup   = bool
  })
  default = {
    name     = "mydb"
    port     = 5432
    username = "admin"
    backup   = true
  }
}

# main.tf
# Access object attributes with dot notation
resource "aws_db_instance" "main" {
  db_name  = var.database_config.name      # "mydb"
  port     = var.database_config.port      # 5432
  username = var.database_config.username  # "admin"
  
  backup_retention_period = var.database_config.backup ? 7 : 0
}
```

**7) List of objects - Combined indexing:**

```hcl
# variables.tf
variable "servers" {
  type = list(object({
    name = string
    size = string
    zone = string
  }))
  default = [
    { name = "web-1", size = "t2.micro", zone = "us-east-1a" },
    { name = "web-2", size = "t2.small", zone = "us-east-1b" }
  ]
}

# main.tf
# Access by index, then attribute
resource "aws_instance" "first_server" {
  instance_type     = var.servers[0].size  # "t2.micro"
  availability_zone = var.servers[0].zone  # "us-east-1a"
  
  tags = {
    Name = var.servers[0].name  # "web-1"
  }
}

# Iterate over list of objects
resource "aws_instance" "all_servers" {
  count             = length(var.servers)
  instance_type     = var.servers[count.index].size
  availability_zone = var.servers[count.index].zone
  
  tags = {
    Name = var.servers[count.index].name
  }
}
```

**8) Map of objects - Key lookup with attributes:**

```hcl
# variables.tf
variable "environments" {
  type = map(object({
    instance_type = string
    disk_size     = number
  }))
  default = {
    dev = {
      instance_type = "t2.micro"
      disk_size     = 20
    }
    prod = {
      instance_type = "t3.large"
      disk_size     = 100
    }
  }
}

# main.tf
# Access by key, then attribute
resource "aws_instance" "prod_server" {
  instance_type = var.environments["prod"].instance_type  # "t3.large"
  
  root_block_device {
    volume_size = var.environments["prod"].disk_size  # 100
  }
}

# Dynamic lookup
variable "current_env" {
  type = string
}

resource "aws_instance" "dynamic_server" {
  instance_type = var.environments[var.current_env].instance_type
  
  root_block_device {
    volume_size = var.environments[var.current_env].disk_size
  }
}
```

**Common functions for variable manipulation:**

```hcl
# Length of list/map
count = length(var.availability_zones)

# Check if key exists in map
contains(keys(var.instance_types), "dev")

# Merge maps
merged = merge(var.default_tags, var.custom_tags)

# Convert list to set (for for_each)
for_each = toset(var.availability_zones)

# Lookup with default
instance_type = lookup(var.instance_types, var.environment, "t2.micro")
```

Advanced usage
----------------

Using `-var-file` to load environment-specific values (recommended):

**Windows (PowerShell):**
```powershell
terraform apply -var-file="dev.tfvars"
```

**Linux/Mac (Bash):**
```bash
terraform apply -var-file="dev.tfvars"
```

Inline JSON for complex CLI overrides:

**Windows (PowerShell):**
```powershell
terraform apply -var='example_object={"name":"json","port":9090}'
```

**Linux/Mac (Bash):**
```bash
terraform apply -var='example_object={"name":"json","port":9090}'
```

Variable passing methods & precedence
----------------

Terraform accepts variable values from multiple sources. When the same variable is set in multiple places, Terraform uses the following precedence order (highest to lowest):

**1. Command-line flags (-var and -var-file)** — Highest precedence

```powershell
# -var flag (individual variables)
terraform apply -var "filename=override.txt" -var "environment=prod"

# -var-file flag (load from file)
terraform apply -var-file="prod.tfvars"

# Multiple -var-file flags are processed in order (later files override earlier ones)
terraform apply -var-file="base.tfvars" -var-file="prod.tfvars"
```

**2. terraform.tfvars or terraform.tfvars.json** — Automatically loaded

If present in the working directory, Terraform automatically loads these files:

```powershell
# terraform.tfvars (HCL format)
filename = "auto-loaded.txt"
environment = "dev"
```

```json
// terraform.tfvars.json (JSON format)
{
  "filename": "auto-loaded.txt",
  "environment": "dev"
}
```

**3. *.auto.tfvars or *.auto.tfvars.json** — Automatically loaded (alphabetical order)

Any file matching `*.auto.tfvars` or `*.auto.tfvars.json` in the working directory:

```powershell
# Example files that are auto-loaded:
# - common.auto.tfvars
# - env.auto.tfvars
```

**4. Environment variables (TF_VAR_name)** — Set via shell

Environment variables must be prefixed with `TF_VAR_` followed by the variable name.

**PowerShell (Windows):**

```powershell
# Set for current session
$env:TF_VAR_filename = "from-env.txt"
$env:TF_VAR_environment = "staging"
$env:TF_VAR_port = "8080"

# Verify the variable is set
echo $env:TF_VAR_filename

# Run terraform
terraform apply

# Unset the variable
Remove-Item env:TF_VAR_filename
```

**Bash/Zsh (Linux/Mac):**

```bash
# Set for current session
export TF_VAR_filename="from-env.txt"
export TF_VAR_environment="staging"
export TF_VAR_port=8080

# Verify the variable is set
echo $TF_VAR_filename

# Run terraform
terraform apply

# Unset the variable
unset TF_VAR_filename
```

**CMD (Windows Command Prompt):**

```cmd
REM Set for current session
set TF_VAR_filename=from-env.txt
set TF_VAR_environment=staging

REM Run terraform
terraform apply
```

**Complex types via environment variables:**

For complex types (lists, maps, objects), use JSON format:

```powershell
# List
$env:TF_VAR_tags = '["web","api","prod"]'

# Map
$env:TF_VAR_labels = '{"env":"prod","team":"platform"}'

# Object
$env:TF_VAR_config = '{"name":"app","port":8080,"enabled":true}'

terraform apply
```

**5. Default value in variables.tf** — Lowest precedence (fallback)

```hcl
variable "filename" {
  description = "The filename"
  type        = string
  default     = "default.txt"  # Used only if no other source provides a value
}
```

**Variable precedence example:**

Given this scenario:
- `variables.tf` defines: `default = "default.txt"`
- `terraform.tfvars` sets: `filename = "from-tfvars.txt"`
- Environment variable: `$env:TF_VAR_filename = "from-env.txt"`
- CLI flag: `-var "filename=from-cli.txt"`

The final value will be: **`"from-cli.txt"`** (CLI has highest precedence)

**If no CLI flag is provided:**
The value will be: **`"from-tfvars.txt"`** (terraform.tfvars is next in precedence)

**If no CLI flag or terraform.tfvars:**
The value will be: **`"from-env.txt"`** (environment variable is next)

**If none of the above are set:**
The value will be: **`"default.txt"`** (default from variables.tf)

**Practical examples:**

**Windows (PowerShell):**
```powershell
# Use defaults from variables.tf
terraform apply

# Override with terraform.tfvars (auto-loaded)
terraform apply

# Override with custom var file
terraform apply -var-file="prod.tfvars"

# Override with environment variable
$env:TF_VAR_filename = "env-override.txt"
terraform apply

# Override with CLI (highest precedence)
terraform apply -var "filename=cli-override.txt"

# Combine multiple sources (CLI wins for conflicts)
terraform apply -var-file="base.tfvars" -var-file="prod.tfvars" -var "filename=final.txt"
```

**Linux/Mac (Bash):**
```bash
# Use defaults from variables.tf
terraform apply

# Override with terraform.tfvars (auto-loaded)
terraform apply

# Override with custom var file
terraform apply -var-file="prod.tfvars"

# Override with environment variable
export TF_VAR_filename="env-override.txt"
terraform apply

# Override with CLI (highest precedence)
terraform apply -var "filename=cli-override.txt"

# Combine multiple sources (CLI wins for conflicts)
terraform apply -var-file="base.tfvars" -var-file="prod.tfvars" -var "filename=final.txt"
```

Tips & best practices
----------------

- Use explicit types in `variable` blocks when possible to catch mismatches early.
- Keep secrets out of committed `terraform.tfvars`; use environment variables or a secrets manager.
- Prefer `-var-file` for environment configuration in CI/CD. Example files: `dev.tfvars`, `prod.tfvars`.
- Use descriptive names and `description` fields for every variable.
- For large, complex variables prefer `object` types with validation blocks.

Local example (this repo)
----------------

Current `variables.tf` in this folder declares a single variable:

```hcl
variable "filename" {
  description = "The filename of the devops local file"
  type        = string
  default     = "iac.txt"
}
```

Example `terraform.tfvars` in this folder sets:

```hcl
filename = "opentofu.txt"
```

Run locally:

**Windows (PowerShell):**
```powershell
cd .\Variables
terraform init
terraform plan
terraform apply -var-file="terraform.tfvars"
```

**Linux/Mac (Bash):**
```bash
cd ./Variables
terraform init
terraform plan
terraform apply -var-file="terraform.tfvars"
```

If this looks good, I'll mark the final todo as completed. If you'd like additional examples (validation, sensitive=true, or environment-specific workflows), tell me which ones to add.