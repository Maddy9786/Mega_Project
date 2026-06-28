variable "kubernetes_version" {
  description = "Hold the K8 version"
  default     = "1.32"
  type        = string
}

variable "node_instance_type" {
  description = "This will give worker node instance type"
  default     = "t3.micro"
  type        = string
}

variable "node_min_count" {
  description = "This will give worker node instance type"
  default     = 2
  type        = number
}

variable "node_max_count" {
  description = "This will give worker node instance type"
  default     = 3
  type        = number
}

variable "node_desired_count" {
  description = "This will give worker node instance type"
  default     = 2
  type        = number
}

variable "cluster_name" {
  description = "Holds cluster name"
  default     = "Bankapp"
  type        = string
}

variable "aws_region" {
  description = "Holds aws region"
  default     = "us-east-1"
  type        = string
}


