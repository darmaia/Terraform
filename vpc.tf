# Cria a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MinhaVPC"
  }
}

# Cria o Internet Gateway para a VPC
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "MinhaVPC-IGW"
  }
}

# --- Subnetes Públicas ---

# Subnete Pública 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a" # Exemplo: us-east-1a
  map_public_ip_on_launch = true # Ativa a atribuição automática de IP público
  tags = {
    Name = "PublicSubnet-1"
  }
}

# --- Subnetes Privadas ---

# Subnete Privada 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.101.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "PrivateSubnet-1"
  }
}

# --- Tabelas de Rotas ---

# Tabela de Rotas Pública
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "PublicRouteTable"
  }
}

# Rota para o Internet Gateway na Tabela de Rotas Pública
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0" # Todo o tráfego para a internet
  gateway_id             = aws_internet_gateway.main_igw.id
}

# Tabela de Rotas Privada (pode ser vazia se não houver NAT Gateway ou peering)
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "PrivateRouteTable"
  }
}

# --- Associações de Tabela de Rotas ---

# Associa a Subnete Pública 1 à Tabela de Rotas Pública
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associa a Subnete Privada 1 à Tabela de Rotas Privada
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

# --- Saídas (Outputs) ---

output "vpc_id" {
  description = "O ID da VPC criada."
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_ids" {
  description = "Os IDs das subnets públicas."
  value = [
    aws_subnet.public_subnet_1.id,
    
  ]
}

output "private_subnet_ids" {
  description = "Os IDs das subnets privadas."
  value = [
    aws_subnet.private_subnet_1.id,
    
  ]
}
