
/* Public subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${var.vpc_id}"
  count                   = "${length(var.core_public_subnets_cidr)}"
  cidr_block              = "${element(var.core_public_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.core_public_subnet_name}${count.index + 1}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${var.vpc_id}"
  count                   = "${length(var.core_private_subnets_cidr)}"
  cidr_block              = "${element(var.core_private_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.core_private_subnet_name}${count.index + 1}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "api_public_subnet" {
  vpc_id                  = "${var.vpc_id}"
  count                   = "${length(var.api_public_subnets_cidr)}"
  cidr_block              = "${element(var.api_public_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.api_public_subnet_name}${count.index + 1}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "api_private_subnet" {
  vpc_id                  = "${var.vpc_id}"
  count                   = "${length(var.api_private_subnets_cidr)}"
  cidr_block              = "${element(var.api_private_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.api_private_subnet_name}${count.index + 1}"
    Environment = "${var.environment}"
  }
}

/* Route table associations */
resource "aws_route_table_association" "public" {
  count          = "${length(var.core_public_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${var.public_routable_id}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.core_private_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${var.private_routable_id}"
}

resource "aws_route_table_association" "api_public" {
  count          = "${length(var.api_public_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.api_public_subnet.*.id, count.index)}"
  route_table_id = "${var.public_routable_id}"
}

resource "aws_route_table_association" "api_private" {
  count          = "${length(var.api_private_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.api_private_subnet.*.id, count.index)}"
  route_table_id = "${var.private_routable_id}"
}