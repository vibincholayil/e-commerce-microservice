module "vpc" {
  source                = "./modules/vpc_module"
  region                = var.region
  vpc_cidr              = var.vpc_cidr
  private_subnet_cidrs  = var.private_subnet_cidrs
  public_subnet_cidrs   = var.public_subnet_cidrs
}