module "networking" {
  source = "../../modules/networking"

  vpc_cidr_block = var.vpc_cidr_block
  environment    = "dev"
}

module "compute" {
  source = "../../modules/compute"

  environment        = "dev"
  instance_type      = "t3.micro"
  subnet_ids         = module.networking.subnet_ids
  security_group_ids = module.networking.security_group_ids
}

module "database" {
  source = "../../modules/database"

  environment     = "dev"
  db_instance_type = "db.t3.small"
  subnet_ids      = module.networking.subnet_ids
  vpc_id          = module.networking.vpc_id
}