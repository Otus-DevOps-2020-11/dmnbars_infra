variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable subnet_id {
  description = "Subnets for modules"
}
variable cores {
  description = "Db VM cores count"
  default     = 2
}
variable memory {
  description = "Db VM memory count"
  default     = 2
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable deploy {
  description = "Need deploy of app or not"
  default     = false
}
