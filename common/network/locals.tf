locals {
    igw_tags = {
        Name = "${module.core.prefix}-igw"
    } 

    vpc_cidr_block = "10.0.0.0/16"

    vpc_tags = {
        Name = "${module.core.prefix}-vpc"
        cidr_block = local.vpc_cidr_block
        zone = "\"ap-northeast-1a\", \"ap-northeast-1c\", \"ap-northeast-1d\""
    }    

    vpc_public_subnets = [
        {
            cidr_block = "10.0.0.0/24"
            zone = "ap-northeast-1a"
            name = "${module.core.prefix}-public-subnet1"
        },
        {
            cidr_block = "10.0.1.0/24"
            zone = "ap-northeast-1c"
            name = "${module.core.prefix}-public-subnet2"
        },
        {
            cidr_block = "10.0.2.0/24"
            zone = "ap-northeast-1d"
            name = "${module.core.prefix}-public-subnet3"
        }           
    ]

    vpc_private_subnets = [
        {
            cidr_block = "10.0.3.0/24"
            zone = "ap-northeast-1a"
            name = "${module.core.prefix}-private-subnet1"   
        },        
        {
            cidr_block = "10.0.4.0/24"
            zone = "ap-northeast-1c"
            name = "${module.core.prefix}-private-subnet2"   
        },
        {
            cidr_block = "10.0.5.0/24"
            zone = "ap-northeast-1d"
            name = "${module.core.prefix}-private-subnet3"   
        }    
    ]
}