variable "env_name" {
  type = string
  description = "Name der Umgebung, wird in Ressourcennamen verwendet"
}

variable "resource_group_name" {
  type = string
  description = "Resource Group in der Ressourcen angelegt werden"
}

variable "storage_account_name" {
  type = string
  description = "Name des Stroage ASccounts von dem Dateien gehostet werden sollen"
}

