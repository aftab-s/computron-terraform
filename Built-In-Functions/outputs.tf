# String Functions Outputs
output "string_functions" {
  description = "Demonstration of string functions"
  value = {
    original       = local.project_name
    uppercase      = local.uppercase_name
    lowercase      = local.lowercase_name
    title_case     = local.title_name
    concatenated   = local.full_name
    length         = length(local.project_name)
    substring      = substr(local.project_name, 0, 4)
    trimmed        = trimspace("  ${local.project_name}  ")
    replaced       = replace(local.project_name, "terraform", "TF")
  }
}

# List Functions Outputs
output "list_functions" {
  description = "Demonstration of list functions"
  value = {
    original_list    = local.server_types
    list_length      = local.server_count
    first_element    = local.first_server
    sorted_list      = local.sorted_servers
    reversed_list    = local.reversed_servers
    joined_string    = join(", ", local.server_types)
    contains_web     = contains(local.server_types, "web")
    index_of_app     = index(local.server_types, "app")
    sliced_list      = slice(local.server_types, 0, 2)
  }
}

# Map Functions Outputs
output "map_functions" {
  description = "Demonstration of map functions"
  value = {
    original_map     = local.server_configs
    map_keys         = local.config_keys
    map_values       = local.config_values
    has_web_key      = can(local.server_configs.web)
    lookup_web       = lookup(local.server_configs, "web", "not-found")
    lookup_missing   = lookup(local.server_configs, "cache", "t2.nano")
  }
}

# Numeric Functions Outputs
output "numeric_functions" {
  description = "Demonstration of numeric functions"
  value = {
    sample_numbers   = var.sample_numbers
    maximum         = max(var.sample_numbers...)
    minimum         = min(var.sample_numbers...)
    sum_total       = sum(var.sample_numbers)
    absolute_value  = abs(-42)
    ceiling_value   = ceil(3.2)
    floor_value     = floor(3.8)
    port_range      = local.port_range
  }
}

# Date/Time Functions Outputs
output "datetime_functions" {
  description = "Demonstration of date/time functions"
  value = {
    current_timestamp = local.current_time
    formatted_date    = local.formatted_date
    formatted_time    = formatdate("hh:mm:ss", local.current_time)
    iso_format        = formatdate("YYYY-MM-DD'T'hh:mm:ssZ", local.current_time)
  }
}

# Conditional Functions Outputs
output "conditional_functions" {
  description = "Demonstration of conditional functions"
  value = {
    environment       = var.environment
    is_production     = local.is_production
    instance_type     = local.instance_type
    coalesce_example  = coalesce(null, "", "default-value")
    try_example       = try(local.server_configs.nonexistent, "fallback")
  }
}

# Collection Functions Outputs
output "collection_functions" {
  description = "Demonstration of collection functions"
  value = {
    for_expression    = local.server_tags
    flattened_list    = flatten([["a", "b"], ["c", "d"]])
    distinct_list     = distinct(["a", "b", "a", "c", "b"])
    compact_list      = compact(["", "hello", "", "world", ""])
    setintersection   = setintersection(["a", "b", "c"], ["b", "c", "d"])
    setunion          = setunion(["a", "b"], ["c", "d"])
  }
}

# Encoding Functions Outputs
output "encoding_functions" {
  description = "Demonstration of encoding functions"
  value = {
    original_text     = "Hello, Terraform!"
    base64_encoded    = local.sample_data
    base64_decoded    = base64decode(local.sample_data)
    url_encoded       = urlencode("hello world & terraform")
    json_encoded      = jsonencode(local.server_configs)
  }
}

# Network Functions Outputs
output "network_functions" {
  description = "Demonstration of network functions"
  value = {
    cidr_block        = local.cidr_block
    subnet_cidrs      = local.subnet_cidrs
    cidr_host_example = cidrhost("10.0.0.0/24", 5)
    cidr_netmask      = cidrnetmask("10.0.0.0/24")
  }
}

# Advanced Functions Outputs
output "advanced_functions" {
  description = "Demonstration of advanced functions"
  value = {
    merge_example     = merge(local.common_tags, { AdditionalTag = "value" })
    zipmap_example    = zipmap(["key1", "key2"], ["value1", "value2"])
    transpose_example = transpose({
      a = ["1", "2"]
      b = ["3", "4"]
    })
    range_example     = range(1, 6)
    chunklist_example = chunklist(range(1, 11), 3)
  }
}

# Summary Output
output "function_summary" {
  description = "Summary of all demonstrated functions"
  value = {
    total_categories = 9
    string_functions = 8
    list_functions   = 9
    map_functions    = 6
    numeric_functions = 8
    datetime_functions = 4
    conditional_functions = 5
    collection_functions = 6
    encoding_functions = 5
    network_functions = 4
    advanced_functions = 5
    demo_file_created = "function-demo-output.txt"
  }
}
