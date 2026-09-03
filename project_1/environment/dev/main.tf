module "network" {
  source              = "../../modules/network"
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  subnets = {
    web        = "10.0.1.0/24"
    management = "10.0.2.0/24"
  }
}

module "nsg_web" {
  source      = "../../modules/nsg"
  name        = "nsg-web"
  subnet_id   = module.network.subnets["web"]
  allowed_ssh = var.admin_ip
}

module "vm_web" {
  source              = "../../modules/compute"
  name                = "vm-web-01"
  subnet_id           = module.network.subnets["web"]
  admin_username      = var.admin_username
  admin_ssh_pubkey    = var.admin_ssh_pubkey
}

module "storage_app" {
  source              = "../../modules/storage"
  name                = "stcoredev001"
  resource_group_name = var.resource_group_name
}

